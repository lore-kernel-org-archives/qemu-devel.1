Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C793C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E59206B2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WKtspLhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E59206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXYj-000395-7M
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXTH-0004uL-Mf; Fri, 30 Oct 2020 12:41:47 -0400
Received: from mout.web.de ([212.227.15.4]:41417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXTF-00031T-Sp; Fri, 30 Oct 2020 12:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604076100;
 bh=E3cjhVZ0qInkcGgTms1XBFQVnv7r83tm0k3kWyQW0XM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=WKtspLhdDDMVTbQJfaB2aB43P2WGTjVg+evJNd9x7j1MUmr3VEUB/QA4NQ7+jWqXn
 AUCh9z1RLqGsI3lxca9l6U3m6s4FfToEzTNV6sSoXSMFDxuGvs0gzMG/gKC7rFH2Wj
 DNAFb5ifrH9pE4hcQLZJFVXX6Q5LBZBLbARd2CvE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVpJg-1ksKSK07xI-00X0Tp; Fri, 30
 Oct 2020 17:41:40 +0100
Date: Fri, 30 Oct 2020 17:41:38 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v10 7/8] MAINTAINERS: Add myself as maintainer for yank feature
Message-ID: <20201030174138.071af6a3@luklap>
In-Reply-To: <cover.1604075469.git.lukasstraub2@web.de>
References: <cover.1604075469.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BsXP.b+6eyCNdDgSp=YabhB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:YimthprSUS4Dscwv4EEJCAt46J9hIgTJxKB2tAXFkIhwePT5ty7
 NxyAU3GIIGDZI7QiH4wSWbi248a7nJlN9mChEXnFNVh3lc8w0H2KeCztILt/Z8Iu9jbYK7f
 gWBefNR7uJKR5FZOt12yLBdpCdK0+mKJAWQ5j1llPrn3Y3QNhrq14pVFXV9kjADFiS3l9sm
 u0zboYqlHlWefieq7cM/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vx9iMk0uaUc=:PcJYdQCwAw9QV5NRZDcBhT
 s2e/LcD3UR/ItsY3r9xjWH+N6jtCMTrU5TCDk2ssnQvee7FBki4/12zA74aPosX99oD3zQLPl
 xxCoyoombem4eniXw1PDct3jDHHyotJjbcTi6s0UISIUO8onmkDX2TNzEUHkdp9T9VXGLEoQV
 EIXdPLA63069i+xpIyws+ZFht5ORngImNRMA+0hFmwZ+INHi1c0xT3EFZ6uL/G9dnXfWsBOjy
 nm84LDJNUl+krVYK3djypxyBS4cTJH1mIQhTN4PnyWLpdWRQzpTC3RbKlzvCT33B47eUNlKgw
 imYAxdVMPmVWE5Rr+NXN8ZgFg3e9Z73RyFV+twq3GJnMWACM+PrXTfDNzK+BtQ3hddnjS5h3J
 f2X2/b6u1yiyzql8oV/3a3IRg83GRgLAGPw5/2RofpgXXPUItnWp8xfxx8SEEhBstrvxx4eAm
 Mo7uv4FYHBvdD1gHtYQeEqFXUa15nz1C8Fv5SAlfZo2MgkaDue8NoFvyl36+eEWIwq6UB7ImS
 +Gacc2Lu6NmJWftb967SBFaWzUkxknOFXYrN/wcLRMdtrGQH4eTOcOqOHx88FqUEqlcxipCES
 lNQIM162O9rJgBrHFEmaY4VaVIB6J4RcsXY2wIPQiTlt5SZ4EMmslpaXnP0yMZg/lrQ6UDt4T
 hFIvSaE7laOdf9Df4TwLMk68zbWHs5lmbiEEPOp+NKxBS4UnWcXdx4HTePTrPwGTLOWK4lkEA
 WZUpj9ollovcFp6diNRYR/Z3iEc8I/jug1FVv716fR8emuKUsxJa+6P8PZoQxhdahGBab+IDD
 +/te2kJPJYve1UyHT7B3D7P/dVVVmJMQ9qTjlgGxxCnmQ5RgPl6fSGtKlQi20IJKXgJdpiwQX
 r8PgK+JnGpc795OYETRw==
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

--Sig_/BsXP.b+6eyCNdDgSp=YabhB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I'll maintain this for now as the colo usecase is the first user
of this functionality.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c744a9bdf..81288fd219 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2676,6 +2676,13 @@ F: util/uuid.c
 F: include/qemu/uuid.h
 F: tests/test-uuid.c

+Yank feature
+M: Lukas Straub <lukasstraub2@web.de>
+S: Odd fixes
+F: util/yank.c
+F: include/qemu/yank.h
+F: qapi/yank.json
+
 COLO Framework
 M: zhanghailiang <zhang.zhanghailiang@huawei.com>
 S: Maintained
--
2.20.1


--Sig_/BsXP.b+6eyCNdDgSp=YabhB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+cQkIACgkQNasLKJxd
slgUhBAAlpaa6wblzGNz1v1fbmSYDbJh23q7hMiVCQZhaWTBEzg+laCy5hmrRtL5
bnDf0tFlPt1qmiJlxoTScZqXZTvdPc18VLdY1cxEIBGWHOZUpyqKo8pmQtWu0CZy
yoGRsrCm87CxM7P8jF4Y74OeNxnb/P5l35NplejXt8IEiY0wvxwSNXAU5ElFqQNt
TYhOXUak5F+ww70z3VNcFuQQnxNE73hcPKrbAXtNuskX64OGTkR+WCCXUKsUbMNo
Cl9YLgODrR7rcQkUzRS3pQW16VhdMFxxungwvEevobC6NzH1R7caUfDs/vAII96m
LK1a6SICOGMEP54QVe8rCC4ikl3+xDH5s+bc0iK3i5MNSdIDFLP0mWKnRr9Mh87z
YTqYJ1PAyUl2gUXWdbI4Ufl6Nf7SUuPelKywxbhBwbH/glQnuANjGJZgjXSFiMBz
Wleam9y2YCB716KaV6qD9Xv/0gQqubSbFJlq+0U+lLRuD5/JA5lnOOiyodO9Imnu
/9kBlYFUuMj6jPUIjfhTVSSaw/2amr8aSXc5yBWaSNUlQsR5++mzbIf4lJpSU7MW
8WDjLf/GF0diPU31mWDnu7q78i4fxc/LnwA0Y+k4gFNBUIyPKEbWmVQ7cV2jSMnc
4evKNJA82B0g/6eBbvChueeienCizCxTHXXO64nKbpTKlr/ZLUQ=
=Qfet
-----END PGP SIGNATURE-----

--Sig_/BsXP.b+6eyCNdDgSp=YabhB--

