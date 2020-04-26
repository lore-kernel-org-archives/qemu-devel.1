Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F65C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF0D2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="as2t8rGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF0D2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSp2G-0005D3-7V
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 17:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSogH-0004Hn-DR
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSogG-0006Ol-Jz
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:17 -0400
Received: from mout.web.de ([212.227.15.3]:34949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSogF-0006Jt-Vq
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587935944;
 bh=v2Q48Pm+/yCuuYhe8oHV9FjEBrga9YLYBk3qMRI8HgU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=as2t8rGxoJwg7aJU+ubbiN1761Gd4peU+KAAYHVrdGgefEL+HsJ8dAnyD/4OnK4dk
 ZUxytoElnZDLiwKbFV7dG3lNLzg3tkBxW7trSmXSYnzqzLWIFT0pDY2CkZsTZ00/Mc
 v/Kopz/Rf+HxlxS1zgpq4eEV03UVELnmAjMb05YY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.69]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkPRz-1ivwhP00lf-00cSqY; Sun, 26
 Apr 2020 23:19:04 +0200
Date: Sun, 26 Apr 2020 23:19:02 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Message-ID: <ac9d7b14d0da6235712711bc9070a6c018df8f5a.1587935686.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587935686.git.lukasstraub2@web.de>
References: <cover.1587935686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eGJFogQB5dS+D27JZGdsPde";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:llL/+uvtLCZWp63V8/ykZa9fER6BWDPZOT0FhR+pxpKFWOPVh2w
 crQKxDAQX5mZKh81dZsEXArBorBcf1L5py1ksOS44WHAEsGarYwKrMBz+7pWbmVKaXKvKwM
 AzfJgZZ7vU8pb4IMbPuD7UOjDxDngPHLtK4nXlJwnDVRcFZ06saLumROXfjDkQ/hdzlmRD3
 AAqGS4xnhL2GQbu3gKbQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AtAt9V8m+EQ=:nXmvzuByTsGwcmghQuGjMh
 ash9UnW/jxVbALYFieXPXSc44y87D+rNaeRwkV0IHl9cqWxmu9+21SvZKtKPyY8LKtralwcCN
 QWh6o6XwW9UXjb3waPvEjHXty38w1gbWCY68Xr5blq4iK+sH54mRwiXwR3tbjKKnYykKgfPYR
 dpcrExhpya5f64LLpudw2032j50s9HOVQW1YvXTX7ai9WabK7cJKa08zNnL/3cnidenT8//7z
 wtA1/khr1JRegaPl32IBSZ/SVthNnLev8opeSBxXwlFpxIVeOmsLXybhD1/rEkldwyBbWn/b/
 nYAFbij28BpytRF7kg6S3Uny8XTqrN/vo1lZ5eNlqxtZx4h3HYwNewMCCvoqKX1fT9qnAwQo4
 gC2GW7zP3NQYfDwmMJLBjkf2jFzglQQFz+o0ipDvK8AOSKRzBLwGm2+qWlvYN+u1pOs0AjEYR
 p3RAZNbPwK3xJpgyfAyEnY/KRZ7HtEhv1wG5vlxQMhUU+rPNXBRQK111pR3PBAHlsYFwipKEf
 EQQvEDIwoXhG2OPM9ppmKYewzwc/tCKrDx11w1Mlf4uHpObFC/WzzHWZeJFj+iqzuckbiRBQh
 nIYO+sU1z3usdntRTwDGqcyJcTUVF5+OArT0dXUGFrwINBxEQIkA70bgHjgYeoPzcHVC+vaiW
 BuVEVQIrs/LIV3TGa5HxDzkbgW6hgtE8LshQgYw0XpSWjc81vjDs6YvHbvXfPHyzUVUVVNjFc
 aNuZSGU1R5zSlTvnTKT5AT2Oge6Ld+8kAWDHVWiuBDbuwJv9SNQlx2DIPalxV5/PTMegHam/f
 81uyS++/eNSEnbrtHR4ZhPumMN61l+YLGmTgfXFs0ITcBdIh3A6zs+UXiQQBTUqQsbWfFHX4X
 X0x2DPQiyEHnwnNJKaxNNLGcZI6A13tZXjr+tyrJ+Ner75P0WqF+kp3jWOACr6I914EZbnDbc
 KaajQFtjwKML5sRtahPny1lhnPpbj8Oioou5oyWV14lJoQ3MuPhVozNcRc1/nmp3JZUr6GLLD
 4Wc36M7wJCQ+eSZZj4GRh+AlIcapsebTaD2Q0PtQnCoAO9JQRxz8QUOtXg4BuFTiiMsQ+v5am
 P4VZxHX8Uh7z/GwZTtftG5uFRujaDGelfJ9j+StZcbDig9g52GrPEJfSUlLLx7NXXcFyRuGc8
 NYMWJ9nHeRFmZeQBO5Y1nnfSKc91uZBMeS5TatejV4MXhNdZ0j2Ee2vl/G5d/dXZyYM4u3T2T
 oGJuqjl7YZZoIdCNQ
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 15:25:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.15.3
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

