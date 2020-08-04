Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F23C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8172177B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fuTnhldl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8172177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sBb-0000XI-TK
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s39-0003cr-Av; Tue, 04 Aug 2020 04:11:55 -0400
Received: from mout.web.de ([217.72.192.78]:34627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s37-0006bJ-3B; Tue, 04 Aug 2020 04:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596528707;
 bh=7L3s5EjxRt+eOZ78W6TKKUDcFvSCE8Nn+E6n9Q/Tngo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fuTnhldlgBMm7KK9cofO2APIkNLcRFKwXo4veLbJYMLLo6tEF84Xd/NjydXih/ry6
 kH+zgXHPYSOMIAUxKr64x/F3MhqC3EaqbJgc8PPV1I5ZMV8anRxfAIxQIquDABXhgC
 k3XijOrN8+bz7kt+jEn10nBeowzzrlQJ4xgg9ddo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYeQ-1kHoPd20la-00WWUf; Tue, 04
 Aug 2020 10:11:47 +0200
Date: Tue, 4 Aug 2020 10:11:45 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 4/8] migration: Add yank feature
Message-ID: <e439085eb0888983595b0f47a379a2d8945ba50a.1596528468.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596528468.git.lukasstraub2@web.de>
References: <cover.1596528468.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dpStp/=BCwa43iQtYQAAHKK";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:A8ccW7cWdEW21ryWus8rORgRX/xmxI5cdCqcVHk/zds0i5oiNMi
 EyXFmykss08vN2LqKoQU/CDburAd2bZoaSbVGUKCUbHg6ha04pGaRoS1wEFiSGNoQjjRqJN
 cK/FDABsL4trrDUW47o6f8Qee8QReec0vG1Q5y7ODbQax+/5vmv95KHkPNd/i3sVc41fUU6
 MxbxsD2OV/5wH/uNF6N4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IG8sV5X4tRI=:x8jcojFtI/Wt2OvrfXe3Em
 AqvbQ2K5E8MVF3W8Z2tNir06WgtgcQIMSYxXMIQYLGlchaaXqM2aWXa8jsj3JzXIlvX74A2Nl
 rOhpSGzCCCO+XzAF5oCU9oTuLMMtIr95PIHgllADnXQAOfG/QGtdeZc8SxbCGALngCYVkc7SN
 wcy8f0onPyC0YI7rH828qkbNsR/2lN5f5h4nInX6R+oqahYZX+TJKXjELK1XRTLBSVUO9/uwl
 Jec+mwd+kiYVx4/fd7M4gNE4rp0vLohlMz7jD1vdJpqLKDr7WF4rZuRvRew/3DcNodBZCTfxL
 ews6Q6F9NmgxSrtcsiGkeuSLVUHnbDpllzsQxKf+xuX7liXP5vxCRD/nZ7IV3dCSNPksHqSNh
 fn+JLZU8qLCHGqXjmjKugpZvgKu5SzK8fDtGpiXyQdzx11HnSbwC89vgyyeAS/tmuMEoyBcq8
 pDHlDQoM/yrqlVYyXmME5+eWvM7xyX9Z0qMkcNIgtZSNQu2Toh4shX8nuQ3jWXb4pgCYjycxU
 MgQlt56MjTi9vshAXrwHEiqIDE5+AMc5uyh8BV5HzDJWgNNS/8w/bxD8ShtY69RUMFBn//xbq
 t+vSrAvFZq87lXl29nT0o7I1m46saYVI51bSrsfteJXoOqYpE6RJEiIQsXXgn9Pir5JoGNWdj
 Cb+Gwpwkt3vAdspRi+B0KTkGVk6niL9A+lcVP9ycnFG72Xxi6yAAPZGYbcGZIDiUfZ02lzFAT
 LT7oHs/NPggtjboNcu2FIz4avFyhEUlyK092D9o/e5zl99YDDd+BJEdiYG3t4QFdqrZM83t7r
 HOVjBO+F+2l+/8i1XNzlvqHPI4/uv1ahtQEeOFvT8fWxKVn5pJ/BobxEajq4OGSAXFIcic3lA
 X1ucVE21PazSmtsXJC6tGAy1M1v4AvJ0vJye8+iXNb/YAbppZ02IVeMtcO1TQzjDai4tksXt4
 Om3jZ5e+drwKH0uAljX78U1Tf9L+T+bebF4q1jee+UC0zVfNRi6/YgTVnxEm4j8Z8ZlXMGHnd
 OvW2TmmiBaLi4s/4ZDOa9ATD/ZfPsJRJvgB8UpCyZSWllk0/OdZNjPkg7+iIS6u1ckc+ViJKU
 r7A1cTg2EKK/SHNrNkntjXrPk9GGfr4JgxQrAEIz5HFFJtkti9ZzNDZAtVwA7LN6IiD9A2eHI
 cA5g4mkDfmE+3rNvlILn8ArozZ1Fa6bvgNKws+zw9ZFkLAX/E9pl1HymRNimVr16APeBhPku0
 gh9H3GDQK9zAZp5QDNK2MthYUBotZJ9yfVzq6Dg==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 04:11:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

