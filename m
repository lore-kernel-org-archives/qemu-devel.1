Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC85C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F0E20723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="nYQJ4XCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F0E20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkO1-0000BK-4m
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8w-0004Ik-H1; Tue, 23 Jun 2020 10:43:22 -0400
Received: from mout.web.de ([212.227.15.4]:49071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8u-0002cT-Qe; Tue, 23 Jun 2020 10:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592923395;
 bh=ZNMbTxbtXHaFTwahCwpOthPggxtv9+n/34UoZIYiClI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=nYQJ4XCdyKnLD5rjHH1JocN+8LXlNXynP/MbfmFAuiWoG2sjuyC3T3OHLEvbJOlam
 KauoPPbpMP9sQTDFQFqkzHc//9otBTcU2lrs7TgSJ2f5KIQDm2U5LCrEZn0vrpmkUl
 FpP+XW9Ha+aTyaKPi6HdjM1EFPZDuCjabGcaceH4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.8]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1j6Syj0Gco-00jtwg; Tue, 23
 Jun 2020 16:43:15 +0200
Date: Tue, 23 Jun 2020 16:43:13 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 7/7] MAINTAINERS: Add myself as maintainer for yank feature
Message-ID: <c09e8bbd44783d9473e64994cad49da6fe2f8f74.1592923201.git.lukasstraub2@web.de>
In-Reply-To: <cover.1592923201.git.lukasstraub2@web.de>
References: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/avpP5RaBUyFCv=lHC=XRIQy";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:oImakV1bRvPU7UulmCWxpSLYdOjZC3Vo1nv+ue14TJE6BfPqnM+
 +YL8HLZfudkZbQHUC6JiFHWVvzBwshxtr0YhcAHWwT78j5wsdTp9Pf5C8QnQ579KgdO1DX2
 /zQVKAEhieTMqwHKNRs0jqcSDHpFVcmTGfCyZw96/NlOeOUdwS8osQTNQjR7x0VEBkjOqmX
 2lXwve1BvJjMta1P+2zJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0i3RUPTd8ck=:OaTjJElTwgvZraM+JTpyAJ
 rDdq71oBVTy0qOxB2TkOqivYidyZ8wEiP7p0kx26lP07gU+WRovzi2lWlcKpdSWOuHD1pFOac
 6impD6TKjVJrEUAhsH0ZHM0dGELafc2+DzMwJ3JNyfjc/6UljQo4nDdtoe27gmMnJqp6g9MMQ
 L8ghc54uNyQv3Pbd6+cr9qVzSqS7UiF8aUIXP68/cELdhUvud7kulRamuCc/CU4R6movldFs8
 IEtHqXbQ89LB966vExcjxOyohIffosqnqUAFBh4e1tPtNf13dBDQ72slw7nRZpy7xkqPxfiJP
 NH3N29Tv+kahS4GF2tdVtATiHnYrZ23gtnH2Ucp/tW8tzO+l9Z2cGNVWQr0awcLvKCpSuOPU2
 8I8XJXtJb6+NBEfDrTN0nZ6K4YYKWzLwdlPAy/0HpNlY6ND6JwkzES158sWI0bz8keRCVX/Nb
 bdV36SYmbmp3XUbfuATVOFc3wsJhlzx8ydpudie+c0EtnAnWzgtGGm5woME9w2DY+icbhg53G
 g8N9fKwFYXbn7BrnOd1TtL0RQSwqdvcY30uxkzojRJ2N8Sa/MVnjvIzQuPgjghFbDt54B09h4
 BtJL389bxjsn+dyIKNt8Al+u9bmV9mB3q1qPnxaM1PKWXFQB/xDAPz+cx2Tk2ie151nHgbfr1
 5/Gi3LKGtxqmgPZtAmsXeHcwvdbZqseEkfaPVIYdf6GKHxIqTNDN69nmwHtQRJgrI2/VnF/R6
 0XvuTJygPJINfEHUDlgBXHYl/K5bGllaqZq+fOmMX7nZOutV0a5AlqMZjQ4u/iYN/RA5apwdV
 LlGhnDJcbeM9ljtbj/QLYNpzwhY4e8sqhBQ6VCnYR14PX/KG9LiVTHZaux9ywEYiMwte2JXQA
 dli+byQ+agDGsM9zIWII5zf/1QDjYYmRK+iTEb1g1JPZkcfgkYUBqVkzsOJr4ta+0TAvY/7Ej
 Q87q5ysOifbxKxEKBaXMGMh1VuQHfs64SSvnU+5XM7ygUiMVERh5B9S27VR65D7IhgMw+8VKx
 iMbjp2YGfzST6q+lC2ogixzxiRLPJw5tHeh6wldJv6YDRsqM5JvexEUUOKoWCnJ69/7cvlCSI
 QFsm6AZl2UvHA63EhFV3/YyNk+LS9hNmzp6A/377lqJu8R3gge1fhXUHH97I64+Am66qOKlhx
 IG+2bBhsb3I8ezAPYpB/J78QN+xBwqLWSIRaMBQoo9MfwtAJYAadbh2O04urghdX0XLuhOly4
 2gWhy+uFXdfRJjLz8
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 09:48:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/avpP5RaBUyFCv=lHC=XRIQy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I'll maintain this for now as the colo usecase is the first user
of this functionality.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 955cc8dd5c..a403d59190 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2506,6 +2506,19 @@ F: util/uuid.c
 F: include/qemu/uuid.h
 F: tests/test-uuid.c

