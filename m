Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22831C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE842098B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxw3uhmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE842098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBkF-0008Na-GH
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBhk-0004ux-M1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:50:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBhh-0000eu-Jq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:50:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id j7so2479223wrt.9
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TrWltPVKZu3fU5m7eJ+qSkFoeHPVQwlD70De7kBRthI=;
 b=Jxw3uhmzxtmX/xDddqhba3465aOVohWrpqzkJxfq5XIrMGrJ2rM6ZdGHy6jd+SViE+
 kO5NYcQT2rIo/20h9eiSPsOI69HnqklJhSdK8KG0ueFHyo/a+eiBfDMTnBeoyDVnWzfI
 DqmNdGyM2Aj16Rf5kYuBovHeuwNPtjzummX15RZDlsr3ndnXTr3HV+Q8pB7QHhTFvmVo
 ijfGrPt628m71PlzceDW3OGixe0q1KP8jij/ojo/yu/OpJIgvOm2OL79MrLUx/3/Gub2
 0KSYwl/LPECeudDCErKqe2T0zDeEdPcHwKHMamCPWYTCKaVmNiH2/I19njtB25ST6N2o
 pveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TrWltPVKZu3fU5m7eJ+qSkFoeHPVQwlD70De7kBRthI=;
 b=nV3F2fAmGyTDhzn7Q+8Tqtf8wnpaIpQjsvflMDm7fZ0cXBzrgazayCoMWEAH4dOHvH
 dqfDTwas0TmAthw7TJPRVLP0wzQ3zzxWYE5lX03dH1FKKVU62qVBrG5GK9gpl5NnGM+s
 6dq4EmlA50mEgNNBy652sLLBQjigRn+kg0aDGABIcO9gqklyK2e6VZEqdSiDXeYUAgAF
 UPMLT1hNZkPano9oB5QAeP9BHnvGvBkgqD9ZP4QM+rxTUemy+yyodQuCnOBL7mgZ7Y04
 SnIyzFX+7dRLjYKHINOQX7YpJQCHYXZfbSwDXtqX4XWvWb+KJHczb7Y0TOfRE46NpUlN
 5/Kw==
X-Gm-Message-State: AOAM531c7lqIPEG1lk/5A3c9IiCvhLTXH77Oab8IWapiU9R0IQ8KP0qF
 Ur/tFra7RIM4Egd+AkL54Bx6SL2IpNw=
X-Google-Smtp-Source: ABdhPJxZLPxY0g4osL9oBzgd18iCn7IwfEu0pBwR2z1+TpCiKBdhjKLPLs4Ac0GdiyJzni01fnRqcg==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr4008117wrm.295.1603277447789; 
 Wed, 21 Oct 2020 03:50:47 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e12sm2798621wme.32.2020.10.21.03.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 03:50:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] tests/acceptance: Use .ppm extention for Portable PixMap
 files
Date: Wed, 21 Oct 2020 12:50:31 +0200
Message-Id: <20201021105035.2477784-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021105035.2477784-1-f4bug@amsat.org>
References: <20201021105035.2477784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

The HMP 'screendump' command generates Portable PixMap files.
Make it obvious by using the .ppm file extention.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_m68k_nextcube.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
index 9d289f2fab7..2baba5fdc26 100644
--- a/tests/acceptance/machine_m68k_nextcube.py
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -69,7 +69,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
 
     @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
     def test_bootrom_framebuffer_size(self):
-        screenshot_path = os.path.join(self.workdir, "dump.png")
+        screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
         width, height = Image.open(screenshot_path).size
@@ -78,7 +78,7 @@ def test_bootrom_framebuffer_size(self):
 
     @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not available')
     def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
-        screenshot_path = os.path.join(self.workdir, "dump.png")
+        screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
         console_logger = logging.getLogger('console')
@@ -94,7 +94,7 @@ def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
     # that it is still alpha-level software.
     @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not available')
     def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
-        screenshot_path = os.path.join(self.workdir, "dump.png")
+        screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
 
         console_logger = logging.getLogger('console')
-- 
2.26.2