--Sig_/dpStp/=BCwa43iQtYQAAHKK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register yank functions on sockets to shut them down.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/channel.c           | 12 ++++++++++++
 migration/migration.c         | 25 ++++++++++++++++++++++++-
 migration/multifd.c           | 10 ++++++++++
 migration/qemu-file-channel.c |  6 ++++++
 migration/savevm.c            |  6 ++++++
 tests/Makefile.include        |  2 +-
 6 files changed, 59 insertions(+), 2 deletions(-)

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
index 8fe36339db..e4818edb2a 100644
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
@@ -379,8 +382,14 @@ void qemu_start_incoming_migration(const char *uri, Er=
ror **errp)
 {
     const char *p;

+    yank_register_instance("migration", errp);
+    if (*errp) {
+        return;
+    }
+
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (!strcmp(uri, "defer")) {
+        yank_unregister_instance("migration");
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p)) {
         tcp_start_incoming_migration(p, errp);
@@ -395,6 +404,7 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
     } else {
+        yank_unregister_instance("migration");
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
 }
@@ -1662,6 +1672,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+    yank_unregister_instance("migration");
 }

 static void migrate_fd_cleanup_schedule(MigrationState *s)
@@ -1935,6 +1946,7 @@ void qmp_migrate_recover(const char *uri, Error **err=
p)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
+    yank_unregister_instance("migration");
     qemu_start_incoming_migration(uri, errp);
 }

@@ -2071,7 +2083,12 @@ void qmp_migrate(const char *uri, bool has_blk, bool=
 blk,
         /* Error detected, put into errp */
         return;
     }
-
+    if (!(has_resume && resume)) {
+        yank_register_instance("migration", errp);
+        if (*errp) {
+            return;
+        }
+    }
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
 #ifdef CONFIG_RDMA
@@ -2085,6 +2102,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
@@ -2094,6 +2114,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
index a843d202b5..395b8fa704 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -63,6 +63,7 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "qemu/yank.h"

 const unsigned int postcopy_ram_discard_version =3D 0;

@@ -2935,6 +2936,11 @@ int load_snapshot(const char *name, Error **errp)
     qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     mis->from_src_file =3D f;

+    yank_register_instance("migration", errp);
+    if (*errp) {
+        ret =3D -EINVAL;
+        goto err_drain;
+    }
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


--Sig_/dpStp/=BCwa43iQtYQAAHKK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pGEEACgkQNasLKJxd
sljoCw/+MhwYxnlCF+krNrhHwy7B0+Rf9Fu87PPCQifGWzdFL4TpeBhcaBKnT8JW
OxHN2GgN1y6e/sToFiu+Hu6ilxT8JXKDWydCRy6UyXF8rOxcl9wjTL2eajsxJWqp
Iu1f7s3kALkjxvcA17muJ+dYqLyEnNjoKOsxTt+aHIK1iB/b4d74Jow+NQlub1Ny
Dn8sZMxnQ1mIekAuXCi1KiL/fHGzECmfCxXWox2H3dxrJRJgx3HLXRMSwLL3SJ9k
q8mSDYlaqhrej8hAi8lpXotIv1uRLVfB2nq/TUtF1ImQNlaNwzL+XlkO3mot8qXx
PyhYX4yqs2edeacgX1eSLu53jsOt6pserZpxuDpcC8+PurbeHP3YatsvUSvk4lpL
M8iJpezJwjNV9YgWhHtRxwkZOrErbjLTFJCAjlp3uGwL91iDrPF/FkWBtxYUBCpj
KNwxiSVt2s9LPrtsa7/zW4yNTQcDesm9v5oM9q/QvEflkgOgy5hjRaXquQdljHaU
IsPR5ItLryLetAltXXz39K/sOtr6QxLH08N+bJmFLeumMMLxZ6cgKgbOW+BFkr6R
rZiB3/F2sBamYTygEKxrc1VB520W3Rj8pFHVPdtvgbUGUK4ePdoDbyRYTKYPK3bF
dOwNrShY1/lcSCXtAp84gvREVbSvRBqm3rIqXXD27wDNPUUg8lg=
=LFe2
-----END PGP SIGNATURE-----

--Sig_/dpStp/=BCwa43iQtYQAAHKK--

