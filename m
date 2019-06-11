Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA6C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2A3206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2A3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33310 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hakdP-0004Sz-8j
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 13:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hakNE-00007C-1W
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 13:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hakNB-0004oz-M8
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 13:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hakN9-0004le-Jb
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 13:15:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00B9781123;
 Tue, 11 Jun 2019 17:15:45 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F10C5C28F;
 Tue, 11 Jun 2019 17:15:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Tue, 11 Jun 2019 14:14:55 -0300
Message-Id: <20190611171456.23444-6-ehabkost@redhat.com>
In-Reply-To: <20190611171456.23444-1-ehabkost@redhat.com>
References: <20190611171456.23444-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 11 Jun 2019 17:15:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/6] BootLinuxConsoleTest: Run kerneltests
 BusyBox on Malta
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This tests boots a Linux kernel on a Malta machine up to a
busybox shell on the serial console. Few commands are executed
before halting the machine (via reboot).

We use the initrd cpio image from the kerneltests project:
https://kerneltests.org/

If MIPS is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:mips" tags.

Alternatively, this test can be run using:

  $ avocado --show=3Dconsole run -t arch:mips tests/acceptance/boot_linux=
_console.py
  [...]
  console: Boot successful.
  [...]
  console: / # uname -a
  console: Linux buildroot 4.5.0-2-4kc-malta #1 Debian 4.5.5-1 (2016-05-2=
9) mips GNU/Linux
  console: / # reboot
  console: / # reboot: Restarting system

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20190520231910.12184-4-f4bug@amsat.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 5d8380a23b..32159503e9 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -11,6 +11,7 @@
 import os
 import logging
 import lzma
+import gzip
 import shutil
=20
 from avocado_qemu import Test
@@ -49,6 +50,11 @@ class BootLinuxConsole(Test):
                 fail =3D 'Failure message found in console: %s' % failur=
e_message
                 self.fail(fail)
=20
+    def exec_command_and_wait_for_pattern(self, command, success_message=
):
+        command +=3D '\n'
+        self.vm.console_socket.sendall(command.encode())
+        self.wait_for_console_pattern(success_message)
+
     def extract_from_deb(self, deb, path):
         """
         Extracts a file from a deb package into the test workdir
@@ -140,6 +146,49 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
=20
+    def test_mips_malta_cpio(self):
+        """
+        :avocado: tags=3Darch:mips
+        :avocado: tags=3Dmachine:malta
+        :avocado: tags=3Dendian:big
+        """
+        deb_url =3D ('http://snapshot.debian.org/archive/debian/'
+                   '20160601T041800Z/pool/main/l/linux/'
+                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
+        deb_hash =3D 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
+        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
+        kernel_path =3D self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-4.5.0-2-4kc-m=
alta')
+        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
+                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
+                      'mips/rootfs.cpio.gz')
+        initrd_hash =3D 'bf806e17009360a866bf537f6de66590de349a99'
+        initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Dini=
trd_hash)
+        initrd_path =3D self.workdir + "rootfs.cpio"
+
+        with gzip.open(initrd_path_gz, 'rb') as f_in:
+            with open(initrd_path, 'wb') as f_out:
+                shutil.copyfileobj(f_in, f_out)
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=3DttyS0 console=3Dtty '
+                               + 'rdinit=3D/sbin/init noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
+                                               'BogoMIPS')
+        self.exec_command_and_wait_for_pattern('uname -a',
+                                               'Debian')
+        self.exec_command_and_wait_for_pattern('reboot',
+                                               'reboot: Restarting syste=
m')
+
     def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         kernel_path_xz =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
         kernel_path =3D self.workdir + "kernel"
--=20
2.18.0.rc1.1.g3f1ff2140


