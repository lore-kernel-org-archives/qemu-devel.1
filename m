Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D69CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297C62083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pgSVpdSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297C62083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2q8-0001im-2m
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2OC-0002so-6a; Tue, 01 Sep 2020 05:15:40 -0400
Received: from mout.web.de ([212.227.17.12]:56797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2OA-0007MC-3q; Tue, 01 Sep 2020 05:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598951731;
 bh=UYMICoXZcQUgCRi75B0dKXjg7htZrckMaqi4u2ILlj0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=pgSVpdSybPci8y23cvGZrr3s6s/1EeVRqSKE+IPMSnT8UGcWox79C7HT3wYpkxjuZ
 slFZRSqAS77FmSrACLuaT+LcdIOOX3QFVCZV+cRVYOF+wGOrD5ESR68/DJh8oJqzgG
 E95+LT1nUWnn8pSmI9KbClgPlSRgiR3E2ETrfuk0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.220]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshWf-1kblAQ0VYn-012Dvs; Tue, 01
 Sep 2020 11:15:31 +0200
Date: Tue, 1 Sep 2020 11:15:29 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v8 7/8] MAINTAINERS: Add myself as maintainer for yank feature
Message-ID: <6c7fabd06fd7ba0c6ce405b871f94c7587a50328.1598951375.git.lukasstraub2@web.de>
In-Reply-To: <cover.1598951375.git.lukasstraub2@web.de>
References: <cover.1598951375.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OLk+N6f=xJvx_NAAxN5dq/l";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:d/IIh62pio8PHLuKwohc/6MNFq7zoOxJ3Ic5rPw/3wx4zuzTStl
 nJgNkfWJ6R3ZtVM/mTQ3MmW3Tr2MbfClpcNL5Tw0sqg+465tTJHWSQxa4eIe2c7Fah1Mbs+
 ClOgNHyFiauv3xjZuh/o9TAlBvN6O7M79GB8AIm8BGtKjN5LsWAl7/cMIkUfLLO5SNfc2da
 x/GKuf+/nwKtWTG2QB1GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5eKK3QK1h04=:dxxo/Ja2qFYIjKdQ+yr5fc
 1zX+fJR25hUp5tFXaRI+TgcsG/l7geTdDCDufBoqI7IvpVjAXxJiJGIjnNQ24K2wcmk5HXMPw
 ZGsuYTbUU+z86W8g5SDM+lyVRFSLR0Y9lihNWrJfcaKMYKkOK81JWszV71/2HEkx6V+VWB0NG
 X4WYzwEHvfo4jOD0BNAJMN9GgmsI7NFM3wJnRN8DtElThDcPAsGxTetS3jvCsxth5ENPMZoZv
 gUrLWwNr6WAZsR64G6FwuiZgPqSjXjQsB7YtXB47ClOv2FC4XalnCrSRf4YxHzsGSvfHiyAoO
 vw09dm9eu0xBNsacEzgNj8EWUQoKzlR7fQlV3l1DH+yMojNTZJRrYsUD2hbn+wqeykqATDyNm
 3q3pSh654375bj9BWvox7RoTEW1Ad37EuGN9sIBflV7bssgjQzx1uqG7wThRgQWMoKoXvwxpg
 nVUBJQKSJd+PJOR3XdmQmOX16MgtNWhSkAllF4WcHaAxwmh6RAmcSiziiShPBVxRGXN9uvmEM
 Shq2ExVPZHGCBgEQYHq0OrJTR2lxGUBJpS5BeoAmCezMI381J7H+z1nWZM4xOuWWYWR9HDlTH
 VwJyVPRl1VLiGa3ExVVWFPMFrIgrjuVYP2fFAJFqtqxhfDOwXBtxfrXHJBcaDVRlEwfYZN646
 /7TSaxT5s3VW2/88o8x1w8viUK7/+xbPYh/IxwfII5dukbyoJI33zmmE+AJBSq5+UBuACb8KX
 TEvISWl9A6O8uT/dObr3BSMioIRP1eVRzqrHtvLHJDhbi+5E2pim7+1ZnXz/OYuAKG7Ihc4xR
 /NkfTTURcdP8CSKqjJI52kVuHpCiwDyxX9fQU4tZlEoIYVV0CwNfqr1TzfXzY3+zAN+eSzZhE
 4XtlMKH3v3lT6OyUikuwXodBkdh184HCJ1G4Rd0nHQwjG6sXxceAkOuLFXKniLeg4oUJ6xuRx
 LCmF0+FLjJGzYl9zgjKvvVS6Y/sE/KEpEaQut53IpHpWGybiUh9UVyydelU8LXfhoB6i2oQ+h
 PswkcUTmub/whLl2D4jtnfjDsIFLzqyZzC3rmk+7ZNuYmCw0foVCX2wsrKKYU169erod1BAnm
 mn8OuuTGvaTMWKhm6td4jJ7DtpHCsDi/yxbsrwTRzPGL4UsZ/DwMImKDnRCLhDcPxhpnEY/vZ
 85f0CVIQYNk7rCgYtoTC7gi0UvAk/NsoW6v/7D5/1TkfO2zvHoFf9wIBsRau+blSAHzdfETau
 67wM+SqpqtyK1ghYKQdlQdysC3kUPtkd6S3wWIw==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:15:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

--Sig_/OLk+N6f=xJvx_NAAxN5dq/l
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
index 5a22c8be42..c1d450e25a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2615,6 +2615,12 @@ F: util/uuid.c
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


--Sig_/OLk+N6f=xJvx_NAAxN5dq/l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9OETEACgkQNasLKJxd
slgQEQ//YGFoftrojhXoOQpIDWtbN44QL5l8++saLj9ePxlSKwF1YaO98mqpvIUj
LV/6mFDcGuoO5YtXH2jYKtDQSuzL4DUtX5kVfxbzuNJNsy8vnXJjIAOfSzbVOIbV
IHLCZEdOFQBDY7UZZbS14KHtP2XvcEsCRsQ03D+Vp2xG4q8kttqyeb2CqFyNvZul
bn8ReJBqYOp8RT35q7V06lbRmL3l3NPh9uBBQ7dtmWah5aGp0fvFO7wBYNPT9x0g
kXB6aTyOsuOiJva9WEe2FWvSvjhLHDlvCOfptw325JS79bKKLGr1Gl3ApU+e4sJO
22+P8FCmNBl+3Ja7CfGk0ffWtSqa1slGMH3msx2GEYtMVm5cLYD5KkQkJ+TRBh+L
PxcaaHoX4FBbxbxdiiETepimk90ZKVZJUeM6Mdv3yITwaQ3zpfZvCqPd4+gNEAX5
x2nAcxz6J1lhIEvU3KKeYWHCZToWVwa2MaMk+Acupr5zPbcf7jIP2Jminv8PPjJy
kV0q1CnLA8CT0t8EaPY1bC8fe2PNzwQTzcpOg95SCop40yHQjtTNWItN6ySGmL1A
QMLEJM3wGlSm+tCACX8qSUr0VTgh7VS7j6giFuanvmqtvRv0dm6qGskGUyK6dVMc
L8uaOPQ561KDEWFTjDB6fQMcL9ymbgVQ0SC3c5gOBIJ9KeQv7a8=
=TbvH
-----END PGP SIGNATURE-----

--Sig_/OLk+N6f=xJvx_NAAxN5dq/l--

