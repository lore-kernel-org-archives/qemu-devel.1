Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F15DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7CA2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="iR+q4NQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7CA2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFTE-0002IY-TU
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jdFHO-00057s-2N; Mon, 25 May 2020 11:44:42 -0400
Received: from mout.web.de ([212.227.17.12]:60207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jdFHM-0006dL-RF; Mon, 25 May 2020 11:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590421475;
 bh=RjwTpyFKLImM2A/3YX/+JYWk6EWjPvnoBKIrskbhufs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=iR+q4NQKh9O9PlFXg1pHuFN8GGB8mSIh0Nfak68FgikNGBFUb7Abl7XTx235O/RSB
 jKSMpjpPrCTb9a5DY+dghtOxngpWtUjrHY2qveP5Cx8wlC3yfQdrmLGXquA+8KvSs/
 MX85RgNODMXlttQtAP3phxRhb5ZEn9w6lzf76b14=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.22]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuON-1jKCpL3ETd-00LD4H; Mon, 25
 May 2020 17:44:34 +0200
Date: Mon, 25 May 2020 17:44:33 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 4/4] migration: Add yank feature
Message-ID: <06c8eb78213a1cceaba4121d205dfc93b7ad9254.1590421341.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590421341.git.lukasstraub2@web.de>
References: <cover.1590421341.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PAihBLjztc=cXXVs/eYlH.W";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:cFHglrK12IzXAfiYI9LscB6GUt9+tM6hWrecsoYVSk6ETlDUmB+
 GNetg3YLGfJg9wRhMLzmWaeaSed9esVokNCMHHVSSxbYrm7qoVGMUN56dvLskJrRQXHKcqt
 mN1YMmRQNPqx6PTw1w72Y1YVCe3nlvtl1Gc9ujFfjuKuYBgyXs+Y6wlg8FturFXpLC/iCq3
 F51rK0eUamd3NQwW0BO1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LhWVhNOis/o=:7IR+aQpmetpHAVFWvaK03X
 kHjMrgu6rURbvO0ySe39PIMhdE4q63NLElQFnfrPeW4YvTkh8QfvJ+6+L5vf3Cs2FnmlpNBTB
 /tV+/Eu7/ef4BZ9NQy0/Rg/tyaaAaebLJpKdVwZEc2IF87WgLcRM+uICRgJP6ouTe54e1egDp
 +X1O8p1uhhMB/H5fHN8WqEv5NgpmapM0K7efWzGMlRABHNVc9JTROAsa3/WqdoB4XfKgD62Pi
 6GgeSN2kjVFLVUUpj5oxqedizIvWTVOKZHrIuInUXtTJ+Bi8Ow8T3UTZjBP3WJGL2vHwTbtzQ
 TxTPsq1EWsp52nhoLor36A6Fu7y/m1ewpO3vW16cmlhr8pwSI+d4hHbHTH4T2IwnWUDm2+G+w
 +m2m3nI8f87V9g9P6hZLsj6lLxagOAhcuSZYB5rDJEGJGx69lnW58RT6I6oh5A/qvqfRxRVuu
 gwn/HCy4n2ZVwlZyCtvNg0zEae1BTx/YdaY1gYnr4OFjrIgllaOGewIY6mLTPdtOMGDdHIFh/
 rGkf42WwHVL8ZLBa08QhLkSmp7IvGGbCh+W7lutQPw/lT3aoDXQB4VjiyZrw9AGgFFADjcsE1
 bmnfixesYlckSUXKTPfO8NJlePFG6GZuRkFSByXdi9qkRy2t9WZnCumPK8LY/wQGxrcKN29FZ
 ci/DRLglsL8ttOLQatpIG/z3IOhrkdyBc/x6etzzQbnG614FjuotBO6NJTZv3yuTV05VsUY4i
 1pJHOqdKTt3+NPuKMmsr4CoUYyZod7Iv8UPHqvJCWavwIFvcMrgVKwJStJjg2de2diaoNoctc
 FXt5N1kmPQfXwFd2pJ3C46gm9/5oerF6UxQLFHEk0fLUzB30GNycr4uv5uIN/+cDrzKHjwjXg
 M4F9G1G8nCX6aUZmTsnKEQmL3nX5VSoWQIqnzcsmuoOUNvuHjJa9xeb2x+lDmIj4/aM4OGCIJ
 vuBIwmXkNGLu82Pm9csEb/QUTLlhelJpxEkqoQmqpjUehyIEKGJFsIlup+fWcsQY4XIUXrXe/
 1tUTpgoGlj+9qIJ0vpY7DUTwfA9aLsrtLNtmSGYZiU0/3gL6OVWQGjOJlBwRwEOjWem1+IckB
 grR+lCwobD2zGda+wxnYYLGSSyEn37fxRpNj70iYTh2sPmQW3B2fEmnotoBJgOnaeG2OVyoj3
 zcyY5doBXINnUfUUY5fxbiXJvx92pGXQ3JWtmq9gHp7kw0VQVPiLLKxHft5ZP/Q12eTd7aUhd
 j3wMc027aBhz/kNwH
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 11:44:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

