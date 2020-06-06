Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46252067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cckZBGoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46252067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheU6-0003J7-Oa
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheL0-0004XM-3k
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:38 -0400
Received: from mout.web.de ([212.227.15.4]:40259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheKz-0005cA-6p
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591471084;
 bh=0U39OAVSTpeXgh0fl/DAwVKSc2A6a00gaGnzuby3zQE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cckZBGoj/TPhylmdUTHMIv8L5vVjtoaH+1hTXiSiPmD3hrtO4qi4GqU1kT2iU1gRi
 mLcJix7+YFnQjfzeH1BvEuBN+VAQFRaFF71ICpDPE6JDS+qGB0jmftSqld6BMHCmdK
 MhzMjUJ2uqnQe2diQ2JhgDMyrqdaYM8n4fNR1SQQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8zdd-1jp2Ar1TRt-00CUIX; Sat, 06
 Jun 2020 21:18:04 +0200
Date: Sat, 6 Jun 2020 21:18:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 3/7] boot_linux.py: Use pick_qemu_util
Message-ID: <f2ec23ad6b20679341a5811d6e09977cadc19c8b.1591456338.git.lukasstraub2@web.de>
In-Reply-To: <cover.1591456338.git.lukasstraub2@web.de>
References: <cover.1591456338.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e/=X.bfbwuHB/7/B5eifMbe";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Hcx8Dy03YirD70VwsHUFc/BZGxy7gkqrfgT7gcNvaQxkckUt4sn
 kUevlGqfz0f26Um3nUQ82u2ogH9YSC7YsRYSUFehBosjlVIsQo+Wy/GCg2oCh3aAXS04cBv
 9vkecVhvy++wbNUiFZInBw1c71K60Sn3PLFGXp3Bu4OTBFKDhY4Vpn5n2Klf8v3NUbBD5FV
 ZLsys/GEknHcFBMIUjpPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:esxYdt/sE2A=:Tip+3Rhj6Uw7a7OvTSEy50
 uQ4SxEXYT6jhB0+yLpIWeDbv4w5E4gWmEDDmPfhncq4UUCh4gAemevbYi8fGSeftAMnOH1mqN
 rMAmvVu8sL8P2Y8TNK8L3xxC8bWaAaYWPkvQoXUupLs1g3AZHjJ7iQXOUou81TGg20kSXhqtl
 RygF5pzKRj+uT/KIwqA9lJKzbsAA9RGCXY6HQSiNZ0EqWk0hnX441rHwRUnUKDTX7Ld6+uY/p
 wGS0BQdvuusm1oldOnSE3p3ECkZRM/rvjDrSC8eNNJ2rI88bGIbK67CnAptBkrlojN+Dgeuxs
 UntxwhgK+ezvVF3YbYh3GpYkZ9ytv7o7aXVHmopQ7Z42vn1kyZFYJseREzbJc5SzouMaG7b36
 yda5DydGrn2jc8zkcMtrpVpsR9kT/BtsrU2WTUzUSJHrkP1Ta4m8jwJ2llumLkqx+vD/hNklr
 yclJ7W2H13pJ7LVW1lFI9A86LSjbnhLoUIE0Frer7+R8GZZsxKy9+8drCwDRyaU/61vxQTjUE
 JWsy8R4j98s7wL2bErPD8cTWUpXrYODMRTvF108jqlzHzU0mMi5RACxIZl2DobhIAVlfNkrIL
 y9s9nIu0dgtcK64yPXXRuFyYudrQxg9SJ75QRFfmdeDeuNmEGTvPZ+Au46xa3Z9Vi/FR4w5co
 npGmnSu1F9axg00qv5aaXHDnBQ8BAcp9ltmm+jpR2yjllUfmPK+DN2FUv5/01kfEOD58Y2Lhq
 Ze+yOQQm91JtMUpSrpiVrS1ECcamMySaFHpPsUSGUS41Zp3kT7+zt9j402szWIoR2goNpFIpt
 foRQuiVW7XPh1LCR5E3PM7QPidWXpusJkaF5/BulXIZnoT/djWvfS4I3Xt59QMFczvY0r9Pn9
 wgZmmedJGFm0f6VkkshwBP6Tfj27kps3cjC6nBrDebz8wAtD2xcrsctq1CYsOMVGm9Jm0KyWV
 tcHXLzfQXwtZvI5cZanIJBcgtLnHlaNRUQ0CeQadSz/EJvcvh65agn7gAy36D54MW0tjDv21K
 X3aS+w1KHnjytJDDZVcl9ulBit8oPZigkrpq1jn1SAFv442U6ozTPJKWt2SqfZLfAaIYT7FZn
 RjMePmuBQqD7DeaCaRg40h8yrAdlUSk7xX9CYyqfuoM8okZ0fIjpbVSqMgH0jxkV010tZB24X
 OsRpjgwtFa36irfyNWJSB+2x4vKzgFqiMmZ0Qw/97w8P4ai1biqYyD5u4gd11WzpVqXgNtxQg
 AiJ2eWADmfzl6HBzX
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:18:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/e/=X.bfbwuHB/7/B5eifMbe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Replace duplicate code with pick_qemu_util.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 tests/acceptance/boot_linux.py | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index 075a386300..6b99112cad 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -44,15 +44,8 @@ class BootLinux(Test):
     def prepare_boot(self):
         self.log.debug('Looking for and selecting a qemu-img binary to be '
                        'used to create the bootable snapshot image')
