Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F28AC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7548D21534
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMgHwLzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7548D21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBmD-0001iL-Vc
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBi2-0005JQ-69
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:51:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBi0-0000kW-G3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:51:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id c16so1603050wmd.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sya+QU41wlcVkPizrwatYGHt9fWrCDbWxbNEti7h2ho=;
 b=jMgHwLzRVp9leEB8s/kEGer0DyfE+AbxVEirZvYHl2E/yUqRez5R1+pmLEBZ3arsRr
 jHY62SfoDw+oRGI2VUqJUGxzQtP006ckJwhWEm7UPa22YurI9YAeWoTQcQsgg2NhPMT7
 Dcslv7tBd+92iEseNfmLn+hH5m5y8dV3pzZBD2YYW5YfBUIUKifJEuhewhfIA0X98oin
 n+dCZPQVl4IqbCHTTRhNtIbxuxmrnzVVomCjEybPq/Fr0IR53ftznA8Ld1wnNKlCh96t
 ftDCroshCCoAPRWGXC4Ha0s/uv6sdL+wPdoeOQxq4n4w2Dhv6RPvxyDtoiB295/Un16i
 cGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sya+QU41wlcVkPizrwatYGHt9fWrCDbWxbNEti7h2ho=;
 b=I6xH0X8syIG8iW7szcPxZ9c2FrsbazYXhiy5/dERr46mwAZH29DHdIL7UDXXrxFAdw
 5FZGYQ8P1jBy2CRJohrl9UBfJSjllna5WaflYRY247+cY7TepkMcMvaPJcgDCfk/MmL+
 /4ZUiXu3KoDoQyqHJCd+Zj/kEQBO/yaUePGdxIE5n4wh802Ghf0r/ABHQWTwTv9Gm4eI
 fFYgoDPxHzvdO0+wI1MLg+NBChCrKf+ScoFaQEaES4IPc5Yf6CHL2X04ZcLfwRO8g89I
 IQL94SKprOmtetClEbs287OUOiu8+cC9yMrT/npy6h2wzbBB/DqDYLBwdwoXNuVGpb+s
 9Qsg==
X-Gm-Message-State: AOAM533obRuv58ZTsMgEc0Ur1U0X9/0JdjAxSslbIZU7Sl+9eisJl9Xr
 TifP91uj8DFvsMJdO/uOCN5PWWeawKk=
X-Google-Smtp-Source: ABdhPJzJycn5B1g7AsDVMp+34eLhwlUyclsIsr3EJMP7HBqA9/0L63lah8aQln9vPACzCp9XGHGK0g==
X-Received: by 2002:a1c:e154:: with SMTP id y81mr2918494wmg.111.1603277466924; 
 Wed, 21 Oct 2020 03:51:06 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 24sm2665954wmf.44.2020.10.21.03.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 03:51:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] tests/acceptance: Test PMON on the Fuloong 2E machine
