Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D94E208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="crUpuB2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D94E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RQB-0003hb-7k
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJW-0007hD-UJ; Fri, 31 Jul 2020 05:26:55 -0400
Received: from mout.web.de ([212.227.17.12]:39677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJU-0003Gy-5B; Fri, 31 Jul 2020 05:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187607;
 bh=wrF87AxrlvPP8Zny62NkjRU+1B5hmL1ZilzlmOqAocY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=crUpuB2toA7muLJ5c1tkF6CFO6bFpy844Tl5jpyxVmE0QrMm8sgDfi5dOtVPTWDIa
 CObQ53LXkc6pJ8oP40Lk4LounQPg3rl1Wr7ZNRjIM1q+X4hlG3Gtc+lJ+T/fJPRCRo
 t/1bHSVtgtc6Om9hSEyHR5Z9I/nXAEzUhO+axrcU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMzM-1jt9qy3dJ8-00AVSm; Fri, 31
 Jul 2020 11:26:46 +0200
Date: Fri, 31 Jul 2020 11:26:45 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 4/9] migration: Add yank feature
Message-ID: <7ed75e5566229179827f025c6393f460e3a726a2.1596184200.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596184200.git.lukasstraub2@web.de>
References: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//=+vShEdzamHa_V8WywO81+";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:nOYWEBwxDAKj7jiSvoauAr1N9o5OkOD1swv3yhL/SIbWOckhnZG
 W4DXE1D7jKxWeuAOvx+S3c6e60oCcU9cMJ8jFf7yMgrmlpDOeu2Q96QppUKzpT4pm+6X7oJ
 2d8LZFIdAPkCSYf3hJM6OeZlyp2Umw21oHb8QcABWzPRVzJcDAf/L/PrRiIXO5qsVE0AEeY
 aMHDwT0aD5YVwe8vaAEBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VpzTzLDA9zA=:q/hv1pkateKiDvBafH9OTQ
 s6MYCSYnxfO7RIIfYdaCKSSLLAleUBnQmI/COWNDpGJBXO7tfl0tfhVMsmaqmAWseFNDSX5T/
 2p74IFIMSQsLoEY5o3KzShNqaz3hg/BTeN3oJgATXNnzHteIPvYcY5FLJ3NSYOgjTeApi8vF+
 C9wsAFHw+nPk1pvKYxQGgtC7y8jjOr7j+R99htsp4JawgQU5cgwBH+vnN3rqrSoIVPOkN8EXw
 2T63yauQuWksZYkPYNGvZloxvGLGz0hyCwpM2V/43f8JPnZf4f77yDHmS4+5wrfY5ku/RgqLj
 nJIyqYWG9n7dr93x4icO5g3R01U0+6VT+Ae21/KPURQUfhHJh8ZjKvzqVpdxuej3ofjPeZJrA
 I/ZxA9fk/IxcIOaJFzKUT78ayBKpnVBPZo00inCKU/ydj8zgDoqzYF2d83OQ4G/znIVVbYDaH
 I18NvpzVRbzL7yMk+y06SkVD/q3LilmOIemi5W64AY3hQ89PyzOrzSraoupMts5A4yNbDUoGB
 bzSSdIxXjBooxO4KXFyFUkBbFnRdD3hw9vPUtfzkmhCReQu9lIGBIWy9DOIO3ZZoGDMDwEsvq
 ECIaB1PYvV8xTnGPFGAyJ6oJdsT8bgjF/UJv5eI0FFCP3J1Pv1q6yVDOSXAfDX8s0SyBXyJxJ
 yheMWQmMMqte6y71ufrm9PwD3UoeMG5BtHPBOpfpfmoKYA6iCny++5w4wCqMYxuWrmbBsguQ4
 NHrOPZ3AZajs7WDOdgs9z3m4nUpUSPk0yCLP/bRJhBG/vxPrfBdFOQl8XOI3F1XkeU2i0DJu6
 FeWC1a23eF2Hmbv0DTiIi/cOuorDxd9Ysi3MYPJv27x0E4MExz07OmWBAeTF5B46SsbJ8Rbgc
 lUtps/ug6pZj8XmTAKit3WdIi4pg0cPXDi3DP+lQXdzjX3OfMqi0EySC2lZa76F5Wvp7MxEIb
 EyvhGDgYVTFO5OGRM1ZJD5DUdiVTmysVrTufD3kk9z6fUBIWfEw1HkLlrQd4pbXK0XFtDWdv0
 iQ1pekyTbfwBFc/PPXH5NhMyDoK84Kacxw9WhwDaBORdpzonl1KR1VL3AibcNXtQRFVP2b+rB
 Iw8GbQy+qfpPgZjSNYeko7YDbyi9Wn8q2Pfw1EITOHhe/j8r9I2uHnsUO7OTc49AgBgwiSLUx
 wVIlf52+eSHAFhuFsFS3/nMtveMSFWJmlqF3RfGSeBUkt7TlmelqvTMzVncZJxnH7QuqqsBOb
 VYw9naukWcOeJlXnotkHER8jKGEF7yPmMAtPVeA==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:26:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_//=+vShEdzamHa_V8WywO81+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Register yank functions on sockets to shut them down.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/channel.c           | 12 ++++++++++++
 migration/migration.c         | 18 +++++++++++++++++-
 migration/multifd.c           | 10 ++++++++++
 migration/qemu-file-channel.c |  6 ++++++
 migration/savevm.c            |  2 ++
 tests/Makefile.include        |  2 +-
 6 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 20e4c8e2dc..21fc8046b9 100644
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
+        yank_register_function("migration", yank_generic_iochannel,
+                               QIO_CHANNEL(ioc));
+    }
+
     if (s->parameters.tls_creds &&
         *s->parameters.tls_creds &&
         !object_dynamic_cast(OBJECT(ioc),
@@ -67,6 +74,11 @@ void migration_channel_connect(MigrationState *s,
         ioc, object_get_typename(OBJECT(ioc)), hostname, error);

     if (!error) {
+        if (object_dynamic_cast(OBJECT(ioc), TYPE_QIO_CHANNEL_SOCKET)) {
+            yank_register_function("migration", yank_generic_iochannel,
+                                   QIO_CHANNEL(ioc));
+        }
+
         if (s->parameters.tls_creds &&
             *s->parameters.tls_creds &&
             !object_dynamic_cast(OBJECT(ioc),
diff --git a/migration/migration.c b/migration/migration.c
index 8fe36339db..29fefcb7dc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -55,6 +55,7 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
+#include "qemu/yank.h"

 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttli=
ng */

@@ -243,6 +244,8 @@ void migration_incoming_state_destroy(void)
         qapi_free_SocketAddressList(mis->socket_address_list);
         mis->socket_address_list =3D NULL;
     }
+
+    yank_unregister_instance("migration");
 }

 static void migrate_generate_event(int new_state)
@@ -380,7 +383,9 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     const char *p;

     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
+    yank_register_instance("migration");
     if (!strcmp(uri, "defer")) {
+        yank_unregister_instance("migration");
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p)) {
         tcp_start_incoming_migration(p, errp);
@@ -395,6 +400,7 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
     } else {
+        yank_unregister_instance("migration");
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
 }
@@ -1662,6 +1668,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+    yank_unregister_instance("migration");
 }

 static void migrate_fd_cleanup_schedule(MigrationState *s)
@@ -1935,6 +1942,7 @@ void qmp_migrate_recover(const char *uri, Error **err=
p)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
+    yank_unregister_instance("migration");
     qemu_start_incoming_migration(uri, errp);
 }

