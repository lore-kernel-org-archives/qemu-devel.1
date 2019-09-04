Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815BDC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5759422CF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5759422CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5OvC-0003Dx-Hb
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 02:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i5Onk-0006S9-0x
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i5Ong-0003oD-ME
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:29:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1i5OnT-0003OJ-Rj; Wed, 04 Sep 2019 02:29:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63BAD18C8937;
 Wed,  4 Sep 2019 06:29:31 +0000 (UTC)
Received: from secure.mitica (ovpn-116-17.ams2.redhat.com [10.36.116.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 606D919C4F;
 Wed,  4 Sep 2019 06:29:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 08:29:12 +0200
Message-Id: <20190904062915.6488-3-quintela@redhat.com>
In-Reply-To: <20190904062915.6488-1-quintela@redhat.com>
References: <20190904062915.6488-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 04 Sep 2019 06:29:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/5] socket: Add num connections to
 qio_channel_socket_sync()
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/io/channel-socket.h    | 2 ++
 io/channel-socket.c            | 7 ++++---
 io/net-listener.c              | 2 +-
 io/trace-events                | 2 +-
 scsi/qemu-pr-helper.c          | 3 ++-
 tests/test-char.c              | 4 ++--
 tests/test-io-channel-socket.c | 2 +-
 tests/tpm-emu.c                | 2 +-
 8 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index d7134d2cd6..ed88e5b8c1 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -123,6 +123,7 @@ void qio_channel_socket_connect_async(QIOChannelSocke=
t *ioc,
  * qio_channel_socket_listen_sync:
  * @ioc: the socket channel object
  * @addr: the address to listen to
+ * @num: the expected ammount of connections
  * @errp: pointer to a NULL-initialized error object
  *
  * Attempt to listen to the address @addr. This method
@@ -132,6 +133,7 @@ void qio_channel_socket_connect_async(QIOChannelSocke=
t *ioc,
  */
 int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
                                    SocketAddress *addr,
+                                   int num,
                                    Error **errp);
=20
 /**
diff --git a/io/channel-socket.c b/io/channel-socket.c
index a533c8bc11..6258c25983 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -197,12 +197,13 @@ void qio_channel_socket_connect_async(QIOChannelSoc=
ket *ioc,
=20
 int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
                                    SocketAddress *addr,
+                                   int num,
                                    Error **errp)
 {
     int fd;
=20
-    trace_qio_channel_socket_listen_sync(ioc, addr);
-    fd =3D socket_listen(addr, 1, errp);
+    trace_qio_channel_socket_listen_sync(ioc, addr, num);
+    fd =3D socket_listen(addr, num, errp);
     if (fd < 0) {
         trace_qio_channel_socket_listen_fail(ioc);
         return -1;
@@ -226,7 +227,7 @@ static void qio_channel_socket_listen_worker(QIOTask =
*task,
     SocketAddress *addr =3D opaque;
     Error *err =3D NULL;
=20
-    qio_channel_socket_listen_sync(ioc, addr, &err);
+    qio_channel_socket_listen_sync(ioc, addr, 1, &err);
=20
     qio_task_set_error(task, err);
 }
diff --git a/io/net-listener.c b/io/net-listener.c
index d8cfe52673..dc81150318 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -82,7 +82,7 @@ int qio_net_listener_open_sync(QIONetListener *listener=
,
     for (i =3D 0; i < nresaddrs; i++) {
         QIOChannelSocket *sioc =3D qio_channel_socket_new();
=20
-        if (qio_channel_socket_listen_sync(sioc, resaddrs[i],
+        if (qio_channel_socket_listen_sync(sioc, resaddrs[i], 1,
                                            err ? NULL : &err) =3D=3D 0) =
{
             success =3D true;
=20
diff --git a/io/trace-events b/io/trace-events
index 378390521e..2e6aa1d749 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -17,7 +17,7 @@ qio_channel_socket_connect_sync(void *ioc, void *addr) =
"Socket connect sync ioc=3D
 qio_channel_socket_connect_async(void *ioc, void *addr) "Socket connect =
async ioc=3D%p addr=3D%p"
 qio_channel_socket_connect_fail(void *ioc) "Socket connect fail ioc=3D%p=
"
 qio_channel_socket_connect_complete(void *ioc, int fd) "Socket connect c=
omplete ioc=3D%p fd=3D%d"
-qio_channel_socket_listen_sync(void *ioc, void *addr) "Socket listen syn=
c ioc=3D%p addr=3D%p"
+qio_channel_socket_listen_sync(void *ioc, void *addr, int num) "Socket l=
isten sync ioc=3D%p addr=3D%p num=3D%d"
 qio_channel_socket_listen_async(void *ioc, void *addr) "Socket listen as=
ync ioc=3D%p addr=3D%p"
 qio_channel_socket_listen_fail(void *ioc) "Socket listen fail ioc=3D%p"
 qio_channel_socket_listen_complete(void *ioc, int fd) "Socket listen com=
plete ioc=3D%p fd=3D%d"
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index a256ce490b..a8a74d1dba 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -1005,7 +1005,8 @@ int main(int argc, char **argv)
             .u.q_unix.path =3D socket_path,
         };
         server_ioc =3D qio_channel_socket_new();
-        if (qio_channel_socket_listen_sync(server_ioc, &saddr, &local_er=
r) < 0) {
+        if (qio_channel_socket_listen_sync(server_ioc, &saddr,
+                                           1, &local_err) < 0) {
             object_unref(OBJECT(server_ioc));
             error_report_err(local_err);
             return 1;
diff --git a/tests/test-char.c b/tests/test-char.c
index b56e43c1eb..f3ebdffd87 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -667,7 +667,7 @@ char_socket_addr_to_opt_str(SocketAddress *addr, bool=
 fd_pass,
         char *optstr;
         g_assert(!reconnect);
         if (is_listen) {
-            qio_channel_socket_listen_sync(ioc, addr, &error_abort);
+            qio_channel_socket_listen_sync(ioc, addr, 1, &error_abort);
         } else {
             qio_channel_socket_connect_sync(ioc, addr, &error_abort);
         }
@@ -892,7 +892,7 @@ static void char_socket_client_test(gconstpointer opa=
que)
      */
     ioc =3D qio_channel_socket_new();
     g_assert_nonnull(ioc);
-    qio_channel_socket_listen_sync(ioc, config->addr, &error_abort);
+    qio_channel_socket_listen_sync(ioc, config->addr, 1, &error_abort);
     addr =3D qio_channel_socket_get_local_address(ioc, &error_abort);
     g_assert_nonnull(addr);
=20
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socke=
t.c
index d172f3070f..613ada32c0 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -57,7 +57,7 @@ static void test_io_channel_setup_sync(SocketAddress *l=
isten_addr,
     QIOChannelSocket *lioc;
=20
     lioc =3D qio_channel_socket_new();
-    qio_channel_socket_listen_sync(lioc, listen_addr, &error_abort);
+    qio_channel_socket_listen_sync(lioc, listen_addr, 1, &error_abort);
=20
     if (listen_addr->type =3D=3D SOCKET_ADDRESS_TYPE_INET) {
         SocketAddress *laddr =3D qio_channel_socket_get_local_address(
diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
index 125e697181..c43ac4aef8 100644
--- a/tests/tpm-emu.c
+++ b/tests/tpm-emu.c
@@ -76,7 +76,7 @@ void *tpm_emu_ctrl_thread(void *data)
     QIOChannelSocket *lioc =3D qio_channel_socket_new();
     QIOChannel *ioc;
=20
-    qio_channel_socket_listen_sync(lioc, s->addr, &error_abort);
+    qio_channel_socket_listen_sync(lioc, s->addr, 1, &error_abort);
=20
     g_mutex_lock(&s->data_mutex);
     s->data_cond_signal =3D true;
--=20
2.21.0


