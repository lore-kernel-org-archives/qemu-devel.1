Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4BA2076E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lMnaxeRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4BA2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2s6y-000615-5e
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s3C-0003ff-7k; Tue, 04 Aug 2020 04:11:58 -0400
Received: from mout.web.de ([212.227.15.14]:57289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s3A-0006bY-CT; Tue, 04 Aug 2020 04:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596528711;
 bh=bSWjpbZspePlZ8BZSSi8m7220at3pdOLN8eqbLiQZjc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lMnaxeRtZMcN4k+f97ZauF6e5EK97IzOck4+TEHjwSKNV1Wdy+JEaTNni51vzT7Bb
 6UyomwDzfBMzBqcFMUdtw9SO6t+63NoDR3LGXdrRVF4/ZZ0io5gUFaVa4n46dJJGUf
 Nm7uf1bQGZRPZujIjQ8jSv4Sjb763U7gw37Btgj0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeBVG-1kOMum2zMc-00Ptq5; Tue, 04
 Aug 2020 10:11:50 +0200
Date: Tue, 4 Aug 2020 10:11:49 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 5/8] io/channel-tls.c: make qio_channel_tls_shutdown
 thread-safe
Message-ID: <dad1ee8d9e87c34c71788eecc71c7743c9e11e20.1596528468.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596528468.git.lukasstraub2@web.de>
References: <cover.1596528468.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6L8wL6ee/s.fuFafRuvIaIp";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:pJpYlpelk/Vm8ALqpszS5baQJuC3IPf6uDNhx3t3cZ9u+2r7NFx
 zMEffUQjWoiSlCq4qzRt9KVvJaq4CMiVZCM86/oaoEDtksK7kH2k74cAU29+CCEfkjEIV0H
 6DC/Bp+CfyXL9LIj/pHwgB5epRAlBmkalRqFWxYXixIGBmiL4AS+PCX3MhHiHnS7pC/1Mr6
 KwzgCGQXFxjyENOPnQtig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sEma/SQcmFQ=:wo767FoEFaCsXz+hfsESw0
 qWUrRSk5cYm6l+6NNV+9tLiiFcGR/P7V554MvyD+C9GAVcFIvcYIDPzRlyGF3i+qxI24MBQRD
 yfVL1Yj5yfVLZW+hM7KBTNjq2fGtb/q7wjWHbhH/DOKDjiBIvHNL8VPQFBdNPm5lTlIGFZwZI
 tNVhhRUYl1qU2sNCpUTCno0rzB1mdiAdaz2+NYGpfh+phY8SzD5V9VSkwO2J/xhhG6XbliEp9
 CLh4PjoHo+EXvxTpn4Wimjky9AS3eePIwgN+v4lcDd0gu3MqTRJMAfAFmLpT2ksKSRwa/whrn
 TbJkCXCNO0WSHRXA/CCqhgiqFtdUPdUyCWGLJgMzUWMlvvcmd2cx1htY4PIsfDRg6QIWrFsCH
 +fUJg0uqViOM+mXBhXE5mwWosMMlPSfRQ3SlE5DnxBR/TkVviGTM81VKZWu3Ac0h+4IFMNZUS
 WczB7jCbOmyGDrLtVOdIkdtmKDBHCJpQ3It7DbnBr6YkgB5RV/SlV3eEdYO1CdfCHQ48o8iSB
 xMg6PlmXCKfZI+8DdXaR8VYSYmdkLIf6/YOYlTXwfj9jQPs7ExVdsRvaYPTxlQKQ6rlz6FKCf
 lFVvIu2cQmwmJ0lKYEMu+ctb2O0HEOKqgXQm8/J0eJm2cRE0pgG4v9CREyGx5pmzLH9EDyXEa
 LEavFB3t9HAU4o5nz6L/KcNE4rzV1bpkKvgxf6zHepL+/ofBRwttNg+Pzk9kvhvd/lj5vfSyG
 I91TWv4vhpYPRege+sLfGWi5wW2oPnXx0FLeHr9g5EzFM4veoGZnNkNRt8J8b8nTqujg+TZRR
 WmDqG8/XXJ8HHDJj8c1v0eDC5QPqp+MORnk4K+6tv9NaejD0fmg7WIvHtHedD0/FU5WeSY10D
 +eQaiyzrnc52O5CMIsl8WFZeMVn0asOTG/G1UZvu83FJaUMeu7yZpLE+G80K17AlmAEMtpbib
 mtQMGVl9h8lJlQKU5vGLXlRAFPI2cyzhGekmZJ1Lb5Y5jTGegHX8QcVOqjWCXOLyOeo19eeJi
 kiMGBX/Wj7snSqdaqrBKPKxiu7jujxdA6y6JXt+FVjSwGcN1QBNNZGNpQnTSqo07Cjqd6CsLp
 vdFEzM5XA2xgaFwhUzEhNg3wRVjkkXwHfulWwAqtmYJ+n1YG1hM8rlRN/lWnr4p9nxn94V0yY
 Yf4ixrcXdXsksqMBzDsGF50D6Rw48Rmxm4ChQ3jlhpl7PaJpWw2e9bQPasvf1Py/omjvaw2Mn
 LlvllSf6ObJd4WRcYUHMHcvAeRRPeMRWCoWoifw==
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 04:11:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

--Sig_/6L8wL6ee/s.fuFafRuvIaIp
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


--Sig_/6L8wL6ee/s.fuFafRuvIaIp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pGEUACgkQNasLKJxd
sliwTQ/8CK125KBG2JH4fy/YQ7of0HzCzB8C1r+CUBtCfXBqGYmehqpV8g9yWXYo
uAEwtvp46gLjAeYxU2WM46UF5I7PrZZ4Ttbh+y31+Z33GeOENUEO1Au+ZXQXMC6i
Qya4aD/8xnK68P7mkymen+IutWPUUZZzKoOzz4/fDBKw9Ee2gdNImd5e4q0ac25A
JOqyacnE1tzpJlH/5ZOxV6SUu/rcmhuocYeFQAtVHUQwvhQ2GYz6AqG4R4z2Wg2D
/dT1bt/YuQkEWUtsFHNeD4p3SBB+OhpCNb2Z/4SDY50Fssfo7jJxeGUdlrYYtZ8Z
h/Rt84maTeZA6UV2OhuuQW5tzITrUF1LLmOH12za83suw46aSLDEsjHcn8tSV0rz
w40dcwFtyB1k6pahirNQkFMZC/R3adWxATRcn/IMMZIk0hncuuXvzUugAm2cAhQo
+siGzGZj/umdvXllNRbncIu17yPZlcBYSIndHSGS820zgOv2iIISp4oW1ZhZOw+L
xX2ClPfOo0XA3vaGW35GP3LmuhDkAkPrTKwE6vQ2ln2ClYaxjgdZpyoXlx2aBQoJ
OVby4vwMxOFaMwvc/URs5Bm1CvLnVHgt3b7eitb8vfRQO2bKi6kg9FAxxWm6mIu/
H3AW2GDnOAyPgAd/OFEV9ymEzTmyRrwlyp8xEiU2vcec8aj/kMI=
=Fzsv
-----END PGP SIGNATURE-----

--Sig_/6L8wL6ee/s.fuFafRuvIaIp--

