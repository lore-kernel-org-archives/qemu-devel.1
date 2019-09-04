Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A2BC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC4822CF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC4822CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Osw-0000h0-QD
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 02:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i5Ono-0006Vs-Jt
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i5Onn-0003tt-5u
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:30:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1i5Onh-0003TZ-64; Wed, 04 Sep 2019 02:29:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA7EB806D1;
 Wed,  4 Sep 2019 06:29:34 +0000 (UTC)
Received: from secure.mitica (ovpn-116-17.ams2.redhat.com [10.36.116.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B764219C4F;
 Wed,  4 Sep 2019 06:29:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 08:29:13 +0200
Message-Id: <20190904062915.6488-4-quintela@redhat.com>
In-Reply-To: <20190904062915.6488-1-quintela@redhat.com>
References: <20190904062915.6488-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 04 Sep 2019 06:29:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/5] socket: Add num connections to
 qio_channel_socket_async()
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
 include/io/channel-socket.h    |  2 ++
 io/channel-socket.c            | 30 +++++++++++++++++++++++-------
 io/trace-events                |  2 +-
 tests/test-io-channel-socket.c |  2 +-
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index ed88e5b8c1..777ff5954e 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -140,6 +140,7 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *=
ioc,
  * qio_channel_socket_listen_async:
  * @ioc: the socket channel object
  * @addr: the address to listen to
+ * @num: the expected ammount of connections
  * @callback: the function to invoke on completion
  * @opaque: user data to pass to @callback
  * @destroy: the function to free @opaque
@@ -155,6 +156,7 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *=
ioc,
  */
 void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
                                      SocketAddress *addr,
+                                     int num,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
                                      GDestroyNotify destroy,
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 6258c25983..b74f5b92a0 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -220,14 +220,27 @@ int qio_channel_socket_listen_sync(QIOChannelSocket=
 *ioc,
 }
=20
=20
+struct QIOChannelListenWorkerData {
+    SocketAddress *addr;
+    int num; /* amount of expected connections */
+};
+
+static void qio_channel_listen_worker_free(gpointer opaque)
+{
+    struct QIOChannelListenWorkerData *data =3D opaque;
+
+    qapi_free_SocketAddress(data->addr);
+    g_free(data);
+}
+
 static void qio_channel_socket_listen_worker(QIOTask *task,
                                              gpointer opaque)
 {
     QIOChannelSocket *ioc =3D QIO_CHANNEL_SOCKET(qio_task_get_source(tas=
k));
-    SocketAddress *addr =3D opaque;
+    struct QIOChannelListenWorkerData *data =3D opaque;
     Error *err =3D NULL;
=20
-    qio_channel_socket_listen_sync(ioc, addr, 1, &err);
+    qio_channel_socket_listen_sync(ioc, data->addr, data->num, &err);
=20
     qio_task_set_error(task, err);
 }
@@ -235,6 +248,7 @@ static void qio_channel_socket_listen_worker(QIOTask =
*task,
=20
 void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
                                      SocketAddress *addr,
+                                     int num,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
                                      GDestroyNotify destroy,
@@ -242,16 +256,18 @@ void qio_channel_socket_listen_async(QIOChannelSock=
et *ioc,
 {
     QIOTask *task =3D qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
-    SocketAddress *addrCopy;
+    struct QIOChannelListenWorkerData *data;
=20
-    addrCopy =3D QAPI_CLONE(SocketAddress, addr);
+    data =3D g_new0(struct QIOChannelListenWorkerData, 1);
+    data->addr =3D QAPI_CLONE(SocketAddress, addr);
+    data->num =3D num;
=20
     /* socket_listen() blocks in DNS lookups, so we must use a thread */
-    trace_qio_channel_socket_listen_async(ioc, addr);
+    trace_qio_channel_socket_listen_async(ioc, addr, num);
     qio_task_run_in_thread(task,
                            qio_channel_socket_listen_worker,
-                           addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddress,
+                           data,
+                           qio_channel_listen_worker_free,
                            context);
 }
=20
diff --git a/io/trace-events b/io/trace-events
index 2e6aa1d749..d7bc70b966 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -18,7 +18,7 @@ qio_channel_socket_connect_async(void *ioc, void *addr)=
 "Socket connect async io
 qio_channel_socket_connect_fail(void *ioc) "Socket connect fail ioc=3D%p=
"
 qio_channel_socket_connect_complete(void *ioc, int fd) "Socket connect c=
omplete ioc=3D%p fd=3D%d"
 qio_channel_socket_listen_sync(void *ioc, void *addr, int num) "Socket l=
isten sync ioc=3D%p addr=3D%p num=3D%d"
-qio_channel_socket_listen_async(void *ioc, void *addr) "Socket listen as=
ync ioc=3D%p addr=3D%p"
+qio_channel_socket_listen_async(void *ioc, void *addr, int num) "Socket =
listen async ioc=3D%p addr=3D%p num=3D%d"
 qio_channel_socket_listen_fail(void *ioc) "Socket listen fail ioc=3D%p"
 qio_channel_socket_listen_complete(void *ioc, int fd) "Socket listen com=
plete ioc=3D%p fd=3D%d"
 qio_channel_socket_dgram_sync(void *ioc, void *localAddr, void *remoteAd=
dr) "Socket dgram sync ioc=3D%p localAddr=3D%p remoteAddr=3D%p"
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socke=
t.c
index 613ada32c0..d43083a766 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -113,7 +113,7 @@ static void test_io_channel_setup_async(SocketAddress=
 *listen_addr,
=20
     lioc =3D qio_channel_socket_new();
     qio_channel_socket_listen_async(
-        lioc, listen_addr,
+        lioc, listen_addr, 1,
         test_io_channel_complete, &data, NULL, NULL);
=20
     g_main_loop_run(data.loop);
--=20
2.21.0


