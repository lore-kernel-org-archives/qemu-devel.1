Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7885FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415C42146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415C42146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCqrb-0002ML-0o
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 15:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCqkY-0005GF-Ok
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCqkV-0004Xm-O6
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCqkV-0004UA-BN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41B218980FB;
 Tue, 24 Sep 2019 19:45:22 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-0.rdu2.redhat.com
 [10.10.121.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 087B461F21;
 Tue, 24 Sep 2019 19:45:20 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] Acceptance Tests: use avocado tags for machine type
Date: Tue, 24 Sep 2019 15:45:01 -0400
Message-Id: <20190924194501.9303-4-crosa@redhat.com>
In-Reply-To: <20190924194501.9303-1-crosa@redhat.com>
References: <20190924194501.9303-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 24 Sep 2019 19:45:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The same way the arch tag is being used as a fallback for the arch
parameter, let's do the same for QEMU's machine and avoid some boiler
plate code.

This requires a bump in the Avocado version, as starting with 72.0,
the characters supported in tags are less strict.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst                     | 18 ++++++++
 tests/acceptance/avocado_qemu/__init__.py  |  5 ++
 tests/acceptance/boot_linux_console.py     | 15 +-----
 tests/acceptance/cpu_queries.py            |  2 +-
 tests/acceptance/linux_initrd.py           |  2 +-
 tests/acceptance/linux_ssh_mips_malta.py   |  5 --
 tests/acceptance/machine_m68k_nextcube.py  | 21 ++-------
 tests/acceptance/x86_cpu_model_versions.py | 53 ++++++++++++++++------
 8 files changed, 71 insertions(+), 50 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bf75675fb0..1816ada919 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -744,6 +744,17 @@ name.  If one is not given explicitly, it will eithe=
r be set to
 ``None``, or, if the test is tagged with one (and only one)
 ``:avocado: tags=3Darch:VALUE`` tag, it will be set to ``VALUE``.
=20
+machine
+~~~~~~~
+
+The machine type that will be set to all QEMUMachine instances created
+by the test.
+
+The ``machine`` attribute will be set to the test parameter of the same
+name.  If one is not given explicitly, it will either be set to
+``None``, or, if the test is tagged with one (and only one)
+``:avocado: tags=3Dmachine:VALUE`` tag, it will be set to ``VALUE``.
+
 qemu_bin
 ~~~~~~~~
=20
@@ -779,6 +790,13 @@ architecture of a kernel or disk image to boot a VM =
with.
 This parameter has a direct relation with the ``arch`` attribute.  If
 not given, it will default to None.
=20
+machine
+~~~~~~~
+
+The machine type that will be set to all QEMUMachine instances created
+by the test.
+
+
 qemu_bin
 ~~~~~~~~
