Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41416C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A4E20679
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VneAj4WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A4E20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1cM-0000Du-36
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 02:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TW-0007WE-87
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:48:10 -0400
Received: from mout.web.de ([212.227.15.4]:48021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TU-00016y-NJ
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590130072;
 bh=MXoVmF4cguAy8DgHsq/lz4aLwi/zGS3q1d2e0sLrm8s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=VneAj4WSKIy9b94B7uaPd8VxFjV5EZJB+qOjGAQg9o1noHptIhPskUK9q3OeVdP9N
 6eFdaY5/l2YGVpRaWv3PtlnK40qQ77UwjKMm1EJvqsfnEiaDNYMMkXAmAqlM43O1bX
 Q+XWUNVTz0MgoRzbtt5TeudsODyChImNV/P11I3k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.67]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWApN-1jZR3m3Hsv-00XL4Q; Fri, 22
 May 2020 08:47:51 +0200
Date: Fri, 22 May 2020 08:47:49 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 6/6] net/colo-compare.c: Correct ordering in complete and
 finalize
Message-ID: <4ea8eafa6a09cd0de48b85f865d88195ddb2e74e.1590129793.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590129793.git.lukasstraub2@web.de>
References: <cover.1590129793.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KMiC0ve/Bof+EUZOI9V7TMO";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:dAgkL82XolU30CnmSdgu3mkibl9fbyP93lT710BODEZEXcm6zRW
 fvSzQ+CQ7ZkcmZEqNBl5kxa0LwZ5FMdaNf7NwX17FBc4Y1ukgRYav5JEU62w1MlUMY7gJwN
 73qK3TaCQnxMX3UamjCVZFF5QxMmlLJ7ijldiBkS96rVp38OiFW5ic0ly6HyuYS57isVQxK
 Vi8Zw2HJk1M6RBQ/6vSsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dv7s4B8EJ6k=:/9qHpXxKLkxYH06ytWLT9I
 cBVRA6peWl80cjyFMPBjwk/WLQngVgWiL0vPeokZwtaSzmUujIVAWppw2oog9IC4mz8AzI0E3
 wImGvc6aghsrgt12FerpLtF72oGgvqoggDHHI+sm9CcffF28b4ulW+vJVhNGEuOy+cnuvE4QF
 wg+Tf0w5ubM0S5KeL17apVrXdDGP9npst/RnnpJcaO92EYhZGnju1zAyhFSKoH3YUYoDuBuhG
 pdnC8BtA4I8+HyUXWXF7Ev7svGc0IBa/R2YTQFG7RVYLW/HcxUXBWlcz6T0lzxk3K9ZXh2z2R
 1ycjpRkFOA7Ro7VoEw7PvKNM3tBwHcwe6l+K1s/B8zyl60DNTMjxjqaZPXgbYfDv7wq1sGwS0
 C8u6EzU9rC9tHcsO+nvEAcQ+zhoeFRMll+OrlUpmj+ob5pKytZr1Zcgo5538pAYcXC8DCsSbT
 TvtOw3Xh7ZNOzTTGKUEv8Nf6E2Asc/M3xxw6beYQMA6tGMY+UW1RMweNPA4/3LLN0yLMuTUvR
 XED0EF8pdyWeh73VlK2ZFFMAC/kD7UxzSXEDMuclzP1K5tX/mC73Ht/nND1+B6JgTMx1ygiWh
 akHAvfoBOWmiq7sJTg2Tj9ndeXPoz2NA80g3klI5DHy4JCS+DhmY/hIVrqk7dueqWS6KVlN3T
 VqEuye90CXy4qhqdCgmyz1a0GljZoQ0GGRO3ZwsfCoH46156/Ap3Qlegzp2chuq0wuob8Dduo
 btpHTBi/wKdyuMHbPGIN3tU9vcCG8gfc11dGL7SKAnOcpgDEW3fWqIRRnLnUuAnBNJu1Lf8dV
 lA9pVEr+2VnlkebcX4HkayfMMG3Im9R6vc0D8iuKCCPJXsuEXjzawyUjSr5rZW/0iaYndbLsO
 zLHtAmHK7RvH4/sYZbETo7+HjWUk42sfSlnxcDPX5sbQ6fCZyEBQRo+DDFMzI14vASFiAns9s
 5hgwtttBWz9rWRsjUOfoLps6J45rLtpHXPSmZMykNO/ARAjYhGhROz5cev7N4f6Pk6+V8DXs9
 u9u8qPNyV6qK9bC0Mdns+eW2mmXnHqnxDvlpYUwIPzuHsKcb0idmlLYwjweOYXDC2yQiGnurr
 NrawY4XBeb+QOneyhRNXyeR3CyV9pO2ZJWpj349/rRqDwaRvmmu7WGTt7A0F9BROGBMe8Rcdw
 o1a53s84IKrIGldiRDfanEn77/jRb/ma/rXft2loOEN/k0E5g74ML5aHI5XkaWbJWuWBt1N8V
 wqZASNChyOEkM/ctc
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:47:49
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
 Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/KMiC0ve/Bof+EUZOI9V7TMO
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
index 64d2453450..160776d39e 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1283,15 +1283,6 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
                            s->vnet_hdr);
     }

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

@@ -1386,19 +1387,6 @@ static void colo_compare_finalize(Object *obj)
     CompareState *s =3D COLO_COMPARE(obj);
     CompareState *tmp =3D NULL;

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
--
2.20.1

--Sig_/KMiC0ve/Bof+EUZOI9V7TMO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7HdZYACgkQNasLKJxd
slgccg//dXB2hOZLCTnAAEAYdNfpndPmqcL73Wf0gOoBSTkAqwgEEcaGwAFyo+0X
RdihcryRS8Ratktx+egNp0exHCPR6ENAt9Bc7omHWCrRjGi+9UU0+29YR+AHE6qq
rlc4HeP0uBbky1LN9Gk7ENVQXfMorgiTTpBMFxAt9bJPAH7P534zQn/HNjw+R64X
5VFumXlD6J/UMA9QiYYPcanlTiE29vPuG8vkuvBOD7SuPaRHZsf8mt6YqhDyXt3m
4U02i8Utj6s3v+GuuZzLpWV+aMCKwj3dWlfjlBRu4TvLWxdzdGQFr7Tj+0sYTiGk
lpAEmdeeVUvFhDlbzGaVlAwFl+ZWb2va+jJZMDOx2q2VGVUm1THEcZlRRSuYdl/7
78h5GYJznPM/SQYR+elKNmZhVqYOl//dmAe1I38iCkZZTfz4ooAkVudl+CZn8Dsb
mSfOjI5enKdRiAQ2C8B8DMwsVinVJMlQIH1g1Xl2J2zVTS0OUD5L1c0afZQSD3AT
QdoJbHOTC2d6UOQErZo0jYMuO9MhBI34v8GZsEI/CBr7XNvvurVgRrssa5EWlDp1
N+zsqTqZWyzZhtb7wC/lVncXYvY+4fqjJGefbBbo2pZ6k7OyEWmcqJBUIkPGhl61
uWazpnYr1tGmlSZnF6RKDtquNVPoxbJgIiPEw1FbYHp37ofaiBc=
=DA1Q
-----END PGP SIGNATURE-----

--Sig_/KMiC0ve/Bof+EUZOI9V7TMO--

