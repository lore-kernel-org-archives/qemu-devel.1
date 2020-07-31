Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040A1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAB420829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="i3GwPA/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAB420829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RVp-0007yp-80
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJZ-0007hp-Nv; Fri, 31 Jul 2020 05:26:58 -0400
Received: from mout.web.de ([212.227.15.4]:48459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJX-0003H8-FI; Fri, 31 Jul 2020 05:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187610;
 bh=7v/Mv0F5waUUMT/mHpp598uQEuJxOezfSzawUfXZvyU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=i3GwPA/lZ+CV2VmYt/ISKai+dXHY+N3dmPBj8e6yEDQShWMUoo67bK14XSVERVAjn
 d2mL+cDMFWhcSaY2gN0VIGoBr6wqFQiGjjCKXyOrT1QcXDY6XiTNjyq07f4O2YhRKL
 hzSZ3AEtdsp89zPUo7gfwc/Le7ouj0hv/dGf+0KU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91LW-1k6PO81z4o-006AMq; Fri, 31
 Jul 2020 11:26:50 +0200
Date: Fri, 31 Jul 2020 11:26:49 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 5/9] io/channel-tls.c: make qio_channel_tls_shutdown
 thread-safe
Message-ID: <cff197852ccdbb622cf737a75526e0334b82b7d3.1596184200.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596184200.git.lukasstraub2@web.de>
References: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5uASeu4UXfhYdWy0CsPfZ1N";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:3oBWF9KpN6NLJMkfUcQJJaqq1/J8stWp7K7+rPwYLgnffevZjCi
 EM05jsyLChGltRbG9HdPzthPtNxXAj/i/Iyup+TgUVyqJKG4Z5IXLtDHI1QIaeSQtMV//fO
 gJP9eve9xgKQ0lExQomQAB5WV3RHA2Nx4hfTnCfSqgjQ1aUUU41nndobvmKfyP7q/GLk94L
 ZpGysaK5pJuDmlWu/Ok5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pk9OdU03prE=:ZCQwh0CnBWXyZ75pCWVyE0
 5pgEqVJumIGTIScoTDKenXVpKUAM0Wjm928gJYeayHqgKfutqtAg94jdH17VBSvKc216WKsEN
 J7fEHpR1gld4ll/yxuAH3z4Sz6ZKnAVObfl27NEExtZQ4CRX4guDjH6rzcxzqm7jWz9O5gcHT
 yZkWkMevOCa6W0DUdUCEQUMwTKR6S4ItZ9KQkQvBWjhQ/q6WLQ+UKh7PLclkQS5kOniVnScqY
 Tehr8dOD+K/EcVy2eruz45nUqNpM4epgl/9st39I+EbUk50BMSUr1s0eQ80H34OeLNZh2G8Va
 OB9XBpzUtVWUM7+CbJEMEze5NrACBF66kcD04Wg25r2bg/OVnyT1fQbJM8cNJ1wIyATULAl2h
 u3ruKzFuL7KOc1re9qwXUWVBD7TBns774ulrF3sjd2XKYL2MaNxaR1H6H5OufAnv0I3QiTTS9
 ZAUhrg5RElvH890KdfdZZwzXm8ECQaN6nzvSKnD5DvAMO+hAS06xp24MgW0+sUjJlJ5ditOpy
 RT1WtGMlDcEjLd4VnNC+DIF4PcCnpKRZ1cULIP3bzkhD1WkSnssoBSWEo8BuD4WMJlzc0XuZH
 +xRGYAau9wNZ/z0cN//KGSnJpQul6RUUoO2PTDsYGMU4i5Ai6/7QWGIc/4w0SueyBczKFoWtC
 Arzm5PjsGuylwxXKbq8Y7C4Zbcb4PgRJoXwhwH4LuiqA3dyiacZAHTVImcbBSVDQTY4gfLNNj
 HUtUgtY+1mB5kx3uqt11KtjkQttGiHn6+uuSOCS+erF4BqsZI8a1dZnswr8AVqWpKJfOPn160
 jXU0fOBPWrpt57/EdGuw1/pmYge+7BA3dX3wDYioE6/LVT5gD6JB8AlqSD3vxvPFTkVUHk5u9
 i4mWIZRFka/jpWS4gw8+f2G4sJOG+rU0Tb78cSO9WT+Zceby4x00zCAD54/tb0ds9wkqQ8fGs
 aplmjnpwrdEQgEaCkDo7r9O2M3LJJoiEQDcvyW1FUBCrKnHr1yq/SLuko6bpFIu1/ZAswk9CV
 CbOYlXUp61stJEqVvSbCCyGfI9Esdgmr7zPJ7j0BIme6m2fD43wdJDgJep6CRlFVlxRF80/U7
 JdC98MfAssvUUMBUsKbCwjzhIPJTGcmXfRL7sHSKILjUZyCn4siEBBuS4y9xVAXBXnoftoyOv
 2nckBRxDTTmei7EZhwL9AdCUotYmWY+4KvgBcY8jwcsQf6pnUhnf7Z/ofCpThPqx4xztCYhOc
 dGjLwujU6a8Z/8MU+KP/3VhA0enGOLWDA9cX1vw==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:26:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/5uASeu4UXfhYdWy0CsPfZ1N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Make qio_channel_tls_shutdown thread-safe by using atomics when
