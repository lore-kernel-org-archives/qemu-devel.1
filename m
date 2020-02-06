Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE5C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB3820658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+LOuK1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB3820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izWCZ-0001VV-Bd
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVou-0001aH-TC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVot-00055W-8i
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:19:04 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVos-0004z4-W4; Wed, 05 Feb 2020 20:19:03 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so5154269wru.3;
 Wed, 05 Feb 2020 17:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wAehENzQCmMVkW/YJV6bnroThHw1HaqNAVBKJsfbRgw=;
 b=e+LOuK1DWEq4Xvc/DBRCvTuT1Z3/F4+qqvLoIdlO5OYwW+1qexs47Xj1rhj4WR+YFe
 av6EFp8eEZqLQLGMW7BJPbaT8QYwCZOxsOHh+8DbEuw4aYFYU/4spN7cs1O+IVyQWUy8
 dbgNrz1XCm9pNae/8J95iFMy+b4mjsKzOXmM7yNyAT+T/Ys+T2LXZH91G0sh5z33rh+v
 hTGzgX7Tys7XzcScRjvpV2GiFs1IxYtpdAIJztfsfh5n6n+qk8FXn6dT2nfxR26X49CH
 UGXa4V/67BZHajmcxw8mDCuzfbAmoMW4uSrRd4kuUqnEeMvXuRMAnrNIhJ+u5+kEGDLM
 1AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wAehENzQCmMVkW/YJV6bnroThHw1HaqNAVBKJsfbRgw=;
 b=on8gIf67d3nSHKOlMHH2foiWLv5dUCmCxGtUphOORXCMG3XGU02zVDEJvjrsmY37ZS
 NQQBQDfQBjLW4PAlnhj3AonATSgSnmnFMVaqXHA3TSCfDCvuhmXrMaDWTihtRTN+HE3D
 I15CZyQsklHnSy5oDa7+8u3mXXW5OJcCOqz2BzhB5dJlOXqZIc2q+niW0Yzunigy1uV3
 Lg5ygpFUGwoPPNDWHpYz+APfW6i3gu+ylPCo/cmyqTM7vHQvIOKZOUuJIyzcOyfbBE6e
 Uezvnz4/m8VJET2tkcvZ9zZdPztIJqBH/pZ2mED/ab6jWAosE0ny+b7WwnbUutiv3pDQ
 xIew==
X-Gm-Message-State: APjAAAXVnn4B5kczsyzLoggjGKpEyaEytleaPgZ/7H+E2kqMSpp37dAu
 MQscBQXlbgwbtCc2ELbg5urA+ifn
X-Google-Smtp-Source: APXvYqyeeZphCWO+llRbh7t0B/o+eJm6cczBsIZGaBRwSOpfkwBeeA93R4j8QDBdS7YTiOlRGCyECQ==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr335378wrm.89.1580951938635;
 Wed, 05 Feb 2020 17:18:58 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/30] tests/acceptance: Count Raspberry Pi logos displayed
 on framebuffer
Date: Thu,  6 Feb 2020 02:17:54 +0100
Message-Id: <20200206011756.2413-29-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test that verifies that each core properly displays the
Raspberry Pi logo on the framebuffer device.

We simply follow the OpenCV "Template Matching with Multiple Objects"
tutorial, replacing Lionel Messi by a raspberrry:
https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html

When OpenCV and NumPy are installed, this test can be run using:

  $ avocado --show=app,framebuffer run -t device:bcm2835-fb tests/acceptance/
  JOB ID     : 9bbbc54c0a6fa180348d0b5305507f76852b4da2
  JOB LOG    : avocado/job-results/job-2020-01-31T23.48-9bbbc54/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2_framebuffer_logo:
  framebuffer: found raspberry at position (x, y) = (0, 0)
  framebuffer: found raspberry at position (x, y) = (71, 0)
  framebuffer: found raspberry at position (x, y) = (142, 0)
  framebuffer: found raspberry at position (x, y) = (213, 0)
  PASS (11.06 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 11.39 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
The resulting match can be visualised at https://pasteboard.co/ISzNHtx.png

Cc: kraxel@redhat.com
---
 tests/acceptance/boot_linux_console.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 7210acd977..33d39d8292 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -12,6 +12,7 @@ import os
 import lzma
 import gzip
 import shutil
+import logging
 
 from avocado import skipUnless
 from avocado_qemu import Test
@@ -21,6 +22,19 @@ from avocado.utils import process
 from avocado.utils import archive
 
 
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
 class BootLinuxConsole(Test):
     """
     Boots a Linux kernel and checks that the console is operational and the
@@ -428,6 +442,54 @@ class BootLinuxConsole(Test):
         """
         self.do_test_arm_raspi(2, 'bcm2835_aux')
 
+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
+    def test_arm_raspi2_framebuffer_logo(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi2
+        :avocado: tags=device:bcm2835-fb
+        """
+        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
+        rpilogo_url = ('https://github.com/raspberrypi/linux/raw/'
+                       'raspberrypi-kernel_1.20190517-1/'
+                       'drivers/video/logo/logo_linux_clut224.ppm')
+        rpilogo_hash = 'fff3cc20c6030acce0953147f9baac43f44ed6b0'
+        rpilogo_path = self.fetch_asset(rpilogo_url, asset_hash=rpilogo_hash)
+        deb_url = ('http://archive.raspberrypi.org/debian/'
+                   'pool/main/r/raspberrypi-firmware/'
+                   'raspberrypi-kernel_1.20190215-1_armhf.deb')
+        deb_hash = 'cd284220b32128c5084037553db3c482426f3972'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,0x3f201000 console=ttyAMA0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        framebuffer_ready = 'Console: switching to colour frame buffer device'
+        wait_for_console_pattern(self, framebuffer_ready)
+        self.vm.command('human-monitor-command', command_line='stop')
+        self.vm.command('human-monitor-command',
+                        command_line='screendump %s' % screendump_path)
+        logger = logging.getLogger('framebuffer')
+
+        cpu_cores_count = 4
+        match_threshold = 0.95
+        screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)
+        rpilogo_bgr = cv2.imread(rpilogo_path, cv2.IMREAD_COLOR)
+        result = cv2.matchTemplate(screendump_bgr, rpilogo_bgr,
+                                   cv2.TM_CCOEFF_NORMED)
+        loc = np.where(result >= match_threshold)
+        rpilogo_count = 0
+        for rpilogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
+            logger.debug('found raspberry at position (x, y) = %s', pt)
+        self.assertGreaterEqual(rpilogo_count, cpu_cores_count)
+
     def test_arm_exynos4210_initrd(self):
         """
         :avocado: tags=arch:arm
-- 
2.21.1


