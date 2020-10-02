Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D005BC35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435D120738
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXKo8YEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435D120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOT8n-0005am-T3
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 18:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT5w-0002XP-Tw
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:05 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT5u-0007MD-LK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:04 -0400
Received: by mail-ot1-x342.google.com with SMTP id n61so2857489ota.10
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1sPywZydkzNx8f/80GoSubL6qkbD2bze0L3zxjjn9Qg=;
 b=sXKo8YEznddVXahGBBUB8MPdd7uVD5frA0ogbMV72F3DEGzKYBnPZOI4QkE9G+i145
 /3TrWuQ7jrfBdZMCf8dHn4VJk3pxhcFX02O2cwDbbY7gwhQFOB715Hqv/Yba9kTkx4Sx
 Apz+hHB5vkWNEE3YQZKFPcxiamos5mcTUro5/3sxq9HiLThhY12IaAGoWLfTxrERIOWI
 JwHtKDttDDQ/irqqhlj1nJdpRwBM37k59LRnFhDx84JWMnhMTmh/KxFWi2fBz7hebHsm
 bVK5lIiVhhMuj7qWDb/p87AfIrtnwfsrkT8whKj36rAbABAA43tFvfE7BgclYkR3inT+
 0YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1sPywZydkzNx8f/80GoSubL6qkbD2bze0L3zxjjn9Qg=;
 b=a5/wqgQ4j9SUSAJWrb0wangKl2KOnmzvpyfctC4cs156WBNVPFDdzTK0ZlrCCEcvC8
 gMn9eSjjNBStimhasRTuZ1ILNlc6WlKu/SgS11vnizcov1QV+KBGkx2Qrz/Wcw2gBxc2
 N+3Avu0pMiDAxho4RFcqmEJx7zHF6mqSIFnJjMc+KLxD9TjunAhbaRENJH+hRGvjCcJb
 rIs3+vmmK/3PhqfPB62g69bNVk2NCILJmUqdL/WmGab4EwvmyXaq+eTjXn+9piz2/xzu
 9ZHW0kNqiiPX1X8fn3l8BHKHNPOhiiPbbdnpt7Z7J5hfX9hUI0IcbXiGpWsA1B4LVfQG
 wlEg==
X-Gm-Message-State: AOAM532I4zLJ+hZkHc+kxJ5FuO0iZAMcgy4fFGFu974v2ko27wfNNiOb
 9N6m4dU+Nsj633tA21L1pIyJphAZVcf6qqWG
X-Google-Smtp-Source: ABdhPJzCn8lS566R5abRvl4jGA/N7I2ltVyfzG+DhtvxKIxOk3KwL9jk1anM2AM7sFxF55YOrSkK6A==
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr3346514oti.63.1601676000681;
 Fri, 02 Oct 2020 15:00:00 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k10sm684268ots.60.2020.10.02.14.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 15:00:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 2/8] linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
Date: Fri,  2 Oct 2020 16:59:49 -0500
Message-Id: <20201002215955.254866-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002215955.254866-1-richard.henderson@linaro.org>
References: <20201002215955.254866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Transform the prot bit to a qemu internal page bit, and save
it in the page tables.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v10: Add PAGE_BTI define (pmm).
---
 include/exec/cpu-all.h     |  2 ++
 linux-user/syscall_defs.h  |  4 ++++
 target/arm/cpu.h           |  5 +++++
 linux-user/mmap.c          | 16 ++++++++++++++++
 target/arm/translate-a64.c |  6 +++---
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index f6439c4705..ba80c46c95 100644
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
index 731c3d5341..cabbfb762d 100644
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
index e4549a8cc0..a07d605c2f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3439,6 +3439,11 @@ static inline MemTxAttrs *typecheck_memtxattrs(MemTxAttrs *x)
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
index f261563420..00c05e6a0f 100644
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
index 7188808341..072754fa24 100644
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
2.25.1


