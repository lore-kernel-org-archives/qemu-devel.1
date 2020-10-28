Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00FCC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3335024810
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="snsUX35v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3335024810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqY3-000602-6G
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqS5-0000FW-5X; Wed, 28 Oct 2020 14:45:41 -0400
Received: from mout.web.de ([217.72.192.78]:38387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqS1-0003HR-29; Wed, 28 Oct 2020 14:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603910731;
 bh=KFqCmUWN7PYq3vUbkZ3VQqIF71Pb83ts5WFS/wlRdQg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=snsUX35vsvJtMOSBvNGqQblJCieDiwkkjTcYhsPtpAg5qwIIEC4bsu9WmqN2sm++Z
 tH6rV3CNuWH9k9caAHksN9xTVskRNrLJcDXXX50s4334aLrypPzjEPlhfMLNcYORwl
 0j9TuL0aFFl1u69FVClpqo5gAVNcoWffq8GfmVhc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.124]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWor-1juN6O1gWp-00eTPp; Wed, 28
 Oct 2020 19:45:31 +0100
Date: Wed, 28 Oct 2020 19:45:30 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v9 4/8] migration: Add yank feature
Message-ID: <e4f0557abcc36a8b47710ba0d822928781a933db.1603909658.git.lukasstraub2@web.de>
In-Reply-To: <cover.1603909658.git.lukasstraub2@web.de>
References: <cover.1603909658.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a+KSomPcRAk6K6ZvZ6Sbjdo";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:kPn4PjvNOhU26H94/Fe2nT0Ae+wWgNOS92slpp0eBVzVaGa5UBM
 7tAbP6sWRlQRAmSL6Eq2evdUddX4SQrGHXvzt9W2WdefZJcdgCoQ48Qgw+xNFmzY4IeGmXV
 bIs/CvvID0yLovuLcc2KLc5+mxQ+JAa+MpXiX9kFxboShLZ1oH3Wj9UDskZktWnt2QXbdnI
 iQfulxUJHr10eImH8V0PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8ROqpSdbiGE=:K1ipue7wH7qybb7hvpAqmi
 rmQvtOJ1mzSo6zEJ8ZvEtQ9S6PxVdu9r+b3tx+KeDiTjr6TbljPwxgTT0v6twYlOzRCKrdTv5
 nUgDS2AjrlYdMdk7fmJydmI5euXez7c+uQiQ8eqCQYt5TMDF9Gqd4fR8ZiNY0V+D+Nwb5FDeT
 kx/Qhb0/4j1vjxgvLh5kN/Cc59lkFDRCOB2JNRBH5VnjJjoJMWqwFjC2RQxURNWMt1a6S3t7d
 +LLSq/Y4eDKB4o0OORATT+bfmTpB8CVCdC8KliEiVKVWpdJXf4ZHuhOBiRkWiGDilWqEI05w1
 lrwsZJmiHgbJK1SMN7geweI7sauJuoaf1XNLIMiH0p3i6BR70lUI75uSMbg5KKBLKTFN/qh3G
 XbAqC62dwl5A3iM91j61IX4fFByrFCrr7Ep/Yht3lF1iPdLjF0p+NYLdMvgXDdSiR8xDRwdmn
 ni8GvVVcsXw66L08y4XMHnOxPu2s8VBrOhldMAALsT+leJL7zl889x6o2v4O2VWHR+VD6baKb
 upoxxcvLCZLBv4E2dIZ3wOTSgkxT1bXL6kC8H0/MlzzkUT++fc37wdbWgH60eDnKgpJQc7yEQ
 4TXgzRUIqVhVHthpZgzINuDY+dUe/OaEq/m5dswiQHsDDj4xfai1xPXGWGt0zjFzYsEsKL6Q3
 +rMv/SEC/B3zZX1x5FpOWJKYVqYEQVP26dEklDY4XoPSNbOWEYgUuA8ABaUxhlcJRs2+OYMti
 0in4pjRmMXA/mz6MCU2Jb2/WRwirVifjAOejGI7GHPek6hUT3qMyHtyMZ1co/vVpP+qrHghXZ
 Ae+SKRe4Uv3MnA0NirGwz0AY25F2FXd7MtaiqrWaZLrV3bKQv6JhRdbgMk7TB4SXKXoqW4ZEs
 aoBsPP5zlAht22NbY9mA==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 13:12:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/a+KSomPcRAk6K6ZvZ6Sbjdo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register yank functions on sockets to shut them down.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/channel.c           | 13 +++++++++++++
 migration/migration.c         | 25 +++++++++++++++++++++++++
 migration/multifd.c           | 10 ++++++++++
 migration/qemu-file-channel.c |  7 +++++++
 migration/savevm.c            |  6 ++++++
 5 files changed, 61 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index 8a783baa0b..35fe234e9c 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -18,6 +18,8 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
