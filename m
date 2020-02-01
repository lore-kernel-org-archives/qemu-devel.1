Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB0C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 20:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB70020643
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 20:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDPwS03x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB70020643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixzhG-0003QY-0G
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 15:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixzgM-0002M9-6t
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 15:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixzgK-0008Tu-BT
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 15:47:58 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixzgK-0008TX-4y; Sat, 01 Feb 2020 15:47:56 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so12872661wru.3;
 Sat, 01 Feb 2020 12:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hud7INdUZT7c/8eahZ3nW0dRQfdJJjynyIPKpNRqO2c=;
 b=LDPwS03xB6d2yu1mdJ9hMEib0pyBFvW3AvEloV+8gKBLYP27DTrxBQS5J3fXgzKUuU
 tP1ulqJJmliDeLu4F1h/4u5OTB1i00yCiyZ0Gu1D1rHolc47Y09mdyLpLVxZgtTDOzQ2
 /zCoPfSJV5XQNrwi/m7JckJ1hjroWrTlsEGsLQ4yirg0EP2Lc5bMP65LuSQEt0OQQfhV
 ld+7u0lOLsOZu65vxaY48Gf0Nwrt9ti4yhWN96EfX/qth8ECL44h7kNMoKEefYy1zT97
 nlhNvOwP+Aam7ixFRd8kXn6PsANRPMcDc0LMDSugX2yPy59lNtMIrbhgma/E+9+V89PE
 6K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Hud7INdUZT7c/8eahZ3nW0dRQfdJJjynyIPKpNRqO2c=;
 b=JhPqRyCSIbLNS0yiQnbDpAwmsRmNzQMx3l1Naa0xH/mxfRWHpXAyjLFu8knMQpuDYJ
 jzIZ9lzibBjNRKxlxsrgUVGroysDEAxYoXJWwjJ/njVDYStvQBoVipdpxTcFAVRyyn4v
 tw1pyXpDzcRqiF+p6sSBaIpQYi5ZfAJ6+OApKyrPTucitCFrlyhnQZDD0CtYJu+seRZc
 l5hpGKHqRYNkXcR2SXYDfILadoNISAQg5XVHzLPoiUvSkSy0v8FkqwYcRy1XlesMPCQe
 QkavLtg9P9mgzJBqvTtT89i+nT4b++SdT0Xx5Tmj+ZMeJSFqcFoHkoXiSdnLdQ8a/Erl
 733Q==
X-Gm-Message-State: APjAAAW8UJBG3wfLUENTZvDm02RvCe18hFniUcgNQOg6EMP8nktFb4rp
 +HB2Fs/ox5hDttzHG9EO1rDmSzzS
X-Google-Smtp-Source: APXvYqzZpnY6fT/w8j7H6IaT8t6tYEVJBNO4D7tmQPvxCmjnCJqx0vsptivAAWcxULiaaruNOHqNsw==
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr4896900wrq.415.1580590074779; 
 Sat, 01 Feb 2020 12:47:54 -0800 (PST)
