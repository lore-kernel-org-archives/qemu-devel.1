Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60AC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E52520704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IaLSFMR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E52520704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXXL-0001Kn-WF
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXT4-0004Tg-J6; Fri, 30 Oct 2020 12:41:35 -0400
Received: from mout.web.de ([217.72.192.78]:53387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXSz-0002zq-RW; Fri, 30 Oct 2020 12:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604076082;
 bh=XXnUryT8gdPGNoVe2QLH8UCrQg46bXT2bnTQntl8b2Q=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=IaLSFMR1tJk+a2jazFth8TQNkP8aPllWHHAg3VqODXB/g/1X0HljEOilNwVS6WPWh
 g2elSIWw1VEW4BnNOQZ2Mog7Y9FGGnzk5CyEQ3/0UvqsjqHp3Ov6+MYVxv/iY6rFAq
 VIOs92mjO0VlxsRTQn519wtOXgdAc+f5mNFjXyRY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDv9a-1kgHDy1Iiy-009vOZ; Fri, 30
 Oct 2020 17:41:22 +0100
Date: Fri, 30 Oct 2020 17:41:21 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v10 4/8] migration: Add yank feature
Message-ID: <20201030174121.6b7816a3@luklap>
In-Reply-To: <cover.1604075469.git.lukasstraub2@web.de>
References: <cover.1604075469.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EPscmumNH=0VFnEeJ._QqIj";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:gZqh8ooBa1Wucd9F5pX+N8o7EKylSDekYcSjEGH2zGg/nbyxzvm
 MucgYDms1zz6fDlK9C2Y6MwboP7IskjrOnXLvN74fyK+XW8fhUfawc3DsbWW/SkGM+cerOr
 +rEfoSdkXXOPFNP9f4xu0Z+nRNBELeIOUwRE8hwT75/heKfyDIwUxmalMXl7FmfGPT9aVAb
 iHUdAl6nwe+KW8vxDZZYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IKy15FUJsLM=:90FFpr3LpWgw+TsfahkqdM
 ykU3OpZkBtcp0OYfKJ/sstacsCo77E4m/R700jyQpGQRfJIA3KdU/UYRGmMG5X+3HtXCjh8fA
 rydbCwoO8HHbAbD7iMFhu5T/VyCytdmnjtkW7SY6C54Dg5Eakt2K1q/pvGo4x/HDnAwYYTBrC
 owgR3gHmi3OoqhtsQhjstSbdAKJOMXUQed+dgiopsg+tJckKRfVAR0PlvsnFIevrke+lesVjA
 RwAmXhPcfGx8jvJBODK/lFp737dStFSLow85uX//KYRZnSOwXqG32oF/fFTC29sq2p2zhk/PF
 pvhnPBHNs4ZdC4AbPQ/PQfz1T/M/dGZh7iip5xvi+UwXddl7BtbLoLO7ebwg+eR4/ZUek3Ojb
 eBCUL9oEpyVePaJ9rH1zTn6I2fGyhAiQdyzSUYwH1tU8v5J69cbefmsfyduE37cO0/Xh8hlzz
 1ZtyHdmIIb7t/gALCAgO8l0SZmyMW5u7G//hxxBzD1Qk0ReaxZ1/Wjk+eN1WAYQ8PTQzHg0L2
 sTCZWA/dug1lAQfPy21RB9JWCwDaia9rI9Op+NSVmh3/5Duiwv0+3El345A9TXgnjYHiRxHPh
 Ak4as4jKR00S5cEQ+nMMg/YJlJYkA08FX5FT/D4WvYLNZc5kvFpQw/yAYvlLM1G9QUVuPRVQg
 4f9vPWAQ2fJ1kCSdezEquqjH4ww4ke3wiWkyfK0bmRdQ3U+JqkYIUHZ+YbAfzkidLRtux7Swb
 7hw9CN6f+9PXvpb7kEML15eGtVxoeZUP7CX7tz4ypOwgBEra9hTAxR7lPfska6E+YSsWXwqCM
 ZnVx+d9FbaRCD30sQIMLHH62OCWy3AV+LJb7ERsExtlopI5vUO9SF5A8GVWzc7F6KROpN9W7u
 FSrmzCGEawjaeLVTpgrw==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 12:41:09
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

