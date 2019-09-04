Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A043C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4055B22CF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4055B22CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ouw-0002ow-EM
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 02:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i5Ono-0006Vn-IM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i5Onn-0003tV-21
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:30:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1i5One-0003cG-3w; Wed, 04 Sep 2019 02:29:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2AFF10F23F3;
 Wed,  4 Sep 2019 06:29:42 +0000 (UTC)
Received: from secure.mitica (ovpn-116-17.ams2.redhat.com [10.36.116.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 177CD19C4F;
 Wed,  4 Sep 2019 06:29:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 08:29:14 +0200
Message-Id: <20190904062915.6488-5-quintela@redhat.com>
In-Reply-To: <20190904062915.6488-1-quintela@redhat.com>
References: <20190904062915.6488-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 04 Sep 2019 06:29:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/5] socket: Add num connections to
 qio_net_listener_open_sync()
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
 blockdev-nbd.c            | 2 +-
 chardev/char-socket.c     | 2 +-
 include/io/net-listener.h | 2 ++
 io/net-listener.c         | 3 ++-
 migration/socket.c        | 2 +-
 qemu-nbd.c                | 2 +-
 ui/vnc.c                  | 4 ++--
 7 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 7a71da447f..c621686131 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -101,7 +101,7 @@ void nbd_server_start(SocketAddress *addr, const char=
 *tls_creds,
     qio_net_listener_set_name(nbd_server->listener,
                               "nbd-listener");
=20
-    if (qio_net_listener_open_sync(nbd_server->listener, addr, errp) < 0=
) {
+    if (qio_net_listener_open_sync(nbd_server->listener, addr, 1, errp) =
< 0) {
         goto error;
     }
=20
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 03f03407b0..185fe38dda 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1170,7 +1170,7 @@ static int qmp_chardev_open_socket_server(Chardev *=
chr,
     qio_net_listener_set_name(s->listener, name);
     g_free(name);
=20
-    if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
+    if (qio_net_listener_open_sync(s->listener, s->addr, 1, errp) < 0) {
         object_unref(OBJECT(s->listener));
         s->listener =3D NULL;
         return -1;
diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 8081ac58a2..fb101703e3 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -95,6 +95,7 @@ void qio_net_listener_set_name(QIONetListener *listener=
,
  * qio_net_listener_open_sync:
  * @listener: the network listener object
  * @addr: the address to listen on
+ * @num: the amount of expected connections
  * @errp: pointer to a NULL initialized error object
  *
  * Synchronously open a listening connection on all
@@ -104,6 +105,7 @@ void qio_net_listener_set_name(QIONetListener *listen=
er,
  */
 int qio_net_listener_open_sync(QIONetListener *listener,
                                SocketAddress *addr,
+                               int num,
                                Error **errp);
=20
 /**
diff --git a/io/net-listener.c b/io/net-listener.c
index dc81150318..5d8a226872 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -62,6 +62,7 @@ static gboolean qio_net_listener_channel_func(QIOChanne=
l *ioc,
=20
 int qio_net_listener_open_sync(QIONetListener *listener,
                                SocketAddress *addr,
+                               int num,
                                Error **errp)
 {
     QIODNSResolver *resolver =3D qio_dns_resolver_get_instance();
@@ -82,7 +83,7 @@ int qio_net_listener_open_sync(QIONetListener *listener=
,
     for (i =3D 0; i < nresaddrs; i++) {
         QIOChannelSocket *sioc =3D qio_channel_socket_new();
=20
-        if (qio_channel_socket_listen_sync(sioc, resaddrs[i], 1,
+        if (qio_channel_socket_listen_sync(sioc, resaddrs[i], num,
                                            err ? NULL : &err) =3D=3D 0) =
{
             success =3D true;
=20
diff --git a/migration/socket.c b/migration/socket.c
index 98efdc0286..e63f5e1612 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -181,7 +181,7 @@ static void socket_start_incoming_migration(SocketAdd=
ress *saddr,
=20
     qio_net_listener_set_name(listener, "migration-socket-listener");
=20
-    if (qio_net_listener_open_sync(listener, saddr, errp) < 0) {
+    if (qio_net_listener_open_sync(listener, saddr, 1, errp) < 0) {
         object_unref(OBJECT(listener));
         return;
     }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 049645491d..83b6c32d73 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1054,7 +1054,7 @@ int main(int argc, char **argv)
     server =3D qio_net_listener_new();
     if (socket_activation =3D=3D 0) {
         saddr =3D nbd_build_socket_address(sockpath, bindto, port);
-        if (qio_net_listener_open_sync(server, saddr, &local_err) < 0) {
+        if (qio_net_listener_open_sync(server, saddr, 1, &local_err) < 0=
) {
             object_unref(OBJECT(server));
             error_report_err(local_err);
             exit(EXIT_FAILURE);
diff --git a/ui/vnc.c b/ui/vnc.c
index 649ce93cd2..bd16746022 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3765,7 +3765,7 @@ static int vnc_display_listen(VncDisplay *vd,
         qio_net_listener_set_name(vd->listener, "vnc-listen");
         for (i =3D 0; i < nsaddr; i++) {
             if (qio_net_listener_open_sync(vd->listener,
-                                           saddr[i],
+                                           saddr[i], 1,
                                            errp) < 0)  {
                 return -1;
             }
@@ -3780,7 +3780,7 @@ static int vnc_display_listen(VncDisplay *vd,
         qio_net_listener_set_name(vd->wslistener, "vnc-ws-listen");
         for (i =3D 0; i < nwsaddr; i++) {
             if (qio_net_listener_open_sync(vd->wslistener,
-                                           wsaddr[i],
+                                           wsaddr[i], 1,
                                            errp) < 0)  {
                 return -1;
             }
--=20
2.21.0


