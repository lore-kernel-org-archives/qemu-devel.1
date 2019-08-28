Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E3EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB9522CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB9522CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34e9-0002gv-KI
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i33Xv-0004o4-O1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i33Xu-0002QY-EY
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:23:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i33Xu-0002PY-2x
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:23:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DA8A3084045;
 Wed, 28 Aug 2019 19:23:53 +0000 (UTC)
Received: from localhost (ovpn-116-60.gru2.redhat.com [10.97.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B23B9100194E;
 Wed, 28 Aug 2019 19:23:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Wed, 28 Aug 2019 16:23:39 -0300
Message-Id: <20190828192340.14025-2-ehabkost@redhat.com>
In-Reply-To: <20190828192340.14025-1-ehabkost@redhat.com>
References: <20190828192340.14025-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 28 Aug 2019 19:23:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/2] BootLinuxSshTest: Only use 'test' for
 unittest.TestCase method names
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

In commit f6e501a28ef9, Eduardo started to use "check_" as a
prefix for methods of similar purpose. Follow this prior art,
since it might become the conventions when writting Avocado
tests.

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190607174953.22342-1-philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/linux_ssh_mips_malta.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index aafb0c39f6..134f10cac3 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -162,7 +162,7 @@ class LinuxSSH(Test):
         self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in line
                              for line in stdout])
=20
-    def do_test_mips_malta(self, endianess, kernel_path, uname_m):
+    def check_mips_malta(self, endianess, kernel_path, uname_m):
         self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_pa=
th)
=20
         stdout, stderr =3D self.ssh_command('uname -a')
@@ -184,7 +184,7 @@ class LinuxSSH(Test):
         kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
-        self.do_test_mips_malta('be', kernel_path, 'mips')
+        self.check_mips_malta('be', kernel_path, 'mips')
=20
     @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_mips_malta32el_kernel3_2_0(self):
@@ -199,7 +199,7 @@ class LinuxSSH(Test):
         kernel_hash =3D 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
-        self.do_test_mips_malta('le', kernel_path, 'mips')
+        self.check_mips_malta('le', kernel_path, 'mips')
=20
     @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_mips_malta64eb_kernel3_2_0(self):
@@ -213,7 +213,7 @@ class LinuxSSH(Test):
                       'vmlinux-3.2.0-4-5kc-malta')
         kernel_hash =3D 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
-        self.do_test_mips_malta('be', kernel_path, 'mips64')
+        self.check_mips_malta('be', kernel_path, 'mips64')
=20
     @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_mips_malta64el_kernel3_2_0(self):
@@ -227,4 +227,4 @@ class LinuxSSH(Test):
                       'vmlinux-3.2.0-4-5kc-malta')
         kernel_hash =3D '6a7f77245acf231415a0e8b725d91ed2f3487794'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
-        self.do_test_mips_malta('le', kernel_path, 'mips64')
+        self.check_mips_malta('le', kernel_path, 'mips64')
--=20
2.21.0


