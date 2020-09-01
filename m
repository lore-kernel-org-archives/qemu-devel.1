Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DED4C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A942206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="NoaCo2VL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A942206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2YY-0002bO-8B
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2Nz-0002TN-KF; Tue, 01 Sep 2020 05:15:27 -0400
Received: from mout.web.de ([212.227.17.12]:52179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2Nx-0007H2-3V; Tue, 01 Sep 2020 05:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598951720;
 bh=tfgirQq1nfSsCQ6/t2B2E/IbTgtjw5i5MPxiCrHomWI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=NoaCo2VLXu7G+qsd4c6sUgQvAAukqTZGFxPd1pgrBFHaUL2JtH/NuPcymMOzgkN4G
 woOwjz3+Tk/eDwF1zNazllTTY0S2Cq9nvexQTy6JANzbKrjde48t5kFgM2yMc1tCdu
 fX5Q+Nkbk/n1Lo159aXDkHdpTsc8JjFHGcDvFjHQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.220]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPU0-1ksT4H3eLC-00lBic; Tue, 01
 Sep 2020 11:15:20 +0200
Date: Tue, 1 Sep 2020 11:15:18 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v8 4/8] migration: Add yank feature
Message-ID: <1a2255fed79dbbc60ba2fd53d9dee23e00a9ba76.1598951375.git.lukasstraub2@web.de>
In-Reply-To: <cover.1598951375.git.lukasstraub2@web.de>
References: <cover.1598951375.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uLo.04FiQOt2FneibgvhQPk";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Rif3NMarG7jL1/HX9cYJO4Oak7P2h4NbOiJ06X58+PXfBtIXWLu
 q0iVeGsFxrINtnzTe/KRAXUH8eZoqwehLqfhGMHCa3h+HQwI0w964FL3ZeFGld3TBTz1EZB
 iJkyqyobSUPmCVjHgeRrfsyzLtR/8FhsswYeDgPeJxdDOsWyGMlUiVEqb+IXd22EzxaTsIJ
 mDeQhKB3OkxtCkOcPK4RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x1MSb+x8Jio=:7W6Y46MkgXRWiD84HVmhlV
 GB4mhK5P52U/S5hfw9+ErwNLCic18umfUBVbQSF9u7D3Z+eJk37u64XWFjkKCJ2sk7/ndPcIx
 DecMY5DY91jIzg+lOaKpmLEJq+lgCMPD3w/g4zPuSN5F2Cp1XPpYThzgJSx5Vyc3+2EMmcHcP
 NWr7akPtUbOW8drFDDGq/sj/RdkRkThyV7PydBK8nF4z4ePbTOqRkJ1WJG84XiZpVAj8c60VM
 K2kO2XOcHqXY6EnCXY4n75UWsvpahzOjLto94xL+tw87ymVzrjkTnmc0++xpA8WOd21wR+m0v
 SGlJuShj0zyJWv246ZrbuEPpDKbB4AotA6kkDN8MMxdUD9ASvn2ypX/gRvsUge+TSG34CiAwQ
 uovEc7QztzQx80y2zhWIIQVrKZzJ0ciRHoqe7HMv/eP0WeRR9VxY/uIlqR1btN9jAbApSWJ0S
 U3tE1WI9Tp0Lx3Ne+UnZdD4U06Ott9hlPIEMQozij53wFbbTiF1c0RQBE1vnLnzADEJcs/gwQ
 jQ/W4C1EI6RABzgFFMsgYGy1fkK1R+M0tUa4pPRqNulsnk1nPvHBnPobkB7hhmfdHu/EwgFaA
 /A6OG+pKkwec3QpJ0NKQ2huAtpLL50NRhqA6CmfzUY6QLzZUVpYLRdiIPx8byacw3JtFkOrIy
 hpbl8ySzhVK6xieGn87psFuElJjSanYhldGs36NIO8WzDRSHfkszRMV/ZXGj1WgJetIUJScV6
 rOfwemVm4sL5TTaIB5aZxr2FZKr0k1qBxGFteK2Gb7gGQmsv8Zi5ImCpqQHDc4ZFM3YgirnyX
 /8ARut6d+T0HYiq9kGz0SuRZniRmooMxlOAMZycVpf77ipAEaVnfEz719tvstQO/X2ibQpYBs
 GbY2+QWT1M3v9eVvePaTkPnkNkeW4QEtLpYJpGBONtry13yTzaubry3vC9M9eUdAVP5G5scu1
 Rr9kT4ApTHsYkOImBjaPmUiAqmxekpH3tUFFEcuvRbqYS9CuXVYN5voUXopV4eC1Rp6iEczqS
 XRnz1vq4Z3DV00ZOFCjo04XAhDcpkexR/A+EveCKfzAJqiXOscgSN/pDfF9MVryxqnHavP1Wo
 Hck4QcsJhIj2kLv9Gu/9uTiV5kKGR/m0dHK+1PC20hbRV7fz0iG5aUJykHoEjN3IUmMFSd4Qi
 xGu0Hg/2Bb1S53BHhUl0pKbuvO84+ad5CFBAJFIACxGvRrwsYMPVtiXiqZCNs2539uQptEkaU
 odJpDtFM0czVXJHLIOqhAA9FSnfd6UeT4T5H6HA==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:15:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/uLo.04FiQOt2FneibgvhQPk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Register yank functions on sockets to shut them down.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/channel.c           | 12 ++++++++++++
 migration/migration.c         | 25 +++++++++++++++++++++++++
 migration/multifd.c           | 10 ++++++++++
 migration/qemu-file-channel.c |  6 ++++++
 migration/savevm.c            |  6 ++++++
 5 files changed, 59 insertions(+)

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
index 58a5452471..61a9e87d22 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -56,6 +56,7 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
+#include "qemu/yank.h"

 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttli=