@@ -2071,7 +2079,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
         /* Error detected, put into errp */
         return;
     }
-
+    if (!(has_resume && resume)) {
+        yank_register_instance("migration");
+    }
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
 #ifdef CONFIG_RDMA
@@ -2085,6 +2095,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
+        if (!(has_resume && resume)) {
+            yank_unregister_instance("migration");
+        }
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
@@ -2094,6 +2107,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
     }

     if (local_err) {
+        if (!(has_resume && resume)) {
+            yank_unregister_instance("migration");
+        }
         migrate_fd_error(s, local_err);
         error_propagate(errp, local_err);
         return;
diff --git a/migration/multifd.c b/migration/multifd.c
index d0441202aa..2c9863e770 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -24,6 +24,9 @@
 #include "trace.h"
 #include "multifd.h"

+#include "qemu/yank.h"
+#include "io/channel-socket.h"
+
 /* Multiple fd's */

 #define MULTIFD_MAGIC 0x11223344U
@@ -866,6 +869,13 @@ int multifd_load_cleanup(Error **errp)
     for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];

+        if (object_dynamic_cast(OBJECT(p->c), TYPE_QIO_CHANNEL_SOCKET)
+            && OBJECT(p->c)->ref =3D=3D 1) {
+            yank_unregister_function("migration",
+                                     yank_generic_iochannel,
+                                     QIO_CHANNEL(p->c));
+        }
+
         object_unref(OBJECT(p->c));
         p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index d2ce32f4b9..d8f8384fea 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -27,6 +27,7 @@
 #include "qemu-file.h"
 #include "io/channel-socket.h"
 #include "qemu/iov.h"
