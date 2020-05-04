Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4DB2071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WCrzG1z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4DB2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYaO-0008EG-Bc
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKt-0007I8-Gx
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:31 -0400
Received: from mout.web.de ([212.227.15.3]:51939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKs-0002X5-Go
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588588099;
 bh=A7ojLWn10Hrpm+MPOTgTEQeuCwTcirRJrsoWi+s+fb4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=WCrzG1z9slB1jqq7zy3XrRs9gOl6UPfNXXFugvn3J7l1KLhNOJ3UOVeEMx4sdO/fS
 sVL3IjdqvE2EbKGQCUeD503yFjHufMA3bODyNIKWXyJ55R5m5HmpWhi790ob/pqyyn
 3uanN/ItOUTsTCHiWNgtOhqNBlwrOuZTRQFFqWI0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.27]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnS3i-1iwlor2SHW-00hgB5; Mon, 04
 May 2020 12:28:19 +0200
Date: Mon, 4 May 2020 12:28:17 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Message-ID: <f6cbde747d78ff080f680c710e2793867a3cf1fa.1588587700.git.lukasstraub2@web.de>
In-Reply-To: <cover.1588587700.git.lukasstraub2@web.de>
References: <cover.1588587700.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pMkx1WRJZ_dYznR/h6v_uZm";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:jTM2WAIulLNVOo40uROClZA04O16ay2zQ8BjQ30GDXNwM95yCk7
 1LDK6GCe879q7NPD/pNiFziNOXKk0uc+sezd294oDYGchJNeaTSTSPKAPJm4ocU1aJIDph6
 OPsQ5EZaAU9nvOUNHBCP6Dy2kCurgnSBCBJrjTVYP0t30zbDq8rnxLMsAOZ5hqfdNikUZXk
 CZgqtOf6+CzgBXUdboAmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SID8jsBaW+8=:xKvzcXKOlNTO0U8Db43fEJ
 Ndugb3QbBWsXgfVAGow5C9ibTVEYkgvNw+q+BZQrJP3cf8Df+JZBqEf+57Baggn85IsMbjPHv
 6v/K0nK88XGDzB3m5vjq2XVst5HeIdEvbeF8hZuzrToXFKICxal12uj2O0pkN7aYenJ2ev2be
 gWtsc5ir774LxKmXiY7WhEzApoCpgyvppaihrQ9yEEYqH+w48OgR8Devgdj5fDa6CL2VF7sl0
 SvglBWTisqRPQrP5R91cCjqv4icssEQn+3XQPLsdbD3CyAiHSTC1+URUmxAZwEo+qacVIjiBX
 0Rnt8iu50H+xCFpcaN2J4NqDYUBtJWa0hYZLBsaEPS/4HoDASEbIIVS5XtmGal0zl7x/Gcbpm
 kXgIjR6B3nnk1LKjVvp69Qq/NaBNCRGlzfGuGGQ7Py9aUakJsIIj+9qANAXWykAWRKjyqoI52
 pVntXJG2DFHWtNNin3xMvvUrIZ6lw49tSfMx6TSPQCBzOirSD/9sW6tolO4dfEWff32Xhkz7k
 KFPpMvIDq9mVErm/2X8hbggIqdGdbqsx8UPePvJhDoJE0JH1EvVrwUXTkInVaig7DjuxpYTpg
 5HTD77elSevr8oQPDLTncKdZjyrHk61DnVJl8mdquaTt7rpZfq4r8Ai1E1DaU4gRhizhZFZQ+
 C0VryJQNEqH7MampSj38DWneHbAO6uGPkjgHqhQZ1EHMeM76MiQTHxV0hV/Xwgu0vB3QBaUJG
 eL3cmovFD5tSQCSocEBQEcupLvgoLE+ryz2Xz08e05nywoXMUSr+yNUZ5STbxaEtjftiXXP2s
 vYa/dhpXwzqJSQEOMuR596o82E/cnWcEGT+5fpyNoxYzbSDYcHxJ4KfFTWzZ5ZUOMvKH/nT/E
 gBWWF9ESZzQ+2GxDQBGABjMntsmfNWwLIq+A1S9uU3R/ifdDN5FQU2Qmn+05C2GV7RklSB06t
 0/1yWKb+f7rfL5udnDmpD8mBHls7dr1yiiknuQlu0WsZ3PAemu8z1oNJa0AMWJe3xUj9chznd
 ceS5k1y4VWwbRhlOos52H98sPz6AEnyirnB1IP4mOyWIh6mHBawkiLQFQXdlz41VB1tdK4gie
 Lj/zp+C2sptbtcRdUDEvXTdbZ8tMQnP+hb7HNrBoi815gHPHu0sL2CiNeYJ9JnJ1r7Vgj4KGU
 GlBHrvTDWBnwy07y5zhlLjDjnmtSdbHp3CxVMpO1Nf95ugN6QiHmEcTno+YA8H/y0/s3HTDw8
 v8gxiq+5LwtgC9ZcH
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:28:29
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/pMkx1WRJZ_dYznR/h6v_uZm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If the colo-compare object is removed before failover and a
checkpoint happens, qemu crashes because it tries to lock
the destroyed event_mtx in colo_notify_compares_event.

