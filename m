Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6177DC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F55216B7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q39QhqX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F55216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr21p-0005GA-TE
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hr20n-0000ok-Qc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hr20m-00073Y-Hs
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:20:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hr20m-00071j-BL
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:20:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so54909631wrs.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GpPKP7yzwy7Lawm8Enx0xBuAIaMsB8U7zaH4ykghGlk=;
 b=q39QhqX2I/wBFcs3F9pHc9DhwtHgDQXq4zhJgy+rrbRLZGeO5fphWVIdcRXm8UcQOs
 ytUWZw+qOm/p4t2U4BbEzKqVhOXxg9VTbGqWbzPtO2DCiYFmb027hhHwsHuORTAPKfsK
 KI6z7gDyDE8VLJXuWRZxQ6XmiLVhqYcSsi0NXmC4qEdK+2GY4+luuqWLu+hZ/S10pgrH
 kVpC+mGgfUFJbVUbJsvDi6JyDaSdXTjI0mu/r+hXNCm7pGEcCdJIqBuIaJ6vOaDvl1Bs
 P3cfLs/TJfVq66uwPRfh4fHdkOXrC1SLaAjofQ3PksxiD314aJVMWdhbnEv4weEkP20C
 AK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GpPKP7yzwy7Lawm8Enx0xBuAIaMsB8U7zaH4ykghGlk=;
 b=a7lgh9VpLQCPOHTQ+6qKD5ClgNfnT5vLGLhnvY1tFHTWT2fgMLekITIT7c7JKw7fzX
 PFwUAn+g/mr7PD/w94Y+PZNq96nVSFbVgRO7cNOCldjSQnchuUrmq6fwG7SJsZpHtsDb
 LL5B8+61etlvGBuvrGlw6WEPXQK3OhD6Wu9F4/kqlhP/rUjVWCrYDPD/CBLy0yYF0lpW
 EO+ZN65h89g2r6Jkx4ZsK5aJcgDyv9qh/eSkQy/PfRAHEl5h0rSaT85GorKX41QpEz0p
 eBJGnEPy8+7wx3c2TWTBBSnuQY01pvIgyFHPC2RBRFKAGySE0L0qq7DuqXFnrnGzuw6c
 1Teg==
X-Gm-Message-State: APjAAAVB30ddrAPxnzOsOAARK+OE2TnR/DPYEmCCLH77E/PHcA3tYffq
 hyhqCDLiaWxgv238YBIxOGOHw37+magjtg==
X-Google-Smtp-Source: APXvYqyWSPw3FL8gCcO+ffqtQOVpLbO5U774wzcx+IUTXt/Ujnqnfu4P4NIjwdJm3s7rA7MKZ4UroQ==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr21056679wrr.170.1564154399117; 
 Fri, 26 Jul 2019 08:19:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v16sm32746844wrn.28.2019.07.26.08.19.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 08:19:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 16:19:52 +0100
Message-Id: <20190726151952.1932-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726151952.1932-1-peter.maydell@linaro.org>
References: <20190726151952.1932-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 5/5] hw/arm/boot: Further improve initrd
 positioning code
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

In commit e6b2b20d9735d4ef we made the boot loader code try to avoid
putting the initrd on top of the kernel.  However the expression used
to calculate the start of the initrd:

    info->initrd_start = info->loader_start +
        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);

incorrectly uses 'kernel_size' as the offset within RAM of the
highest address to avoid.  This is incorrect because the kernel
doesn't start at address 0, but slightly higher than that.  This
means that we can still incorrectly end up overlaying the initrd on
the kernel in some cases, for example:

* The kernel's image_size is 0x0a7a8000
* The kernel was loaded at   0x40080000
* The end of the kernel is   0x4A828000
* The DTB was loaded at      0x4a800000

To get this right we need to track the actual highest address used
by the kernel and use that rather than kernel_size. We already
set image_low_addr and image_high_addr for ELF images; set them
also for the various other image types we support, and then use
image_high_addr as the lowest allowed address for the initrd.
(We don't use image_low_addr, but we set it for consistency
with the existing code path for ELF files.)

Fixes: e6b2b20d9735d4ef
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Message-id: 20190722151804.25467-3-peter.maydell@linaro.org
---
 hw/arm/boot.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index b7b31753aca..c2b89b3bb9b 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -988,7 +988,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     int is_linux = 0;
     uint64_t elf_entry;
     /* Addresses of first byte used and first byte not used by the image */
-    uint64_t image_low_addr, image_high_addr;
+    uint64_t image_low_addr = 0, image_high_addr = 0;
     int elf_machine;
     hwaddr entry;
     static const ARMInsnFixup *primary_loader;
@@ -1041,17 +1041,29 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         uint64_t loadaddr = info->loader_start + KERNEL_NOLOAD_ADDR;
         kernel_size = load_uimage_as(info->kernel_filename, &entry, &loadaddr,
                                      &is_linux, NULL, NULL, as);
+        if (kernel_size >= 0) {
+            image_low_addr = loadaddr;
+            image_high_addr = image_low_addr + kernel_size;
+        }
     }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
         kernel_size = load_aarch64_image(info->kernel_filename,
                                          info->loader_start, &entry, as);
         is_linux = 1;
+        if (kernel_size >= 0) {
+            image_low_addr = entry;
+            image_high_addr = image_low_addr + kernel_size;
+        }
     } else if (kernel_size < 0) {
         /* 32-bit ARM */
         entry = info->loader_start + KERNEL_LOAD_ADDR;
         kernel_size = load_image_targphys_as(info->kernel_filename, entry,
                                              ram_end - KERNEL_LOAD_ADDR, as);
         is_linux = 1;
+        if (kernel_size >= 0) {
+            image_low_addr = entry;
+            image_high_addr = image_low_addr + kernel_size;
+        }
     }
     if (kernel_size < 0) {
         error_report("could not load kernel '%s'", info->kernel_filename);
@@ -1083,7 +1095,10 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
      * we might still make a bad choice here.
      */
     info->initrd_start = info->loader_start +
-        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
+        MIN(info->ram_size / 2, 128 * 1024 * 1024);
+    if (image_high_addr) {
+        info->initrd_start = MAX(info->initrd_start, image_high_addr);
+    }
     info->initrd_start = TARGET_PAGE_ALIGN(info->initrd_start);
 
     if (is_linux) {
-- 
2.20.1


