Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E774EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3041207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvZ7kUgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3041207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtJD-0006vb-Mj
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSg-0002Wy-Os
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSd-00089u-7P
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDrSb-00087x-5j
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:05 -0400
Received: by mail-wr1-x442.google.com with SMTP id v8so3153945wrt.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Nfr1PbQT0Jo9Bvco8Z/MdDyJj7lbe3iyjg+htmYoZyk=;
 b=lvZ7kUgPYDeisfp8Kul6oDEt308mX3gDVEeShL3OAvE0ikqkAM78ZqzEOwcS8/2q1V
 H3/UuVhse+sKqC+yTesLgflqc5LaZAqxufUUoUJXiOCOb3QCuDC9SZIx8LLGcInOIv+J
 Gj96fSNInS+C96wNiBLHOFgSm5wdaUZmKbTDmsr2eXmgbnSPErKL86fJtigojUkXQHJg
 GCAxW9HgiD2jVeDV/BJCkFv2BLDjHxYSiaXx2/nwRovyKU1Yh1C1F4EiPu8RvR7Ly1AR
 se98U++rYmN/OcikJVbGTYsohB8JdhNJ91bhrtdT8bp6RYw6OY0IcRRgKoPiYyUY2C1J
 DDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nfr1PbQT0Jo9Bvco8Z/MdDyJj7lbe3iyjg+htmYoZyk=;
 b=eGVVZlqFz0Qi/EV20wTzX3i9knh0II3o2kuwsHAVNjZf2Xfaw/I0acDX33vbo7SrSg
 jfSoIW3iUw2+ofls+p2paKZSu2vyN5gZG03+iGem/trmuGiFhQJ6Py8gTuldzyjVIK8L
 fn2aIiw7DkLCyA1yO2b9m0pl3BUYlpjoO/3RmAL36AlOHzUtvLM1LpSmfU/TFnXl1sTi
 iLZp+P3WG2UIbiYPKRziV7vye8e6WQPlanLkpod2Hxj4SaGcHZ/fvqFWLh6Avz27NkhN
 hFd9kORhxJi4FS1KXe3KHDcy80AdZ+Sy8fVF/rQjNFJzv+U9nN+IzeqfruJcLcwH5Wfx
 4H1g==
X-Gm-Message-State: APjAAAWhY4/cxBjBefcosu8Drv8lBJ+jAYXBzu1xft3y7UshJziOyP+o
 rF/beBHgNXR8sNHJcdW5GvJr9MTX1GwAKw==
X-Google-Smtp-Source: APXvYqzOSanJqfFoC3rXuZ4CzXmYdQ7qNdQZaqAo32D33UouQyfeVUaCrsKTr/UWYld91qNTo14BwA==
X-Received: by 2002:a1c:2144:: with SMTP id h65mr7924062wmh.114.1569595380311; 
 Fri, 27 Sep 2019 07:43:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y12sm2874539wrn.74.2019.09.27.07.42.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 07:42:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] hw/arm/boot: Use the IEC binary prefix definitions
Date: Fri, 27 Sep 2019 15:42:49 +0100
Message-Id: <20190927144249.29999-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927144249.29999-1-peter.maydell@linaro.org>
References: <20190927144249.29999-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

IEC binary prefixes ease code review: the unit is explicit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190923131108.21459-1-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 25422660545..c264864c11d 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -575,7 +575,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         goto fail;
     }
 
-    if (scells < 2 && binfo->ram_size >= (1ULL << 32)) {
+    if (scells < 2 && binfo->ram_size >= 4 * GiB) {
         /* This is user error so deserves a friendlier error message
          * than the failure of setprop_sized_cells would provide
          */
@@ -1097,7 +1097,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
      * we might still make a bad choice here.
      */
     info->initrd_start = info->loader_start +
-        MIN(info->ram_size / 2, 128 * 1024 * 1024);
+        MIN(info->ram_size / 2, 128 * MiB);
     if (image_high_addr) {
         info->initrd_start = MAX(info->initrd_start, image_high_addr);
     }
@@ -1157,13 +1157,13 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
                  *
                  * Let's play safe and prealign it to 2MB to give us some space.
                  */
-                align = 2 * 1024 * 1024;
+                align = 2 * MiB;
             } else {
                 /*
                  * Some 32bit kernels will trash anything in the 4K page the
                  * initrd ends in, so make sure the DTB isn't caught up in that.
                  */
-                align = 4096;
+                align = 4 * KiB;
             }
 
             /* Place the DTB after the initrd in memory with alignment. */
@@ -1180,7 +1180,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
                 info->loader_start + KERNEL_ARGS_ADDR;
             fixupcontext[FIXUP_ARGPTR_HI] =
                 (info->loader_start + KERNEL_ARGS_ADDR) >> 32;
-            if (info->ram_size >= (1ULL << 32)) {
+            if (info->ram_size >= 4 * GiB) {
                 error_report("RAM size must be less than 4GB to boot"
                              " Linux kernel using ATAGS (try passing a device tree"
                              " using -dtb)");
-- 
2.20.1