ng */

@@ -244,6 +245,8 @@ void migration_incoming_state_destroy(void)
         qapi_free_SocketAddressList(mis->socket_address_list);
         mis->socket_address_list =3D NULL;
     }
+
+    yank_unregister_instance("migration");
 }

 static void migrate_generate_event(int new_state)
@@ -380,8 +383,14 @@ void qemu_start_incoming_migration(const char *uri, Er=
ror **errp)
 {
     const char *p =3D NULL;

+    yank_register_instance("migration", errp);
+    if (*errp) {
+        return;
+    }
+
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (!strcmp(uri, "defer")) {
+        yank_unregister_instance("migration");
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p) ||
                strstart(uri, "unix:", NULL) ||
@@ -396,6 +405,7 @@ void qemu_start_incoming_migration(const char *uri, Err=
or **errp)
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
     } else {
+        yank_unregister_instance("migration");
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
 }
@@ -1692,6 +1702,7 @@ static void migrate_fd_cleanup(MigrationState *s)
     }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+    yank_unregister_instance("migration");
 }

 static void migrate_fd_cleanup_schedule(MigrationState *s)
@@ -1965,6 +1976,7 @@ void qmp_migrate_recover(const char *uri, Error **err=
p)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
+    yank_unregister_instance("migration");
     qemu_start_incoming_migration(uri, errp);
 }

@@ -2102,6 +2114,13 @@ void qmp_migrate(const char *uri, bool has_blk, bool=
 blk,
         return;
     }

+    if (!(has_resume && resume)) {
+        yank_register_instance("migration", errp);
+        if (*errp) {
+            return;
+        }
+    }
+
     if (strstart(uri, "tcp:", &p) ||
         strstart(uri, "unix:", NULL) ||
         strstart(uri, "vsock:", NULL)) {
@@ -2115,6 +2134,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
@@ -2124,6 +2146,9 @@ void qmp_migrate(const char *uri, bool has_blk, bool =
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
index 304d98ff78..39d5ba9a2e 100644
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
--
2.20.1


--Sig_/uLo.04FiQOt2FneibgvhQPk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9OESYACgkQNasLKJxd
slgwNg/+JJACIwtPed7tcciey2gvLMK56Xzy5Pb2jar/J+vDJDqeq9lq21ozLq3S
1Rf1+LQ3ZkqwSxb84Ics5En4QgxhD5ywWInQ/tcPySMvhWpYJA4sNuUCaffozhW3
jBT6oeC7FbShoT6QtXGOlOaJQHJM2Rq9s/h3ldh+L1XvZYgWBkKn9CEKU2w8VsHc
PYwWwZNJi279drzZc7AjUnkuMuTfMaau9jXywZE5bBQyVAcLe3TS0nLMwX483lqQ
tcJK11Etzfr21JUp4OLj0X4cx9yIfTNRvuT+WLOKQ0KbFC+sYynFj3wynfnGnfR2
niRW8XJOlv+IbjjUSl2IbKiJvqmX7wlfxbeadfTO/VfLGvUgXl4z4QEmDLLkt545
pNkarhz2DKx0RmEhY+azSqmP2d2AjklGHy5V3MqqyUlJUzHO0a9DVSX/fSXr6+xQ
Qr91nAGHvFJqQjw+FjuFcZtIDDwoseeESXDgYQGgl0xuICIoSj64+jlzIQ5rsDTy
HEnjnqBv6lFSN3J2fEPGvB6q9Q+u+pYe/1lD2faegLyAW49zAIXGdStnx1e35wJm
0bopty71l2dQ7j9drRroWo/ASoS+NvyLp5/MNnKM6gKxFTZcPjyva6PZGa4i1OnD
GGE6J8TgNHH+R0YF8NyULeI8PdwaSujzNNvJ7LUnWcZRws0w96I=
=KybB
-----END PGP SIGNATURE-----

--Sig_/uLo.04FiQOt2FneibgvhQPk--

