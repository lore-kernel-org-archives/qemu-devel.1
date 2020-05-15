Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6414C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE73204EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="K6fFhFN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE73204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYU6-0008AZ-Db
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYG6-0001pl-Fk
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:12:06 -0400
Received: from mout.web.de ([212.227.17.12]:58527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYG4-0008FH-Tq
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589541115;
 bh=/BRR383xwz8e/cdtXOCGs/9bda64NE7CUbfcKKkSXtM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=K6fFhFN8Asw3AJuU03sGHKyPqYXhFBF54uqC8Y33To6BJQW9aKfVITX7ri9z7/6TJ
 bZL3NGl+cdZcaswtBkMb37Jux3jZIJIncGcReB5boOlI7Dn+QNIVHomILfrBRMNtvi
 vtFDu8oX0v6AJUAfi6J0KbgGkxgfMhni2C2XIJS8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshWf-1j7Fp40H2f-012EZZ; Fri, 15
 May 2020 13:11:55 +0200
Date: Fri, 15 May 2020 13:11:53 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Message-ID: <fbd6d5960683b95d768b504ca9a93b42c7d6a873.1589540787.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589540787.git.lukasstraub2@web.de>
References: <cover.1589540787.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tB//jzM3d.+_QoiJo3NznNz";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:zisGVcRHWVRf/jgsmBo3phHB4561wcsKRzPvPIek1z4aZ/W5q5G
 c+2lVHWMTMyaKNoa8sO3n3re/tYlnTH2EPvvc4Zp9vOS104+arD1ZEhPLWXbnN+zrpf5V6g
 vQIDHn5eQtBpJ1F3AAIy8vkQ2WCd2tayD31KOTLP6eRqfg53wi3swlruJpG6OtKi+Ovm2ef
 NMOGwN3EMb27LzydTtFMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eBXHk8LzAHI=:4RuLsRscCmhekSUyogFh1o
 MduYPqZp/yd1PpDwN6P+Kmv4MAEGtbuE4nPL/LSh7z/ZlBZRzRoHvNLpl7r26slYjJHDQT/o0
 ZCcj6jToD17pUbjxHBH2uP6ITLkdgskStElI2oSIqu8+IdX9UNnPvs/AntW/4AxFZRZI1HlyX
 k+z8VyyTPvRu87I53caNwIAITGas8k5CDVFASSsKTcJwytd4g7hoKvct5wHvgWy/8QUc45UVV
 9j4U3uEmkw7yO2tjK6hMUGsZQLc3lVtBRmFFEVIuFxC6KEzJ6QbQ39Rxxa+YZwR1HROSyFZix
 61GVYzOibSoq77wbtVcVXY0cuurwllqYN8bsSQxiDw1ZCpSG75Q5c0gS/hdAFPPmWieyypbM0
 rUvEa9+greVAEQChp+vYfGlmbIuOYI7FNqzwUxtsPOgb7MABZPmBjxSERwWgvkQWW0D/QLhej
 DTRxj9u7l5/WmE44dkLMBtdyNg821tiU5eJTpxQIkqoXo4ZFj5i1pA/pI6o7dJr64jihESMbC
 +nZqVptIxz9LqAhUwGRFJHLIdPGfWHdMZYPUDYqysb2vXsyV1HKwBXrrS+w/iYR0Gg2cfsCMZ
 9c/YJJU0Z2XJnjnjmQikIKCuJtJb69wIOHDBqWUz//lk5ZGHf4d3pm/AVeVG85VVzVwiDa28p
 0ZwdvDsYfaUSEwTJa6JeZUKFxePw43aT1svvrOQyJZFLuRX2agQx2eOmoEsN/hxFK8+UTPxJB
 cPdNxSPggWDSvthSZ0x1Q4tfoWxiUvZiygK6wVBtKknyNI+VswCuq6Dgq79A+tXiypKfMf5ZF
 JIMFrkfJ4WHNRPwlZ3FokHmrfoRYnfSGJxkwPPyR3Nej3P3kOQ05xYoq1cGWGcprpBaioI42H
 7S0qLZw/VXc88MpD85y/sx3rftTQ5iKr4ZL5sIe3IW4iVILHA8b9AMKOZNBShZ9wgPDs0wgAy
 nGzSj23KBS81TZCakUZ8dZcPQZ/jLVZn1aZjaGjWQgB2iG7wuMe7oGIqmc/FD9pSc6C8QHYCw
 cp6IKKcqTWIpqbKHuLV3bucqCWhJMab1z9KqEkCenovKTIU+v0qQYF/wjVyIzL2eRSF85P7iW
 ZZOTIXZ8vKV8arXQRYMDrds3oN6eWSU5EhedoKT/vTWSJ+7ljEvSOrWQqUC6heZpYzqAwVXUV
 GxwU//i7Fo9m0ovzHmJC0fZ7FOcChlVWAHIvgheneMjamqf/oAWqYx/PpBRVcPGGXFF9gtTqS
 /Js65jfKOm4a54yur
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 07:11:55
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/tB//jzM3d.+_QoiJo3NznNz
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
index 7886444cdf..7205fdac29 100644
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
@@ -1292,9 +1308,6 @@ static void colo_compare_complete(UserCreatable *uc, =
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
@@ -1386,12 +1399,19 @@ static void colo_compare_finalize(Object *obj)
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
@@ -1419,15 +1439,18 @@ static void colo_compare_finalize(Object *obj)
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


--Sig_/tB//jzM3d.+_QoiJo3NznNz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+ePkACgkQNasLKJxd
sljUdw/+J7KTnaCsuC0tjkud4CdBFu3EbLmarorsCYP1OFkgu5fM6bdxTNxiJPas
K6IQMP4PZGYSgHfygkpP1fZjUsgkMVwwOLhqe4JT/A+3rB7NAE5+ll6pe/cf/D9l
vIHRPBJU+8AgIQACBcLlNTFuE/vc6cmb5yrBGtQilrE/2HNSjEujziQ+bz49UyvU
dea+Ie+3bByYuIE4PiZlJxMUlKmX+C191D6V0ocUb7tqJdbQ94Gx5S7d3An079TE
B5WcjHLzDh9atqyXrEQBn0D7d7Mz5WFQLEJgByMIqpTNOhnqH7gMsk5DOpFo4NL/
b1qEJjkph4J4DYFBztijHclsP++cdrgKpgmo+ycdA9KrYNFIyzv6Q3ZrlpAZDlVu
/mWMnIwovEBBQ13fBZmFeb3VTQc5mBEFblOMhwCbdFagFTL57ED03XAAUwIchZdm
QrlP1UIU7rhR5atiu9Z0H9f4psukYF2vQ2Oge7QHUxIrXwwOujrhCWGHlCnVBvvv
/xv7dZ4KhG85hN0qV/3ReYc7gftaQuyNuXY9g8rd9W/SBXBWvx7dvYLQAQdUjJ4H
01yk8bukQJdvHT+XCz3i1RChh5OyypnKbRJG0LuxYGt6oANRGrioMuZeluFDBmf3
YFBNRasgkeq0H5FlJmu7Jiw+HNlG174t7Rh/SpZ6LBdCi88kyQU=
=YtT/
-----END PGP SIGNATURE-----

--Sig_/tB//jzM3d.+_QoiJo3NznNz--

