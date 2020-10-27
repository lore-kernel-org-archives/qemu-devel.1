Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2AFC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2ADC20760
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bB3S3T7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2ADC20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOCL-0007Es-St
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPP-0001FZ-Se
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:44:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPM-0004Ph-CD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:44:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id w23so1060892wmi.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pfMSojrXlqoam4BfR1MYmZ5ygmdoGUgMNwn3s+dXVnA=;
 b=bB3S3T7tGl0bBH9GMFOLryPBFwrrjYfaB2y7zydtTAHZUX04ac+j6GCL1kXyQycnlb
 8ZNXFDPwtNJpF4FW9x5V5SasYud0nKy1YNiZuZJMB392mJNjTL1UIs3oCztD/SjA7iJ1
 llrLbQuh8y7FwvwAwFeoDWhQLejv7hL6MgVNzJ1XRWusSe7uW7CUi7/0wTxVT3t8XzLs
 87gwAP41HUHVc3kJYe3oNoV0m7OQmyCTyz23uVUtNLvTjPGFYL4MbUOgmA4EfGbsSuxR
 jjDBlP1Gf2Tu7MdvliB6HeLBDKlo9j/YPRaBYtkgQr+oDpIbnxx8jCmucVtshJnnvQfH
 Frxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pfMSojrXlqoam4BfR1MYmZ5ygmdoGUgMNwn3s+dXVnA=;
 b=hPFsLEK1vdGaVwrPjrhwUspeazXrVa1+cGjK6StUIXtu+CAbzx5/qkWGf4yBCvbvTz
 m+wgC8EVcnK4LyvAZJIEABIFid64dPrtREShcRwzyvPVt4w6zo7QftmQEKAH3f60wdam
 rjcNRDl+HE3u17jEmxJz1AQjUsOjAneTZbghw3RdgpJUU6JgEDc+t1Qca2DI4+87M61+
 eIUPH4e+yc0vePhSbcIpKNOSrF4RiYUfG4ho3bS8BTWtwXeQCVnRKcl03nn5g/lvdxkw
 8Ak8QRBvD3eVSEu22ptEbKI54SlEQka6AE1yRoXjZN+mFigbOb1ucffIqgDwLvxz7O4u
 f5Ug==
X-Gm-Message-State: AOAM533YMpPxz4kVwE/f4wVHIlTu9rj2pbL3+WYr08+fmEUwRRu50642
 yI/nH0qnAtDCP4m8SOxIEWuYOBI4gK255g==
X-Google-Smtp-Source: ABdhPJw0nfZnueWuUIkcOpO3GOIvojZv0LrSXmeVSndcSE68qwXkSl7wOGyeGp6/Ywc5TFRiGq7xng==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr2261540wmh.158.1603799084661; 
 Tue, 27 Oct 2020 04:44:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/48] linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
Date: Tue, 27 Oct 2020 11:43:52 +0000
Message-Id: <20201027114438.17662-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Transform the prot bit to a qemu internal page bit, and save
it in the page tables.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201021173749.111103-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/cpu-all.h     |  2 ++
 linux-user/syscall_defs.h  |  4 ++++
 target/arm/cpu.h           |  5 +++++
 linux-user/mmap.c          | 16 ++++++++++++++++
 target/arm/translate-a64.c |  6 +++---
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 61e13b50382..656a2a87888 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -274,6 +274,8 @@ extern intptr_t qemu_host_page_mask;
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0020
 #endif
+/* Target-specific bits that will be used via page_get_flags().  */
+#define PAGE_TARGET_1  0x0080
 
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 731c3d5341a..cabbfb762dd 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1277,6 +1277,10 @@ struct target_winsize {
 #define TARGET_PROT_SEM         0x08
 #endif
 
+#ifdef TARGET_AARCH64
+#define TARGET_PROT_BTI         0x10
+#endif
+
 /* Common */
 #define TARGET_MAP_SHARED	0x01		/* Share changes */
 #define TARGET_MAP_PRIVATE	0x02		/* Changes are private */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 49cd5cabcf2..c18a9167665 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3445,6 +3445,11 @@ static inline MemTxAttrs *typecheck_memtxattrs(MemTxAttrs *x)
 #define arm_tlb_bti_gp(x) (typecheck_memtxattrs(x)->target_tlb_bit0)
 #define arm_tlb_mte_tagged(x) (typecheck_memtxattrs(x)->target_tlb_bit1)
 
+/*
+ * AArch64 usage of the PAGE_TARGET_* bits for linux-user.
+ */
+#define PAGE_BTI  PAGE_TARGET_1
+
 /*
  * Naming convention for isar_feature functions:
  * Functions which test 32-bit ID registers should have _aa32_ in
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f2615634201..00c05e6a0f1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -83,6 +83,22 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
     *host_prot = (prot & (PROT_READ | PROT_WRITE))
                | (prot & PROT_EXEC ? PROT_READ : 0);
 
+#ifdef TARGET_AARCH64
+    /*
+     * The PROT_BTI bit is only accepted if the cpu supports the feature.
+     * Since this is the unusual case, don't bother checking unless
+     * the bit has been requested.  If set and valid, record the bit
+     * within QEMU's page_flags.
+     */
+    if (prot & TARGET_PROT_BTI) {
+        ARMCPU *cpu = ARM_CPU(thread_cpu);
+        if (cpu_isar_feature(aa64_bti, cpu)) {
+            valid |= TARGET_PROT_BTI;
+            page_flags |= PAGE_BTI;
+        }
+    }
+#endif
+
     return prot & ~valid ? 0 : page_flags;
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 71888083417..072754fa24d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14507,10 +14507,10 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
  */
 static bool is_guarded_page(CPUARMState *env, DisasContext *s)
 {
-#ifdef CONFIG_USER_ONLY
-    return false;  /* FIXME */
-#else
     uint64_t addr = s->base.pc_first;
+#ifdef CONFIG_USER_ONLY
+    return page_get_flags(addr) & PAGE_BTI;
+#else
     int mmu_idx = arm_to_core_mmu_idx(s->mmu_idx);
     unsigned int index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-- 
2.20.1


