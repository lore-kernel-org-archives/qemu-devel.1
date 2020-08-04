Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8718DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8662070A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="d+dsyFmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8662070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sHd-0003RF-R9
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s3J-0003m4-BK; Tue, 04 Aug 2020 04:12:05 -0400
Received: from mout.web.de ([212.227.15.4]:50781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s3H-0006cP-KX; Tue, 04 Aug 2020 04:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596528718;
 bh=jJiANSLgv/H5Do6WJz6D84z5O0+cbPoWlrgPB0cClfg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=d+dsyFmuFysBCHX+4mb9NpoOFqiX/HsMmRCHVuflWOrjFlsDw5sL4g7UDTOaqMutg
 5egFcsoYQGzD0sP++bFpmhfl37dPb80ZvSxB4dRZWQQAXp6vmY4XFB2qsinBGYsNzy
 QWRlGl3Zy+9JZEkRyVRpxRvkHmi2A8Y8mojdPITQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWsm-1kIKV41SBs-00Jnta; Tue, 04
 Aug 2020 10:11:58 +0200
Date: Tue, 4 Aug 2020 10:11:57 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 7/8] MAINTAINERS: Add myself as maintainer for yank feature
Message-ID: <5562d48f00ccebc3694cb2bd332b56441c64bebe.1596528468.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596528468.git.lukasstraub2@web.de>
References: <cover.1596528468.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//Fon2fwJf+XS0Jau.Rg2Tyr";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:xEIHEBr1PXfi7MuijFwo8/qUx8Grn3ynlzFbrnDhUdIqk04iPDA
 DdCaou4cHN+kUK+SVUkbT5Tfvy/Yk7R31rgJm5lKenSmx5yKt7QikDgRa208TGBwgln1pbo
 i8KGdZ9yCtFsNudrrx0ylG8c8zjsyPzGmXCyIHTB8s9NrvLrz6TyebTzFgtIcvlcVPCR3A1
 7uKJBxdRnjexXMHy4b5hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JvKbVnyzl7Q=:WB9fjBumrOB8l7W/Dx0MHr
 mrQLs9+URj7WOLDr+7A9GqKkZMsgMnkURNY5yXtsVFz1PdroVzjYzDa+3fSA7msUH+FCzIbCt
 9Y/OpX08osbvC2RDKYzIdOOi+405dUG9GuEaBkEReAtvE3Ao2QP8c4L+2k5ZQs4EJI/Nw8iJ2
 hkrwFK4GrFwNRZNPZ6dKxF+ra02d6fPhTakWY8bHSPnbviJzz19yBVTeXRLfvAZ36zMWsyYno
 pU5Jb5Yn2KMsBiv0UIv08XjAMR3QOz1Ez9L0DaWQIWNacR357iYOVYECttkhVyEm1aj8kOcSm
 qASSMhTZqlPlGHf/cbAQ+GHatu60YNO+Jt14rIln61lfUHr/WihoogwUIIlcdj/2o7LAEE7DW
 /qw9ONTUQcQ0LXmjgcIlB7cUMrKtQVzXfNJrVIveL59LywJO+VtoVdUDxRwmC4JEF65bvH1JB
 osqLO3Bq0zUJdDs89mWK7W8Fo63VjYMpdVMLrcvWPTA+Ye7yVJ+L1T+FQrO8+35lx+lxMSrC8
 Jze0o9If3Mt+cmawJSX+bofQ7DpH5AIKGg6TLB9lS1/ydwg70Ee7u7ln1UvcpESjKIP8iPNgH
 ONwAG3tPdqr85iNesus+jNoKXfAzw6cW9pNDgED6glmYerwvtbaSiHddE5I0ip1KgguSh79G1
 xV+I7Fu/BmWktIuOHX7G7Pufa3Au+dmLvnbG1W1HsbVMyzefjHN4R8JmGNMd113YUYbWD9ra4
 Ne/xSNI67MZ3hMP8b8r96R+LiNdVr4hkEPZMoOGzKDU5dwwdxVYsXUrjHV9Yb9UcFoACfqY8c
 d4/JXkYc4tZL65URZZ9jnQu5rvqJMQAKzQm+yf1hTjz8/Sx2+ZTQcee+Lo61cOlROgC59S8fI
 5XEEGNvAhxfje5OwnmzFgGfLDe8k5QYUjC4UYE9q6tdNTx0xljHVXtWk1z9QmcHzxaoHV5247
 4nx8GROlw4YDeItg8kSRkHBY/u/1YdjphXOmszxYNCog9qBEcFSwcc14FJ6vnDJvjjHA5iOBo
 w0cmceIqM8qZtB9t7SXGZCAJ9omFpIktmhjTRYwHCbX5DhNZKVYwSzOJeMsrFGiPJAGcbXU59
 CPxWgPh9LLQj5nhpoiHycWnZu3jiknuYTDHjFFbzBB4hulmWi/pWoUpjk8AnDcD2YfpLfckyt
 dc7ZszcxD7w9tfoREpH/Ozd4Jqjg8An1YVuak3NFdxQBBfW8EPt8rVwo/ksEZDu4jNwPUyzTL
 W2hLLaZrCJD3zNL82sJQLMOcG2SHhfrHtF3czKA==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 04:12:02
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

--Sig_//Fon2fwJf+XS0Jau.Rg2Tyr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'll maintain this for now as the colo usecase is the first user
of this functionality.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b..bf5075a637 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2614,6 +2614,12 @@ F: util/uuid.c
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


--Sig_//Fon2fwJf+XS0Jau.Rg2Tyr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pGE0ACgkQNasLKJxd
sljFmg//TtBCNOnsmRx4+t3oQv4sBv6zrw0kEZy4hJY5xBrpRvFhs4guhJjkxmKF
FInnIOKymXVsrmWEVBatIF7kFvset3tG+V0q02zaispYia2ciglWGeovEY5BrrmJ
wuii+EJxwJWiRUHGCT4z2DZlqtaWj2uDUnDWTtouSv//48AIhMumsfUUqu8aYGP5
XVVBW1zOm5SqyDt6zSOFGfaUw53CZd9PONI5xGTkaZY6wMDS8mCeg4QfzliWPsjM
uXYc/FodlJBTnK8RmBF3d6EIGmgYDwvY30bou/YQbU3DYeNyKaSJ7ttbOw7DV8ym
hRk2DIsMD5K9HaQ12RdYtMJMch3Kcbn72PfEMugutW0dah6Mdey/JgQFyuuxZLY8
30cnMmgzKMc/BVwEzeVv74qKExraV8QebacF/iNImaBIadqlsFw88WxPMg2mibZc
rGsIIaws8BahZByIMu5Fge93PFiL8kOA0VS3yPW6Us5DA3bpU219Mbu3FI9sG1ag
ncpd6coVjC3sa+jsmJIMwGWq++hTUJZhWCAjyf+xZ5fMVTDLyGXO+H4KT7ZH/RnF
xHipuTV8ELTf/+BuSQZMvUX9Tf9Pk2p9FLVNAEuspS7PpJnQYQWh2DzrP+e5ZfBl
AfN27vx8xKrQFWTTwPq/iHfMRiACzWEZt4MwcnnjMWQmiZPkm4w=
=8Kpr
-----END PGP SIGNATURE-----

--Sig_//Fon2fwJf+XS0Jau.Rg2Tyr--

