Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F817C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A022206BF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gYBWYSW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A022206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSooZ-0007ME-A6
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 17:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSog6-0004Dv-EN
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSofy-0005Lo-JR
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:06 -0400
Received: from mout.web.de ([212.227.15.4]:40645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSofy-0005JI-0f
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587935925;
 bh=KlCniyLWMcP5meR1EMfh+9J/dqnOAwFcyGmWU0KJCdg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=gYBWYSW4FDWXgautvwygWZODJtfrNr0R0Vx6CaKYyt7jdBckgm6yYjwuR5PPRG27O
 qVThMIi3HQDGf5ukXHqtmRbedo2yBPVNhq5nmBuRKzTQ/CdEKNltoO91ix28MYCx1R
 EpsIc6rpWutyYobkFedpl1v7wzEyKPnnR2te2lpg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.69]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTPjb-1jaguA08sp-00SOp0; Sun, 26
 Apr 2020 23:18:45 +0200
Date: Sun, 26 Apr 2020 23:18:43 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 1/6] net/colo-compare.c: Create event_bh with the right
 AioContext
Message-ID: <dc7c5716e1e3367dc96f8496c52490ce7578a678.1587935686.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587935686.git.lukasstraub2@web.de>
References: <cover.1587935686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6Yb3bbn4LWPpQk2bs5bYoiY";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Y+e1XuD7bAxwd1lKicD6/cC+P9/ujCZvW4cX1iaIzwlQeyBnK6W
 IKBMQxWOtnu8ulz0AQDdf584Rt+MF2Stj+53kkw/3W52vo4pnyq2hWvswPNL9SZE+A8skyS
 ohOV47+rjqHoZTSA1HS89//qqoHzWT0CwUComk5GJ3VtZVRLQgFUdaVmLAS0URtriydswMz
 MvVYXy8Bnp7+DW4308gdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QSlz2Tr0d38=:Qdg/N1F122ByJ4TikGf1d6
 2wrnaqWPxWYZ9B8QUtTC9oJZtd/jrFcQvZMShc/mCmuBdHI1VmxJ4UVL32tPG6PZ8cTmjhr8Y
 pnqrl3z3PhSYPZBVYuxsij8nupdhm1PxB0RxXJSdxnAKL9QhulmCwhwyKGHQXjbjcvJq7R+xj
 nErmZ/AyWvFvmfuP/eSJQlnqxVFsNHRbgpHzCVwQ5GsqSNEigxhazbHtEYBNKjVGbPO+MwU/Z
 uf9nEL3FGgExyJ8XkwHD+waWgyyKPbrfAnI8LUQomCQ2VJ1zBs013cjc4MbR1OGVS1M/ggaeB
 0TkU/an/7MrwefSjmQHWTbdXH64fEdfZqcjcNcrQH4hyD/8Jr7kWzZTIrMQR/aI6UVWTEfNEo
 yMNNCXeSsSnIMdbqI0Gmd7loWJxglzCHdiyjDipzW31jA0XJNfMVA5kcaBitmA3hMQGzk0llo
 AkRCvvHy1mp472id16cX0VvMYhK818U1UF5JwcN426aqYmFnISDZpK1wZHUSlYfPpREdokWUY
 5vULvm2HheNDYWFAN+/qVXDMoZKyngv6CysYvoUnrfUB2Dyc1Mt4lYm7VdKJKc/0Bq25oqTMW
 IupgyUnnMHFkTUZi1Chs7YjWiCHqw4VVc/ejUvSrApZLfp7+WHidwn+s7E9fmJmCrEUQuv+I7
 0ffgtOyHOgDiVOykQffeGFi/oeAJUQHBTHgK7uo/8SG7pdYRwPiAxQz3qdQXNasPNbP0Bod5g
 OWmo/QSe8GkV447anime1ltUOxcKlAK0kqIGdI+0SHp9FZgtLt4m+YesUQQ7KaEu1s8Oc7KjR
 kxYZe42hgIxUwgOOMu1naPUBZVukpIQ71drnbhbFYJBKZtDS/U+0cfwkeE+5iv8F52ifYw8RE
 Fsub1HCkhNUu6iuG9Tk0fq133i3tcc4pq8tCxvrLIxDGN68M7BMcYdugF5QZwoYe1dIWTqt2B
 kvZ+tr0DMDN8OB8V3zNXN5Fxzz5TyX/QgTown4A2ZMVfuRXchupsiIpNIBXN+3XvvzgfVyLXg
 RwDxnUQUIUv6zKumuN+tLPP5WP1MFqCo+WdWNZOqcNtL2wjGZzqRDmhmZl5tpHyrpv6HvYAc2
 wfln/IvGhQdujWuiF3QIKFcBr7NOt9GRL3XkYmO5chEnn3DP36m5vBgDJbPhpIlJaz4jBe9r+
 iAc37i83AFmLBODgflbzUnKu/4qj99EhPoM+BVGyBT9bR+vE1vWDsBUH0AFA1A18K2CmCYEmz
 08wmAp72Es6tMlGbz
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 15:25:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
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

