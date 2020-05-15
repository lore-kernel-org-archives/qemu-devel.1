Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024EEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7FF204EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eZ6lwOBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7FF204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYPN-0002MS-P2
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYGH-0001yb-HD
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:12:17 -0400
Received: from mout.web.de ([212.227.15.4]:36617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYGG-0008IY-IV
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589541118;
 bh=BYrK+knR+D/cawytbYf3E0l4+H25EAb667xb1e3Ktog=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=eZ6lwOBvZ0B7ozoEWD1Hqx58pzQR3T/YD6T1xK62WBauU9E5tN0xLnXlXZ+rc6oI8
 gXA72p+xwr2O5hCuNlglzNuDupt3hsys2G/JI65ZkIF943Qm6SiSqF8q9BC4wXRY9d
 CTEBMzWnxrP4W9H+2N6puJhQLVDZfWMMxDZVM5DA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2Mq4-1jGvPO1gLE-00s2PJ; Fri, 15
 May 2020 13:11:58 +0200
Date: Fri, 15 May 2020 13:11:57 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 6/6] net/colo-compare.c: Correct ordering in complete and
 finalize
Message-ID: <be21a738172716ca50e0e9f02d9bdae941d30b82.1589540787.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589540787.git.lukasstraub2@web.de>
References: <cover.1589540787.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VpVauuQZ4vDdG6L7i8E8bHp";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:FQ+36GBUVENmTy3GC2bdyjjbghZ/xJ5un8p2CYuUY3xrySLu9H2
 JLOUgXryGD/XOIZUEC/7ILqEllRgo2FEXd/QM+hB/TSECLrf/l3FbiEPDfkCIBZ2kuG8zNn
 FkMy9IyQu6DCrulXhvUNeNn8Uo6IsjlSZJflBJEP8urkvtvxEyQwMvn4XNX7P7ru5/XL0y5
 a4tXTEY1xSbiAVTTz355w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zBsY1PSxvXE=:SSvs3vrwi/ycdYa0uaDrUy
 jncR8wC7jB6acd+w0iWbPQH1ukeI+HdkqRviAd1sLTHCA3maQHHhw9FDyRbFPa5hAGrK8BhH7
 KeD0TrdS7gvG9Y1KSwHp8S7jk26TZghv3U34k13++SdRVCaeLx6NhTICp8M0VSzzGPW/e6LDH
 Byovfv0ckgMWcMikyruyryjbs7lJy6F9LA76m7R8/I+zWn2BSh3V9a3LHX8+ntP77NkYezTXS
 uw+whDYw7dwhLomN4q5rSy1u7esVhhRo+lE/PuNwIYDgonTe3Qjey+2oYwOc9WkkXyVKmEuwW
 3+BDkGWNhuTcAUezfNYjH6lWf9LGHYNRSatZoslMNWQMsr99JNB3NYfqzsPdN1DEj8zrcCGy6
 NIYHg849d2woV+UKuVdQ0ZL1p8MfBOW905qLLOWDMgit0JteGai1qfEyshw8KXROTAByfFhPY
 qj+Q0nPqwNla/AzDF9sOLIY5c6DkHS6SnRy0LlD1obGb7fY23DsivMcBvUaqlyqKOMa2OzQpU
 n3/fRCRE6usTySyKwWfhhrwugEaa8NkzE4rRvLpcoxHnKB+pteE9CXiCQRSZrdejCp2RxONt2
 gKuQg8qQuDnYA0pW3jjp67Ilkans03o5JdQ7/4yE1i3jdcfl2xDl+rSDqDHAK3zbYTjdnO4n1
 FUMeIHlGYQWhtVY0cqXYsKPmmeyrjivrwEtfkJxJhWNZttBnFv7mkA7ZlDrtikdx76mwYnzGi
 zrPu7A3bKbs16ZyBrfY8WriHifeV0LKGeVxb3VpUPssDykKzoP2LRodQ4CcsKyKmy3nZPfC0g
 i+4P4Zn49GVlrIXV9Ybgde5q4wQVGM7Eq7+7R3R2Rr1I/yOYow6DdatcMBKFKuD81gVN+WRcR
 MkRP5XB7rZzeEWUbYM3MQ9xUIysHS5tLaLJNP+nMrlvtpy81h0AozSLhJtlAcKUyT0NtTsn7e
 immjGDdatlV93FUkRTpRtrWk3Yr2kvdQgK9+zBk3MeArCare78tiRwb+4mPCcC3Is8ilT6bX2
 RpRSpOjubCn2P/tYwSRcYh0PaUhiMP3Mb/u87RJBq/iC8ukZ3abRlPG2FLyQnEvm+iL2BJnA2
 HnfhwR7L/8wUk7byrK2p+AxucqSAxflBrDw8IIni5CFL1YUdkfnTKnZIiiguOg6x5a0Li0mV9
 hRGTQF90xLMU3Hi0IZXrsVTuM/EeNn63hXl1K6VbYkG19tCxV0W10I92Ufg5E7RusOMnG3DSa
 FKHXS4UaAOmhN+ueA
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 07:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--Sig_/VpVauuQZ4vDdG6L7i8E8bHp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

