Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8FEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7A220720
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="f0Hx31tD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7A220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkDo-00083g-5H
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8c-00042h-5Z; Tue, 23 Jun 2020 10:43:02 -0400
Received: from mout.web.de ([217.72.192.78]:50347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8a-0002WD-0v; Tue, 23 Jun 2020 10:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592923374;
 bh=OXYA2rA7TS0jYFzP7AJQBG9AKnGgKRdTNDQd8/ZssBo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=f0Hx31tD5Zyd4sLchX4lMbw3+OaNETax0snATbwMMfWU8ylMonZ8bGCfVNqHSwqSY
 5AUWTmfXzQkS5OPKCqqNEwWZ4+0G+tfJDj9ZAO++vzJ6Ii9wYfZ9uopSFFDUgFUG6P
 5QKaa1klVz5kg+H1KjfRPuwJm7T8qCowINOGlRaA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.8]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76bV-1jmMIE43wd-008ZT8; Tue, 23
 Jun 2020 16:42:54 +0200
Date: Tue, 23 Jun 2020 16:42:52 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 4/7] migration: Add yank feature
Message-ID: <5f155c94d2d516bf2a10cb183b1740f7d56f0459.1592923201.git.lukasstraub2@web.de>
In-Reply-To: <cover.1592923201.git.lukasstraub2@web.de>
References: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qNaxyqW6TU8r.MY5ARPCnkG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:CF9JN5Qkz5PZh0Zymzf09S1yWzxZ0pUq1Rr1YOcNM1LAb43u9gr
 45BBa2qFope7ZWA1jn9XvPDu2uJOq8bbsr6h+zM2qVRiOPCmHiXo0rDsW/vGq7BzdB2+DXq
 mQ374/OwAJrjd6AhqLNkZ8o1dj0QYqY89vy9lraxJEXS4mEzhsL8D8VkFkgTAKF0QKFrquC
 qgM2mCb4aw2sXU2egLXvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lx3sl0MR+WM=:mlxqhJHadW7A8sb9TMUvrT
 TUd8XYgxdFRCnU0beXcuthvCCtsi4wcuAPWaj+cWN1/B7Kj92i5H1pdpBJMWB/3rzs/WWZucl
 5NAqyZy//j7kUrYPZ8SHlhptt+m7dke9pxX3s7pQdq5X0/rL1FBbt9B1VJagmcQal0tcV9FdR
 60N3JoFCVVpMFER/i2ngZaReoNydfZuLdWSpsfBYtauN85hUGu6gTGFIOeIHDjOkcUZVyaYnN
 oCZqkoWlP3+EmMHqxAjuf4GuWPHk17n0271Iv5nwDkZnDDG26MsthbzH41KsGqOpQTPlJYNT9
 jwV14glA769RVFEoSqaajR4HgNjlS3xTdJy9b4QUMqkI1HQEzIa6aqhkz8jco0U9EsrhdhOS4
 cWNtw09HiPF6fgdrjcskkHRn5+gkqSdsroRMP4dzcuAtJAp1BtxitAXkYpy3vCkwhSArV09KE
 thhOnqn3zQtq8f1/PJQeUFg/9vOUuudWeizLlr6EXyC5E1je++vDoUvcJDfmA2SkJcWMzYQEQ
 q3502rw/WOJOUI/EcA/kpyRna/7doJIi10kLET8GSL2q073YKe8gQMUx0nIHIivwmlRBJaauS
 9hepV9pJJFDSWTDd/O1PFEIaf7vSbab2VK9FYyOwrqoS53Xu9+ZZkZOWg+0/z6TzlM4bj+Lh9
 f9jbbLV+cFAYLCADB8/qNGeFh0K9WHviEVgwFaN91idwYcK3HXRdt8ApB7Ig9RzqqDpTib4Dw
 /mct0aLOSC9nY0PxA7U8gSpCQzdspaBJBzodFA4p5pplC3MyRi8YJmyIHad5SUu3qWYdsCD49
 j10yScvHqj/J2sRL4qTNPp6iC+dXmI1T6on1E2t3/zlSxObFnTmxTcJRpngenZ0rnS6/uMslT
 zfjr018kgSH9ht4w37sXZgiPSZKRF0ZOBohb645fbS4hkgVtKXF4mVQVmdGY5qkJGawIXtO0I
 aPee5LP/pNNNS2a2NKzC68Rc55bBhcmvge1+KkwAlub/lrH13ZzWglGC0e8Y3W16aV5+/eanS
 nYCNBkHuDlnkjowQvPABVrE61iFXliajUklxj5+fNGJ2nHnxSQ9bY3f6YeQev8slTuzlrbtTd
 F8Z9+vpM6n4/7NrSsFMUuT1WMT5yDsKSGE35srlZZk8XGs4I8vXVkrGzVbjL8S1aac0Zhjt5i
 tPhQl0jhnv3JjMWcPV3eLnaNzAZYUJ1MgUQYF0eS5GoaPSnMKMfkGrkU3tWc/yBQsPVB7YxED
 UocIJ3GY4vYijD93U
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 10:42:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

