Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3C0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B850C20748
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jN8JQPuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B850C20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbW5A-0002ou-Q5
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuY-0002OT-CZ; Wed, 20 May 2020 17:05:58 -0400
Received: from mout.web.de ([212.227.15.3]:45821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVuX-0002Sw-AG; Wed, 20 May 2020 17:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590008752;
 bh=ZT5paGKoMkxQIIK3do9eYhtJlP8tDd8KzO7ihZmKyFg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jN8JQPukWhbroWA6Nhx6lWlgaewQxPeY4r5MqilJIrGlITpSm+E9kwMvmFpN7sds5
 UDxjZTT8N5H0W9gtbbCOENLrXeF1AXPqK7GB/5chdyelH0x1kMZkJxUPZU3iyls+XX
 jH/xOUeGzwxzL+bgjY2XH9POmJUA+orvI9zZVMdg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWeGR-1jZfAi40VP-00XweA; Wed, 20
 May 2020 23:05:52 +0200
Date: Wed, 20 May 2020 23:05:50 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 4/4] migration: Add yank feature
Message-ID: <b3ca78c3b4b8ad903ca2f70795fc38218802afc4.1590008051.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590008051.git.lukasstraub2@web.de>
References: <cover.1590008051.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l8g7G.FqFtewSq3AYYNqV+B";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:OED8SphvAPMlmwdWiFINwLgEeKhUa5E5Vr0SVmxdzdgTzU3dPbQ
 cFsDGo84lys4jxKwIRC2AzMfb0HAvnHuwy1ATFJnPkwbfK5zNuQn/A9lfc7ICgdBJpvSIf1
 acEIvJHEDkYUZeZ4M7m2EtAK+n/6VOHWrAHWo42K9NcWTx7S6YL/J7OUaauOt5ARMeaaCZF
 cyV6ROAEn2kKPnO9EG/Kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0iO+pklncoo=:u/XEMv949gD4atgEnMt3J2
 3cfAWwqgaKN4FAAT9ACuMh7+RnYOS+n81/cBqD9/GGzOuKHzTaX3nCt8VROWcUS5HdYWfrnUN
 beB1AQzo9lxyBp6PNh3rImNE8WEjLaMEFaO8uxaPbWbkijK9VCn7bX3KitZLoFmg9i6M+vJAk
 o0qqQg0Qm86WUOL/54dOUKu8VW3ekHdXrRWdpGLm6v8vwTXZyAfZkOs6eMYUBHRi/e8vIXQ5T
 eT8EnqWTYZpLCzmDkBG8celKFDiyOY2bZzZnEKcHVk6bbpLrmnMQQlExYnLTr9OnEPjY1Tx9i
 bdBpBXVgiviwfBg27ITE8sSYldomSfKi9dQY9Tn9yTpp3EK5wDe/v/Yy8OlDGXbIfLZl+Dln0
 gkTaiRSlGB10dXf/a51AMjffj5tmMNqrnXsS5anRXhEn3ZYwlLAFkIjVujdtzMoM0de9I9Ho1
 zAGawGe17AQZknq3swYBfMm+njnvWc6kiWZi83n6GfgkRtwIGyrU0t9G/g7cLWRPggSQcN+22
 HQedScU9ad/QSQTNlZV4I18kNzwBqN4oj8wtup5IpbMvJ9KK8JYM8MljloEdntVMpRT6fn/GU
 4BttCmUhYor97Y521TO90f6s7pD2kuuIs7vnjj3QN6MjF2CnwZcQOL+zfUS1qVreBZzzz1tuV
 Q1vfh1QqKXfvW3lmpeki1lnxEDI4TXC+a4Le0DFCJB+T7xIqTc0rjxkO3BrK1hfSG6cZROXZQ
 uBQhYUXKg/6fHSWwUaeCluNAQk5UJCwfQQraPCk+rsv4N6lgbyyeDiDouGdi14trSKOXIbzJJ
 U7UxUZW5P6Nc+IBz82teOIMQwgSW4BJO0eXnfKdRKpnfD5m4A9HPOJ1ygkwUE3LkkhN3DhEOX
 lc6eTsQZYaPFlCqTmSOkTUESAxbFb3CjgthLDRAxlM+u34QAhDbTKM1HN2rYirMOnMQq/S+Vx
 svJTABr1fiKrAo54dGJJNraT5RzTHqVuZUfxJsOieA2f8MuJLYX+7EfvINnrXhk5nR2j2KN77
 85wtDmqbItOY645AXu2oyM36/WQTtGampOnQ5YTPsVwnhsmEf/sZmIW2wD45LXsqjhyCnbhJO
 5ZIetpe7XkRkQxljRCUrRiO419RIXDj05SbkOAFBQhz006ir4I0l4qPTrWiJTY7X1EzBGtU6n
 5v/6X9B4az/JdbJOaW/OiHkUeIEUGrl8L73Znx2YzFiEG+7q6SeC2a/s7fwg+8I+berZBjqPl
 ltPleRJ0DxvEzZEtK
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/l8g7G.FqFtewSq3AYYNqV+B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register yank functions on sockets to shut them down.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/migration.c         |  9 +++++++++
 migration/qemu-file-channel.c |  6 ++++++
 migration/socket.c            | 11 +++++++++++
 3 files changed, 26 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 187ac0410c..f89fcba198 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -54,6 +54,7 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
