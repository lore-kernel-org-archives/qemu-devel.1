Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF38C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0A0218AC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0A0218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6d4f-0003hD-Qq
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 11:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i6cwT-0003o0-2v
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i6cwR-0007kg-7Z
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:48:00 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i6cwQ-0007jv-TT
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:59 -0400
Received: by mail-wr1-f54.google.com with SMTP id 30so9437694wrk.11
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 08:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3/MAIxhVMjzHPxk6i+ZNE+2r2ZgoAuT7WenvBxcwPkY=;
 b=MJyEucwEEhEh7Et/+RBPSUokCDpTv0/jvoeUhOdSXMElirgr90SoKSzdiKeEnvYgAC
 hB02tXlgAO5pp3lcjlyIQJ0EB18sCyk5xcCUgU0jh02llB+IHJekMCOui3+QDE+sBZet
 G88cYWNKAiuj6xvWIs1UaS87ZaeXMjiIF9FWtjzkPTBGbgyn+rNp7As2/uSXXpVm74fQ
 0ufmTRgf4oGwAnvlo/f+aw7ckNUfbYLK0Oz2p6NkbNLRei9lubCFd3bC3/srFtJlFwXd
 Z8nib4wWAAh4XfUkFjz7CASfdRjTwNHTA1zS0ZZnn6Q2l4APLWmniT8JgmYfCXXoaUL5
 3bEQ==
X-Gm-Message-State: APjAAAVw0yc2DgFR6BkKoawU6aji/PtWA9MCmNVPEMMPGPGSgFUWaRSA
 S17spF6nDrD7tCcXq8uPJm0=
X-Google-Smtp-Source: APXvYqxccI2ATjfH/E3hDu4P8eE+Q+iTrHjMwqSF0ATmzVO/bnmgmM2p7WIb7UPIot53TReApu2MDQ==
X-Received: by 2002:a5d:46c4:: with SMTP id g4mr10825226wrs.189.1567871277815; 
 Sat, 07 Sep 2019 08:47:57 -0700 (PDT)
Received: from thl530.multi.box (pD9E8385F.dip0.t-ipconnect.de.
 [217.232.56.95])
 by smtp.gmail.com with ESMTPSA id s19sm17173418wrb.14.2019.09.07.08.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 08:47:57 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Sat,  7 Sep 2019 17:47:43 +0200
Message-Id: <20190907154744.4136-8-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907154744.4136-1-huth@tuxfamily.org>
References: <20190907154744.4136-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.54
Subject: [Qemu-devel] [PULL 7/8] tests/acceptance: Add test of NeXTcube
 framebuffer using OCR
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add a test of the NeXTcube framebuffer using the Tesseract OCR
engine on a screenshot of the framebuffer device.

