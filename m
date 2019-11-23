Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5624C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 03:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CA92071B
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 03:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+T0NMIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CA92071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYML3-0004yu-O3
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 22:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npes87184@gmail.com>) id 1iYMKR-0004Xs-C7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 22:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npes87184@gmail.com>) id 1iYMKP-0003yq-TU
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 22:43:23 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npes87184@gmail.com>) id 1iYMKP-0003yB-Lk
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 22:43:21 -0500
Received: by mail-pl1-x643.google.com with SMTP id q18so3997229pls.5
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 19:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=MLBTxJoVvKWYQpe+21zfBA6r0xCR7j/UjZi4bu+Dj2U=;
 b=o+T0NMIOtY17/k9GRB9x4eJQGVVNSx3vbhhWrZrgdD2VZFgYYTvLHfP3IRCV41mFlG
 zGRIiFHyZ5eG11nNzW7g+5GNtV7vs+LB0VASUGkGtD3n/6qXFvIq2xSFd05miop6le3/
 W8zv9Y3o3rYcc7KGht9LI+BagBlT9lI4JItM0bNERLNURwWgsR5sXhoi2wCSBkKj5tyB
 HAas3iEaqGoyOuQEbO6WZNiGCY7ugsASUug8IhMHmmyHdliZOhOS6nE5I4szrJ+orcTT
 ZCOENR7T2PbPdQSUyAK5SbsffryE7ZCnJh1cNKVt8E5x7HCbl9auwB6Xw4dOM3+m8GhR
 PXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=MLBTxJoVvKWYQpe+21zfBA6r0xCR7j/UjZi4bu+Dj2U=;
 b=Tx1vtmoTjvLtY82F5tRjRabyqPsy9mjBWTTnOJrf3SxlmA4lXNQ7ARGg8OAuAho+kW
 jEzINhk2tSofRsI2rYNmJhPvvGqDbbUV9fZXnL+ZlaYLJwKyJRUiegcUU0DXu7J1OqNT
 N+LTZURmV69KZDCwT5wXpFian76aVdRA8m6zakHL5d6hBn6CuPc2vlkN8rULzMk7ewH5
 c4MFxvgJU1yAiArVuzJMk/TIdYqNWywWU1D/ZQei7fKYt8jipRjZThSfv5WMSyeyjJ1y
 v7b8m1oc4Fd6qBeAjtBZrLuTRG/pTvu67Wrj+O2S1FvgaXpOdcCXgUu+DhDWnFdXRsrX
 lPIQ==
X-Gm-Message-State: APjAAAVpIWQbYAVCZfAjKyNpJzbtR7GnpchgimFUmFxY0eLKmtR796fv
 I/5coK/Nczp9lab1g2UkTWatTWa3
X-Google-Smtp-Source: APXvYqz4E+rObIjWUU2Hg3VuTjvjV91fzITfROqkyARl0R09IZihcvoTwFqmKTsyZkpnT+GuSRwX4w==
X-Received: by 2002:a17:902:8f98:: with SMTP id
 z24mr17991156plo.35.1574480599645; 
 Fri, 22 Nov 2019 19:43:19 -0800 (PST)
Received: from localhost.localdomain (223-137-219-129.emome-ip.hinet.net.
 [223.137.219.129])
 by smtp.googlemail.com with ESMTPSA id j7sm77994pjz.12.2019.11.22.19.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 19:43:19 -0800 (PST)
From: Yu-Chen Lin <npes87184@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] io/channel-websock: treat 'binary' and no sub-protocol as the
 same
Date: Sat, 23 Nov 2019 11:43:06 +0800
Message-Id: <20191123034306.6139-1-npes87184@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yu-Chen Lin <npes87184@gmail.com>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

noVNC doesn't use 'binary' protocol by default after
commit c912230309806aacbae4295faf7ad6406da97617.

It will cause qemu return 400 when handshaking.

To overcome this problem and remain compatibility of
older noVNC client.

We treat 'binary' and no sub-protocol as the same
so that we can support different version of noVNC
client.

Tested on noVNC before c912230 and after c912230.

Buglink: https://bugs.launchpad.net/qemu/+bug/1849644

Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
---
 io/channel-websock.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index fc36d44eba..918e09ea3f 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -49,13 +49,20 @@
     "Server: QEMU VNC\r\n"                       \
     "Date: %s\r\n"
 
+#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK \
+    "HTTP/1.1 101 Switching Protocols\r\n"              \
+    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON            \
+    "Upgrade: websocket\r\n"                            \
+    "Connection: Upgrade\r\n"                           \
+    "Sec-WebSocket-Accept: %s\r\n"                      \
+    "Sec-WebSocket-Protocol: binary\r\n"                \
+    "\r\n"
 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK    \
     "HTTP/1.1 101 Switching Protocols\r\n"      \
     QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON    \
     "Upgrade: websocket\r\n"                    \
     "Connection: Upgrade\r\n"                   \
     "Sec-WebSocket-Accept: %s\r\n"              \
-    "Sec-WebSocket-Protocol: binary\r\n"        \
     "\r\n"
 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND \
     "HTTP/1.1 404 Not Found\r\n"                    \
@@ -336,6 +343,7 @@ qio_channel_websock_find_header(QIOChannelWebsockHTTPHeader *hdrs,
 
 static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *ioc,
                                                       const char *key,
+                                                      const bool use_protocols,
                                                       Error **errp)
 {
     char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +
@@ -361,8 +369,13 @@ static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *ioc,
     }
 
     date = qio_channel_websock_date_str();
-    qio_channel_websock_handshake_send_res(
-        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
+    if (use_protocols) {
+            qio_channel_websock_handshake_send_res(
+                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_WITH_PROTO_RES_OK, date, accept);
+    } else {
+            qio_channel_websock_handshake_send_res(
+                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
+    }
 
     g_free(date);
     g_free(accept);
@@ -387,10 +400,6 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
 
     protocols = qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
-    if (!protocols) {
-        error_setg(errp, "Missing websocket protocol header data");
-        goto bad_request;
-    }
 
     version = qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
@@ -430,10 +439,12 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
     trace_qio_channel_websock_http_request(ioc, protocols, version,
                                            host, connection, upgrade, key);
 
-    if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
-        error_setg(errp, "No '%s' protocol is supported by client '%s'",
-                   QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
-        goto bad_request;
+    if (protocols) {
+            if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
+                error_setg(errp, "No '%s' protocol is supported by client '%s'",
+                           QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
+                goto bad_request;
+            }
     }
 
     if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION)) {
@@ -467,7 +478,7 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
         goto bad_request;
     }
 
-    qio_channel_websock_handshake_send_res_ok(ioc, key, errp);
+    qio_channel_websock_handshake_send_res_ok(ioc, key, !!protocols, errp);
     return;
 
  bad_request:
-- 
2.17.1


