FROM golang:1.20 AS builder

WORKDIR /build
COPY . /build/
RUN go mod download
RUN CGO_ENABLED=0 go build -o grafana-agent-loader main.go

FROM waggle/plugin-base:1.1.1-base
COPY --from=builder /build/grafana-agent-loader /app/
WORKDIR /app
ENTRYPOINT ["/app/grafana-agent-loader"]