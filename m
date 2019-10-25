Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A01BCA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E42D2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E42D2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2zv-0000rb-EK
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2ik-0005Bx-HJ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2ii-0002Ms-Ij
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:50 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34492 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iO2ii-0002Fx-6a
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:48 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 4C0871A228C;
 Fri, 25 Oct 2019 18:44:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1742E1A2282;
 Fri, 25 Oct 2019 18:44:30 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] tests/ssh_linux_malta: Refactor how to get image/kernel
 info
Date: Fri, 25 Oct 2019 18:44:21 +0200
Message-Id: <1572021862-28273-20-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The qcow and kernel images use a similar pattern regarding they
are for big/little endianess, or 32/64 bit.
Refactor using more dictionary keys.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20191019153437.9820-11-f4bug@amsat.org>
---
 tests/acceptance/linux_ssh_mips_malta.py | 75 +++++++++++++++++++-------=
------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index b19598e..14b8a5b 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -25,15 +25,44 @@ class LinuxSSH(Test):
     KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
     VM_IP =3D '127.0.0.1'
=20
+    BASE_URL =3D 'https://people.debian.org/~aurel32/qemu/'
     IMAGE_INFO =3D {
-        'be': {'image_url': ('https://people.debian.org/~aurel32/qemu/mi=
ps/'
-                             'debian_wheezy_mips_standard.qcow2'),
-               'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5'}=
,
-        'le': {'image_url': ('https://people.debian.org/~aurel32/qemu/mi=
psel/'
-                             'debian_wheezy_mipsel_standard.qcow2'),
-               'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802'}
+        'be': {'base_url': 'mips',
+               'image_name': 'debian_wheezy_mips_standard.qcow2',
+               'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5',
+               'kernel_hash': {
+                   32: '592e384a4edc16dade52a6cd5c785c637bcbc9ad',
+                   64: 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'}
+              },
+        'le': {'base_url': 'mipsel',
+               'image_name': 'debian_wheezy_mipsel_standard.qcow2',
+               'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802',
+               'kernel_hash': {
+                   32: 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a',
+                   64: '6a7f77245acf231415a0e8b725d91ed2f3487794'}
+              }
         }
+    CPU_INFO =3D {
+        32: {'kernel_release': '3.2.0-4-4kc-malta'},
+        64: {'kernel_release': '3.2.0-4-5kc-malta'}
+        }
+
+    def get_url(self, endianess, path=3D''):
+        qkey =3D {'le': 'el', 'be': ''}
+        return '%s/mips%s/%s' % (self.BASE_URL, qkey[endianess], path)
+
+    def get_image_info(self, endianess):
+        dinfo =3D self.IMAGE_INFO[endianess]
+        image_url =3D self.get_url(endianess, dinfo['image_name'])
+        image_hash =3D dinfo['image_hash']
+        return (image_url, image_hash)
=20
+    def get_kernel_info(self, endianess, wordsize):
+        minfo =3D self.CPU_INFO[wordsize]
+        kernel_url =3D self.get_url(endianess,
+                                  'vmlinux-%s' % minfo['kernel_release']=
)
+        kernel_hash =3D self.IMAGE_INFO[endianess]['kernel_hash'][wordsi=
ze]
+        return kernel_url, kernel_hash
=20
     @skipUnless(ssh.SSH_CLIENT_BINARY, 'No SSH client available')
     @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
@@ -91,8 +120,7 @@ class LinuxSSH(Test):
         return stdout_lines, stderr_lines
=20
     def boot_debian_wheezy_image_and_ssh_login(self, endianess, kernel_p=
ath):
-        image_url =3D self.IMAGE_INFO[endianess]['image_url']
-        image_hash =3D self.IMAGE_INFO[endianess]['image_hash']
+        image_url, image_hash =3D self.get_image_info(endianess)
         image_path =3D self.fetch_asset(image_url, asset_hash=3Dimage_ha=
sh)
=20
         self.vm.set_machine('malta')
@@ -184,7 +212,10 @@ class LinuxSSH(Test):
             'md5sum /dev/mtd2ro',
             '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
=20
-    def check_mips_malta(self, endianess, kernel_path, uname_m):
+    def check_mips_malta(self, uname_m, endianess):
+        wordsize =3D 64 if '64' in uname_m else 32
+        kernel_url, kernel_hash =3D self.get_kernel_info(endianess, word=
size)
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
         self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_pa=
th)
=20
         stdout, _ =3D self.ssh_command('uname -a')
@@ -200,12 +231,7 @@ class LinuxSSH(Test):
         :avocado: tags=3Dendian:big
         :avocado: tags=3Ddevice:pcnet32
         """
-        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mips/'
-                      'vmlinux-3.2.0-4-4kc-malta')
-        kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
-        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
-
-        self.check_mips_malta('be', kernel_path, 'mips')
+        self.check_mips_malta('mips', 'be')
=20
     def test_mips_malta32el_kernel3_2_0(self):
         """
@@ -214,12 +240,7 @@ class LinuxSSH(Test):
         :avocado: tags=3Dendian:little
         :avocado: tags=3Ddevice:pcnet32
         """
-        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mipsel/=
'
-                      'vmlinux-3.2.0-4-4kc-malta')
-        kernel_hash =3D 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
-        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
-
-        self.check_mips_malta('le', kernel_path, 'mips')
+        self.check_mips_malta('mips', 'le')
=20
     def test_mips_malta64eb_kernel3_2_0(self):
         """
@@ -228,11 +249,7 @@ class LinuxSSH(Test):
         :avocado: tags=3Dendian:big
         :avocado: tags=3Ddevice:pcnet32
         """
-        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mips/'
-                      'vmlinux-3.2.0-4-5kc-malta')
-        kernel_hash =3D 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
-        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
-        self.check_mips_malta('be', kernel_path, 'mips64')
+        self.check_mips_malta('mips64', 'be')
=20
     def test_mips_malta64el_kernel3_2_0(self):
         """
@@ -241,8 +258,4 @@ class LinuxSSH(Test):
         :avocado: tags=3Dendian:little
         :avocado: tags=3Ddevice:pcnet32
         """
-        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mipsel/=
'
-                      'vmlinux-3.2.0-4-5kc-malta')
-        kernel_hash =3D '6a7f77245acf231415a0e8b725d91ed2f3487794'
-        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
-        self.check_mips_malta('le', kernel_path, 'mips64')
+        self.check_mips_malta('mips64', 'le')
--=20
2.7.4


