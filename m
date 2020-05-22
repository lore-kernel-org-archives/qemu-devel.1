Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD9C2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Sig4kNgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD9C2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1mA-0001fZ-OA
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 03:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TS-0007Vk-94
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:48:06 -0400
Received: from mout.web.de ([212.227.17.11]:56815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TQ-00016h-FW
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590130068;
 bh=6t3gKbi3BYQQYPWCApOdko0vUfgjwHXmi7x4ro7HDkU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Sig4kNgErcY9WAL2hbZWdpxzdxlF/D4Yg1vJRQESHW1mYZmnuAqhBG8EHg5R/T/6Y
 p7a/YFkq1v3zN0O8gagU+4lSq1/n+HLM5jwaWCY6/AwR7YRE4uYFKRtYFCg4P+XjOs
 LyFx/BZ1KOJZjrzXYKUASGOtHzziX2R0XHtBa+80=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.67]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V5b-1ir3sm3KRP-00yTGv; Fri, 22
 May 2020 08:47:47 +0200
Date: Fri, 22 May 2020 08:47:45 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 5/6] net/colo-compare.c: Check that colo-compare is active
Message-ID: <3291bc9d7372e2b50c517efd92404ae5437e65fb.1590129793.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590129793.git.lukasstraub2@web.de>
References: <cover.1590129793.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VDK6llwDvmHOglbuy8K_skv";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:P3iRCobE8CgAsFIuNa6GbaiiA/TLO+hNQNxgTumrOKFBSO08WER
 qHZqVRFq85E7EBgJqygr593V45kKlOr42OeKc4tDQu3n+7JiqDp84/94k25x7qvaEea8bi9
 guu1lPabLQgCbPa1NpqL2MwvtJbr1+BHYpAPqT1OtR780J9IoHuJwymx0ZzW2rEJ9Yv9L2H
 apCuW6XxxoDiE+JgHgT1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DDJpM3iBj+k=:rJmF2R7y9UczoiNFOi25l3
 ocQyNqGWly0o5wrypZbaWwngj2s1fv9amIVWmG6QAUhm2SEN43Efdyhlb5WFhjrwmePtt7+I8
 SQ20LyTaql2uudaf2D+KghgtYAhb+KxWmvN7BxKrSs0aBcHBG7BSgLEqzTPFkgfC4XqV8lvzz
 loVpYDuRJBH004UiZeZylYSK7zUasQ3Hjyl3i48YwxBlYBa7iGGqWX9KWEAIWsp9HamFA+ug7
 AM/kN7XvC/BC2K2p+VNxBjUvYOyy7EnvNTcRQ+z/8HiYfNl4mwKHK3Hh9BcylrXV7CrNXR/26
 PGy7/LZK2HKgOqr2GDZRuMesRzgWrwMVk1Qe7G4R7U8ZPoagPWxhvN5LM+/TgYkLJNiv4LzwG
 x76XeUl+a//CwFQdW5i9bwWm+8rtGKq5WEYpIOUSiVgrQxXeM544DvE1gOif5Bwype33WFhKk
 7AcJ2E+YmUoKeB/kyK0o0QXHBYRKTfuTGUWa3StyJmDgaVcZfH6HPFl21F1h7VgNF642DKA3H
 ftzi/4XOcLjWvd8p2zO/q1gFAhjZkr7v8k6gN0Z4LO7jO79cpJglvhg/FeDPSs0RJ5P46Iovs
 TaHV+40/j0IxRjQX/PwOafmHcDf76kE67qnRS1+FwSRO8ecH9be/stBk6BnsUAgSpwh4YopSP
 Gf7NeyRRZ9Sqd2UgmjYbFmVLP5AD1t3yDDyrykMQUcLTh7EtjxV1QKEBlVW8PJH0+YM0jSDUr
 yVsnKDEIqjZXqraWoTCOWFrWdkRWG476fxvFzx2wnfRZZE21erR4pbcJ4Q66MXIlEMV8u/asG
 q7KVqHStbHDGsu5hYs8+bfCVa2b6KHR5GLXCIm1u4qB5JKzXLuElBi7U1ybmDTHpgVlDV7Ugy
 Ml23qKdlh7L4XYhzx7WOfs6R3KpXu0/qJLyQzlI+Sn43SEsC4dPPOtL8jHUFg2qpF9ccXwjpt
 LK0sHhKLdEeQdtoWvZbARJH+7waASBRKs3nrOw6y00xOczKtB4X4WR1xwxCn69O9CPJY0UikI
 Oenrlkv2oMO///13ie7NSikirvR2daiGzl7x7fwqxkkVkD3HAZC6DMmmgzOPwy8SFCRDIeiJ7
 P+kVa/8+pcPJ85SWXnxVTvrHbP6cItElArjVQ0OzBbMJWvlN+fu2Z1EV6UHJ12gevdPNhPNNi
 KrNf+vUYhhnw4BiLK+bspcKbCZARk2a1R3P/gHc7tKY9ar3M5V23UhOn2U3nNbRBMYDIPLVlZ
 kRoSLzAqMxZYitNVi
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:48:03
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
 Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/VDK6llwDvmHOglbuy8K_skv
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
Tested-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7886444cdf..64d2453450 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =3D
 #define REGULAR_PACKET_CHECK_MS 3000
 #define DEFAULT_TIME_OUT_MS 3000

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

     qemu_mutex_lock(&event_mtx);
     QTAILQ_FOREACH(s, &net_compares, next) {
@@ -919,6 +927,7 @@ void colo_notify_compares_event(void *opaque, int event=
, Error **errp)
     }

     qemu_mutex_unlock(&event_mtx);