Fix this by checking if everything is initialized by
introducing a new variable colo_compare_active which
is protected by a new mutex colo_compare_mutex. The new mutex
also protects against concurrent access of the net_compares
list and makes sure that colo_notify_compares_event isn't
active while we destroy event_mtx and event_complete_cond.

With this it also is again possible to use colo without
colo-compare (periodic mode) and to use multiple colo-compare
for multiple network interfaces.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
 net/colo-compare.h |  1 +
 softmmu/vl.c       |  2 ++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 56db3d3bfc..c7572d75e9 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =3D
 #define REGULAR_PACKET_CHECK_MS 3000
 #define DEFAULT_TIME_OUT_MS 3000
=20
+static QemuMutex colo_compare_mutex;
+static bool colo_compare_active;
 static QemuMutex event_mtx;
 static QemuCond event_complete_cond;
 static int event_unhandled_count;
@@ -906,6 +908,12 @@ static void check_old_packet_regular(void *opaque)
 void colo_notify_compares_event(void *opaque, int event, Error **errp)
 {
     CompareState *s;
+    qemu_mutex_lock(&colo_compare_mutex);
+
+    if (!colo_compare_active) {
+        qemu_mutex_unlock(&colo_compare_mutex);
+        return;
+    }
=20
     qemu_mutex_lock(&event_mtx);
     QTAILQ_FOREACH(s, &net_compares, next) {
@@ -919,6 +927,7 @@ void colo_notify_compares_event(void *opaque, int event=
, Error **errp)
     }
=20
     qemu_mutex_unlock(&event_mtx);
+    qemu_mutex_unlock(&colo_compare_mutex);
 }
=20
 static void colo_compare_timer_init(CompareState *s)
@@ -1274,7 +1283,14 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
                            s->vnet_hdr);
     }
=20
+    qemu_mutex_lock(&colo_compare_mutex);
+    if (!colo_compare_active) {
+        qemu_mutex_init(&event_mtx);
+        qemu_cond_init(&event_complete_cond);
+        colo_compare_active =3D true;
+    }
     QTAILQ_INSERT_TAIL(&net_compares, s, next);
+    qemu_mutex_unlock(&colo_compare_mutex);
=20
     s->out_sendco.s =3D s;
     s->out_sendco.chr =3D &s->chr_out;
@@ -1290,9 +1306,6 @@ static void colo_compare_complete(UserCreatable *uc, =
Error **errp)
=20
     g_queue_init(&s->conn_list);
=20
-    qemu_mutex_init(&event_mtx);
-    qemu_cond_init(&event_complete_cond);
-
     s->connection_track_table =3D g_hash_table_new_full(connection_key_has=
h,
                                                       connection_key_equal,
                                                       g_free,
@@ -1384,12 +1397,19 @@ static void colo_compare_finalize(Object *obj)
=20
     qemu_bh_delete(s->event_bh);
=20
+    qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
         if (tmp =3D=3D s) {
             QTAILQ_REMOVE(&net_compares, s, next);
             break;
         }
     }