--Sig_/eGJFogQB5dS+D27JZGdsPde
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
index 6634911770..f3074ee3ff 100644
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
@@ -912,6 +914,12 @@ static void check_old_packet_regular(void *opaque)
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
@@ -925,6 +933,7 @@ void colo_notify_compares_event(void *opaque, int event=
, Error **errp)
     }
=20
     qemu_mutex_unlock(&event_mtx);
+    qemu_mutex_unlock(&colo_compare_mutex);
 }
=20
 static void colo_compare_timer_init(CompareState *s)
@@ -1278,16 +1287,20 @@ static void colo_compare_complete(UserCreatable *uc=
, Error **errp)
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
     s->sendco.done =3D true;
     g_queue_init(&s->sendco.send_list);
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
@@ -1382,12 +1395,19 @@ static void colo_compare_finalize(Object *obj)
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
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
@@ -1403,15 +1423,18 @@ static void colo_compare_finalize(Object *obj)
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


--Sig_/eGJFogQB5dS+D27JZGdsPde
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l+sYACgkQNasLKJxd
sljtSA//ckaOz9BAdpfTWc2QRFQusktdDPC04PAkt7fVgtLA1sYn7e3qj5wFr7xf
OpqOfDsLfDCMnSiRKKRKwjiFUWwSM/sIDWhIuxC+pl+T7bCiFAu4/5kWFRveiV5j
MBiOV8ldIwyQW0/Q0w8mgel9ozcvTTkR2yQHdvSfdZNJAe4C6XNW3KpkGJR17xTx
c4e3h+gfJRtQhds40L3mVphmfTbIEQz5zK97mS0QQwdoihMXNvLKL/FzFQUzqsbk
t2TY0t5R8oF4ApiJiLRf35NytLV1i65FzvX0RBUq22UmasqCJMYGczILeI/1e1Os
EZCcDtaPiYm0Y8PhKfQjaglyRwPx7Q69CvvnjJhkTTq8J4zzXU6okOVtVZIwuU3z
VLqIVU5shZIu6JvQmesS3P8YIMNaSvVKtwiceXpVrl1ddyIuj1iRF/903UaNSOnE
Y1rNcD1h2Ea4NmlZy8gvuWZ8kXDqYIPU+Y0vXKUAG3IDaLCIymIdOsgurrS79y1c
w/k0wAC3EomlbiJ6BBtQiXhZBGwxl2RJ/mDQDiSvGFFzUlP7CpeUzOEpePoIEd/g
Lyyl8y2m+WapIlRfIf3jtVmzXMXuztv2aZAXtjW7GmTavOuvNWp+kCMkt1DlA4ux
NQiWY8hGeGA2C+Qf9l3reDWR+cItXugjVZEAxl3oRnX2ICRBUtY=
=iS/F
-----END PGP SIGNATURE-----

--Sig_/eGJFogQB5dS+D27JZGdsPde--