--Sig_/PAihBLjztc=cXXVs/eYlH.W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register yank functions on sockets to shut them down.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 Makefile.objs                 |  1 +
 migration/channel.c           | 12 ++++++++++++
 migration/migration.c         | 18 +++++++++++++++++-
 migration/multifd.c           | 10 ++++++++++
 migration/qemu-file-channel.c |  6 ++++++
 migration/savevm.c            |  2 ++
 tests/Makefile.include        |  2 +-
 7 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 5582f4eda9..d2a49d3834 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -58,6 +58,7 @@ common-obj-$(CONFIG_LINUX) +=3D fsdev/

 common-obj-y +=3D accel/
 common-obj-y +=3D migration/
+common-obj-y +=3D yank.o

 common-obj-y +=3D audio/
 common-obj-m +=3D audio/
diff --git a/migration/channel.c b/migration/channel.c
index 20e4c8e2dc..5cb48d403a 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -18,6 +18,8 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
+#include "io/channel-socket.h"
+#include "yank.h"

 /**
  * @migration_channel_process_incoming - Create new incoming migration cha=
nnel
@@ -35,6 +37,11 @@ void migration_channel_process_incoming(QIOChannel *ioc)
     trace_migration_set_incoming_channel(
         ioc, object_get_typename(OBJECT(ioc)));

+    if (object_dynamic_cast(OBJECT(ioc), TYPE_QIO_CHANNEL_SOCKET)) {
+        yank_register_function((char *) "migration", yank_generic_iochanne=
l,
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
+            yank_register_function((char *) "migration", yank_generic_ioch=
annel,
+                                   QIO_CHANNEL(ioc));
+        }
+
         if (s->parameters.tls_creds &&
             *s->parameters.tls_creds &&
             !object_dynamic_cast(OBJECT(ioc),
diff --git a/migration/migration.c b/migration/migration.c
index 187ac0410c..c6d7119c08 100644
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
@@ -362,7 +365,9 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     const char *p;

     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
+    yank_register_instance((char *) "migration");
     if (!strcmp(uri, "defer")) {
+        yank_unregister_instance((char *) "migration");
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p)) {
         tcp_start_incoming_migration(p, errp);
@@ -377,6 +382,7 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
     } else {
+        yank_unregister_instance((char *) "migration");
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
 }
@@ -1632,6 +1638,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+    yank_unregister_instance((char *) "migration");
 }

 static void migrate_fd_cleanup_schedule(MigrationState *s)
@@ -1899,6 +1906,7 @@ void qmp_migrate_recover(const char *uri, Error **err=
p)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
+    yank_unregister_instance((char *) "migration");
     qemu_start_incoming_migration(uri, errp);
 }

@@ -2035,7 +2043,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
         /* Error detected, put into errp */
         return;
     }
-
+    if (!(has_resume && resume)) {
+        yank_register_instance((char *) "migration");
+    }
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
 #ifdef CONFIG_RDMA