+#include "yank.h"

 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttli=
ng */

@@ -231,6 +232,8 @@ void migration_incoming_state_destroy(void)
         qapi_free_SocketAddressList(mis->socket_address_list);
         mis->socket_address_list =3D NULL;
     }
+
+    yank_unregister_instance((char *) "migration");
 }

 static void migrate_generate_event(int new_state)
@@ -362,6 +365,7 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     const char *p;

     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
+    yank_register_instance((char *) "migration");
     if (!strcmp(uri, "defer")) {
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p)) {
@@ -377,6 +381,7 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
     } else {
+        yank_unregister_instance((char *) "migration");
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
 }
@@ -1632,6 +1637,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+    yank_unregister_instance((char *) "migration");
 }

 static void migrate_fd_cleanup_schedule(MigrationState *s)
@@ -2036,6 +2042,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
         return;
     }

+    yank_register_instance((char *) "migration");
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
 #ifdef CONFIG_RDMA
@@ -2049,6 +2056,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
+        yank_unregister_instance((char *) "migration");
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
@@ -2058,6 +2066,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
     }

     if (local_err) {
+        yank_unregister_instance((char *) "migration");
         migrate_fd_error(s, local_err);
         error_propagate(errp, local_err);
         return;
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index d2ce32f4b9..6224bda029 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -27,6 +27,7 @@
 #include "qemu-file.h"
 #include "io/channel-socket.h"
 #include "qemu/iov.h"
+#include "yank.h"


 static ssize_t channel_writev_buffer(void *opaque,
@@ -104,6 +105,11 @@ static int channel_close(void *opaque, Error **errp)
     int ret;
     QIOChannel *ioc =3D QIO_CHANNEL(opaque);
     ret =3D qio_channel_close(ioc, errp);
+    if (object_dynamic_cast(OBJECT(ioc), TYPE_QIO_CHANNEL_SOCKET)
+        && OBJECT(ioc)->ref =3D=3D 2) {
+        yank_unregister_function((char *) "migration", yank_generic_iochan=
nel,
+                                 QIO_CHANNEL(ioc));
+    }
     object_unref(OBJECT(ioc));
     return ret;
 }
diff --git a/migration/socket.c b/migration/socket.c
index 97c9efde59..bbca53cc49 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -26,6 +26,7 @@
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
 #include "trace.h"
+#include "yank.h"


 struct SocketOutgoingArgs {
@@ -35,6 +36,8 @@ struct SocketOutgoingArgs {
 void socket_send_channel_create(QIOTaskFunc f, void *data)
 {
     QIOChannelSocket *sioc =3D qio_channel_socket_new();
+    yank_register_function((char *) "migration", yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     qio_channel_socket_connect_async(sioc, outgoing_args.saddr,
                                      f, data, NULL, NULL);
 }
@@ -42,6 +45,8 @@ void socket_send_channel_create(QIOTaskFunc f, void *data)
 int socket_send_channel_destroy(QIOChannel *send)
 {
     /* Remove channel */
+    yank_unregister_function((char *) "migration", yank_generic_iochannel,
+                             QIO_CHANNEL(send));
     object_unref(OBJECT(send));
     if (outgoing_args.saddr) {
         qapi_free_SocketAddress(outgoing_args.saddr);
@@ -101,6 +106,8 @@ static void socket_outgoing_migration(QIOTask *task,
     Error *err =3D NULL;

     if (qio_task_propagate_error(task, &err)) {
+        yank_unregister_function((char *) "migration", yank_generic_iochan=
nel,
+                                 QIO_CHANNEL(sioc));
         trace_migration_socket_outgoing_error(error_get_pretty(err));
     } else {
         trace_migration_socket_outgoing_connected(data->hostname);
@@ -127,6 +134,8 @@ static void socket_start_outgoing_migration(MigrationSt=
ate *s,
     }

     qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-outgoing");
+    yank_register_function((char *) "migration", yank_generic_iochannel,
+                           QIO_CHANNEL(sioc));
     qio_channel_socket_connect_async(sioc,
                                      saddr,
                                      socket_outgoing_migration,
@@ -163,6 +172,8 @@ static void socket_accept_incoming_migration(QIONetList=
ener *listener,
     trace_migration_socket_incoming_accepted();

     qio_channel_set_name(QIO_CHANNEL(cioc), "migration-socket-incoming");
+    yank_register_function((char *) "migration", yank_generic_iochannel,
+                           QIO_CHANNEL(cioc));
     migration_channel_process_incoming(QIO_CHANNEL(cioc));

     if (migration_has_all_channels()) {
--
2.20.1

--Sig_/l8g7G.FqFtewSq3AYYNqV+B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7Fm64ACgkQNasLKJxd
sljZLxAAgsAWsDmdQ++wo+H8X0iEHJBq9/rXWg86mwA05S7vtV1Nt9hvrOLLrIyS
W0F6klqZ9g4w7PoQzOR2O3IgnHMHMpVvDn/1KH/JOshhiLJQcQrl1Bhx0sPPBcN2
n1tFs0xPb+6Baor3FqpjHnKt3pesipR5AYXrlrz/MyU6XbAYdJniZtfANh+yrdNU
0Y19/zqgCK4yNnetc2y0q6c30FAxDUh4IJMqTJ1/xGJoucbyWLb39dd1mCY/mUfs
5TtAqf1ISEp/pxCaMoZLlrI+R0DIsnLOEJX5PUiRn7xC8IKSZL/hndhLaPZOooHc
zcATV1pGraEvQ4si/3z7nbdyXHT3ym+e4TsdPYCPq6xf5GHSoe766srYWTWT9bNC
HZkMkPWQHcqilakjgHfHcac9E3PpHZjrLBGt2/mDKhK8aLs35AyB8jaUwalSmfGz
QGVB9v0klrg0hMnrvgCLa9tX4VVgH64DCeU010dzf61sCkFZ/2b5+RPz4V7ZsPzu
QaWzaKrqO65Y6cT6XgVEzY6sq6Ix4BsU6zUTCA1aIePLpMJi+vO9HU5cArukHzoe
ppJ/ZP5nS1Lz5IhWCrzXJv2ugMUCzG8a8rSvFi1zdeQoTtjEUKSF34wL2bftUnDL
122ZctFw8iVpuyIoyRL7+j9KgsUbG9kRZ0LdZns3vDoyz4Xu650=
=Oj2/
-----END PGP SIGNATURE-----

--Sig_/l8g7G.FqFtewSq3AYYNqV+B--

