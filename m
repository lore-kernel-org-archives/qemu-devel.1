Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985E5C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F382173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F382173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQr1-0001bb-8h
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hbPSA-0003QM-SZ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hbPS9-0006AY-2y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hbPS8-00069a-MD
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:07:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA9BE2EED37;
 Thu, 13 Jun 2019 13:07:33 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EECA8452B;
 Thu, 13 Jun 2019 13:07:31 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 09:07:16 -0400
Message-Id: <20190613130718.3763-3-crosa@redhat.com>
In-Reply-To: <20190613130718.3763-1-crosa@redhat.com>
References: <20190613130718.3763-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 13 Jun 2019 13:07:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] tests/vm: avoid image presence check and
 removal
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

Python's os.rename() will silently replace an existing file,
so there's no need for the extra check and removal.

Reference: https://docs.python.org/3/library/os.html#os.rename
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/vm/centos      | 2 --
 tests/vm/freebsd     | 2 --
 tests/vm/netbsd      | 2 --
 tests/vm/openbsd     | 2 --
 tests/vm/ubuntu.i386 | 2 --
 5 files changed, 10 deletions(-)

diff --git a/tests/vm/centos b/tests/vm/centos
index 466fa59fec..3ee7ca780e 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -77,8 +77,6 @@ class CentosVM(basevm.BaseVM):
         self.ssh_root_check("systemctl enable docker")
         self.ssh_root("poweroff")
         self.wait()
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
         return 0
=20
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 5575c23a6f..091be1a065 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -36,8 +36,6 @@ class FreeBSDVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
=20
 if __name__ =3D=3D "__main__":
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index d0508f4465..ee9eaeab50 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -36,8 +36,6 @@ class NetBSDVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
=20
 if __name__ =3D=3D "__main__":
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 87ec982489..28c7d25e29 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -38,8 +38,6 @@ class OpenBSDVM(basevm.BaseVM):
         sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["ln", "-f", cimg, img_tmp_xz])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
=20
 if __name__ =3D=3D "__main__":
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index a22d137e76..12867b193f 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -80,8 +80,6 @@ class UbuntuX86VM(basevm.BaseVM):
         self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
         self.ssh_root("poweroff")
         self.wait()
-        if os.path.exists(img):
-            os.remove(img)
         os.rename(img_tmp, img)
         return 0
=20
--=20
2.21.0