In colo_compare_complete, insert CompareState into net_compares
only after everything has been initialized.
In colo_compare_finalize, remove CompareState from net_compares
before anything is deinitialized.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7205fdac29..fddc955229 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1283,15 +1283,6 @@ static void colo_compare_complete(UserCreatable *uc,=
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
     s->out_sendco.s =3D s;
     s->out_sendco.chr =3D &s->chr_out;
     s->out_sendco.notify_remote_frame =3D false;
@@ -1314,6 +1305,16 @@ static void colo_compare_complete(UserCreatable *uc,=
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
@@ -1386,19 +1387,6 @@ static void colo_compare_finalize(Object *obj)
     CompareState *s =3D COLO_COMPARE(obj);
     CompareState *tmp =3D NULL;
=20
-    qemu_chr_fe_deinit(&s->chr_pri_in, false);
-    qemu_chr_fe_deinit(&s->chr_sec_in, false);
-    qemu_chr_fe_deinit(&s->chr_out, false);
-    if (s->notify_dev) {
-        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
-    }
-
-    if (s->iothread) {
-        colo_compare_timer_del(s);
-    }
-
-    qemu_bh_delete(s->event_bh);
-
     qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
         if (tmp =3D=3D s) {
@@ -1413,6 +1401,19 @@ static void colo_compare_finalize(Object *obj)
     }
     qemu_mutex_unlock(&colo_compare_mutex);
=20
+    qemu_chr_fe_deinit(&s->chr_pri_in, false);
+    qemu_chr_fe_deinit(&s->chr_sec_in, false);
+    qemu_chr_fe_deinit(&s->chr_out, false);
+    if (s->notify_dev) {
+        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
+    }
+
+    if (s->iothread) {
+        colo_compare_timer_del(s);
+    }
+
+    qemu_bh_delete(s->event_bh);
+
     AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     aio_context_acquire(ctx);
     AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
--=20
2.20.1

--Sig_/VpVauuQZ4vDdG6L7i8E8bHp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+eP0ACgkQNasLKJxd
slgmUhAAgtVdo9xQ3mMl/VkxVNKKllwC3s+XScyMpVfs9+mzERALtO5IYKCz5st8
78kwxLcEH+Mhhm5ck5faXx+q47jBRDClXu9y/hpCpVnaZPzRNn4pSwuE/Zzi6xo9
nV5/5IHNzdfUDA26ZXDx3/gpJjSMUDlsKhgzYMM/cCTR79RMfG7x/jBNZz0+3yTs
uH8mvtG4375fnGLZ38NH7CgC9vFPAFvMS+OcUpRhKSSl8XwepyuRv9LQZjg/HoL8
sa1J8YMwvkP+kA0Ajr++N52XTwB7+gPJ7uGcdYKCVRZmGHoDgGms9oJ1F4jLJIFa
niOWBu7wJgRUqvP+pkVmK0eghfnnXqQQSEae3XFi2ar4XxzRyCIQB16T2cRXoOap
/QC6Y/qsjvSaQSPQz0epA/gxnwkQXVenUPtfNJl5WcER9/Vsbyr6VNi6huYKt72P
6HUjhvqSpzuykg0x/T7c62CunmfS2zg2utL8QcxW2DMBQm0VhMEj32aktF59R3cS
yl/wBCmZHrCkNL3CyUmmC1JDgcRsB3s5VuxMm9B70K5PTK5oC83STc4MwrbLbQyx
Q4L1qJ28/mfHuq0k/kqJTxblKFvqhJEMAaRP3uzx9gkdqyqcmhbwr5DeZ742wQbt
/SloXoesrLUxoHyBmnkb5cFS3/9A/ldi+oIbUCMRS7liPFh6Ee4=
=YloQ
-----END PGP SIGNATURE-----

--Sig_/VpVauuQZ4vDdG6L7i8E8bHp--