--Sig_/qNaxyqW6TU8r.MY5ARPCnkG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register yank functions on sockets to shut them down.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
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
index 481a590f72..720f0f9d44 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -54,6 +54,7 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
+#include "qemu/yank.h"

 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttli=
ng */

@@ -231,6 +232,8 @@ void migration_incoming_state_destroy(void)
         qapi_free_SocketAddressList(mis->socket_address_list);
         mis->socket_address_list =3D NULL;
     }
+
+    yank_unregister_instance("migration");
 }

 static void migrate_generate_event(int new_state)
@@ -362,7 +365,9 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     const char *p;

     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
+    yank_register_instance("migration");
     if (!strcmp(uri, "defer")) {
+        yank_unregister_instance("migration");
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p)) {
         tcp_start_incoming_migration(p, errp);
@@ -377,6 +382,7 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
     } else {
+        yank_unregister_instance("migration");
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
 }
@@ -1646,6 +1652,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+    yank_unregister_instance("migration");
 }

 static void migrate_fd_cleanup_schedule(MigrationState *s)
@@ -1912,6 +1919,7 @@ void qmp_migrate_recover(const char *uri, Error **err=
p)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
+    yank_unregister_instance("migration");
     qemu_start_incoming_migration(uri, errp);
 }

@@ -2048,7 +2056,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
@@ -2062,6 +2072,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
@@ -2071,6 +2084,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
index b979ea6e7f..75e8b85697 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -63,6 +63,7 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "qemu/yank.h"

 const unsigned int postcopy_ram_discard_version =3D 0;

@@ -2897,6 +2898,7 @@ int load_snapshot(const char *name, Error **errp)
     qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     mis->from_src_file =3D f;

+    yank_register_instance("migration");
     aio_context_acquire(aio_context);
     ret =3D qemu_loadvm_state(f);
     migration_incoming_state_destroy();
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3f4448a20b..889fc4e4e7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -450,7 +450,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qdev-=
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


--Sig_/qNaxyqW6TU8r.MY5ARPCnkG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7yFOwACgkQNasLKJxd
sliWng//Xi5bYxm1OpnmIey5vEoGvysu/xJm+hFe25BgQvUB1FB0KOAgHjWker9y
o3k0DJJI+uQS44hRmeQV5fyyquxL9SlwQoYw4ahf+tPEEVeVERqWmQHnSUgZjCNl
8XxBRZrucxghVbeOVgvR/dhrbeLc6+ASIEPEPbTRb+H7WcJp/C0+JA/w4V95lvWb
gtlao5Ri+VZRlin3ScOZHba3XjZ3C3QlcZCRdapxbIB59OpIQm/93CYwItcmpIew
oohrRiYYwbDgkpCKTBqaEDMpyvb0dggXyvjq3WeZpgMdCxYMWEDK1G8yjvNWLwqX
ibNYeEFpnqf2XpBmgZcUCcFHoCSwrbmI33d65+TojyASWB82YvXZe2m3TsxXbjVQ
+Ra9pXYaN6U/mSoAaMyVv08onApGc59MlIKsQH6HC21UkVCbj7p3z5VbKNkoI3DI
AwSNhQeoaTM6CC0fUdWnvkb9cX1nuBiBI++AskuE2aOkEfPdGcAupo0Sx954/ajF
JOaGbeJCUpp6/1GfHxfjUvDHugWX3vrnhgFz7+AjckJ/VrkyiNq6HwO9KcO1f6DD
FzyL81iHMO1E96bk9zKGT07itPct3LhT9v9atlcuY58n+dP/onaf07Xg2nUxkWSK
VFs5W7dCdiFGJ7SVeL4N1lvdjEazYJEoYmqHanadFEfVlaOuFqE=
=Nxi9
-----END PGP SIGNATURE-----

--Sig_/qNaxyqW6TU8r.MY5ARPCnkG--