--Sig_/EPscmumNH=0VFnEeJ._QqIj
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
index 9bb4fee5ac..0b0442df37 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -56,6 +56,7 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
+#include "qemu/yank.h"

 #define MAX_THROTTLE  (128 << 20)      /* Migration transfer speed throttl=
ing */

@@ -248,6 +249,8 @@ void migration_incoming_state_destroy(void)
         qapi_free_SocketAddressList(mis->socket_address_list);
         mis->socket_address_list =3D NULL;
     }
+
+    yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }

 static void migrate_generate_event(int new_state)
@@ -425,8 +428,14 @@ void qemu_start_incoming_migration(const char *uri, Er=
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
@@ -441,6 +450,7 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
     } else {
+        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
 }
@@ -1733,6 +1743,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+    yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }

 static void migrate_fd_cleanup_schedule(MigrationState *s)
@@ -2007,6 +2018,7 @@ void qmp_migrate_recover(const char *uri, Error **err=
p)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
+    yank_unregister_instance(MIGRATION_YANK_INSTANCE);
     qemu_start_incoming_migration(uri, errp);
 }

@@ -2144,6 +2156,13 @@ void qmp_migrate(const char *uri, bool has_blk, bool=
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
@@ -2157,6 +2176,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
@@ -2166,6 +2188,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
index 21ccba9fb3..c7648a9388 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -62,6 +62,7 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "qemu/yank.h"

 const unsigned int postcopy_ram_discard_version;

@@ -2997,6 +2998,11 @@ int load_snapshot(const char *name, Error **errp)
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


--Sig_/EPscmumNH=0VFnEeJ._QqIj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+cQjEACgkQNasLKJxd
slipcQ//RNIqtjj1LgBGScbwWnNIZodzLxMD8TdLxmnoJQwxmExAMHUpPsEQ9r+l
yd8MTBu8EZmTGFnYE7QVudH2KN7WAwbwDaNXYEUbqV764Y068TlLdCeczD9xtQt8
CZz4r7+YSVgDwRWjDwS5Bn8cpJXEptpkm5DpPeZ2KAmgL9r+XNDXrIzoT8+m7oFK
bbWb6r+Ga59RfAkP27pLALhYV/Tz2SoCI9C4Th8Dt/NvyIMJzaynwucrmtJv4/WL
P7IxFZ6wgyxzN/bB5y5YGDUwc/3a8X+xjydhlEa4b0xvOg8ofjuP3Y92eUYO/fZf
YYwK/BGXyBqD4dxHWslWizJhyT2Haigus5rPbU/fQx2WEiwLXcBDdtbBCUYSM1kY
lBxNVxJkvhMtLzoYPdm64VEeCahCytVIu4/mi+VJ0XLNK9p6L7VpCR8Ct7fgFe9T
aNSGArHz7ISKhbwjqilWLouwR1DMk5IU9NhmfaIaW3c+VApSt32fng34T6EI3x9g
Sp/gbea8Z70j4B+51lLbrrW0aFvABRwBtTpb+b2Ni1xR71550xiet5A1lPwDjBSK
T1AxkmUnwBd7OnOzAsYs2XRs+AwgrzxgjghrdWpGXkwdNUOTDwDA0MWdVv/0i9ET
UGcxGOFSBoSD4nkCMg7id6qwS18jHyR2RdNSL2NzHVNaPTV1hO4=
=rhNV
-----END PGP SIGNATURE-----

--Sig_/EPscmumNH=0VFnEeJ._QqIj--

