Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35251C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAED820851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAED820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQks-0005yb-Ge
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hbPSD-0003RK-B5
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hbPSB-0006CW-5c
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hbPSA-0006BH-Rs
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:07:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B054B7E42A;
 Thu, 13 Jun 2019 13:07:35 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E045F2B442;
 Thu, 13 Jun 2019 13:07:33 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 09:07:17 -0400
Message-Id: <20190613130718.3763-4-crosa@redhat.com>
In-Reply-To: <20190613130718.3763-1-crosa@redhat.com>
References: <20190613130718.3763-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 13 Jun 2019 13:07:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] tests/vm: pin ubuntu.i386 image
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's a good practice to always have the same components used in tests.
According to:

   https://cloud-images.ubuntu.com/releases/16.04/

New images are released from time to time, and the "release/"
directory points to the latest release.  Let's pin to the latest
available version, and while at it, set a hash for verification.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/vm/ubuntu.i386 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 12867b193f..7017e6d388 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -61,7 +61,9 @@ class UbuntuX86VM(basevm.BaseVM):
         return os.path.join(cidir, "cloud-init.iso")
=20
     def build_image(self, img):
-        cimg =3D self._download_with_cache("https://cloud-images.ubuntu.=
com/releases/16.04/release/ubuntu-16.04-server-cloudimg-i386-disk1.img")
+        cimg =3D self._download_with_cache(
+            "https://cloud-images.ubuntu.com/releases/16.04/release-2019=
0605/ubuntu-16.04-server-cloudimg-i386-disk1.img",
+            sha256sum=3D"e30091144c73483822b7c27193e9d47346dd1064229da57=
7c3fedcf943f7cfcc")
         img_tmp =3D img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
--=20
2.21.0


