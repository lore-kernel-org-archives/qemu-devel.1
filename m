Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB75AC4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B9C2469D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B9C2469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JHe-0006kA-RN
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j7JDs-0001Rm-EN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j7JDq-0005i1-Jd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:29:04 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51494 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1j7JDq-0005hR-8n
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:29:02 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7C8221A20EA;
 Thu, 27 Feb 2020 14:28:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 54C941A20A0;
 Thu, 27 Feb 2020 14:28:11 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] tests/acceptance: Count multiple Tux logos displayed on
 framebuffer
Date: Thu, 27 Feb 2020 14:27:36 +0100
Message-Id: <1582810056-22646-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Add a test that verifies that each core properly displays the Tux
logo on the framebuffer device.

We simply follow the OpenCV "Template Matching with Multiple Objects"
tutorial, replacing Lionel Messi by Tux:
https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html

When OpenCV and NumPy are installed, this test can be run using:

  $ avocado --show=3Dapp,framebuffer \
    run -t cpu:i6400 \
    tests/acceptance/machine_mips_malta.py
  JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
  JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
   (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_1core:
  framebuffer: found Tux at position (x, y) =3D (0, 0)
  PASS (3.37 s)
   (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_7cores:
  framebuffer: found Tux at position (x, y) =3D (0, 0)
  framebuffer: found Tux at position (x, y) =3D (88, 0)
  framebuffer: found Tux at position (x, y) =3D (176, 0)
  framebuffer: found Tux at position (x, y) =3D (264, 0)
  framebuffer: found Tux at position (x, y) =3D (352, 0)
  framebuffer: found Tux at position (x, y) =3D (440, 0)
  framebuffer: found Tux at position (x, y) =3D (528, 0)
  PASS (5.80 s)
   (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_8cores:
  framebuffer: found Tux at position (x, y) =3D (0, 0)
  framebuffer: found Tux at position (x, y) =3D (88, 0)
  framebuffer: found Tux at position (x, y) =3D (176, 0)
  framebuffer: found Tux at position (x, y) =3D (264, 0)
  framebuffer: found Tux at position (x, y) =3D (352, 0)
  framebuffer: found Tux at position (x, y) =3D (440, 0)
  framebuffer: found Tux at position (x, y) =3D (528, 0)
  framebuffer: found Tux at position (x, y) =3D (616, 0)
  PASS (6.67 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
  JOB TIME   : 16.79 s

If the AVOCADO_CV2_SCREENDUMP_PNG_PATH environment variable is set, the
test will save the screenshot with matched squares to it.

Test inspired by the following post:
https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips64-releas=
e-6-cpu/
Kernel built with the following Docker file:
https://github.com/philmd/qemu-testing-blob/blob/malta_i6400/mips/malta/m=
ips64el/Dockerfile

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200201204751.17810-1-f4bug@amsat.org>
---
 MAINTAINERS                            |   1 +
 tests/acceptance/machine_mips_malta.py | 118 +++++++++++++++++++++++++++=
++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tests/acceptance/machine_mips_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index b084201..880da9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1005,6 +1005,7 @@ F: hw/mips/mips_malta.c
 F: hw/mips/gt64xxx_pci.c
 F: include/hw/southbridge/piix.h
 F: tests/acceptance/linux_ssh_mips_malta.py
+F: tests/acceptance/machine_mips_malta.py
=20
 Mipssim
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/ma=
chine_mips_malta.py
new file mode 100644
index 0000000..92b4f28
--- /dev/null
+++ b/tests/acceptance/machine_mips_malta.py
@@ -0,0 +1,118 @@
+# Functional tests for the MIPS Malta board
+#
+# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import gzip
+import logging
+
+from avocado import skipUnless
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import archive
+
+
+NUMPY_AVAILABLE =3D True
+try:
+    import numpy as np
+except ImportError:
+    NUMPY_AVAILABLE =3D False
+
+CV2_AVAILABLE =3D True
+try:
+    import cv2
+except ImportError:
+    CV2_AVAILABLE =3D False
+
+
+@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
+class MaltaMachineFramebuffer(Test):
+
+    timeout =3D 30
+
+    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
+
+    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
+        """
+        Boot Linux kernel and check Tux logo is displayed on the framebu=
ffer.
+        """
+        screendump_path =3D os.path.join(self.workdir, 'screendump.pbm')
+
+        kernel_url =3D ('https://github.com/philmd/qemu-testing-blob/raw=
/'
+                      'a5966ca4b5/mips/malta/mips64el/'
+                      'vmlinux-4.7.0-rc1.I6400.gz')
+        kernel_hash =3D '096f50c377ec5072e6a366943324622c312045f6'
+        kernel_path_gz =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
+        kernel_path =3D self.workdir + "vmlinux"
+        archive.gzip_uncompress(kernel_path_gz, kernel_path)
+
+        tuxlogo_url =3D ('https://github.com/torvalds/linux/raw/v2.6.12/=
'
+                       'drivers/video/logo/logo_linux_vga16.ppm')
+        tuxlogo_hash =3D '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
+        tuxlogo_path =3D self.fetch_asset(tuxlogo_url, asset_hash=3Dtuxl=
ogo_hash)
+
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
+                               'clocksource=3DGIC console=3Dtty0 console=
=3DttyS0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-cpu', 'I6400',
+                         '-smp', '%u' % cpu_cores_count,
+                         '-vga', 'std',
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        framebuffer_ready =3D 'Console: switching to colour frame buffer=
 device'
+        wait_for_console_pattern(self, framebuffer_ready,
+                                 failure_message=3D'Kernel panic - not s=
yncing')
+        self.vm.command('human-monitor-command', command_line=3D'stop')
+        self.vm.command('human-monitor-command',
+                        command_line=3D'screendump %s' % screendump_path=
)
+        logger =3D logging.getLogger('framebuffer')
+
+        match_threshold =3D 0.95
+        screendump_bgr =3D cv2.imread(screendump_path, cv2.IMREAD_COLOR)
+        tuxlogo_bgr =3D cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
+        result =3D cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
+                                   cv2.TM_CCOEFF_NORMED)
+        loc =3D np.where(result >=3D match_threshold)
+        tuxlogo_count =3D 0
+        h, w =3D tuxlogo_bgr.shape[:2]
+        debug_png =3D os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
+        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=3D1):
+            logger.debug('found Tux at position (x, y) =3D %s', pt)
+            cv2.rectangle(screendump_bgr, pt,
+                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
+        if debug_png:
+            cv2.imwrite(debug_png, screendump_bgr)
+        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
+
+    def test_mips_malta_i6400_framebuffer_logo_1core(self):
+        """
+        :avocado: tags=3Darch:mips64el
+        :avocado: tags=3Dmachine:malta
+        :avocado: tags=3Dcpu:i6400
+        """
+        self.do_test_i6400_framebuffer_logo(1)
+
+    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
+        """
+        :avocado: tags=3Darch:mips64el
+        :avocado: tags=3Dmachine:malta
+        :avocado: tags=3Dcpu:i6400
+        :avocado: tags=3Dmips:smp
+        """
+        self.do_test_i6400_framebuffer_logo(7)
+
+    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
+        """
+        :avocado: tags=3Darch:mips64el
+        :avocado: tags=3Dmachine:malta
+        :avocado: tags=3Dcpu:i6400
+        :avocado: tags=3Dmips:smp
+        """
+        self.do_test_i6400_framebuffer_logo(8)
--=20
2.7.4


