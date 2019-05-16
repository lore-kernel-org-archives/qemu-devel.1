Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0390AC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EEA20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SE+aDuN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EEA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59435 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHhg-0003oK-Vh
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:49:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRHfZ-0002au-7a
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRHfY-0008H6-5g
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRHfX-0008Eh-86
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id h11so3752880wmb.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DgMhkLiABo0DJwU8oJ8YkfjP+Hk6v1roeqysC4eg468=;
	b=SE+aDuN2LJ0lQpMoo3ZRFMPWP9p0Weq1dhOnfcYXLJ79rrxDtptgaDDry/xFsWUZqh
	eGBHZgrufeHGBGg8ZUruLfPOXSDTXPrDhA/iVRTm8gxN0vi+xvpPSnGtb+IdR3vvaOrg
	kxpGfZ3OvKEGOtcR352oxR76OHjU0B7Dpa1G/3CoLDW7Hbt4gxTXQbJfA0hivygq8P8s
	V0wEpSfveD1o3Z0yFyXJMoN6mK5UMIXdThhvM6YMXaKIJMAwk0uymPQ2KBL/H0kYXwyW
	+vGrU604TknDsnj9O+9Az3DG7WIxZ2meQfG/feuGmmQdTF+FOr7LSMyDpQm6YQCkRFP+
	bn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DgMhkLiABo0DJwU8oJ8YkfjP+Hk6v1roeqysC4eg468=;
	b=Kl6B5BcOlSIcjmipkYClOiAF/Wbl21VOWoJJI8F0nzSdrqMeLIZ9unVA2ZboSqshSb
	T5XnYv39+xjas5kNxKsvNfFZR5WEwuRhqrkGG504V9BZjKwl+1I6T7C4UXfjlz1ruqwn
	937soYjLW+qebIw1YgyNXPezwD6I38Z7H42qEBNRAc7qVDd60uZlrICjjHR+1m7qYOrK
	eMopwC0fg7VkvvdFVGPQOVFxHXNStF25lYvn/cVWjaz3gJonToqjSyI64TzP5tBmMuXZ
	Oh/yKhLNCj7Mfkt4NxzqF04D2QSg13FYCONufzxKY76QYPfBLgA0L9vGb87NME/D8BzD
	qoqA==
X-Gm-Message-State: APjAAAVh3Os9AX6Eype/jXKaT4bEawoHO33p5LZIycnye3OnAS2t/h9z
	ZTRVBHREFmpgTgYSrN5/ljrDgg==
X-Google-Smtp-Source: APXvYqwJboeSmaXVCkOQA0uw97JcB1A7k6HHKmAOMOaI4Qh9zlskErpjyUIWYYIVZ9RjZjJjIf3Ogg==
X-Received: by 2002:a1c:63d5:: with SMTP id x204mr11618190wmb.3.1558018058135; 
	Thu, 16 May 2019 07:47:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id o8sm7629018wra.4.2019.05.16.07.47.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 07:47:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 16 May 2019 15:47:31 +0100
Message-Id: <20190516144733.32399-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516144733.32399-1-peter.maydell@linaro.org>
References: <20190516144733.32399-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2 2/4] hw/arm/boot: Diagnose layouts that put
 initrd or DTB off the end of RAM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We calculate the locations in memory where we want to put the
initrd and the DTB based on the size of the kernel, since they
come after it. Add some explicit checks that these aren't off the
end of RAM entirely.

(At the moment the way we calculate the initrd_start means that
it can't ever be off the end of RAM, but that will change with
the next commit.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 0bb9a7d5b5c..935be3b92a5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1055,11 +1055,25 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         error_report("could not load kernel '%s'", info->kernel_filename);
         exit(1);
     }
+
+    if (kernel_size > info->ram_size) {
+        error_report("kernel '%s' is too large to fit in RAM "
+                     "(kernel size %d, RAM size %" PRId64 ")",
+                     info->kernel_filename, kernel_size, info->ram_size);
+        exit(1);
+    }
+
     info->entry = entry;
     if (is_linux) {
         uint32_t fixupcontext[FIXUP_MAX];
 
         if (info->initrd_filename) {
+
+            if (info->initrd_start >= ram_end) {
+                error_report("not enough space after kernel to load initrd");
+                exit(1);
+            }
+
             initrd_size = load_ramdisk_as(info->initrd_filename,
                                           info->initrd_start,
                                           ram_end - info->initrd_start, as);
@@ -1075,6 +1089,11 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
                              info->initrd_filename);
                 exit(1);
             }
+            if (info->initrd_start + initrd_size > info->ram_size) {
+                error_report("could not load initrd '%s': "
+                             "too big to fit into RAM after the kernel",
+                             info->initrd_filename);
+            }
         } else {
             initrd_size = 0;
         }
@@ -1110,6 +1129,10 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
             /* Place the DTB after the initrd in memory with alignment. */
             info->dtb_start = QEMU_ALIGN_UP(info->initrd_start + initrd_size,
                                            align);
+            if (info->dtb_start >= ram_end) {
+                error_report("Not enough space for DTB after kernel/initrd");
+                exit(1);
+            }
             fixupcontext[FIXUP_ARGPTR_LO] = info->dtb_start;
             fixupcontext[FIXUP_ARGPTR_HI] = info->dtb_start >> 32;
         } else {
-- 
2.20.1


