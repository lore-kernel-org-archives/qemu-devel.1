Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE15BC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A7E2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSoX3I/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A7E2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBkG-0008M6-BA
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBhs-000560-NS
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:51:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBhr-0000iM-16
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:51:00 -0400
Received: by mail-wm1-x32f.google.com with SMTP id d78so1374906wmd.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u8MIW0fZuo8s+yk9Tsr3op5QbGANqrFw34tCgPBF3cw=;
 b=fSoX3I/r74xELcpRZ3OdZaYY+ZfCUTskrMBMgjWVe4FbwR/txGkVTyawTWQQ+vHKNE
 sBU0L5sSs0pfSJ70pK4frMRhldqv2Z7tXM9WPaoM+mz/tfY6bcD0m1nVIq+YHckx1gNJ
 FP8Tzo8xvRYGx29Ih/bbYAsCTYvE5YGeFOzhaa0kSZjskFdcCmcsWKn32Z/X6jYIMhSc
 WTsXhgxyKPJkLsoL3Px3FdmLCeV8+DsyGvq0S/0DTEr0H6b6cvzq+mR4YMuUWDvxrwg5
 5zEFwzEe4fiVCPkJPtEilvh2QOIx9tKo51DZ7BB04JQyyxSsqw4GoT+qAN2qPs7qWOoz
 6LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=u8MIW0fZuo8s+yk9Tsr3op5QbGANqrFw34tCgPBF3cw=;
 b=FstXIH7cQSiZGV8/RpSHssHx6U3TyN2noUedYxFYccEyiHotu5hO2NU6xx63LwqAmr
 LUfkf75apEeQ8Fn398Aox6oBAMzIBIdSz/xPhF4HkkT/q4YMEP4ZFBXeA/8NmQ8YAL/a
 Vm4NOJSLGLw5aZFCrfEeoDH0vuA0Pe9/IAM2WbfEzUy1ALgWN5tcBlAc71KMRNjLYcDK
 uZyojICkLqvHdIKUuRImXw/+5tHaXIW6tMTp24uPjZWC9w/Di+3Uxx9SwLqNa3pK2qDj
 jkmqqh29TIy5IWfg/8jwNxIQO+XcSGdrC6hTZCGepLB5unVhcDjtN1uGMl8umh6HwYwU
 zKMg==
X-Gm-Message-State: AOAM530TKHeQvjOd7Qnyak5IAf6X/0RI/I6mzTbEgkD9dzSdnPAP1Wh5
 GSHLtBFx8g+o3x+SC0DXJeYH+vxz7Wc=
X-Google-Smtp-Source: ABdhPJw4WuLXr4fMv1GVowlFCqxkzdgn0xn2wi9PmCKKIJ7Wo0gIYde7vbK77YJLUEIvrk8XzROSRA==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr3065574wmi.140.1603277457309; 
 Wed, 21 Oct 2020 03:50:57 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z6sm2781092wmi.28.2020.10.21.03.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 03:50:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] tests/acceptance: Introduce tesseract_ocr() helper
Date: Wed, 21 Oct 2020 12:50:33 +0200
Message-Id: <20201021105035.2477784-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021105035.2477784-1-f4bug@amsat.org>
References: <20201021105035.2477784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
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

We are going to reuse the tesseract OCR code.
Create a new tesseract_ocr() helper and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_m68k_nextcube.py | 21 +++++----------------
 tests/acceptance/tesseract_utils.py       | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
index 3c7400c43e4..09e2745cc52 100644
--- a/tests/acceptance/machine_m68k_nextcube.py
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -7,13 +7,11 @@
 
 import os
 import time
-import logging
 
 from avocado_qemu import Test
 from avocado import skipUnless
-from avocado.utils import process
 
-from tesseract_utils import tesseract_available
+from tesseract_utils import tesseract_available, tesseract_ocr
 
 PIL_AVAILABLE = True
 try:
@@ -61,12 +59,8 @@ def test_bootrom_framebuffer_size(self):
     def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
         screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
-
-        console_logger = logging.getLogger('console')
-        text = process.run("tesseract %s stdout" % screenshot_path).stdout_text
-        for line in text.split('\n'):
-            if len(line):
-                console_logger.debug(line)
+        lines = tesseract_ocr(screenshot_path, tesseract_version=3)
+        text = '\n'.join(lines)
         self.assertIn('Backplane', text)
         self.assertIn('Ethernet address', text)
 
@@ -77,13 +71,8 @@ def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
     def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
         screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
-
-        console_logger = logging.getLogger('console')
-        proc = process.run("tesseract --oem 1 %s stdout" % screenshot_path)
-        text = proc.stdout_text
-        for line in text.split('\n'):
-            if len(line):
-                console_logger.debug(line)
+        lines = tesseract_ocr(screenshot_path, tesseract_version=4)
+        text = '\n'.join(lines)
         self.assertIn('Testing the FPU, SCC', text)
         self.assertIn('System test failed. Error code', text)
         self.assertIn('Boot command', text)
diff --git a/tests/acceptance/tesseract_utils.py b/tests/acceptance/tesseract_utils.py
index acd6e8c2faa..72cd9ab7989 100644
--- a/tests/acceptance/tesseract_utils.py
+++ b/tests/acceptance/tesseract_utils.py
@@ -6,7 +6,9 @@
 # later. See the COPYING file in the top-level directory.
 
 import re
+import logging
 
+from avocado.utils import process
 from avocado.utils.path import find_command, CmdNotFoundError
 
 def tesseract_available(expected_version):
@@ -26,3 +28,19 @@ def tesseract_available(expected_version):
         return False
     # now this is guaranteed to be a digit
     return int(match.groups()[0]) == expected_version
+
+
+def tesseract_ocr(image_path, tesseract_args='', tesseract_version=3):
+    console_logger = logging.getLogger('tesseract')
+    console_logger.debug(image_path)
+    if tesseract_version == 4:
+        tesseract_args += ' --oem 1'
+    proc = process.run("tesseract {} {} stdout".format(tesseract_args,
+                                                       image_path))
+    lines = []
+    for line in proc.stdout_text.split('\n'):
+        sline = line.strip()
+        if len(sline):
+            console_logger.debug(sline)
+            lines += [sline]
+    return lines
-- 
2.26.2