=20
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 02775bafcf..fb5d6616bc 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -69,6 +69,9 @@ class Test(avocado.Test):
         self.arch =3D self.params.get('arch',
                                     default=3Dself._get_unique_tag_val('=
arch'))
=20
+        self.machine =3D self.params.get('machine',
+                                       default=3Dself._get_unique_tag_va=
l('machine'))
+
         default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Ddefault_qemu_bin)
@@ -90,6 +93,8 @@ class Test(avocado.Test):
             name =3D str(uuid.uuid4())
         if self._vms.get(name) is None:
             self._vms[name] =3D self._new_vm(*args)
+            if self.machine is not None:
+                self._vms[name].set_machine(self.machine)
         return self._vms[name]
=20
     def tearDown(self):
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 8a9a314ab4..3d2a53d4c8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -82,7 +82,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
-        self.vm.set_machine('pc')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
         self.vm.add_args('-kernel', kernel_path,
@@ -105,7 +104,6 @@ class BootLinuxConsole(Test):
         kernel_path =3D self.extract_from_deb(deb_path,
                                             '/boot/vmlinux-2.6.32-5-4kc-=
malta')
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
         self.vm.add_args('-kernel', kernel_path,
@@ -138,7 +136,6 @@ class BootLinuxConsole(Test):
         kernel_path =3D self.extract_from_deb(deb_path,
                                             '/boot/vmlinux-2.6.32-5-5kc-=
malta')
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
         self.vm.add_args('-kernel', kernel_path,
@@ -171,7 +168,6 @@ class BootLinuxConsole(Test):
             with open(initrd_path, 'wb') as f_out:
                 shutil.copyfileobj(f_in, f_out)
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
                                + 'console=3DttyS0 console=3Dtty '
@@ -197,7 +193,6 @@ class BootLinuxConsole(Test):
             with open(kernel_path, 'wb') as f_out:
                 shutil.copyfileobj(f_in, f_out)
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
                                + 'mem=3D256m@@0x0 '
@@ -257,7 +252,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D '8c73e469fc6ea06a58dc83a628fc695b693b8493'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
-        self.vm.set_machine('virt')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=3DttyAMA0')
@@ -279,7 +273,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
-        self.vm.set_machine('virt')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=3DttyAMA0')
@@ -292,7 +285,7 @@ class BootLinuxConsole(Test):
     def test_arm_emcraft_sf2(self):
         """
         :avocado: tags=3Darch:arm
-        :avocado: tags=3Dmachine:emcraft_sf2
+        :avocado: tags=3Dmachine:emcraft-sf2
         :avocado: tags=3Dendian:little
         """
         uboot_url =3D ('https://raw.githubusercontent.com/'
@@ -306,7 +299,6 @@ class BootLinuxConsole(Test):
         spi_hash =3D '85f698329d38de63aea6e884a86fbde70890a78a'
         spi_path =3D self.fetch_asset(spi_url, asset_hash=3Dspi_hash)
=20
-        self.vm.set_machine('emcraft-sf2')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE
         self.vm.add_args('-kernel', uboot_path,
@@ -319,7 +311,7 @@ class BootLinuxConsole(Test):
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=3Darch:s390x
-        :avocado: tags=3Dmachine:s390_ccw_virtio
+        :avocado: tags=3Dmachine:s390-ccw-virtio
         """
         kernel_url =3D ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/s390x/os=
/images'
@@ -327,7 +319,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D 'e8e8439103ef8053418ef062644ffd46a7919313'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
-        self.vm.set_machine('s390-ccw-virtio')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3Dsclp0'
         self.vm.add_args('-nodefaults',
@@ -349,7 +340,6 @@ class BootLinuxConsole(Test):
=20
         uncompressed_kernel =3D archive.uncompress(kernel_path, self.wor=
kdir)
=20
-        self.vm.set_machine('clipper')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
         self.vm.add_args('-vga', 'std',
@@ -370,7 +360,6 @@ class BootLinuxConsole(Test):
         kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc77'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
-        self.vm.set_machine('pseries')
         self.vm.set_console()
         kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3Dhvc0'
         self.vm.add_args('-kernel', kernel_path,
diff --git a/tests/acceptance/cpu_queries.py b/tests/acceptance/cpu_queri=
es.py
index af47d2795a..293dccb89a 100644
--- a/tests/acceptance/cpu_queries.py
+++ b/tests/acceptance/cpu_queries.py
@@ -20,8 +20,8 @@ class QueryCPUModelExpansion(Test):
     def test(self):
         """
         :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Dmachine:none
         """
-        self.vm.set_machine('none')
         self.vm.add_args('-S')
         self.vm.launch()
=20
diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_in=
itrd.py
index c61d9826a4..3a0ff7b098 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -20,6 +20,7 @@ class LinuxInitrd(Test):
     Checks QEMU evaluates correctly the initrd file passed as -initrd op=
tion.
=20
     :avocado: tags=3Darch:x86_64
+    :avocado: tags=3Dmachine:pc
     """
=20
     timeout =3D 300
@@ -66,7 +67,6 @@ class LinuxInitrd(Test):
             initrd.write(b'\0')
             initrd.flush()
=20
-            self.vm.set_machine('pc')
             self.vm.set_console()
             kernel_command_line =3D 'console=3DttyS0'
             self.vm.add_args('-kernel', kernel_path,
diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index 25a1df5098..e40a57de51 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -95,7 +95,6 @@ class LinuxSSH(Test):
         image_hash =3D self.IMAGE_INFO[endianess]['image_hash']
         image_path =3D self.fetch_asset(image_url, asset_hash=3Dimage_ha=
sh)
=20
-        self.vm.set_machine('malta')
         self.vm.set_console()
         kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
                                + 'console=3DttyS0 root=3D/dev/sda1')
@@ -199,7 +198,6 @@ class LinuxSSH(Test):
     def test_mips_malta32eb_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mips
-        :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:big
         :avocado: tags=3Ddevice:pcnet32
         """
@@ -213,7 +211,6 @@ class LinuxSSH(Test):
     def test_mips_malta32el_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mipsel
-        :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:little
         :avocado: tags=3Ddevice:pcnet32
         """
@@ -227,7 +224,6 @@ class LinuxSSH(Test):
     def test_mips_malta64eb_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mips64
-        :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:big
         :avocado: tags=3Ddevice:pcnet32
         """
@@ -240,7 +236,6 @@ class LinuxSSH(Test):
     def test_mips_malta64el_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mips64el
-        :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:little
         :avocado: tags=3Ddevice:pcnet32
         """
diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance=
/machine_m68k_nextcube.py
index fcd2c58ee7..32cf571f94 100644
--- a/tests/acceptance/machine_m68k_nextcube.py
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -43,6 +43,11 @@ def tesseract_available(expected_version):
=20
=20
 class NextCubeMachine(Test):
+    """
+    :avocado: tags=3Darch:m68k
+    :avocado: tags=3Dmachine:next-cube
+    :avocado: tags=3Ddevice:framebuffer
+    """
=20
     timeout =3D 15
=20
@@ -52,7 +57,6 @@ class NextCubeMachine(Test):
         rom_hash =3D 'b3534796abae238a0111299fc406a9349f7fee24'
         rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
=20
-        self.vm.set_machine('next-cube')
         self.vm.add_args('-bios', rom_path)
         self.vm.launch()
=20
@@ -66,11 +70,6 @@ class NextCubeMachine(Test):
=20
     @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
     def test_bootrom_framebuffer_size(self):
-        """
-        :avocado: tags=3Darch:m68k
-        :avocado: tags=3Dmachine:next_cube
-        :avocado: tags=3Ddevice:framebuffer
-        """
         screenshot_path =3D os.path.join(self.workdir, "dump.png")
         self.check_bootrom_framebuffer(screenshot_path)
=20
@@ -80,11 +79,6 @@ class NextCubeMachine(Test):
=20
     @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not avail=
able')
     def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
-        """
-        :avocado: tags=3Darch:m68k
-        :avocado: tags=3Dmachine:next_cube
-        :avocado: tags=3Ddevice:framebuffer
-        """
         screenshot_path =3D os.path.join(self.workdir, "dump.png")
         self.check_bootrom_framebuffer(screenshot_path)
=20
@@ -101,11 +95,6 @@ class NextCubeMachine(Test):
     # that it is still alpha-level software.
     @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not avail=
able')
     def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
-        """
-        :avocado: tags=3Darch:m68k
-        :avocado: tags=3Dmachine:next_cube
-        :avocado: tags=3Ddevice:framebuffer
-        """
         screenshot_path =3D os.path.join(self.workdir, "dump.png")
         self.check_bootrom_framebuffer(screenshot_path)
=20
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
index 6eb977954d..90558d9a71 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -75,12 +75,15 @@ class X86CPUModelAliases(avocado_qemu.Test):
                          "EPYC-IBPB shouldn't be versioned")
=20
     def test_4_0_alias_compatibility(self):
-        """Check if pc-*-4.0 unversioned CPU model won't be reported as =
aliases"""
+        """
+        Check if pc-*-4.0 unversioned CPU model won't be reported as ali=
ases
+
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         # pc-*-4.0 won't expose non-versioned CPU models as aliases
         # We do this to help management software to keep compatibility
         # with older QEMU versions that didn't have the versioned CPU mo=
del
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.launch()
         cpus =3D dict((m['name'], m) for m in self.vm.command('query-cpu=
-definitions'))
=20
@@ -105,9 +108,12 @@ class X86CPUModelAliases(avocado_qemu.Test):
             self.assertNotIn('alias-of', c, "%s shouldn't be an alias" %=
 (name))
=20
     def test_4_1_alias(self):
-        """Check if unversioned CPU model is an alias pointing to right =
version"""
+        """
+        Check if unversioned CPU model is an alias pointing to right ver=
sion
+
+        :avocado: tags=3Dmachine:pc-i440fx-4.1
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.1')
         self.vm.launch()
=20
         cpus =3D dict((m['name'], m) for m in self.vm.command('query-cpu=
-definitions'))
@@ -207,9 +213,12 @@ class X86CPUModelAliases(avocado_qemu.Test):
         self.validate_aliases(cpus)
=20
     def test_none_alias(self):
-        """Check if unversioned CPU model is an alias pointing to some v=
ersion"""
+        """
+        Check if unversioned CPU model is an alias pointing to some vers=
ion
+
+        :avocado: tags=3Dmachine:none
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('none')
         self.vm.launch()
=20
         cpus =3D dict((m['name'], m) for m in self.vm.command('query-cpu=
-definitions'))
@@ -242,68 +251,84 @@ class CascadelakeArchCapabilities(avocado_qemu.Test=
):
         return self.vm.command('qom-get', path=3Dcpu_path, property=3Dpr=
op)
=20
     def test_4_1(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.1
+        """
         # machine-type only:
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server should not =
have arch-capabilities')
=20
     def test_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server should not =
have arch-capabilities')
=20
     def test_set_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         # command line must override machine-type if CPU model is not ve=
rsioned:
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff,+arch-capabilities')
         self.vm.launch()
         self.assertTrue(self.get_cpu_prop('arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabi=
lities should have arch-capabilities')
=20
     def test_unset_4_1(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.1
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff,-arch-capabilities')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server,-arch-capab=
ilities should not have arch-capabilities')
=20
     def test_v1_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         # versioned CPU model overrides machine-type:
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=
=3Don,check=3Doff,enforce=3Doff')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server-v1 should n=
ot have arch-capabilities')
=20
     def test_v2_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=
=3Don,check=3Doff,enforce=3Doff')
         self.vm.launch()
         self.assertTrue(self.get_cpu_prop('arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server-v2 should ha=
ve arch-capabilities')
=20
     def test_v1_set_4_0(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.0
+        """
         # command line must override machine-type and versioned CPU mode=
l:
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.0')
         self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=
=3Don,check=3Doff,enforce=3Doff,+arch-capabilities')
         self.vm.launch()
         self.assertTrue(self.get_cpu_prop('arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-cap=
abilities should have arch-capabilities')
=20
     def test_v2_unset_4_1(self):
+        """
+        :avocado: tags=3Dmachine:pc-i440fx-4.1
+        """
         self.vm.add_args('-S')
-        self.vm.set_machine('pc-i440fx-4.1')
         self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=
=3Don,check=3Doff,enforce=3Doff,-arch-capabilities')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
--=20
2.21.0


