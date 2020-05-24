Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88313C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5629C207DA
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 18:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HJ3lxZMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5629C207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcvZB-0005WC-CW
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 14:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvPH-0008EC-60; Sun, 24 May 2020 14:31:31 -0400
Received: from mout.web.de ([212.227.17.12]:56761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jcvPG-0006UI-2y; Sun, 24 May 2020 14:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590345083;
 bh=HnGhPPIWzFr2cqiH6723UqmRsC/vXvexVasAo/QPp1Y=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=HJ3lxZMo9GHu+msLUSA8oAvfJPfR/2dyL+TnAEdPpD13i/gUQh1hBtExE6y4ZBjgw
 jn+umePKJSkiAgFmJ4BEsHH/vTgQb/Owa+Qh9+YInM90sjrzSyUm5oyNuPYQjQaecj
 niHkAnwTY7pxqepqmP1Z/0xMrVwRMCeKcZ08me8A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.42]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAvGa-1jmmlD0tYC-009zQu; Sun, 24
 May 2020 20:31:23 +0200
Date: Sun, 24 May 2020 20:31:21 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 4/4] migration: Add yank feature
Message-ID: <a7cb1502be18bc2d9d8c16565d5bda067d34b098.1590344541.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590344541.git.lukasstraub2@web.de>
References: <cover.1590344541.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S0jXRj/FZt=6cupU59rFWB0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:2Vxyktjm7sPozNvi6cpLcMXsYayHvbxMFY2p8yErzVZX+v/heeV
 MRZs2A3L8jBzl7QCNae/J3+M0dLxDOAOmfAsuFZklU81h/tLQj8F4zjdtLsYiw0KHBrsz4J
 CiWzB3cW7BCk4eGL7gbI9gjNDHUbpq6Xq7lA92gmkZ52hvi5hSJC+qWiC/qIK+cZleHB81D
 zhsqQGS7neOQ65CesQWBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9w8IwTaLC1U=:W86OkbBor1xV1m25i8LhRI
 IDDI3Xa2HyoNZyK78aDXJb0cqr3QuPhn1j/aj9jY56x1i9O4klK5Z61EbNmalMgk0dcsaM0DJ
 oIbumWEc1wRunL7oAz+q/FSNZ1a8PRRmbxW9/ihS9ei61T8sgcyiVsd0trVD4oEk840cLGNnk
 ZSAofxqQEjrQnQMzbQxig1FzmtHwyyMCV/egK7qIVpuGHsyLO3aDJ9kU2ldQQmPDYAnv5bLcy
 +qP5lye/X6RePbl1moa1TJCyjkCECyJnt51Hr+4WwIbcLd6QwKt+rXAF5W8odftv58ZptDXRr
 X6mZLxmiZk2vfs+8OGJKwMiBEU/RapkHTkMV7jVvBWdT77dJe3adDPECc7kqrPbDg9VGNIk1+
 yffMhxidqHC2VMtk9pIJDQjRuADnwrVfS+ZlJrnToyy/Vbm/OAABV8X+DwXhfqf4DsimfxP/L
 02AeSFrypC0SVKp4ZnMrW5R/teeI5XZVCPIW8O2LQKwW3Ktxi+fzWu8+VgnCRN19yv0APCcO8
 Tlb7r2IH2nH7ikMkwZd8xv3kGV14AtfXwbqkYijp6Uml4JKdT5jLC5AeufcQ/lnuwFeQnYIjj
 1ItZEuhb94xGv/7RkdKYAJB9+K0Ilh9giqnVqjsL4FRk9uqiOZX/WI9Xc1KjxOTy59L+dn2qW
 lxq0h3qxEaa8VqghY24YalT1OQhmo/7YWEjNG4HDbQalcKbswmtFyE8lXVCr1Mx15HLh0DYzj
 3tXEWPEspnuoWd3PGIlbjt0BgynrkiC5ByG6ccgw1wWSL6aonPiYcqJFq8MH4z6DS33uBC+Du
 sHuaqY2kcYVizcgjxTC1H5vF34W9bYVT1GJ1VCRM1nktOmL57itEu4Hbz3yphJ64uqO6m1VTK
 0Fbn+kBZolE4LIyspqgVrH+bIClQ/q485/XIp5+PflMBxYeZcPtsNJTAD2HhSi4OAW7n9zZ78
 frV783yocnI2xbaGc1BpC+IBNcQJCrbuBtxsXLDKqbc6IqYEIIoWJ221FJbmuhI8my4Uuf2Sl
 KspQa4IwPJyjUAQBI71QFVS3e3zXKLXk7+XHA/t0Y+BPCQ7nLXM7bqvGFs9LEDZra2suOqlY/
 ny72uo2sI9XgcmqSkzkLotw5jqGmaZoNq7KOoSIGLIusS5j963KIBdFh3vaWabO+JCLjnGILQ
 Wm42cylbZc+WdJQPJgNwKn5WKkpjEOsSj3kw08mttSNDLz91N1g/oPpApeDQJAjPON1Ewjix2
 m7paXxVnfcmsN9QsT
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 14:31:12
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

--Sig_/S0jXRj/FZt=6cupU59rFWB0
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
 5 files changed, 46 insertions(+), 1 deletion(-)

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
--
2.20.1

--Sig_/S0jXRj/FZt=6cupU59rFWB0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7KvXkACgkQNasLKJxd
sljt9xAAr2+eHuIyIZOIOdpUAG1W+ia4QaJyGa9Cgw3KUnT+/2KcWbo/VeE0Qo1M
usnuktojSAncfPz0au7eCiB2s4UTdEU1UA3dIMukeat9ENiuFQakXnrgLQqNk1q+
rmvGS8iOY8tZ/Ko55YiYfIySUmaoOyGIxxxCNyYuTmiFKqkXscXi2MybLbYhovXI
LrGJAadkW8kBTd17EicrU0cLkX9kWEvjWpp0Roqf+Zbd+P8PQovwL40UcMI80Atq
ZvQmNyEvZHZxYIOm1CKjYKr+L7e65FSDJG7P3Xp04uhGPU01lRmvYMJtO9hDq7XI
6++9+4bKheGXUdETvWxBKgg0MkpTzxJFvE+PCRckdA2cs/YjqEFVAUhOTiejDxPE
QRMVC52MpPoxgiw2KAuiGikcCwfRpWzDaCSej/B7xxRj/sqcIuzJ88PmoLN8BkEC
WkW0icoygz4RpOhGRjpeERKI3KnxHNMCLwh31TjOHr4aY7GukhwSL4cdbbs2sNUN
WQWttpNOt7MmpdNE0eMmEwT8CdGEyTGN0VrLDVRr6Oq6EC5BpB1VzqXizF+ntSrF
ccBS6yhKcQHugWPwAiZt81gZiuVi8NqtG5QCbJmshw6BgsHFZUTc0920I0GpfYT5
6btF0My3qTcPvNnVrzfJw5RuVScmkhfqG1mhSLo2qXXLA/qRDcY=
=mM10
-----END PGP SIGNATURE-----

--Sig_/S0jXRj/FZt=6cupU59rFWB0--