-        # If qemu-img has been built, use it, otherwise the system wide one
-        # will be used.  If none is available, the test will cancel.
-        qemu_img =3D os.path.join(BUILD_DIR, 'qemu-img')
-        if not os.path.exists(qemu_img):
-            qemu_img =3D find_command('qemu-img', False)
-        if qemu_img is False:
-            self.cancel('Could not find "qemu-img", which is required to '
-                        'create the bootable image')
-        vmimage.QEMU_IMG =3D qemu_img
+
+        vmimage.QEMU_IMG =3D self.pick_qemu_util("qemu-img")

         self.log.info('Downloading/preparing boot image')
         # Fedora 31 only provides ppc64le images
--
2.20.1


--Sig_/e/=X.bfbwuHB/7/B5eifMbe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b6+kACgkQNasLKJxd
slghhw//S2SVzB2lFIybUSDnbYpv7i3wCAcROhQYs8RXbDl/GiezyNigFQb6S/hV
4BuIEaRi5VHnVf6oKXa2tdZNw/3+N8nF7KouFsmBcGr7GlHTCY3i167bLV21Qmc8
aWzaWxhuyGqXKQ40dVS8LcY3fxeEgiPWDtT07SOPgaWog6vhxB4Vyh7CadlB6ANS
zCON3oJSjnOLGomWCNG0uzwH4gfFmDiAuqGfz9RFDmXWFTWOlHA5CeMKrExxMyvC
uuz9tmpkT7H/H9p2moTJg7pgfKDvlH/3zlwbegU3nL/kksFuhrS8oBhOCNXtEB1q
Qres8S5z/k4Itk3oJM9JK8KBwV+bHgoNg9wnZZ/xdJSW4fHCOwcfd9gidPOIoiQd
arOt2ImqnU0Ixwrpxz3CNy27+G1SVwElIbz1flmgVQ6trDNTKYdLi+nzz0GC/8B1
W3Pp/hXcuzhHm3HRh29UgVRvbhfS7RDW8u/G0J2Af870XLno4GgUZj1SVKj3jqc0
sA632OjySLH7VOTlui8oVf0Ty6ilPqlBJePipgwxpwGQE7i8R68jfwemMj0I70GY
XHhe/NDEy8QG/x+BgNt604MOK8FUCPmpZGI247xgw6JMPAbwyDUGrSmUaEaIDlkD
vm1sCn6EDBi/WapQZFE0oK1HQTyQLk4z86pADjI7QoQlTkskqYQ=
=w4F8
-----END PGP SIGNATURE-----

--Sig_/e/=X.bfbwuHB/7/B5eifMbe--