--Sig_/6Yb3bbn4LWPpQk2bs5bYoiY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

qemu_bh_new will set the bh to be executed in the main
loop. This causes crashes as colo_compare_handle_event assumes
that it has exclusive access the queues, which are also
concurrently accessed in the iothread.

Create the bh with the AioContext of the iothread to fulfill
these assumptions and fix the crashes. This is safe, because
the bh already takes the appropriate locks.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Derek Su <dereksu@qnap.com>
Tested-by: Derek Su <dereksu@qnap.com>
---
 net/colo-compare.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 10c0239f9d..1de4220fe2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -890,6 +890,7 @@ static void colo_compare_handle_event(void *opaque)
=20
 static void colo_compare_iothread(CompareState *s)
 {
+    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
     object_ref(OBJECT(s->iothread));
     s->worker_context =3D iothread_get_g_main_context(s->iothread);
=20
@@ -906,7 +907,7 @@ static void colo_compare_iothread(CompareState *s)
     }
=20
     colo_compare_timer_init(s);
-    s->event_bh =3D qemu_bh_new(colo_compare_handle_event, s);
+    s->event_bh =3D aio_bh_new(ctx, colo_compare_handle_event, s);
 }
=20
 static char *compare_get_pri_indev(Object *obj, Error **errp)
--=20
2.20.1


--Sig_/6Yb3bbn4LWPpQk2bs5bYoiY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l+rMACgkQNasLKJxd
sliATQ//Qi/V6wtWk/Lva94UlZTax5WxkKP6uaP0QoHMXBMZ7oTXwt84BHsy+Srh
5oNS6G8m9MX1V+9kpZ+mZcdepjcDvwP0my6Lr2vbZzBSA7MXGRA5xmg3kxcCDn96
zp1EysuuLNZjHRBi2cceRsZ0FuVqGrYQJsEFzOvkRzfSr0i5D1WiVB0EEwiuNdHK
b+5tk2O2EReBUAAbShAHut5/mevrGMBHi+rMdZyYulnHwYN3exKLnyZ1JTpDUZIs
6GRXYdC0JH0nGTRRhuUnVxLFrdZu2RTcS7WPSk+eI9gqFr5o1rTgiWLtCJ/HB/HK
jfLCrpoVT3kfshI7oYtvCMPPbvd1FETXpDh4ucy4yjeU3PzVjevqQuQ+YyOIFqh5
qsex+3JZZpc7AdRSt9SKonSYgTQulWgonI2RvSmv4YIiN1FYcSW//FdN3UNoEXs3
078KbTQg0/j4d7/oz4WRhktkNrnlyBmM2WunBBUFRMV8GfizO6NJvAShILd4qT49
W3Vqfvo9hpndYnXlgl5xSGRpHQLAxQNJjuTKPnrmsRUC4iphczCIj/dKI4w4D5pg
VtG9hhrj4yd6l5Tx2CHetp0xO972PUGi+OsVHhrHgwFUlhH135R69CDVyz0SFsqu
Ojqn+29NXM2DejOMaJAfenlErlGVfYlHxhLYnTeiPt83bO4dwWQ=
=ru6O
-----END PGP SIGNATURE-----

--Sig_/6Yb3bbn4LWPpQk2bs5bYoiY--