+Yank feature
+M: Lukas Straub <lukasstraub2@web.de>
+S: Odd fixes
+F: util/yank.c
+F: include/qemu/yank.h
+F: chardev/char-socket.c
+F: block/nbd.c
+F: migration/channel.c
+F: migration/migration.c
+F: migration/multifd.c
+F: migration/qemu-file-channel.c
+F: migration/savevm.c
+
 COLO Framework
 M: zhanghailiang <zhang.zhanghailiang@huawei.com>
 S: Maintained
--
2.20.1

--Sig_/avpP5RaBUyFCv=lHC=XRIQy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7yFQEACgkQNasLKJxd
slgKtQ/7BbnJtSTBppwhvAwAIoxsup2MT3vOTMMwBjZ2utB9C/C8Iwv0W2jbnCB2
sxQ+t+HIkVRGEnWUDYyTngYxpTizEAlFVVZNZJe/dhzxF2vtfXOxxW9UXplvon2q
GKsdwtUF0i/fbCqnr4/XBQMdyWKOVBTde1ad9q8kAbsCcgoboYsrSeZZMPVjquq6
967rBXPNg/ExKlhLFSAI/PdZxje/s78Y0373INPZd3q/apG1ZUAh/M9xuYaJc5hy
pFhkxhDVtABkkgOem9lQxvwgY/wNiSwfZUA4r7eLT3WDK/pGhyjm+lRpXZo+ilfJ
c4TIm+CQgVbBklqPGCZxCmx0cEd6hthriOgvq4VHIlRGrxF0+VWyRImxUbEK+M2z
IaAgn/U8Qrdgf7wHX0hjYdea71yjyBJGQAdM/sVUuVyU3uMxmbOPsDRT0UO/TRnO
xdN/08N/4tbKKzXebcIC0A57G7uOuyDLdyQHAH0BHvvgEs5ql+THvpYFu3U2GJW+
7+CX9X7zg6geGQwhhZv13v5DOYWXwFMO5j4M3J7a+af6kjic7iQB5cU1h+AeKNZS
6Pb/ZVdU55Z0A3KHEBiI44bsj7DIrd/GQXuAA8oo2RLwLBM7ZHCEVfDCj6fsu1dx
ZJQ87Kslt9UFGhYz9PQLf4JlqG4EjT0A2yVf4ialrSADPmTezek=
=U1aJ
-----END PGP SIGNATURE-----

--Sig_/avpP5RaBUyFCv=lHC=XRIQy--

