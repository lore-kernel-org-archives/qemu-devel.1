Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A06C2D0A7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A624D208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QETrhhnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A624D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSfN-0006x0-Lx
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSa6-0004vP-1w
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38940
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSa3-0000co-OF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZOcCIlgtYTbBYD+qGN6JUOF4pxhSN6iGYRbBWA82UkE=;
 b=QETrhhnLInQaoEeRs5QJyyXoRJf6jBVWJ79QlJWt5DNMpEMBr9egjH72ba7ZTgCR7uLuts
 bi2zFtdawfO1BjhH3gO4ZZOMDVet6Oh9QfkGQ5jvRa2JW0B+glMBlSn9PnMha9WiKdx2Ay
 nhVZexaLEkNzknX7J2cfesFnvuF4f7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-3ot2Est2PpKtATOqPiP9vg-1; Thu, 10 Sep 2020 15:50:00 -0400
X-MC-Unique: 3ot2Est2PpKtATOqPiP9vg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 936611007B00;
 Thu, 10 Sep 2020 19:49:59 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C7D619C66;
 Thu, 10 Sep 2020 19:49:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/18] chardev: Rename SOCKET_CHARDEV to CHARDEV_SOCKET
Date: Thu, 10 Sep 2020 15:48:56 -0400
Message-Id: <20200910194903.4104696-12-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename instance and class type checkers to match the
TYPE_CHARDEV_* constant names and the QOM type name strings
("chardev-*").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 chardev/char-socket.c | 68 +++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 95e45812d5..fac2b4a821 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -88,7 +88,7 @@ struct SocketChardev {
 };
 typedef struct SocketChardev SocketChardev;
 