Date: Wed, 21 Oct 2020 12:50:35 +0200
Message-Id: <20201021105035.2477784-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021105035.2477784-1-f4bug@amsat.org>
References: <20201021105035.2477784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test the PMON firmware. As the firmware is not redistributable,
it has to be downloaded manually first. Then it can be used by
providing its path via the PMON_BIN_PATH environment variable:

  $ PMON_BIN_PATH=~/images/fuloong2e/pmon_2e.bin \
    AVOCADO_ALLOW_UNTRUSTED_CODE=1 \
    avocado --show=app,console run tests/acceptance/machine_mips_fuloong2e.py
  Fetching asset from tests/acceptance/machine_mips_fuloong2e.py:MipsFuloong2e.test_linux_kernel_isa_serial
   (1/3) tests/acceptance/machine_mips_fuloong2e.py:MipsFuloong2e.test_pmon_serial_console:
  console: PMON2000 MIPS Initializing. Standby...
  console: ERRORPC=00000000 CONFIG=00030932
  console: PRID=00006302
  console: Init SDRAM Done!
  console: Sizing caches...
  console: Init caches...
  console: godson2 caches found
  console: Init caches done, cfg = 00030932
  console: Copy PMON to execute location...
  console: copy text section done.
  console: Copy PMON to execute location done.
  Uncompressing Bios........................OK,Booting Bios
  PASS (0.25 s)
   (2/3) tests/acceptance/machine_mips_fuloong2e.py:MipsFuloong2e.test_pmon_framebuffer_console:
  [...]
  Uncompressing Bios........................OK,Booting Bios
  console: FREQ
  console: FREI
  console: DONE
  console: TTYI
  console: TTYD
  console: ENVI
  console: MAPV
  console: Mfg  0, Id 60
  console: STDV
  console: SBDD
  console: PPCIH
  console: PCIS
  console: PCIR
  console: PCIW
  console: NETI
  console: RTCL
  console: PCID
  console: VGAI
  console: Default MODE_ID 2
  console: starting radeon init...
  console: radeon init done
  console: FRBI
  console: cfb_console init,fb=b4000000
  console: Video: Drawing the logo ...
  console: CONSOLE_SIZE 450560HSTI
  PASS (4.10 s)
   (3/3) tests/acceptance/machine_mips_fuloong2e.py:MipsFuloong2e.test_linux_kernel_isa_serial:
  console: Linux version 2.6.27.7lemote (root@debian) (gcc version 4.1.3 20080623 (prerelease) (Debian 4.1.2-23)) #6 Fri Dec 12 00:11:25 CST 2008
  console: busclock=33000000, cpuclock=-2145008360,memsize=256,highmemsize=0
  console: console [early0] enabled
  console: CPU revision is: 00006302 (ICT Loongson-2)
  PASS (0.19 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 5.10 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/machine_mips_fuloong2e.py | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/acceptance/machine_mips_fuloong2e.py b/tests/acceptance/machine_mips_fuloong2e.py
index 5fd3da09e7c..807e38da74a 100644
--- a/tests/acceptance/machine_mips_fuloong2e.py
+++ b/tests/acceptance/machine_mips_fuloong2e.py
@@ -8,15 +8,74 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
+import time
 
 from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import wait_for_console_pattern
 
+from tesseract_utils import tesseract_available, tesseract_ocr
+
 class MipsFuloong2e(Test):
 
     timeout = 60
 
+    @skipUnless(os.getenv('PMON_BIN_PATH'), 'PMON_BIN_PATH not available')
+    def test_pmon_serial_console(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:fulong2e
+        :avocado: tags=endian:little
+        :avocado: tags=device:bonito64
+        :avocado: tags=device:via686b
+        """
+        pmon_hash = 'c812e1695d7b2320036f3ef494976969' # v1.1.2
+        pmon_path = self.fetch_asset('file://' + os.getenv('PMON_BIN_PATH'),
+                                     asset_hash=pmon_hash, algorithm='md5')
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', pmon_path)
+        self.vm.launch()
+        wait_for_console_pattern(self, 'PMON2000 MIPS Initializing. Standby...')
+        wait_for_console_pattern(self, 'Booting Bios')
+
+    # Tesseract 4 adds a new OCR engine based on LSTM neural networks. The
+    # new version is faster and more accurate than version 3. The drawback is
+    # that it is still alpha-level software.
+    @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not available')
+    @skipUnless(os.getenv('PMON_BIN_PATH'), 'PMON_BIN_PATH not available')
+    def test_pmon_framebuffer_console(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:fulong2e
+        :avocado: tags=endian:little
+        :avocado: tags=device:bonito64
+        :avocado: tags=device:ati-vga
+        """
+        screenshot_path = os.path.join(self.workdir, 'dump.ppm')
+
+        pmon_hash = 'c812e1695d7b2320036f3ef494976969' # v1.1.2
+        pmon_path = self.fetch_asset('file://' + os.getenv('PMON_BIN_PATH'),
+                                     asset_hash=pmon_hash, algorithm='md5')
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', pmon_path,
+                         '-vga', 'std')
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'Video: Drawing the logo ...')
+        self.log.info('VM launched, waiting for logo on display')
+        time.sleep(2)
+        wait_for_console_pattern(self, 'CONSOLE_SIZE')
+        self.vm.command('human-monitor-command', command_line='stop')
+        self.vm.command('human-monitor-command',
+                        command_line='screendump %s' % screenshot_path)
+
+        lines = tesseract_ocr(screenshot_path, tesseract_version=4,
+                              tesseract_args='--dpi 128')
+        pmon_version = 'PNON2000 for Loongson, Version 1.1.2' # PNON is enough
+        self.assertIn(pmon_version, lines)
+
     @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_linux_kernel_isa_serial(self):
         """
-- 
2.26.2


