Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C89C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F97720700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="K7gTE+N0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F97720700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSpEl-00025w-EZ
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 17:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSogY-0004OC-78
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSogI-0006Tj-Rb
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:34 -0400
Received: from mout.web.de ([212.227.17.11]:49365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSogI-0006R1-9k
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587935947;
 bh=OKrJYPQYFYSKUAa7NoCdFf6KnsK6PjCuDGPnWMhKDbI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=K7gTE+N0eYE/937499J09aZUvMxMfdMVgR7+HGSHNAY7xYR8LGXJ2tuxF5y1f0IfI
 ao5BF4SVDwje+tccA+uCAXWHkRR7vipnFIMAbBbm0xVbriePPzNQzY/ZE1nkCdlPWD
 VYrf50KQyzFUjPyoYL7Xh4Q1b4cbwuIBLTJg7aNs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.69]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWjAd-1jiMOu151n-00Xp7P; Sun, 26
 Apr 2020 23:19:07 +0200
Date: Sun, 26 Apr 2020 23:19:06 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 6/6] net/colo-compare.c: Correct ordering in complete and
 finalize
Message-ID: <c68c18861cc47a0e600f01aa2cfef8a27a5bbe8d.1587935686.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587935686.git.lukasstraub2@web.de>
References: <cover.1587935686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t=mktcj3KfGac3S5g_ptJtj";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:e97cc28SczBHZR8grl3MOyvXZzNnq2oWlTt0IbCvnTy8wj5F3ib
 p/83W/QzgWr14jkbMe42CIo4uidzQp7e6jvtHUYz0Xwo28+mV5T8CYcKTLRXzNqbEwwCqWf
 LTPxvRbvJFNm8Zk+jX/7r9KjfLzmS1ptF84gw6YahggojXoVWXF57gjTRMYpJZEhdIQtOjP
 7G8YEDAZRSXuKdrUPOoKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ynnV0hqCJ+s=:EOtlW70vzoGDSPOMfPABUg
 KZLNwkx1M6T1FA8kQlV7asRqZ5hI4D55D4pcgHpphw4JbHC13xrHbjIm64PUM4EQwYJTl5f0T
 8c0uk44yuuzkTwABstTc54IeS3IO/eL1WDuqYNLI/Qt2MA8Q4+tn4d2DGx6ZMOxgBU3JaaRac
 jYe0p7Nzr+0iYLNSZ4DUMipQoPNTT4oM/ZgHijaKCjOUUvbvG083aDQSmd+k9yki1/BbsYhhw
 c57q7MDn4+vNJP3p6dGOKNA2x6lClMdZtecK5Wpqt34gUSyX5txBAspgkwJt3dzNbLcTpLb4K
 etsKpg7FxI5hT9r6MbW+DFaojLr06fbCxYEnY86ZOORJhddDBB14vj/DqPE9pQ50jqdNEwUeX
 sqBd8uqBO+fJbdCRNxJMEoEiJtzoxqPos0M9OcvP8hVfqhAFUJGa0kPwFMGe84rT61kSI4Jdu
 iyLcxDV9dBq0sDjBx84axqROCTXpxHCVl82jmUpHmhU4C6yxPu3Xt3lQZIjYH2z1aMsBwl+Qw
 oQoj4ozmPdoTyEc875uB1vqBMdt9AZoPhGPKX+HJZh6Qy4kvSIh4hsLc8XdhLITa2UlaAA2aa
 oRKzIJZAiM0sAfgsEwWZYXyDXA2DNEAsLOhIOp8albdcoAAx1L5PL5+juRMjFn9GscvnPJjil
 bVGn5UiSSjtguVdYf7BxalG2huv3J2d1AITyfU5akiGgaCrDRFY/r1azf8eTtzQNKq0A/TF+Q
 uAaCSFdFVrtbWuBoOTpglyYdyUHxshuz2Gp749+Ujcrm6A/YlIQXCjDuVvVWsnFI17Hg+/Xnb
 mt3aq7zE2oed8LsEEYgskr45NXDXWoWT13u9KvCdiH/ZY8zEUBRQ9rqSlgvdiTA5QerXeuhZx
 A6HHkyydstK+ByhZJwBfAb/iEYHHY7FI7r9NoWpKIAFWOLQkTJu9GZqEqBm8UihaNRTT6iSEj
 lBQMrVEPA7st/fWCpuCYz/RvrdDd+RC7dvSTbtif1c7wKcLZRU27ZtN5ATKPbaCdlb6zYyFVP
 A0/nzEVxo87ToeppxgdpNE0fJ8Q4mLDUll696HDL0bEF12MjRH4Aup6zw00VdVa5o1Jw6GH5Q
 fZdDqdRq6rNka1kVsbNmCg2Lkm65TGS0MoCJbTSp6Yab3F23IhLSGHF86lrCSNl8auGxMSqkf
 aIvStvoqQmcLFVL756eIF8P0DbjUE5aqcZUDuNmBrIz72c0TrBRgj7TpKRtU292e3qCYMZ7GD
 V+0ZC6TJBkV+L8zNX
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 17:18:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
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

--Sig_/t=mktcj3KfGac3S5g_ptJtj
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
index f3074ee3ff..e86dd72f02 100644
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

--Sig_/t=mktcj3KfGac3S5g_ptJtj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l+soACgkQNasLKJxd
sliopw//ZnQwYYWfWHW6USHk55rFBVO/9ooPl6G8pL4rtUt9opeUeo4SPT8lodT2
ezBSFwLHYGvybZq6oTQ3q2PnpKu2UsJfTdzyG5dA2e78S48zplGcvgfMGVfNGs4f
S6Xc0CWfwrM+NY4GFn0T+ztATY/jSPC8gjpmS1kc7aEqK3C6hggCzebgMjQQShcI
VhhB/v4zm5kog9BYMu5yroB7jiqmtv6+cShrFbEDaitGDtckvf/SSWf5v+H4ByEF
fGiwZePM/ZtpUUJ0hpbyKZA2PEJzq4YHrq10odBI9kXSQjZImfnBVYWywteZKmSF
s95sDKxtj92XqJAPSI5JUMT/7vms3KFqI+5VjpxhfMmeXuYzmpgmAWJ9HV8O52GP
f7Ps2Jz7zQeHqsALJnBxnIE9V8EXE/XIz3npJ0on09BBKOTmGkCuYwVt8sNbsDNx
b6PIao2BRyc/edvv+P1C2fbn4kc9lBjLWUJJuEpaPaZXPow/1P8sjwK39vTBIejl
cqqVXfgvs43aSV4Hs2wZcr5V2c7SIp7xteSb3MsdK+xyfh2oWI+Te7r75iHsyc/6
JBcxr/PGnQaZrKahiQovrHjqoxMj/8FtgoRD2OeDoKP5wmnQMsuwfu3/BHMwt9lc
lL0357lDi6t3tO2I0BtkzIfWZMsZ8MqrOxfF8phy+SHCPrPPVZQ=
=EryD
-----END PGP SIGNATURE-----

--Sig_/t=mktcj3KfGac3S5g_ptJtj--