Received: from localhost.localdomain (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id g21sm16576143wmh.17.2020.02.01.12.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 12:47:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance: Count multiple Tux logos displayed on
 framebuffer
Date: Sat,  1 Feb 2020 21:47:50 +0100
Message-Id: <20200201204751.17810-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Leon Alrae <leon.alrae@imgtec.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test that verifies that each core properly displays the Tux
logo on the framebuffer device.

We simply follow the OpenCV "Template Matching with Multiple Objects"
tutorial, replacing Lionel Messi by Tux:
https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html

When OpenCV and NumPy are installed, this test can be run using:

  $ avocado --show=app,framebuffer \
    run -t cpu:i6400 \
    tests/acceptance/machine_mips_malta.py
  JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
  JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
   (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core:
  framebuffer: found Tux at position (x, y) = (0, 0)
  PASS (3.37 s)
   (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores:
  framebuffer: found Tux at position (x, y) = (0, 0)
  framebuffer: found Tux at position (x, y) = (88, 0)
  framebuffer: found Tux at position (x, y) = (176, 0)
  framebuffer: found Tux at position (x, y) = (264, 0)
  framebuffer: found Tux at position (x, y) = (352, 0)
  framebuffer: found Tux at position (x, y) = (440, 0)
  framebuffer: found Tux at position (x, y) = (528, 0)
  PASS (5.80 s)
   (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores:
  framebuffer: found Tux at position (x, y) = (0, 0)
  framebuffer: found Tux at position (x, y) = (88, 0)
  framebuffer: found Tux at position (x, y) = (176, 0)
  framebuffer: found Tux at position (x, y) = (264, 0)
  framebuffer: found Tux at position (x, y) = (352, 0)
  framebuffer: found Tux at position (x, y) = (440, 0)
  framebuffer: found Tux at position (x, y) = (528, 0)
  framebuffer: found Tux at position (x, y) = (616, 0)
  PASS (6.67 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 16.79 s

If the AVOCADO_CV2_SCREENDUMP_PNG_PATH environment variable is set, the
test will save the screenshot with matched squares to it.

Test inspired by the following post:
https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips64-release-6-cpu/
Kernel built with the following Docker file:
https://github.com/philmd/qemu-testing-blob/blob/malta_i6400/mips/malta/mips64el/Dockerfile

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
The resulting match can be visualised at https://pasteboard.co/ISIj6ZA.png
Generated using:

  $ AVOCADO_CV2_SCREENDUMP_PNG_PATH=/tmp/screendump_matched.png \
    avocado --show=app run -t cpu:i6400 \
    tests/acceptance/machine_mips_malta.py
  JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
  JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
   (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core: PASS (3.37 s)
   (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores: PASS (5.80 s)
   (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores: PASS (6.67 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 16.79 s
---
 MAINTAINERS                            |   1 +
 tests/acceptance/machine_mips_malta.py | 116 +++++++++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 tests/acceptance/machine_mips_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ceb1ad882..65a3dfb564 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -983,6 +983,7 @@ F: hw/mips/mips_malta.c
 F: hw/mips/gt64xxx_pci.c
 F: include/hw/southbridge/piix.h
 F: tests/acceptance/linux_ssh_mips_malta.py
+F: tests/acceptance/machine_mips_malta.py
 
 Mipssim
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
new file mode 100644
index 0000000000..2764143d15
--- /dev/null
+++ b/tests/acceptance/machine_mips_malta.py
@@ -0,0 +1,116 @@
+# Functional tests for the MIPS Malta board
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+NUMPY_AVAILABLE = True
+try:
+    import numpy as np
+except ImportError:
+    NUMPY_AVAILABLE = False
+
+CV2_AVAILABLE = True
+try:
+    import cv2
+except ImportError:
+    CV2_AVAILABLE = False
+
+
+@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
+class MaltaMachineFramebuffer(Test):
+
+    timeout = 30
+
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
+        """
+        Boot Linux kernel and check Tux logo is displayed on the framebuffer.
+        """
+        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
+
+        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
+                      'a5966ca4b5/mips/malta/mips64el/'
+                      'vmlinux-4.7.0-rc1.I6400.gz')
+        kernel_hash = '096f50c377ec5072e6a366943324622c312045f6'
+        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        kernel_path = self.workdir + "vmlinux"
+        archive.gzip_uncompress(kernel_path_gz, kernel_path)
+
+        tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
+                       'drivers/video/logo/logo_linux_vga16.ppm')
+        tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
+        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'clocksource=GIC console=tty0 console=ttyS0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-cpu', 'I6400',
+                         '-smp', '%u' % cpu_cores_count,
+                         '-vga', 'std',
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        framebuffer_ready = 'Console: switching to colour frame buffer device'
+        wait_for_console_pattern(self, framebuffer_ready,
+                                 failure_message='Kernel panic - not syncing')
+        self.vm.command('human-monitor-command', command_line='stop')
+        self.vm.command('human-monitor-command',
+                        command_line='screendump %s' % screendump_path)
+        logger = logging.getLogger('framebuffer')
+
+        match_threshold = 0.95
+        screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)
+        tuxlogo_bgr = cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
+        result = cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
+                                   cv2.TM_CCOEFF_NORMED)
+        loc = np.where(result >= match_threshold)
+        tuxlogo_count = 0
+        h, w = tuxlogo_bgr.shape[:2]
+        debug_png = os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
+        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
+            logger.debug('found Tux at position (x, y) = %s', pt)
+            cv2.rectangle(screendump_bgr, pt,
+                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
+        if debug_png:
+            cv2.imwrite(debug_png, screendump_bgr)
+        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
+
+    def test_mips_malta_i6400_framebuffer_logo_1core(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:malta
+        :avocado: tags=cpu:i6400
+        """
+        self.do_test_i6400_framebuffer_logo(1)
+
+    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:malta
+        :avocado: tags=cpu:i6400
+        """
+        self.do_test_i6400_framebuffer_logo(7)
+
+    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:malta
+        :avocado: tags=cpu:i6400
+        """
+        self.do_test_i6400_framebuffer_logo(8)
-- 
2.21.1