The test is very quick:

  $ avocado --show=app,console run tests/acceptance/machine_m68k_nextcube.py
  JOB ID     : 78844a92424cc495bd068c3874d542d1e20f24bc
  JOB LOG    : /home/phil/avocado/job-results/job-2019-08-13T13.16-78844a9/job.log
   (1/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_bootrom_framebuffer_size: PASS (2.16 s)
   (2/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_bootrom_framebuffer_ocr_with_tesseract_v3: -
  ue r pun Honl'ﬂx ; 5‘ 55‘
  avg ncaaaaa 25 MHZ, memary jag m
  Backplane slat «a
  Ethernet address a a r a r3 2
  Memgry sackets aea canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled
  Memgry sackets a and 1 canflqured far 16MB Darlly page made stMs but have 16MB page made stMs )nstalled
  [...]
  Yestlnq the rpu, 5::
  system test raneg Errar egge 51
  Egg: cammand
  Default pggc devlce nut fauna
  NEXY>I
  PASS (2.64 s)
   (3/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_bootrom_framebuffer_ocr_with_tesseract_v4: SKIP: tesseract v4 OCR tool not available
  RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 1 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 5.35 s

Documentation on how to install tesseract:
  https://github.com/tesseract-ocr/tesseract/wiki#installation

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20190813134921.30602-2-philmd@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 tests/acceptance/machine_m68k_nextcube.py | 121 ++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 tests/acceptance/machine_m68k_nextcube.py

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
new file mode 100644
index 0000000000..e09cab9f20
--- /dev/null
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -0,0 +1,121 @@
+# Functional test that boots a VM and run OCR on the framebuffer
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import re
+import time
+import logging
+import distutils.spawn
+
+from avocado_qemu import Test
+from avocado import skipUnless
+from avocado.utils import process
+from avocado.utils.path import find_command, CmdNotFoundError
+
+PIL_AVAILABLE = True
+try:
+    from PIL import Image
+except ImportError:
+    PIL_AVAILABLE = False
+
+
+def tesseract_available(expected_version):
+    try:
+        find_command('tesseract')
+    except CmdNotFoundError:
+        return False
+    res = process.run('tesseract --version')
+    try:
+        version = res.stdout_text.split()[1]
+    except IndexError:
+        version = res.stderr_text.split()[1]
+    return int(version.split('.')[0]) == expected_version
+
+    match = re.match(r'tesseract\s(\d)', res)
+    if match is None:
+        return False
+    # now this is guaranteed to be a digit
+    return int(match.groups()[0]) == expected_version
+
+
+class NextCubeMachine(Test):
+
+    timeout = 15
+
+    def check_bootrom_framebuffer(self, screenshot_path):
+        rom_url = ('http://www.nextcomputers.org/NeXTfiles/Software/ROM_Files/'
+                   '68040_Non-Turbo_Chipset/Rev_2.5_v66.BIN')
+        rom_hash = 'b3534796abae238a0111299fc406a9349f7fee24'
+        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
+
+        self.vm.set_machine('next-cube')
+        self.vm.add_args('-bios', rom_path)
+        self.vm.launch()
+
+        self.log.info('VM launched, waiting for display')
+        # TODO: Use avocado.utils.wait.wait_for to catch the
+        #       'displaysurface_create 1120x832' trace-event.
+        time.sleep(2)
+
+        self.vm.command('human-monitor-command',
+                        command_line='screendump %s' % screenshot_path)
+
+    @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
+    def test_bootrom_framebuffer_size(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:next_cube
+        :avocado: tags=device:framebuffer
+        """
+        screenshot_path = os.path.join(self.workdir, "dump.png")
+        self.check_bootrom_framebuffer(screenshot_path)
+
+        width, height = Image.open(screenshot_path).size
+        self.assertEqual(width, 1120)
+        self.assertEqual(height, 832)
+
+    @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not available')
+    def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:next_cube
+        :avocado: tags=device:framebuffer
+        """
+        screenshot_path = os.path.join(self.workdir, "dump.png")
+        self.check_bootrom_framebuffer(screenshot_path)
+
+        console_logger = logging.getLogger('console')
+        text = process.run("tesseract %s stdout" % screenshot_path).stdout_text
+        for line in text.split('\n'):
+            if len(line):
+                console_logger.debug(line)
+        self.assertIn('Backplane', text)
+        self.assertIn('Ethernet address', text)
+
+    # Tesseract 4 adds a new OCR engine based on LSTM neural networks. The
+    # new version is faster and more accurate than version 3. The drawback is
+    # that it is still alpha-level software.
+    @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not available')
+    def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:next_cube
+        :avocado: tags=device:framebuffer
+        """
+        screenshot_path = os.path.join(self.workdir, "dump.png")
+        self.check_bootrom_framebuffer(screenshot_path)
+
+        console_logger = logging.getLogger('console')
+        proc = process.run("tesseract --oem 1 %s stdout" % screenshot_path)
+        text = proc.stdout_text
+        for line in text.split('\n'):
+            if len(line):
+                console_logger.debug(line)
+        self.assertIn('Testing the FPU, SCC', text)
+        self.assertIn('System test failed. Error code 51', text)
+        self.assertIn('Boot command', text)
+        self.assertIn('Next>', text)
-- 
2.21.0


