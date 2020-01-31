Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97339C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6113620705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyUPTWsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6113620705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixdaS-0004Io-Jg
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 16:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixdZG-0002rP-PL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixdZF-0003KS-4w
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:11:10 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixdZE-0003F3-UF; Fri, 31 Jan 2020 16:11:09 -0500
Received: by mail-wm1-x344.google.com with SMTP id g1so9483594wmh.4;
 Fri, 31 Jan 2020 13:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qui543OYuTfKdLmeSHcAvTrY+hYv6Ip3HFhW4S9oNcs=;
 b=iyUPTWspBRumgyv9VuNHpRhM1mc+lCvRIx7fMqyHY6zDBg7PiFGsBARiyIN5Ryrbuh
 seAzXIifSB1BXVMLq94SmhL1Z3wZFoqD9gfBN7grphC50pYxIW/c1C17e+dCY4boAi4H
 asPLEMLoltVFwXrZcswXjt7V/JcWbKfeWDPqoTxwixv/Hv4vWxtmtxCrGcFjPAaszE0r
 ss3xKZscW7dQdGpkNBqEGaqoPbielmlNoPJRgUr5vjxdqDlcO2uDQMDLi2pQ2af0bVpc
 ZuSHwIcfRX1y6dXiqciTE9zsuJD9JfYHGhZBzEC0JonzaMWvdlqIUQZe1HERRfKBl3Dn
 LA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qui543OYuTfKdLmeSHcAvTrY+hYv6Ip3HFhW4S9oNcs=;
 b=A2m5TlcsPMZ3W6Zjk4nyVv0Ohg6nDbq5aNFJ22zbkbuBGpIUR3c40M2NVD/sd7lGFv
 n8cBKoZ1DhORq6izhJVwgpr7Se/ojLASnho0eIpsOZfl1sHdOJp9DpOzWuzWoM/CmdiG
 zWpU1qCiBCBtjEuxivYp4ViT5UTpl4MKtTo+BFmPicP7vdYcnwxDyHB2I9vrHaQJWkMg
 WVNOkKimblCH1JmTyDsl4fcMf1wCmSd2gtihYN61CpvUOMNQl+mItCM9qB3sRkaFnIoj
 PJvJwXzVFhU0iXfaJIHgg22QC8GW6MvVuZ9M54CPa4Jdx4myiNVzVycXSuVRU+eg29y4
 C4OQ==
X-Gm-Message-State: APjAAAUGJ/41L6qLEl2yJHaA0gC2Yti+bgA4jsCG3DPGd26qytuJ/Q37
 scBGxeuFDcHzZLdcV+YKJ2A4AmnT
X-Google-Smtp-Source: APXvYqx/i3s5llQjVvWSorRMt7ATq2pXb4YT1Hl7nI718jgkBbbxp7e8/NZ9IWBQZx2nvdykPl9Lcw==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr14155267wme.85.1580505067668; 
 Fri, 31 Jan 2020 13:11:07 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d204sm12236025wmd.30.2020.01.31.13.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 13:11:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/acceptance/integratorcp: Verify Tux is displayed on
 framebuffer
Date: Fri, 31 Jan 2020 22:11:02 +0100
Message-Id: <20200131211102.29612-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200131211102.29612-1-f4bug@amsat.org>
References: <20200131211102.29612-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test that verifies the Tux logo is displayed on the framebuffer.

We simply follow the OpenCV "Template Matching with Multiple Objects"
tutorial, replacing Lionel Messi by Tux:
https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html

When OpenCV and NumPy are installed, this test can be run using:

  $ AVOCADO_ALLOW_UNTRUSTED_CODE=hmmm \
    avocado --show=app,framebuffer run -t device:framebuffer \
      tests/acceptance/machine_arm_integratorcp.py
  JOB ID     : 8c46b0f8269242e87d738247883ea2a470df949e
  JOB LOG    : avocado/job-results/job-2020-01-31T21.38-8c46b0f/job.log
   (1/1) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine.test_framebuffer_tux_logo:
  framebuffer: found Tux at position [x, y] = (0, 0)
  PASS (3.96 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 4.23 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
The resulting match is https://pasteboard.co/ISz7kr8.png

For matching SMP machines, these suggestion might work:
https://stackoverflow.com/questions/50579050/template-matching-with-multiple-objects-in-opencv-python
---
 tests/acceptance/machine_arm_integratorcp.py | 51 ++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/acceptance/machine_arm_integratorcp.py
index 748819916d..a706fe1b44 100644
--- a/tests/acceptance/machine_arm_integratorcp.py
+++ b/tests/acceptance/machine_arm_integratorcp.py
@@ -9,11 +9,26 @@
 # later.  See the COPYING file in the top-level directory.
 
 import os
+import logging
 
 from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import wait_for_console_pattern
 
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
 class IntegratorMachine(Test):
     """Boots the Linux kernel and checks that the console is operational"""
 
@@ -45,3 +60,39 @@ class IntegratorMachine(Test):
         """
         self.boot_integratorcp()
         wait_for_console_pattern(self, 'Log in as root')
+
+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_framebuffer_tux_logo(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:integratorcp
+        :avocado: tags=device:pl110
+        :avocado: tags=device:framebuffer
+        """
+        screendump_path = os.path.join(self.workdir, "screendump.pbm")
+        tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
+                       'drivers/video/logo/logo_linux_vga16.ppm')
+        tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
+        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
+
+        self.boot_integratorcp()
+        framebuffer_ready = 'Console: switching to colour frame buffer device'
+        wait_for_console_pattern(self, framebuffer_ready)
+        self.vm.command('human-monitor-command', command_line='stop')
+        self.vm.command('human-monitor-command',
+                        command_line='screendump %s' % screendump_path)
+        logger = logging.getLogger('framebuffer')
+
+        cpu_count = 1
+        match_threshold = 0.92
+        screendump_bgr = cv2.imread(screendump_path)
+        screendump_gray = cv2.cvtColor(screendump_bgr, cv2.COLOR_BGR2GRAY)
+        result = cv2.matchTemplate(screendump_gray, cv2.imread(tuxlogo_path, 0),
+                                   cv2.TM_CCOEFF_NORMED)
+        loc = np.where(result >= match_threshold)
+        tux_count = 0
+        for tux_count, pt in enumerate(zip(*loc[::-1]), start=1):
+            logger.debug('found Tux at position [x, y] = %s', pt)
+        self.assertGreaterEqual(tux_count, cpu_count)
-- 
2.21.1