+#include "io/channel-socket.h"
+#include "qemu/yank.h"

 /**
  * @migration_channel_process_incoming - Create new incoming migration cha=
nnel
@@ -35,6 +37,11 @@ void migration_channel_process_incoming(QIOChannel *ioc)
     trace_migration_set_incoming_channel(
         ioc, object_get_typename(OBJECT(ioc)));

+    if (object_dynamic_cast(OBJECT(ioc), TYPE_QIO_CHANNEL_SOCKET)) {
+        yank_register_function(MIGRATION_YANK_INSTANCE, yank_generic_iocha=
nnel,
+                               QIO_CHANNEL(ioc));
+    }
+
     if (s->parameters.tls_creds &&
         *s->parameters.tls_creds &&
         !object_dynamic_cast(OBJECT(ioc),
@@ -67,6 +74,12 @@ void migration_channel_connect(MigrationState *s,
         ioc, object_get_typename(OBJECT(ioc)), hostname, error);

     if (!error) {
+        if (object_dynamic_cast(OBJECT(ioc), TYPE_QIO_CHANNEL_SOCKET)) {
+            yank_register_function(MIGRATION_YANK_INSTANCE,
+                                   yank_generic_iochannel,
+                                   QIO_CHANNEL(ioc));
+        }
+
         if (s->parameters.tls_creds &&
             *s->parameters.tls_creds &&
             !object_dynamic_cast(OBJECT(ioc),
diff --git a/migration/migration.c b/migration/migration.c
index 0575ecb379..e2c1123a90 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -56,6 +56,7 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
+#include "qemu/yank.h"

 #define MAX_THROTTLE  (128 << 20)      /* Migration transfer speed throttl=
ing */

@@ -244,6 +245,8 @@ void migration_incoming_state_destroy(void)
         qapi_free_SocketAddressList(mis->socket_address_list);
         mis->socket_address_list =3D NULL;
     }
+
+    yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }

 static void migrate_generate_event(int new_state)
@@ -390,8 +393,14 @@ void qemu_start_incoming_migration(const char *uri, Er=
ror **errp)
 {
     const char *p =3D NULL;

+    yank_register_instance(MIGRATION_YANK_INSTANCE, errp);
+    if (*errp) {
+        return;
+    }
+
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (!strcmp(uri, "defer")) {
+        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p) ||
                strstart(uri, "unix:", NULL) ||
@@ -406,6 +415,7 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
     } else {
+        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
 }
@@ -1698,6 +1708,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+    yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }

 static void migrate_fd_cleanup_schedule(MigrationState *s)
@@ -1972,6 +1983,7 @@ void qmp_migrate_recover(const char *uri, Error **err=
p)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
+    yank_unregister_instance(MIGRATION_YANK_INSTANCE);
     qemu_start_incoming_migration(uri, errp);
 }

@@ -2109,6 +2121,13 @@ void qmp_migrate(const char *uri, bool has_blk, bool=
 blk,
         return;
     }

+    if (!(has_resume && resume)) {
+        yank_register_instance(MIGRATION_YANK_INSTANCE, errp);
+        if (*errp) {
+            return;
+        }
+    }
+
     if (strstart(uri, "tcp:", &p) ||
         strstart(uri, "unix:", NULL) ||
         strstart(uri, "vsock:", NULL)) {
@@ -2122,6 +2141,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
+        if (!(has_resume && resume)) {
+            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
+        }
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
@@ -2131,6 +2153,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
     }

     if (local_err) {
+        if (!(has_resume && resume)) {
+            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
+        }
         migrate_fd_error(s, local_err);
         error_propagate(errp, local_err);
         return;
diff --git a/migration/multifd.c b/migration/multifd.c
index 68b171fb61..620b55f5d9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -25,6 +25,9 @@
 #include "trace.h"
 #include "multifd.h"

+#include "qemu/yank.h"
+#include "io/channel-socket.h"
+
 /* Multiple fd's */

 #define MULTIFD_MAGIC 0x11223344U
@@ -962,6 +965,13 @@ int multifd_load_cleanup(Error **errp)
     for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];