-DECLARE_INSTANCE_CHECKER(SocketChardev, SOCKET_CHARDEV,
+DECLARE_INSTANCE_CHECKER(SocketChardev, CHARDEV_SOCKET,
                          TYPE_CHARDEV_SOCKET)
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
@@ -120,7 +120,7 @@ static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
 
 static void qemu_chr_socket_restart_timer(Chardev *chr)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     char *name;
 
     assert(s->state == TCP_CHARDEV_STATE_DISCONNECTED);
@@ -137,7 +137,7 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
 static void check_report_connect_error(Chardev *chr,
                                        Error *err)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
 
     if (!s->connect_err_reported) {
         error_reportf_err(err,
@@ -160,7 +160,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr);
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
 
     if (s->state == TCP_CHARDEV_STATE_CONNECTED) {
         int ret =  io_channel_send_full(s->ioc, buf, len,
@@ -195,7 +195,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 static int tcp_chr_read_poll(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    SocketChardev *s = SOCKET_CHARDEV(opaque);
+    SocketChardev *s = CHARDEV_SOCKET(opaque);
     if (s->state != TCP_CHARDEV_STATE_CONNECTED) {
         return 0;
     }
@@ -276,7 +276,7 @@ static void tcp_chr_process_IAC_bytes(Chardev *chr,
 
 static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
 
     int to_copy = (s->read_msgfds_num < num) ? s->read_msgfds_num : num;
 
@@ -302,7 +302,7 @@ static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 
 static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
 
     /* clear old pending fd array */
     g_free(s->write_msgfds);
@@ -327,7 +327,7 @@ static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 
 static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     struct iovec iov = { .iov_base = buf, .iov_len = len };
     int ret;
     size_t i;
@@ -384,7 +384,7 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 
 static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     return qio_channel_create_watch(s->ioc, cond);
 }
 
@@ -399,7 +399,7 @@ static void remove_hup_source(SocketChardev *s)
 
 static void tcp_chr_free_connection(Chardev *chr)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     int i;
 
     if (s->read_msgfds_num) {
@@ -479,7 +479,7 @@ static void update_disconnected_filename(SocketChardev *s)
  */
 static void tcp_chr_disconnect_locked(Chardev *chr)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     bool emit_close = s->state == TCP_CHARDEV_STATE_CONNECTED;
 
     tcp_chr_free_connection(chr);
@@ -507,7 +507,7 @@ static void tcp_chr_disconnect(Chardev *chr)
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    SocketChardev *s = SOCKET_CHARDEV(opaque);
+    SocketChardev *s = CHARDEV_SOCKET(opaque);
     uint8_t buf[CHR_READ_BUF_LEN];
     int len, size;
 
@@ -546,7 +546,7 @@ static gboolean tcp_chr_hup(QIOChannel *channel,
 
 static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     int size;
 
     if (s->state != TCP_CHARDEV_STATE_CONNECTED) {
@@ -627,7 +627,7 @@ static void update_ioc_handlers(SocketChardev *s)
 static void tcp_chr_connect(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    SocketChardev *s = SOCKET_CHARDEV(opaque);
+    SocketChardev *s = CHARDEV_SOCKET(opaque);
 
     g_free(chr->filename);
     chr->filename = qemu_chr_compute_filename(s);
@@ -648,7 +648,7 @@ static void tcp_chr_telnet_destroy(SocketChardev *s)
 
 static void tcp_chr_update_read_handler(Chardev *chr)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
 
     if (s->listener && s->state == TCP_CHARDEV_STATE_DISCONNECTED) {
         /*
@@ -708,7 +708,7 @@ end:
 
 static void tcp_chr_telnet_init(Chardev *chr)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     TCPChardevTelnetInit *init;
     size_t n = 0;
 
@@ -779,7 +779,7 @@ static void tcp_chr_websock_handshake(QIOTask *task, gpointer user_data)
 
 static void tcp_chr_websock_init(Chardev *chr)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     QIOChannelWebsock *wioc = NULL;
     gchar *name;
 
@@ -817,7 +817,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
 
 static void tcp_chr_tls_init(Chardev *chr)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     QIOChannelTLS *tioc;
     gchar *name;
 
@@ -855,7 +855,7 @@ static void tcp_chr_tls_init(Chardev *chr)
 static void tcp_chr_set_client_ioc_name(Chardev *chr,
                                         QIOChannelSocket *sioc)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     char *name;
     name = g_strdup_printf("chardev-tcp-%s-%s",
                            s->is_listen ? "server" : "client",
@@ -867,7 +867,7 @@ static void tcp_chr_set_client_ioc_name(Chardev *chr,
 
 static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
 
     if (s->state != TCP_CHARDEV_STATE_CONNECTING) {
         return -1;
@@ -906,7 +906,7 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
 {
     int ret;
     QIOChannelSocket *sioc;
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
 
     if (s->state != TCP_CHARDEV_STATE_DISCONNECTED) {
         return -1;
@@ -928,7 +928,7 @@ static void tcp_chr_accept(QIONetListener *listener,
                            void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
 
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, cioc);
@@ -938,7 +938,7 @@ static void tcp_chr_accept(QIONetListener *listener,
 
 static int tcp_chr_connect_client_sync(Chardev *chr, Error **errp)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     QIOChannelSocket *sioc = qio_channel_socket_new();
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, sioc);
@@ -955,7 +955,7 @@ static int tcp_chr_connect_client_sync(Chardev *chr, Error **errp)
 
 static void tcp_chr_accept_server_sync(Chardev *chr)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     QIOChannelSocket *sioc;
     info_report("QEMU waiting for connection on: %s",
                 chr->filename);
@@ -969,7 +969,7 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
 
 static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     const char *opts[] = { "telnet", "tn3270", "websock", "tls-creds" };
     bool optset[] = { s->is_telnet, s->is_tn3270, s->is_websock, s->tls_creds };
     size_t i;
@@ -1056,7 +1056,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 static void char_socket_finalize(Object *obj)
 {
     Chardev *chr = CHARDEV(obj);
-    SocketChardev *s = SOCKET_CHARDEV(obj);
+    SocketChardev *s = CHARDEV_SOCKET(obj);
 
     tcp_chr_free_connection(chr);
     tcp_chr_reconn_timer_cancel(s);
@@ -1080,7 +1080,7 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
     Chardev *chr = CHARDEV(opaque);
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     Error *err = NULL;
 
     s->connect_task = NULL;
@@ -1114,7 +1114,7 @@ static void tcp_chr_connect_client_task(QIOTask *task,
 
 static void tcp_chr_connect_client_async(Chardev *chr)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     QIOChannelSocket *sioc;
 
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
@@ -1143,7 +1143,7 @@ static void tcp_chr_connect_client_async(Chardev *chr)
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    SocketChardev *s = SOCKET_CHARDEV(opaque);
+    SocketChardev *s = CHARDEV_SOCKET(opaque);
 
     qemu_mutex_lock(&chr->chr_write_lock);
     g_source_unref(s->reconnect_timer);
@@ -1165,7 +1165,7 @@ static int qmp_chardev_open_socket_server(Chardev *chr,
                                           bool is_waitconnect,
                                           Error **errp)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     char *name;
     if (is_telnet) {
         s->do_telnetopt = 1;
@@ -1203,7 +1203,7 @@ static int qmp_chardev_open_socket_client(Chardev *chr,
                                           int64_t reconnect,
                                           Error **errp)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
 
     if (reconnect > 0) {
         s->reconnect_time = reconnect;
@@ -1300,7 +1300,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
                                     bool *be_opened,
                                     Error **errp)
 {
-    SocketChardev *s = SOCKET_CHARDEV(chr);
+    SocketChardev *s = CHARDEV_SOCKET(chr);
     ChardevSocket *sock = backend->u.socket.data;
     bool do_nodelay     = sock->has_nodelay ? sock->nodelay : false;
     bool is_listen      = sock->has_server  ? sock->server  : true;
@@ -1468,7 +1468,7 @@ static void
 char_socket_get_addr(Object *obj, Visitor *v, const char *name,
                      void *opaque, Error **errp)
 {
-    SocketChardev *s = SOCKET_CHARDEV(obj);
+    SocketChardev *s = CHARDEV_SOCKET(obj);
 
     visit_type_SocketAddress(v, name, &s->addr, errp);
 }
@@ -1476,7 +1476,7 @@ char_socket_get_addr(Object *obj, Visitor *v, const char *name,
 static bool
 char_socket_get_connected(Object *obj, Error **errp)
 {
-    SocketChardev *s = SOCKET_CHARDEV(obj);
+    SocketChardev *s = CHARDEV_SOCKET(obj);
 
     return s->state == TCP_CHARDEV_STATE_CONNECTED;
 }
-- 
2.26.2