+#include "qemu/yank.h"


 static ssize_t channel_writev_buffer(void *opaque,
@@ -104,6 +105,11 @@ static int channel_close(void *opaque, Error **errp)
     int ret;
     QIOChannel *ioc =3D QIO_CHANNEL(opaque);
     ret =3D qio_channel_close(ioc, errp);
+    if (object_dynamic_cast(OBJECT(ioc), TYPE_QIO_CHANNEL_SOCKET)
+        && OBJECT(ioc)->ref =3D=3D 1) {
+        yank_unregister_function("migration", yank_generic_iochannel,
+                                 QIO_CHANNEL(ioc));
+    }
     object_unref(OBJECT(ioc));
     return ret;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index a843d202b5..bbbdbd8ea2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -63,6 +63,7 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "qemu/yank.h"

 const unsigned int postcopy_ram_discard_version =3D 0;

@@ -2935,6 +2936,7 @@ int load_snapshot(const char *name, Error **errp)
     qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     mis->from_src_file =3D f;

+    yank_register_instance("migration");
     aio_context_acquire(aio_context);
     ret =3D qemu_loadvm_state(f);
     migration_incoming_state_destroy();
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c7e4646ded..e733918269 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -452,7 +452,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qdev-=
global-props.o \
 	$(test-qapi-obj-y)
 tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
-        migration/qemu-file-channel.o migration/qjson.o \
+        migration/qemu-file-channel.o migration/qjson.o util/yank.o \
 	$(test-io-obj-y)
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-=
obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
--
2.20.1


--Sig_//=+vShEdzamHa_V8WywO81+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j49UACgkQNasLKJxd
slgK1Q/+NGa7fHHaHMCV9GuJ66c7PSzAxnGkovYUwiQ9DaHbX+I27FbqJUh7Gxr/
RIGkvXhwN23ocnQ0xkxZp5IyfzSAtHJx5U+Sk2/fWj3J7HGD3jbMwka5ytxqmZu4
gO8cR7NeqziFxp8ax1+P9Ycc1bfHgc1E/Qqm/9zBUEtou3AZTvJ7DPpN0PUpjcjR
gzsPFhj6oMS7EMpAYQGczXkretOLaj0we6PnsmD1nlSKKuNOU0NeKoYo8bTYbPyK
QnKUbakAOQDTezQoXJmBAtmKnG5WZDpoSWT7jIk6wfINinBAusY45+1SyoGOSY3+
CpYZ20/nXCcRxoNP06oST3q/ZAYrfsYZMK66S6cbeL1dRpIDuoZvyT3f8jk/wHMf
AoyyYmLWaxj9p6x0+bUHOewGr8BYyHqa3GQiiX8g7zjzGiLn2ROfc2sL/xmvfJcR
d1/vOunkkpDbswhusWcLv2mnBEzN6chffUlebr4SbHCnEqzHMKjSYlfOzFpFa6CQ
8ADBgKsWog/kcatmp8ezlXGSyWc3i9cXYX8EQmKFFHRirw1w142ZmKbWb5/pPlLy
ZN7I84v3EvefWW75L/1Z6Lrzf3DEh3Ee26sAPsQ8EH/GmWeAFhCwT1mKk6rnlCv6
wcFqI2r8j4NHIDElP6muwZtI4Q1MBFRjAHUa8cDGBDirGwpsgPw=
=wJrm
-----END PGP SIGNATURE-----

--Sig_//=+vShEdzamHa_V8WywO81+--