+    qemu_mutex_unlock(&colo_compare_mutex);
 }

 static void colo_compare_timer_init(CompareState *s)
@@ -1274,7 +1283,14 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
                            s->vnet_hdr);
     }

+    qemu_mutex_lock(&colo_compare_mutex);
+    if (!colo_compare_active) {
+        qemu_mutex_init(&event_mtx);
+        qemu_cond_init(&event_complete_cond);
+        colo_compare_active =3D true;
+    }
     QTAILQ_INSERT_TAIL(&net_compares, s, next);
+    qemu_mutex_unlock(&colo_compare_mutex);

     s->out_sendco.s =3D s;
     s->out_sendco.chr =3D &s->chr_out;
@@ -1292,9 +1308,6 @@ static void colo_compare_complete(UserCreatable *uc, =
Error **errp)

     g_queue_init(&s->conn_list);

-    qemu_mutex_init(&event_mtx);
-    qemu_cond_init(&event_complete_cond);
-
     s->connection_track_table =3D g_hash_table_new_full(connection_key_has=
h,
                                                       connection_key_equal,
                                                       g_free,
@@ -1386,12 +1399,19 @@ static void colo_compare_finalize(Object *obj)

     qemu_bh_delete(s->event_bh);

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

     AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     aio_context_acquire(ctx);
@@ -1419,15 +1439,18 @@ static void colo_compare_finalize(Object *obj)
         object_unref(OBJECT(s->iothread));
     }

-    qemu_mutex_destroy(&event_mtx);
-    qemu_cond_destroy(&event_complete_cond);
-
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
     g_free(s->notify_dev);
 }

+static void __attribute__((__constructor__)) colo_compare_init_globals(voi=
d)
+{
+    colo_compare_active =3D false;
+    qemu_mutex_init(&colo_compare_mutex);
+}
+
 static const TypeInfo colo_compare_info =3D {
     .name =3D TYPE_COLO_COMPARE,
     .parent =3D TYPE_OBJECT,
--
2.20.1


--Sig_/VDK6llwDvmHOglbuy8K_skv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7HdZEACgkQNasLKJxd
slh1yhAAueAL2doLnzy7gd1EYmb4FFVcTptfz21Sh7HPgPlNG6tBkXSuIIntLgO1
nZg/MNk1J5NFt5jaV2yBlcRmhg2zcIIyWQNe07Y5hhnF+UrzWN4SpnxAgP5anwQ8
auHUG6/GDeFOTJzmYyNevBtX4u20XRgR1IuMy19F8S9IQBI3kemJjif1Bvy9/z37
WbQu9dm59Kuo/QErsfAxFv3DbR1DYnalvZMfWIMGlIElHCPgSGrFha3A0GmDGJ07
tJXFPxM4ZvX+lT/3mjXOQmkNOKKbvSXM4z0/czjXr2RkbIwtVQU9MXDUswsXncXG
YhKZAbr0x4Nv/I3FgLqbOtT01SxhHy59NnOg9t1Sg2QYjEogdco9FZa3444mPhQk
IF9tBX4ij5BOYRjQbMZRA+NFIFg74vN2Y/oIXYKs6aJ09LrQx7WQXZVIbGSFSpkw
XRWGFaubbNeO6Qh8UuBJkg7zLv1F3aVkhODhyFujz3Fsi1Z9qpBz9LzPM+pjobGI
rCgQixCL/pitczal50d1BaSRvlgy8YUu1epoS7MJoH+KIBBqkmpcFhs/1P4XqF/u
XBNcl9HRJrzRaZXSRMlO5ljc78H9GH491MqHzhyiGjNUGIVp0cEweWYJkTnv9OzV
wHJmzER/hcLP/5dBVKTmA4jb0kb9RWH+PruDcuKg17h1JaOO/0g=
=5CGg
-----END PGP SIGNATURE-----

--Sig_/VDK6llwDvmHOglbuy8K_skv--

