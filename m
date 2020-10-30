Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44363C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A4A20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="itVtAkjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A4A20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXWA-0000ID-5P
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXT9-0004ZR-7T; Fri, 30 Oct 2020 12:41:39 -0400
Received: from mout.web.de ([212.227.15.4]:47101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXT4-00030J-KZ; Fri, 30 Oct 2020 12:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604076086;
 bh=WbYUVUmQ4bxoNlZ39tsJOBftsWsUATGdtkCVQCitbF0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=itVtAkjTg5OTk7wmsjzTCqWyPx+iRN0fL6hhDD2LdLKlWflG+5Jq1sS001Yf3ReSB
 QcwIQg4hf0aEvqYZgFVnquVZnfjLSdIGag6JYvTlRI25ekwJkusogaUUsspXwkhYLV
 1zreDZgOZs0Em91zpu7U128/f1JzmfZJ3sXPlMKw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MvKbd-1kHHlP1inx-00r5Sg; Fri, 30
 Oct 2020 17:41:26 +0100
Date: Fri, 30 Oct 2020 17:41:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v10 5/8] io/channel-tls.c: make qio_channel_tls_shutdown
 thread-safe
Message-ID: <20201030174124.38566940@luklap>
In-Reply-To: <cover.1604075469.git.lukasstraub2@web.de>
References: <cover.1604075469.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6Ejnx2MDRqNM7dmKAl5grHC";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:1w3ebkSUG3wFeqbjCnutZogDcsFUtR9nrIKFeont3zStixaDAZR
 8BdiRKyDGpE4a07zDyccXE37zcWI2qitAoYVCvB9wCrqjJFZqNZgo1xpEb87Tzv0KNt95WN
 NdIJ3zui5J0M1yHL2AZOtCzVa1TGgxwcPKqw9znpHxB8yQheXPVPk57ZdNg54k/9DGi5Kfv
 Fsd/iHAb6L5iJem5SjUzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:obYvn5c3dGE=:3hiXfvKvXDM3YQBxMgSmJu
 iaPddKlueTmzMkE3LRguteZL4mGmxzhJMm506ZEXayOEvKyxRb4iNUPkSeiNaLlXaSLgeGDIg
 oEkt2tckId/UW60t5YNt2lcNtS7eUAe1CjtYU7kO++d2tyE4y/5likLX8T85IpeI+iS/yIri5
 61tngiHhaTLRSwUa9YVVVXQfs7LjgEnggRXXYcfdWKXX57/0F7y2LFeM5wb23gKo2I4QN4x86
 HzpQpMUAUngzWEFPwTFted7/KKY5skW/fTPn8Voh27pX6nUrn6WFRaZqxbYKi3qM2ttoanyh8
 WwvBS3IlV30E2CanHoAmcJIqWqa/gTMOOhZT278FmsrFyLNeLO9kuBgA1TZGbpx1Fq36M7G5i
 lPX7zLm7Lq4dCDuncn4ZZfFMi9tvWQsBeE/7M1DEPHZbpkQLRqSPwUUH+zKPLt0VMf2uKNZJ1
 goYODcZE2ASwTWIAgKPeiEPn5oprZlExgMvYpscDu6sAjocr0oUr57LEzqXXbzihSwQSiO/QJ
 PMVV63/oxXDRWc7GA0LgGXe3eH79t0Ajggjey3LDfYf0YYltszrEK295PFpNsgRwvIC5XK4+N
 YcXydmQ80IIZqMISQDcXnJyvqwTQghsT+jfAWgejfLo71a2jXzUKLjj+t1H2Ek6v+olGwi4wO
 oIOAseKvaxR0SuhHLEKytRqfpUgVVc/j/iCLsIg8+1Paw2iY9kgmC4N6W894Nj44ocLQC6qQo
 2ARCExboy4fJULMylhi/7rHm03S9N5plTLyANBMaU9TCyVRswIv6NpWf4OUojHjBZNMcke1xV
 /MbZpgVA7hc2DYysqU0f9Mf4Pm6YUMQC+P7DmyLm1A+PSilfSk0kroup6jJnKMMrzdAqg7ESI
 QyGGuh2gH2KMpQh+XQ1w==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 12:41:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/6Ejnx2MDRqNM7dmKAl5grHC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Make qio_channel_tls_shutdown thread-safe by using atomics when
accessing tioc->shutdown.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 io/channel-tls.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7ec8ceff2f..10d0bf59aa 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "io/channel-tls.h"
 #include "trace.h"
+#include "qemu/atomic.h"


 static ssize_t qio_channel_tls_write_handler(const char *buf,
@@ -277,7 +278,8 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
                     return QIO_CHANNEL_ERR_BLOCK;
                 }
             } else if (errno =3D=3D ECONNABORTED &&
-                       (tioc->shutdown & QIO_CHANNEL_SHUTDOWN_READ)) {
+                       (qatomic_load_acquire(&tioc->shutdown) &
+                        QIO_CHANNEL_SHUTDOWN_READ)) {
                 return 0;
             }

@@ -361,7 +363,7 @@ static int qio_channel_tls_shutdown(QIOChannel *ioc,
 {
     QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);

-    tioc->shutdown |=3D how;
+    qatomic_or(&tioc->shutdown, how);

     return qio_channel_shutdown(tioc->master, how, errp);
 }
--
2.20.1


--Sig_/6Ejnx2MDRqNM7dmKAl5grHC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+cQjQACgkQNasLKJxd
slg4DQ//cKYEL4ks23CBU9/iS3Xoujizgccb4un3W5vjfM/D7/IXmvLnCBJofEYy
fQtIUyxz14g4C4DViSQJsN+lb9KZeVjYpKT7AAzsbc0qmzVJZJpW2UrWfsNuPQwv
f6q82yTBWV+YGBcPBsQNevQLEu236lZ/JCvrHXBND7NxmdNsj7VJZOKVE/IVodLv
XBs35kWi+Y4w1s2JQIYrY0jMzUMyofGu+teT1I2+IX3oLrkOqcHkwm2me4pSInGe
+uppjFEOs49LtmtzWL2DsInI5IFLXtQ19surjWiJ5WtX1D+0d7VJDsOpp0rMs85i
pNc34RuI8ZgrYr7P2qToj0HSDxLZtou9++1MLtv90F2vUxx9P6+KEF4DaXt2Uw6d
w6p2i3VCp7GCdQ7iM5EmhuGL8Wn9I/SF1tQKmFmOy3fOofi1vwiMaN8Ij2Zr3sEk
BeTSAY3KjwbAAXNGjb/JcCHAEIABT+SUDcZA/z+pOT7RdAm3BB0ofvg/2wKObW/X
n2/SCs240q3hSgtzGf5izowQ3LRdCKsh0dEbzJgWkcP895oROGL+CqHNHlcF6GCQ
EcIm2U65PXe5o0EIlaSDPQh2vF3Oc3jKSOHRVsCj2GvVB9Pw1CmSVXdNfvY+RYu+
GWCL7h84TDrl/7lJhNUA7hKuepDJgiRmAZeiu44TDgbapUTL8UA=
=Jpqg
-----END PGP SIGNATURE-----

--Sig_/6Ejnx2MDRqNM7dmKAl5grHC--

