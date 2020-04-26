Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6284C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADA9206BF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eoVUWUY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADA9206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSnN1-0008Ew-3S
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 15:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmuo-0001HY-NW
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmuo-00068A-9i
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:10 -0400
Received: from mout.web.de ([212.227.15.14]:35121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSmun-000615-NZ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587929159;
 bh=bn07OABEnP65wBkyNehkeefl/TDdh0u0fLf89mgd5jA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=eoVUWUY3kz4SXk663FqDpQN3bNYwCjYShVVQnY47dc/VIqbNpI+JMrQ50bodTMV68
 WQY/fC8SXldRfDl2aIFplqrv0V1W5t96Zl+mE84vE5PziuOSgu4OqJGM19LZ/W7cXx
 0gtv6UcHozb0HIdJdY56Sgis2fYgiQ3MevOxrXMs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.95]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZliY-1jlyzR0G8U-00LUN2; Sun, 26
 Apr 2020 21:25:59 +0200
Date: Sun, 26 Apr 2020 21:25:58 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 6/6] net/colo-compare.c: Correct ordering in complete and
 finalize
Message-ID: <1f8588fc862c9a96006239f82431775c60953250.1587927878.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587927878.git.lukasstraub2@web.de>
References: <cover.1587927878.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O5t4FLcDeKV6n0DOYDTr1s.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:eMORE7rslF06fO7KdwJI3wW43+RE9wizYdPzOVgtGkBOpY7IajJ
 jBh4Hl+mvToQseJbBIY0qpRePwdwqRvYahar9WqJOQ9tFJON//CfrvReo1u6jvNkluT6cMP
 3mETCRew66Mq+g/AnXp2DBW/GiSf4HWVLRJs++aZ46zAqhSdFz1tl4Hz2hXjbs6EC4NAhw9
 izBHf52mMs4UjcfjZkX7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gwtfQ+v7ngE=:BIyVkOdN8xUVlFFcbHxhR+
 6i2LgrpWI1LkyhYfi57QM7H0bnlF+kZ6rGnQacKdG4Mr2dEzcvE4y/KMZoOBwt51bRlp9Hpw4
 YB3IQ+FhdBSlZxnHUGeakdiSnw7gQQwYieku/k50KcCtHx9IYo2LCVm4FASqNkOMfa6I+0IAy
 d6KTHpFSmn5awGGqjljk7/WfOu7YGEXRZXGCgb0BtqePSapG8FsJjsZmDNrGkIShQOawvINpI
 YMQ3xQAf1QDBnFoWAc9LHgvHnh5omK288XBB1FhZAl4vfZ/Ov9UWQgxJLhCxDHbh5VZe+/2bw
 cOllSNtOFnkCdTc3Ky42JnBCvaIOh4z2Ka9pTCf/YU3yLWrd+8vuwwGEIr7H+Xn+QnRtOkaoW
 f27++BjM+wpJmUF9TpmQxK3Ift94T27g45uE8Y6jX9VdV5/Pd3A3KNKUqxTIYoP54BkWn9Kd4
 wRAGpzrUd31zL0kCD1kVQBdst71412siMXA1uqXpBYGSTIEdB5Nzalf2tlzO1XG03Pwe/ny2d
 zmLKIHN2OZIOL+YSvf8msrgBwJmxHMVsLQeZFClW7Fbyh/f5DaMlfedx9W5fTXkX6zVwTrIRK
 hgksOhKcy2V/9P9wrkzH/yWNbJL1jOd2sTkmqWYqH8tBeBth8kZgdEEyTF3uB/R0F6vvwZ6qM
 TCYspUJwsMPB6u3uiMw+FrkC/G1IpLUQf6ykhkUFPAAYJt9QsrEw6vHrhOl2PnFA8LjC+4P1e
 XDTK6vvnQiLbNV8Q0WH32vx5i3mDty1wifvcEVKTbvtE/HSvPOZ/Af2xkeusvduTvdVBzbsbx
 keRutN6XAlKQ6q9ctqjH/YeCN5tGPV2D+Jq95fSLu0R74nscWKeYqM2n0iwwZzsRrMbvHZ016
 6zI+oTbNOVx/xywbuMGuwThJBWDZI3oHI5bf+MWLqwLyEtz4w56zO4HgLjK0owg2uFcAs512U
 HwvBfcOyc/XP4Rhj9a9OY7XfKxKWEWvcaZofSrDKAr9e2gDne5jG7ZHLMv7XQnJ+aH5avzZhx
 sR/dE4gkqfUJYFR6O2WJfHuBF/A2545bQlaGmWmxVYwkHIGZn/1NGVgbn6xN9pLc57qu9P18v
 yjtkfcuF71vPSvnBSbRbmlNqEC1FohbTxvZvUWjBCa6FThTcPJ8rNRZTUMEvJSImDQ+vsp7Mn
 93cTjSRE4VKszu/X6AhU0vYNeMBPgUepbBexe017e8QwJA7TiMfa5Xrd7mKgtPDOECBhJ2Ho/
 g+NY+s5OeuH7MRGtB
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 15:26:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
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

