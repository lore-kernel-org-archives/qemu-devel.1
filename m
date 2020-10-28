Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B34C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09B724810
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IenQ4dtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09B724810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqZV-0007oA-K9
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqSB-0000Nl-2X; Wed, 28 Oct 2020 14:45:48 -0400
Received: from mout.web.de ([212.227.15.3]:52951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqS9-0003J5-3e; Wed, 28 Oct 2020 14:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603910738;
 bh=qNFWTek6fmYyiC+xP39ERwe9G5RcmmLQxbh3EAxvyro=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=IenQ4dtDSWZWnD8zG9PNFzHHvyl9ivENGW/rIVSIhKGnvSXHHZRAt7e6l8rFT1SUW
 9RvQnJUk+kEy3NhNeCu0zeTVmnyZoLfIKN8IKsZeTURCuuj90+gHcBt22uuHyRrATX
 FlOd2Xp0lJDiqTb/Jcln+NFo836CGfV19Y/idMgc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.124]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1kNYXk2fHx-013CLW; Wed, 28
 Oct 2020 19:45:37 +0100
Date: Wed, 28 Oct 2020 19:45:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v9 5/8] io/channel-tls.c: make qio_channel_tls_shutdown
 thread-safe
Message-ID: <22072bf9d36a8e8ce6d9b1c9312c15538d7f7e3c.1603909658.git.lukasstraub2@web.de>
In-Reply-To: <cover.1603909658.git.lukasstraub2@web.de>
References: <cover.1603909658.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jXqwX78+Dou2aIueyJo_vus";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:n3Mt/H3g1zAQ9GPZ4k+NAcgqGvcUEZ7zGQwPqQzXRICU3F0HRoB
 YSfy7EraT5pYsmeuTzll+4aOlQsZl18bZTH61d+XlRPaja4jFlbwBVnG14LY3P6a34lPpig
 PiuDUmQB8Q10sO9YKKriw4lYl1MtLLDd7b/ggslCD440Cf4PfGbL2ikpiqiYigVtlto3R8S
 hsbPjdcHq0RrK77NYDc8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K6t2iyMazNg=:UXT4Kk7WgFyN4bTFiB4Mdz
 sF2SvFXFfcj0VRJ4gIPaWkad8ADeePCktRkcAYikoMgj6PW7iZsXW1KWH/yNNa73R4vN5niJp
 7kxHUci9YWnNKo5g2XSmuWMLhO1xMthZru5aXQA7/2oJdJj4+2Hsd5lHamT+pPm9o7z7Tr8tC
 EFoT6Yky+InfBJbqb4CazdclHfY2CG99FmZ2Mm7S0Qw16l7DSm6mJOmuK8Or99nUqR/9ygPqY
 bvF5CgRhRqV4TfTM1XHQfYBTBRuHxhNdtt6afDmuW4f/YiP8lXKWT5/RNX/nnsMPaN7xaIC4B
 ks2M8+vgUsTlArXPJfIRlA2t7CbZJJVUw1q+ZKQT2aO+clZ5JT6Vk8YQufuva8u/ngEOvNFnJ
 WbOBcyL+PC73F0TDo5/+R3grjs/i8+fEplI8KY9Biy6qx9sJZILM4qywTfLUPvNOQD0q8BYak
 PKqU4RT2kP+FYkvIgcbu2vR10ZX0DGdeJI1K07RabVeX/5KqL3rtK5QjqlKVTAADrkCekhdhv
 mTogAsrWyay8rm/f6TjXMYNlCrlfHjq1cBaKTRCLMT0Z95H3vr29/Ah8ZmR2V5S/wbJeuMO7W
 5KEvFrZRfpxn275/3C3gPLCzkS5T3Jv4Z4cY8CepjXSXTS2QMlS+QjwGlLOjTU2Iv9Jz9wFon
 Eo3bamquQO0xVDl94LlFf/UoAYAbo7Krr8M0t3nZWAcOHGXtgUV3fhNYzAAY4okGutfAwGwIQ
 JLBB27bWYxsC1/nl6vr/2Y29W5lDQR6b7XtqiL60IQxIIwkMIKuvYbJonPvOFg4ZoQYYHdEiO
 /Kgy/hSxZhQ4UH+1/XhNJac8ogGihYsms6mbuDtSuoLUBFv8OcQ/zdgbfd7Bth92fdVvKnrUy
 EZFFqgGoMw0tZt897+Ww==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 14:45:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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

--Sig_/jXqwX78+Dou2aIueyJo_vus
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


--Sig_/jXqwX78+Dou2aIueyJo_vus
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+ZvFAACgkQNasLKJxd
slgvSQ//UA+9kpLZWuN1ZbOjMabwm+r6FQMhxb8ww+AtCIim486ClEuto45JZA3+
fCejeddtDSkDkzXUkjKCnJeXs8SANXSc48aAl1MsqsF0xYcbFNqtAcvxn8jiz6b8
NjARbDQrUolr3Y3vir6QSAUn0BDoN+wP64iaJ1D5PBk7h11DKKKgvytbrB9Ia1il
9ATULx04MW0TFfXgy5L/ew9tsuIprXC3zuNmbCKuM6GXlrjIJM8X6dQEWsRtb7Lp
pAnTvmmWkWYjvTfQ67opEwsR/JvyV/w/DdMH1Tlkcyccpdd6U6olPCofQ9UmIYDV
/gZkO53i7M0SmQvD3KWopm/fqMac0fVtAEMDHmILNyFCM82ko757pSSID1jhsCkK
qgbH1qSWBjVZEuHfUEdCVXVc2oAGL0CJYe6BGuWQCjC5PNRjUNtCrY6j8tVwoZgY
6ApBWnPoAC3gfwPdOFR7SD1dOOgREmuCHskah6f/eeEXgzBuJE/se3NPFFzgeMpT
aYhFTbZPcLKxgsZV4TP84MJNZ2e1yF8PzMibK7sdc7chNUJ5hG+f9KuZ6/MgBYZD
thujMxGVTMcJ491B5hx1HbO9aF9VdBpXVmkwkRGnP1U9s8OEBgqFdq1bCVUY1mLY
j55RkQn40OHpkjYBEu2cfZeeCWj+hy4NiCyL/0p3tQ97B+3H/wk=
=UFh+
-----END PGP SIGNATURE-----

--Sig_/jXqwX78+Dou2aIueyJo_vus--