accessing tioc->shutdown.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 io/channel-tls.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7ec8ceff2f..b350c84640 100644
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
+                       (atomic_load_acquire(&tioc->shutdown) &
+                        QIO_CHANNEL_SHUTDOWN_READ)) {
                 return 0;
             }

@@ -361,7 +363,7 @@ static int qio_channel_tls_shutdown(QIOChannel *ioc,
 {
     QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);

-    tioc->shutdown |=3D how;
+    atomic_or(&tioc->shutdown, how);

     return qio_channel_shutdown(tioc->master, how, errp);
 }
--
2.20.1


--Sig_/5uASeu4UXfhYdWy0CsPfZ1N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j49kACgkQNasLKJxd
sljQrQ/7BCOfBsdV8qc0xh+ReXvUokuZ2o/vwQb7wifSfRpVD1hBWEHC42iSvM7Y
6aSuTbf77G7FntPvMGYkd0jyBzxc5b4PHi5S9aThqDE5y1DM75pqaQnjwU7QEB9x
twprJ8Z0ZfopB0aFaPe8V0T3J+q6pKMKZ0aIN9cgjtS1a/jX3OGY8hVHjJHbbuMZ
aZl0N/B07dH1o0lDpciHjeBY7E1MoFfk0EzcHS372qyfLGffl+S0CNmQFBImlXLr
enLhVTUFvd+DWp85M/VrHCZcmsH71RVlADw1OvxFm8xxrfdaJKb3U9ZbuG/zZa3C
dQJVA+dzj+GtbfItrrm2egGBxJlX/MRWhQb2RwVgLdpVO7jfGAeJMsXFk3T9B9us
JGYYRFWIfe7IREyClgM3WfA3AIuzgDBj2+U/89GlV9NUKkm7nOHeEW6O0EqdQbId
JQxTPu8gshkzPZehaFSBfEb0HYDW9JNeKeiVQMh2r77WKrZIx35fbvC6DTtyVA2w
U9GXKLBpIslm+fZNJr1vYGLGHSX+plHBUmTL+EbG76mLuhv27T3XKfvCinJ2wMZL
NTdx+h9w36Xb5+R2daXqgNwj+fjJHhMsG6f5dSzjvvHkHu3uXvn1kK8CgH/nPolO
bsolPrSLi0GuaUIBaHG3ORr4waajkymG2+Qs7mImAUcR/2/bjN8=
=8Wcs
-----END PGP SIGNATURE-----

--Sig_/5uASeu4UXfhYdWy0CsPfZ1N--