--Sig_/O5t4FLcDeKV6n0DOYDTr1s.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

In colo_compare_complete, insert CompareState into net_compares
only after everything has been initialized.
In colo_compare_finalize, remove CompareState from net_compares
before anything is deinitialized.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 47 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index a82bb27a67..53cc145a84 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1287,15 +1287,6 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
                            s->vnet_hdr);
     }
=20
-    qemu_mutex_lock(&colo_compare_mutex);
-    if (!colo_compare_active) {
-        qemu_mutex_init(&event_mtx);
-        qemu_cond_init(&event_complete_cond);
-        colo_compare_active =3D true;
-    }
-    QTAILQ_INSERT_TAIL(&net_compares, s, next);
-    qemu_mutex_unlock(&colo_compare_mutex);
-
     s->sendco.done =3D true;
     g_queue_init(&s->sendco.send_list);
=20
@@ -1307,6 +1298,16 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
                                                       connection_destroy);
=20
     colo_compare_iothread(s);
+
+    qemu_mutex_lock(&colo_compare_mutex);
+    if (!colo_compare_active) {
+        qemu_mutex_init(&event_mtx);
+        qemu_cond_init(&event_complete_cond);
+        colo_compare_active =3D true;
+    }
+    QTAILQ_INSERT_TAIL(&net_compares, s, next);
+    qemu_mutex_unlock(&colo_compare_mutex);
+
     return;
 }
=20
@@ -1377,6 +1378,20 @@ static void colo_compare_finalize(Object *obj)
     CompareState *s =3D COLO_COMPARE(obj);
     CompareState *tmp =3D NULL;
=20
+    qemu_mutex_lock(&colo_compare_mutex);
+    QTAILQ_FOREACH(tmp, &net_compares, next) {
+        if (tmp =3D=3D s) {
+            QTAILQ_REMOVE(&net_compares, s, next);
+            break;
+        }
+    }
+    if (QTAILQ_EMPTY(&net_compares)) {
+        colo_compare_active =3D false;
+        qemu_mutex_destroy(&event_mtx);
+        qemu_cond_destroy(&event_complete_cond);
+    }
+    qemu_mutex_unlock(&colo_compare_mutex);
+
     AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     aio_context_acquire(ctx);
     AIO_WAIT_WHILE(ctx, !s->sendco.done);
@@ -1395,20 +1410,6 @@ static void colo_compare_finalize(Object *obj)
=20
     qemu_bh_delete(s->event_bh);
=20
-    qemu_mutex_lock(&colo_compare_mutex);
-    QTAILQ_FOREACH(tmp, &net_compares, next) {
-        if (tmp =3D=3D s) {
-            QTAILQ_REMOVE(&net_compares, s, next);
-            break;
-        }
-    }
-    if (QTAILQ_EMPTY(&net_compares)) {
-        colo_compare_active =3D false;
-        qemu_mutex_destroy(&event_mtx);
-        qemu_cond_destroy(&event_complete_cond);
-    }
-    qemu_mutex_unlock(&colo_compare_mutex);
-
     /* Release all unhandled packets after compare thead exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
=20
--=20
2.20.1

--Sig_/O5t4FLcDeKV6n0DOYDTr1s.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l4EYACgkQNasLKJxd
slimEBAAg5PC99qWg0eeZJjXBGtqMqXQtZOyImnJ5/INDnosM6bbr7Ux5uPud92s
ti0vDIs0ocp5VVNgJ25uthYY58noGVgoZ4bPO8YyOZpys1Zp9HGA110d2vii8tlZ
eByLPsroGPf2oaLp10MoufxGzRIUkxQXBJz74Ewy2DrBJ9sKoELgV54tDQ7r0jgA
K/+kBPCtNltXyZy1uOqbPXTaT/SklAZxREdCrBQG9QFEn3dN6Dr9czqyPDB8Leb0
b+t8WT+P5vgSSrTNULoj1sVzMXf8AQDjMhy1ZPo6uGFAYZ4qMTr/tHrt7c04ovo+
myGSB/a/rxNMtLPQZpGfSLv+2bTE8tyntXuSlyuT/42BUpCMOI2O0ecPDbZHJirC
kpvYwKvBEUG8a2rPD7UL+nrBjfy2NMSPtqeDf97j25hf/cura7jb9jD0QydayXJp
Uwa45eqYwERgolT+L4dAiuXBdj+u4ihru2AeFnCUye8q1XN7bKzFqdeMzsTQ0Pz+
0+3E1p+1WPuO0D703IVgRFoOPxYaHhNTEAqMn0sR+FlTwM5ic9hNxBP+b79X25a1
sUhhkYSBQPoI/XGg6HOUYuUzuYPXoY0X48S3oldwu5W/SM4NDLmKUz7gwnI3IqA6
GjXGu6AlVDs1JjUmU6Nnx7ayx/xwtUIeNmsBvqST0Ku0dpxo4Y0=
=v9KF
-----END PGP SIGNATURE-----

--Sig_/O5t4FLcDeKV6n0DOYDTr1s.--

