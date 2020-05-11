Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFFAC54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92BB20736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HhJZf8wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92BB20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6a4-0000TX-BE
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Ky-00058W-NS
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:11:08 -0400
Received: from mout.web.de ([212.227.15.14]:56081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Kx-0005lb-T8
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195460;
 bh=tUg9o884OMIklfCikslkyZW37XNcYKoP71AiwmXwais=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=HhJZf8whG4m37KkvMIcoWqfkCyE/Mg7MyLwP2gg7lpwBnG7fzd8pCniv2bw+9BbHM
 Z63KpGKlgELSbElYbVjWqA2LB/5nOy2ikXUr/wf3l+jyCw/X+WZ65sTpqe6gal2THP
 dYQaf2SHD8GKkHOVrQvslKU6Vl+3QPaqnxnz8diA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KNZ-1jXpLu3hQX-000MFN; Mon, 11
 May 2020 13:10:59 +0200
Date: Mon, 11 May 2020 13:10:58 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 5/6] migration/qemu-file.c: Don't ratelimit a shutdown fd
Message-ID: <f3ea4250e6982598ffffc73924a6917dbc823c87.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193382.git.lukasstraub2@web.de>
References: <cover.1589193382.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/flNjsFKhuuZ.XOnZadI_aPr";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:wRaJQIVGOrJKahlvJBpGxF5IfAavcvQhBJS93SOFVHN+nTFMCV1
 bi/9HMv+nsF9Z2f3o9Muz+4NaL7ZCnOZY9nbWsKvgbFhlhVqgMeXfZI3gtKol51E4EYIAMz
 Mb9KU0wPrYMEFcTeKllvK4gJR09kOJKq/RhKCLg12fn+AaKEWjcm3MjhOFBxXNrr8YYuqhp
 TiKfbAeByRad7kv94SDiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2atHHipKfU=:1U5dNSkQ3wUvDdYHthQHdO
 Al/GrL7FYMkWYRJZRk9+vs+NCTY7AqHGkvNTl4ND7C3RDFWY4I3ykfBIo6yrbdVr3LBjObRlC
 bzyqSdQHYa4hWl+EAjMNO7pdtz/WumSWYFqTLRneX/PYjYE1tzo3FcrzkZQZfXJ8bhFmGLRqY
 Kl/y6W10hDlR4gIXOtuljunWI63qhFgCwkso3UhAx7DW58YmAGr3DQ9Py/uyO+Bn7T6Bn895r
 NXJ0Q13+UVYsYQ2MYQRDZhSRVadK3PWLPE1D7ZDxL8+y/bFu2D/ntYSyNR772aLlUJOuuFZhJ
 WhGyiCkC2xXbCyxM7dNX5kHnOxxSHOX7fDSRdJ0dWbKxkSj8PVD2MOBFRV0VaKtUX+GAkOqW8
 7fd89LKsUgDyax1J8vu1mSVcK9HlrQWPilwMLmHFIEn3qlUN5T04f1kEqSTBFaNpYRSuITeB7
 AUMF3qMDwzZnEXxn8bf/yJx2wwcA1jYkmsg9Rbg3GinT42TCyNIAw2XJPnqhQ73Bt60u4GFjy
 p9KaOug47O4LIlGjAYRQvrwVeGMPN46jC6JH7PIHj8U+6EpjyNr/UqWs4V+HXVuZxrbO6MIMN
 P2KchcoM5yqxntNKZIsLO4gUHF24MCehH1Bj1YVYgkXBEYVSl21gf/1JSLNAT4OgjiZclBJtw
 GbpPZvheF9bvEjFuM/L2y5eXfVhECHtlFluC6nGl73e/UBBT5FfopsDIsIwrZtv9Ow6qxGN4u
 Hyh3VBZivjmPh8FjcP7Xn92OBirJPYg8hUQTHJYzw2CIsJzAHLEjntjP41qAuwKVuxCOQKeZs
 +kCvdXqJRWX+ET/UsFXejRlQifWLk7QiR9CzzXifnSHYFXxroO6Ax0GkH3fE/nSYfUGyd2nAK
 gPjfwV6zV6+68KPaFWIvQyw+Endutr4TMf2gSN4ke+5zaqbXtJAIYQnuAHCM2xjDBBxigv43Q
 rEaKAK18hN1MjjM1WzjFD3hjc4vIBeszSHa0Gnsl83HLEt2Lv0hyxNzfSqIZjqXC+wlwTBRGZ
 FbYccZB4UsJ61s8wyiUPzLzrJGnyrDJ5/ED+ZEzsg1luPxLVQia6wHEDZNpvShicDZhVVX4am
 xsanau6M4irFkoW/c6SBbLH06rtWE1NVkcPWFs5cfhOJoMZEfMk7BtZvzhVRrGq7uzy5z7QQI
 hEZoflI3OZCOvA6oEjpUvlt22DGKmwkHYc1CvkB4zbH1ghZumeJBomhERmlUH6NoL194HijCT
 rfzs4vgFx+HbE2rnF
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/flNjsFKhuuZ.XOnZadI_aPr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This causes the migration thread to hang if we failover during
checkpoint. A shutdown fd won't cause network traffic anyway.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/qemu-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 1c3a358a14..0748b5810f 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -660,7 +660,7 @@ int64_t qemu_ftell(QEMUFile *f)
 int qemu_file_rate_limit(QEMUFile *f)
 {
     if (f->shutdown) {
-        return 1;
+        return 0;
     }
     if (qemu_file_get_error(f)) {
         return 1;
--=20
2.20.1


--Sig_/flNjsFKhuuZ.XOnZadI_aPr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65MsIACgkQNasLKJxd
sljmvBAAooZW0qTfOd1ma3V2WOqUPqrMep0iTH06U7J1b2Nu75H1BiFFZL1Zsxok
aYILa5gqcTfVscdlNKJ7bGGv+sM+EcDbPwu8Q0xaYGdWcTvAF6MvrIwd5tSpqtQB
Uvpd02YcIWw9kROzQfw2Thi2GVh2k0PLuo6vot9eTvOTNHGs2xpzMEcKhPKvIHz5
VHf5eticieQAvC5fu+UbLe9Asmq8sgMCqbXFH1rruEbyghi5cWBzCqC/gC+pHkUZ
BbAuJxQvXnp8LhXxBtZxbHzt4q9b1rnsVLetairfGQk47YY5Qb75V/2cPG6l/0Ry
GCa/pUBqsmHQjjjsKomaHBBGASgFZL8LQqbNjDcFC7ScK97ifmaONl7GafvDEZHX
K6vm/spoipQyXzcMmROLA56Z0x93gqWXCr4wlrUuAMYJe6cHjkZCO+naMEUlAtCB
DQ6LCSSgggW5sZadoVZE7lBzZvE8fTa1pllgmYEdLz9I/s1KX1ehRIauhOhuUD6k
rOuvbq+jXyzJWFkjdndNov/tmOFMWjVjedbQXgqMQwSzlv8mUoXveA9EDU8oKQDC
uM97KHsbVdCTOv03mTCH0MMgV96Cc7DaX0r1baVz3W+i9ATqyUJdS4LhR6niasER
gNYvSrc+AJTP6jU9qrHN6igM7m0haDxcazvvtVa28n0k1RWoCcU=
=rd3m
-----END PGP SIGNATURE-----

--Sig_/flNjsFKhuuZ.XOnZadI_aPr--

