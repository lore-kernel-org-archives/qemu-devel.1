Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C72C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C6824810
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="roq6LE5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C6824810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqaY-0000V3-Rp
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqSI-0000Sg-3f; Wed, 28 Oct 2020 14:45:54 -0400
Received: from mout.web.de ([212.227.15.4]:47949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqSD-0003Jd-Bm; Wed, 28 Oct 2020 14:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603910744;
 bh=TEOTvZ6vmNmtm1XmryrmocojKh9C86ExYbG0SMm/iuA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=roq6LE5oP/IslMRArn6PHZB8+4lHO7vlaazzIKCylwQnWUumh1HpHL0/oCKc8kf1y
 f0JytcTTiSmQ0srUw37RqcwYsQ8K/tJqBRifgiwaaHnan9zD71oiVdIH0HdlKCLEwI
 PRJeVlXCnyKSnUblxIadYkVC9/nTtMPoEZH/vUVg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.124]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1khhpE27PA-00A23a; Wed, 28
 Oct 2020 19:45:44 +0100
Date: Wed, 28 Oct 2020 19:45:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v9 7/8] MAINTAINERS: Add myself as maintainer for yank feature
Message-ID: <29e967825e52fc799c175a60fc2cc1bcca2c5d86.1603909658.git.lukasstraub2@web.de>
In-Reply-To: <cover.1603909658.git.lukasstraub2@web.de>
References: <cover.1603909658.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h7Sq.z+Xuqq6PIFkhjWER3K";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:1WhGu7wZySWGDRBAu4mjBcb80h9TMJ6JWF6TZ9KYIPisTyGbvcf
 yqJuZxNJn2WnYnwdgRjvydzI34lFu8IMbCAyMauZasdFKlhVW3BiXqR8yrPXrCc51UTnfDP
 ZOzJPPbYEcJqnTGnU94LKgnzaNOzMbUVrxRm5Nt2rej+MWEjjfv/MxwWYT+h5e28Ou9u09J
 Ua9z4Xy1vE89pQAELMaog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M68FpzMEjEc=:7nLDDUKDF4xtFA9kPOlI77
 RuDc7t5PZhBYTXgddM6Pt2dtsXOi4i2X+LJ4DClgRD4/ATX1BdHFY9m1fimYP6zdSTa/zL0HO
 W7iC5KSF7PcesUBoA5dvHpwAiD5e1lR73SSSjKO25HWd5/Eo92TWaIL3sLkYUd7uMfpxImv+2
 69vpfW1ec7HfSXN3+P+Ht6B1eEKQXvV1uoCMH71CE0Si5k+7A95Qa84+4aYjjhk/dHAllJhby
 JgdjWjfk9IQuhBg6I0VrpcR2/tnMrvhw2hE1iyvSifB3ZM9kzUCNqvZAjfpyRwwYlG893ypJd
 OKPAOeH/7c/+DoT5l2O8bk0gfEdgXRpbX2q+Kcq5v1yMq+eIN9mokQO74ApYtyluiMIJCjVrW
 sY6xbPLIfXo/fthP7cOdkKn5Dzrf7cZF/amMgbZmGykuFpytn72hxNxXsQphT+XFxjgnmQQtr
 TC96xm9trGVGmprWVEdScLdET4mGqIO6VwvHINkO2Oofm7CmLVXwRHsJPHNI9+x+Ii29fxvS0
 I3z9prCkKJr2zCdKHahMrNXUOYYH1EW53EfPgGsOY3A8Y2Bi6FO3jBjQ6H4xA3vJ869ILbDqO
 YM2+vkU1ZWI38RGi+juAvAfy36kNWDMouW7HdtE6AllXLNayMF/VWWNQbz+PbpLcqm8WUqXQU
 dUhROJJyLdv+yE0Y48PmbAeFHKOl54vHtOBQRf6qYHVliZBEcjqfR+ZF53gI82kD1DkhPtTKe
 D2t7ZQn5Rj0uvc70Nug6lO58vBj7XMkfmg5ph8kA13MX/wNjtwl0HlDdZ+EXjccDw6xe+XKMw
 mGnFwmOE1Vk/PcmRSFpW6i2jzLGvhtk6dyyPM264LtykEQ5L9cjTYcHnQluMYysQ2NzJR4pbB
 tpG/zabqYJCfZH6atKQQ==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 14:45:25
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

--Sig_/h7Sq.z+Xuqq6PIFkhjWER3K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'll maintain this for now as the colo usecase is the first user
of this functionality.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef6f5c7399..5921e565df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2669,6 +2669,12 @@ F: util/uuid.c
 F: include/qemu/uuid.h
 F: tests/test-uuid.c

+Yank feature
+M: Lukas Straub <lukasstraub2@web.de>
+S: Odd fixes
+F: util/yank.c
+F: include/qemu/yank.h
+
 COLO Framework
 M: zhanghailiang <zhang.zhanghailiang@huawei.com>
 S: Maintained
--
2.20.1


--Sig_/h7Sq.z+Xuqq6PIFkhjWER3K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+ZvFcACgkQNasLKJxd
slhldA//ePYssiifYGZqr4DxNgqm0c6mqS2OzLy91XcW0tgAbj4SrnIdDF49q7e0
F5hySQWEFPNAvYRi1ylUmKI/67Gd6++MD1HiY3Lp5abCM7sk1YiqyCWNtHYNcrqO
qeSmV8lnHXC6aMajudgJewQrpJfjid6ey6A77PsI7BdtyyKzNIZZT7tna/LEBqat
psvVRmkJC61BJa37eDWOCKHSjLgn0ic5OqhuLeQSiem2Pmn5ohYUBXypu1p6idQ1
PWkcDuqSOA4G3wOtmnNUhKDz0ZfQqZi/niAGYzfDSEqlGsHtvRLvWyHU/TX/7n6R
tAez4oVc4OlCZ50FhBhErsfHbOh7h02AjJYO2GbUrZ5lXORHcZGRzp6qxkx7kzFA
pgbFgYbcON5Yuq8PiGhQ52d2DMF1sSYqx5yb+6QT6X1qOzLTCRsfWwbVLbQdC0rm
eM6LCilMkRq+T7NzcyBXEIRd1B5iKmIpnlA/8HmhDBiw/Znl3cqI1jmPlgEJOz1q
rYVGgCB25JOhE0k0FuUTx7CTx5/KmVzyrZ//un7iZCKOjiYldxvGz0j/z6jXv55p
VYQPAsYCUnRhd43WGOxfLI7BHcePYp7rEkzzD8r2kj+MDvLtI/6Icy+l40emYtsO
Ww52sO8vn+3aQSkTpVSPAYbOgvOlEzhNreFtc2lXA1AT2oOPuOs=
=WdGs
-----END PGP SIGNATURE-----

--Sig_/h7Sq.z+Xuqq6PIFkhjWER3K--