+    if (QTAILQ_EMPTY(&net_compares)) {
+        colo_compare_active =3D false;
+        qemu_mutex_destroy(&event_mtx);
+        qemu_cond_destroy(&event_complete_cond);
+    }
+    qemu_mutex_unlock(&colo_compare_mutex);
=20
     AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     aio_context_acquire(ctx);
@@ -1413,15 +1433,18 @@ static void colo_compare_finalize(Object *obj)
         object_unref(OBJECT(s->iothread));
     }
=20
-    qemu_mutex_destroy(&event_mtx);
-    qemu_cond_destroy(&event_complete_cond);
-
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
     g_free(s->notify_dev);
 }
=20
+void colo_compare_init_globals(void)
+{
+    colo_compare_active =3D false;
+    qemu_mutex_init(&colo_compare_mutex);
+}
+
 static const TypeInfo colo_compare_info =3D {
     .name =3D TYPE_COLO_COMPARE,
     .parent =3D TYPE_OBJECT,
diff --git a/net/colo-compare.h b/net/colo-compare.h
index 22ddd512e2..eb483ac586 100644
--- a/net/colo-compare.h
+++ b/net/colo-compare.h
@@ -17,6 +17,7 @@
 #ifndef QEMU_COLO_COMPARE_H
 #define QEMU_COLO_COMPARE_H
=20
+void colo_compare_init_globals(void);
 void colo_notify_compares_event(void *opaque, int event, Error **errp);
 void colo_compare_register_notifier(Notifier *notify);
 void colo_compare_unregister_notifier(Notifier *notify);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 32c0047889..a913ed5469 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -112,6 +112,7 @@
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 #include "qemu/guest-random.h"
+#include "net/colo-compare.h"
=20
 #define MAX_VIRTIO_CONSOLES 1
=20
@@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char **envp)
     precopy_infrastructure_init();
     postcopy_infrastructure_init();
     monitor_init_globals();
+    colo_compare_init_globals();
=20
     if (qcrypto_init(&err) < 0) {
         error_reportf_err(err, "cannot initialize crypto: ");
--=20
2.20.1


--Sig_/pMkx1WRJZ_dYznR/h6v_uZm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6v7kEACgkQNasLKJxd
sliwrRAAlOf+UpLhnXH/otpn21duRbhjM6YIU5pfWxYd+11XBjmRCMs/L43s3lZ0
wvbfgGPAZhGCdiSj6zxW9dVS+ZaZkbtJAKYqDmoMkVnW1UaG2SIu7c8VGbnkICXP
Pg9eUC2DDzsAblQPsIZToxY/kloi2X1B806nqHNBaJLbRdq3EXmeaO7WacJZKWK8
vmzFaUfYEyZQC+tSW7bV8XLC+AHnLoJz6BE71ALLDTZ1G/BVbjYq2o8xKd6bdbkJ
njVwKaACsOXtHArjiUU1gyVUwmpyGU7PeFHihIeYE9HfjWoMhW6MQjMB66tPWgfA
lZpWz3lGTGKU57F5qmbccVXbyqLxTWq1Ubn4qVP1Im5ksDz4O6ARwCOLDs+pSvlW
dcAqLk9MvSoXftdD+LNfou7QSJLFVakAUlUH7o8+jVvafy4yb3sdrtF2JTQjTn5N
XTBmuZoG/jo+VODo2uf1uqN1cwFKS+WRgLmktXnOOQdPbxuYy8p85CRo1bTIXB13
aSvYEsbchRn7dUw2dcyobMMt73eTnrwZ/BTRQUYcuWuC5OhPzgqRMczGLf72bWRU
ErNTq4yJgQMKTWHnPCUmmNU8FthC1PHwzOjYXAro6QC/SRr3SUN3Vvq6l7hSIQBB
THrjmTGq5BaYjn7k4B2Ix3+QKOYmg5WjImd2uPJp8+XzTOQjKQs=
=VzIN
-----END PGP SIGNATURE-----

--Sig_/pMkx1WRJZ_dYznR/h6v_uZm--

