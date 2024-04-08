# Stage - 1
FROM golang:1.22.2-alpine3.19 AS builder
ENV CGO_ENABLED=0
ENV GOOS=linux
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o go_server .

# State - 2
FROM alpine:latest
ENV PORT=8080
COPY --from=builder /app/go_server /go_server
EXPOSE $PORT
CMD ["/go_server"]