+        if (object_dynamic_cast(OBJECT(p->c), TYPE_QIO_CHANNEL_SOCKET)
+            && OBJECT(p->c)->ref =3D=3D 1) {
+            yank_unregister_function(MIGRATION_YANK_INSTANCE,
+                                     yank_generic_iochannel,
+                                     QIO_CHANNEL(p->c));
+        }
+
         object_unref(OBJECT(p->c));
         p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index d2ce32f4b9..afc3a7f642 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -27,6 +27,7 @@
 #include "qemu-file.h"
 #include "io/channel-socket.h"
 #include "qemu/iov.h"
+#include "qemu/yank.h"


 static ssize_t channel_writev_buffer(void *opaque,
@@ -104,6 +105,12 @@ static int channel_close(void *opaque, Error **errp)
     int ret;
     QIOChannel *ioc =3D QIO_CHANNEL(opaque);
     ret =3D qio_channel_close(ioc, errp);
+    if (object_dynamic_cast(OBJECT(ioc), TYPE_QIO_CHANNEL_SOCKET)
+        && OBJECT(ioc)->ref =3D=3D 1) {
+        yank_unregister_function(MIGRATION_YANK_INSTANCE,
+                                 yank_generic_iochannel,
+                                 QIO_CHANNEL(ioc));
+    }
     object_unref(OBJECT(ioc));
     return ret;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index ff33e210eb..33da4692c4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -62,6 +62,7 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "qemu/yank.h"

 const unsigned int postcopy_ram_discard_version =3D 0;

@@ -2940,6 +2941,11 @@ int load_snapshot(const char *name, Error **errp)
     qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     mis->from_src_file =3D f;

+    yank_register_instance(MIGRATION_YANK_INSTANCE, errp);
+    if (*errp) {
+        ret =3D -EINVAL;
+        goto err_drain;
+    }
     aio_context_acquire(aio_context);
     ret =3D qemu_loadvm_state(f);
     migration_incoming_state_destroy();
--
2.20.1


--Sig_/a+KSomPcRAk6K6ZvZ6Sbjdo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+ZvEoACgkQNasLKJxd
slhk+xAAneW19MdYSD0v8+BvO61xrZC7o6HNPYw6mwOJd2GiJmrksHUDkdyaxC9q
0hRzIP9c4pMUKnrkcslMgJWqf1RD1RaVbv4Rf7Z3nvi+5is9ImoQ3e1FvRKgbCNX
8MyNHWw32DbfXeoZpeiGgsD2OOk7I0Vt3+cf0uhFQbzreOjraZxDQp4jWJRDBWoY
oYPM/XeWS3W8Mo/AsguDLrLKOZzRevELVI80OXNl1ghnbPJNgldGC9c3dsKhJ162
RztCEagd4z23pLErZvpNdFvqPLfpwkqYF0gMwZlMuGl8H8osjrF2iB2qijUfi+Nk
6u3SQXPyTTFezbZBr0nEf0RcGTw4Keeb/i3abH/Q4GQ5Ku9Q3HcQDG2UsSHcgljr
skb4pAHg7gkrYFhahtJ2WXJVNKyFC2DE9sRQlCH3EPzukgC5dKX6hDwFL874vyVq
xQwyrHnZsQ0JNWDmHPcqDTeQpnfbPc6rnKIfYoGTU0SGHn8+asxBDtdcz03wgxT7
2pxAszk/O+WMLDfjwt2gFP6z3yGT3HrstpWhiZnLxOt1rFoZ5F7HL/51KDsS4HcO
p2+nzgZhDkjnvpcv4kwBFx7KKRtcSzc1fEeGa6VYKtaBhJldgVE64GTjkbFo5//g
JxrHO7q/XyhJsVHqTEYyOQPmiJMPzPVvXbxVlXGJbWKMhknUAqg=
=3yqq
-----END PGP SIGNATURE-----

--Sig_/a+KSomPcRAk6K6ZvZ6Sbjdo--

