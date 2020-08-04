Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A298C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7022075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TFFe43em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7022075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ubj-0006K6-VD
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTX-0000r1-8z
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:19 -0400
Received: from mout.web.de ([212.227.15.3]:50295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTV-0003a2-LQ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596538013;
 bh=e//HiURP75Et9ivYV9SJ55oWF+4mjUJe/Vs4sreEytA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=TFFe43emDEPbZIIBpAs+0WIQkFDRrGoW0Xbc1xCZI5p18PsXGGcQGsN97AHRLwqOo
 RHIB0iOo5WyC6mFqhEhIpFx1TXpb5kHQb5v68BCsWJyPGFszqUJIXnSX6wmQ1DUqez
 0niLXaCxi7cpPT2sj9LUjfKagIJ7x0qXChucx4yY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M604t-1k5MVK0XAh-007VNP; Tue, 04
 Aug 2020 12:46:53 +0200
Date: Tue, 4 Aug 2020 12:46:52 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 3/7] boot_linux.py: Use pick_qemu_util
Message-ID: <39a4ee6737c33d28d6b396d17b466ef56ba811fd.1596536719.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596536719.git.lukasstraub2@web.de>
References: <cover.1596536719.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KETfucbCkvM3sCxH.ATKsl=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:rAU2kYwJua4PNEz4TOMABTGxOjbz/xS+d83nzgarfE2eEGDSyvB
 hnaSJdpj9VGhuR1PhlUhmXmcoGQqz9tZ5M7wGzZ9yWGO2CBet8gb24aKd/5A/RHn8WSsUae
 WyNUlM+W4pn/P+jgS9GLapTgQDpbJ4QR+r/wwCR4XGAv+WSQ7R6enlpdr5F71ERnaysUl6B
 9+SFzBlZSGt0tIMhYXc0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QxDu5nbFX1k=:tmAkM+r1NXYq9YxF5YpO9r
 953tinOezmkJoTPHxxGfvWCKT3JMC4ZlK+su4mhE+3odmwQ+kAS9IJvlo5lSaYPHZ7r3NlVvF
 RT1fnUFjg8O7eNOg1ml9rsKUwm7Lkf27JFbQYfdq11+GF7ULE3ZDx5/Xbn27HgNEi1eB5TiTh
 gVellXG5DSP0/6lOeqA/wGBada/apdF6AeqmJ8yV9PORUYXR46OlogMy2GTU88sGWBNcwNB8q
 /LupOkOLfJMA0NvV23msyG9x0UcTl+gZhEUneNzFKEsPxbIuUVGYc/POD8L9XTVylGxBSg1lU
 NXW0meiJon/nnBzOE0HJJWAwor4Csiu/V7nu59zZ/6x1UaP70GeiZ6Y349R419rF+Sr0N3Y+a
 m2TM9XDq9mZx8rVfFuyWjnaeknHgHX1g2mGM8MaxPFmmv+P4X7FOm0PibHQlfBKxxOuLFzXXd
 s6jreWt97MHR6mAe6QWEpj2NsqA9dSaHtctorIW1twZVsC+1QR6yIjqL15+sMnuV8vdCBwygP
 Y63uUpuPiFdFdpx6hxP6qGQoQ+vWYVFMA2nyCrfb8qlFIBtgkHofEZ6I+y1y7kL/tMS1hMuL8
 9HMynF+66qU0HjzXiNs3AGc1uz4ImHl/bZ9i8PHWKhnitho6zTWyZaaDI0TiKxA0PiOl5bQ5H
 DBvkWp0S47/GGRjvi/xQlHE1I6eiNgKzABmGv+Mb8v1vJLA//exFSIbNkrmuHN8u/rkGKjZxD
 uY1wtv0uzWuDGadvYuVUprfPhcebpLs0kQEc+vHiX4CmhojkZvXw0GwS+KLAipLyGcv0Yi4ht
 9cCDRhfZ/KZKSbbQp78wOvBY/mh3DKurMMAYYHtA+RJRTVlPVOTVpw7dFSmacB6r9EhGtFTkF
 SNy8TWvFzKhlLT3X6vsM1LEGJdvrDY1DpNYPvEv0U0menHsufHzD+sTfLpCgGlsxEV+/9I1vh
 xTzS1qHo2FlYKeKeAU2gySsxMXXP6klDhczfnLvB1rVwQoTXlhsDzA5gZTxwpXv9QMZ1/ZnJI
 a6R1FN9cv3ABbbiMbvElPOHLMMvpyD/ykypvIa+QKdKH+w3XbharIzNGbi6uQBucfGN9kv+LC
 C3sjP5P1YcmvHR6liJvwGi5L6A6k2hjgzC1jQrkbAznUPRygY244Zkpyeh46cxEKNhDeNPUi9
 iNpmuQgJrNKdRExEdB5X9UkPZ0+AGlmBn373p62HPOT4s81kRncjbwhcihaAfXXO68hWGQU15
 NtkRm1SotqUuKkXr/Cark0T55KwszNu5Dc5rBwg==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 06:47:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/KETfucbCkvM3sCxH.ATKsl=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Replace duplicate code with pick_qemu_util.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 tests/acceptance/boot_linux.py | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index 0055dc7cee..0d3629cabb 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -31,15 +31,8 @@ class BootLinuxBase(Test):
     def download_boot(self):
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


--Sig_/KETfucbCkvM3sCxH.ATKsl=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pPJwACgkQNasLKJxd
sljpAQ/5AY625wMh4Mn4ee23mUy4BawI5grOZ1SL0Xixwpl9RBB+lRFR4bMyS8i1
fZrGa2iK+v9PYod0uXKIoVNbnn+2phuv3Ab/NUL4IUvbwuC2r4Dzy1NN6bRTMuPQ
Dx8ih5saiGL4BI1zyoK/Y4qOFkC02nrcdS2XQXgNokq7eCKKD003kovRePJKPYkH
vR62sVOkJ3HOIpxynP9niujGGmyUfBRDoK8QwA56yhkzHGPIMs3e0ePq3h2V7DEs
/35fxr0fhmLZVS9hKsu2ZZmUX2BU1FQOB6hK4sVweImG5XBIe1ZxJ/tlkNE/3bL5
OFquealXrX+xuwSuqRkALHLDZiNjdafW+n0QeJY2CrxHK1LWvK775kuH8rKYLJ4l
jDL1sviLAYxpgSYiFOr1+4d6WcwoIJ9QNauY5+eleE+VNNj1mUauuosDS+fArHUa
bE12oNeU1umE3lg5sw7S0jyJOFQhi+eBpSpBMaFWx9abUtX7HbRxy+fAad4T4f7a
SfvMOJPeekRB8smabLPgmqz83P3kkzdHtRj3vQUcsWWTU4qI9Ua1ANw6HER/btBE
usvNb/fEm/GDXs7lqVe2OasML7IkawuaTIa/UH1mUOx8Ar/R58WEoNlaG2bD6WVa
G3Q4MgF1J9wdHWYd9Hsg+zAFhgWys9uSrz/sa1jewTxSXjwxvPE=
=MqEh
-----END PGP SIGNATURE-----

--Sig_/KETfucbCkvM3sCxH.ATKsl=--