@@ -2049,6 +2059,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
+        if (!(has_resume && resume)) {
+            yank_unregister_instance((char *) "migration");
+        }
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
@@ -2058,6 +2071,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
blk,
     }

     if (local_err) {
+        if (!(has_resume && resume)) {
+            yank_unregister_instance((char *) "migration");
+        }
         migrate_fd_error(s, local_err);
         error_propagate(errp, local_err);
         return;
diff --git a/migration/multifd.c b/migration/multifd.c
index cb6a4a3ab8..97566262c1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -24,6 +24,9 @@
 #include "trace.h"
 #include "multifd.h"

+#include "yank.h"
+#include "io/channel-socket.h"
+
 /* Multiple fd's */

 #define MULTIFD_MAGIC 0x11223344U
@@ -856,6 +859,13 @@ int multifd_load_cleanup(Error **errp)
     for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];

+        if (object_dynamic_cast(OBJECT(p->c), TYPE_QIO_CHANNEL_SOCKET)
+            && OBJECT(p->c)->ref =3D=3D 1) {
+            yank_unregister_function((char *) "migration",
+                                     yank_generic_iochannel,
+                                     QIO_CHANNEL(p->c));
+        }
+
         object_unref(OBJECT(p->c));
         p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index d2ce32f4b9..b725ac8098 100644
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
+        && OBJECT(ioc)->ref =3D=3D 1) {
+        yank_unregister_function((char *) "migration", yank_generic_iochan=
nel,
+                                 QIO_CHANNEL(ioc));
+    }
     object_unref(OBJECT(ioc));
     return ret;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index c00a6807d9..c5f957d4e4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -63,6 +63,7 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "yank.h"

 const unsigned int postcopy_ram_discard_version =3D 0;

@@ -2897,6 +2898,7 @@ int load_snapshot(const char *name, Error **errp)
     qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     mis->from_src_file =3D f;

+    yank_register_instance((char *) "migration");
     aio_context_acquire(aio_context);
     ret =3D qemu_loadvm_state(f);
     migration_incoming_state_destroy();
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 51de676298..e76a5458c3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -442,7 +442,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qdev-=
global-props.o \
 	$(test-qapi-obj-y)
 tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
-        migration/qemu-file-channel.o migration/qjson.o \
+        migration/qemu-file-channel.o migration/qjson.o yank.o \
 	$(test-io-obj-y)
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-=
obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
--
2.20.1

--Sig_/PAihBLjztc=cXXVs/eYlH.W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7L5+EACgkQNasLKJxd
slhjNw/7BgDOpemNql7n+twSZkmfMyHbWScPczqal5Ax0QKAgJOPaCbgJGi3zJcz
aw6HYyRF+lFaBvo4XaZDmYZ0RSFuMZwVTsXvJYwGeX3lIbzmleveWIzNUipObqBy
6VJgpY4EQ7oFa/EzSN9x8lQKcsccMX/yGgxIjZ4dZFEazF2Jt3u6AzsBodvD0lRQ
ZmwuYJrIDDixR5Kq98y+tXnnUlt4BXSCno10JXNBOPTnbSz+TFFEcCYga5Y9FkEy
oKWK7r82YrLSdaJw5IeuWpG8oBMBHj/E8kGYPtgey9hZqjsXnFn2znws0B7f+vz9
Ph3bQ6ybuNcMtaknDs/e1FXjwlmnBQ4PK86IpR6PMyoysTqbcSaJpr4wA5SVqjdo
IWkqygjhuFl0P5+iHIASLPtuWdjok5RGUkBEhfghVC2zKQklH+kdIC7DOxmXOJ4+
wltAuoUBLG7q6tsLKvGfgRX1TBPA3GsN9w2Ra5VpTVFbi3/ltLR09dalxFzMFhi4
iIZeIykDggXz8hYvxWjpYf9ccwyyUID7fyR4988UT1SiDJhODRGa5K8nvxHqYKMM
RcNBMNbDiP4g/6hpwdP0egkVIUEdLxb0ep7PAjfJSNBVUCIykb65zghyjCSm9jYv
BRQl7r76x0FBKo7jcfKoef52+Mj813Cw9+y5/Fs6DniIMm1hDKE=
=KxbI
-----END PGP SIGNATURE-----

--Sig_/PAihBLjztc=cXXVs/eYlH.W--

