Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC3C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D2B21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCdsbD7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D2B21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izevC-00078a-JZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoO-00034N-7G
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoK-00071X-PS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:08 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoK-0006wN-8q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:04 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so6470586wmf.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yGXxmEILtcVqUnUIIO59FUMDCwmme/jGV3qvovTSKWE=;
 b=jCdsbD7EAOuC8UICuzOuSOXDaG/9YvH+l9cCts5tAHr8JFs5Jk8wgfj83AHQca5I8n
 gPuV1NhFNuTgYqN7V+8wJkF07m/YJJuW0gMnTommh175KHZ/QPAol/1SHBWSA3QyWuZO
 kibC9aD2n5g0fHPHDVyi/e92JJVdEgKuByvX5++bMmNNb+9OjjqaZ+hJAQwp9m90gcWj
 g5VX6q+is1B0WFDDPP+fQRHeaSvTYyjE99tkhSC0PcpvWMpLfC/SemjWchP725pP/rQe
 hEbFlUDM7fzkK8/oPnGVCqJGqlfyMhuX/OClY5uum4scn7QjRNfOwyqJmqtfKRma/cni
 xaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yGXxmEILtcVqUnUIIO59FUMDCwmme/jGV3qvovTSKWE=;
 b=ZFOeeXKf0jKojrRDquBNvFQNvbjlrceIzLuqDpliKioHwUbAYlUi9cBXdpV3qska2y
 8JpPi3Bh2RN6biSdrKQXQsLgGBF7zQ/7yrskew6h7ElxuOFwpM/7pAVIMkW+HA8IYHXT
 A5YF2JH/kUCv379DGBd4CVwJNZnhOoAyrjXCjgloxQpFwkFkzOkaiKxRpvuFIsCRLcTl
 +O/BedR687AyRMxQ7ZxCLo4nfLrXz5W2Mhq7NtXj4Zm3k0uX9Ln7JZDQMeD6RbamUPHs
 tzWqf5HaA+UI4wUt6CIlzOZhkPPdrlifDgFEVXahMDfgqC9Z0H5KxxE4CVbGp+6Cb3JX
 u5bA==
X-Gm-Message-State: APjAAAUhmmKCuoCVOcwqzCoessDrycMlzD4tnt3HwRLdesrmS8foxGd/
 Ni+LdqXj+xHmqSMXwJkwNW/iMX52lhgPAg==
X-Google-Smtp-Source: APXvYqywpNFeiojPx3MMJZHpM7399nFhNcjRYq+p7E/EfKVnSs/qWGC0Rgjo6xX/I+KEpmBwdugojQ==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr3889771wma.89.1580986502650; 
 Thu, 06 Feb 2020 02:55:02 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 15/41] target/arm: Recover 4 bits from TBFLAGs
Date: Thu,  6 Feb 2020 10:54:22 +0000
Message-Id: <20200206105448.4726-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We had completely run out of TBFLAG bits.
Split A- and M-profile bits into two overlapping buckets.
This results in 4 free bits.

We used to initialize all of the a32 and m32 fields in DisasContext
by assignment, in arm_tr_init_disas_context.  Now we only initialize
either the a32 or m32 by assignment, because the bits overlap in
tbflags.  So zero the entire structure in gen_intermediate_code.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 68 ++++++++++++++++++++++++++----------------
 target/arm/helper.c    | 17 +++++------
 target/arm/translate.c | 57 +++++++++++++++++++----------------
 3 files changed, 82 insertions(+), 60 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a188398b03..fce6a426c8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3214,6 +3214,16 @@ typedef ARMCPU ArchCPU;
  * We put flags which are shared between 32 and 64 bit mode at the top
  * of the word, and flags which apply to only one mode at the bottom.
  *
+ *  31          21    18    14          9              0
+ * +--------------+-----+-----+----------+--------------+
+ * |              |     |   TBFLAG_A32   |              |
+ * |              |     +-----+----------+  TBFLAG_AM32 |
+ * |  TBFLAG_ANY  |           |TBFLAG_M32|              |
+ * |              |           +-------------------------|
+ * |              |           |       TBFLAG_A64        |
+ * +--------------+-----------+-------------------------+
+ *  31          21          14                         0
+ *
  * Unless otherwise noted, these bits are cached in env->hflags.
  */
 FIELD(TBFLAG_ANY, AARCH64_STATE, 31, 1)
@@ -3223,46 +3233,54 @@ FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)     /* Not cached. */
 /* Target EL if we take a floating-point-disabled exception */
 FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
 FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
-/*
- * For A-profile only, target EL for debug exceptions.
- * Note that this overlaps with the M-profile-only HANDLER and STACKCHECK bits.
- */
+/* For A-profile only, target EL for debug exceptions.  */
 FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
 
-/* Bit usage when in AArch32 state: */
-FIELD(TBFLAG_A32, THUMB, 0, 1)          /* Not cached. */
-FIELD(TBFLAG_A32, VECLEN, 1, 3)         /* Not cached. */
-FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)      /* Not cached. */
+/*
+ * Bit usage when in AArch32 state, both A- and M-profile.
+ */
+FIELD(TBFLAG_AM32, CONDEXEC, 0, 8)      /* Not cached. */
+FIELD(TBFLAG_AM32, THUMB, 8, 1)         /* Not cached. */
+
+/*
+ * Bit usage when in AArch32 state, for A-profile only.
+ */
+FIELD(TBFLAG_A32, VECLEN, 9, 3)         /* Not cached. */
+FIELD(TBFLAG_A32, VECSTRIDE, 12, 2)     /* Not cached. */
 /*
  * We store the bottom two bits of the CPAR as TB flags and handle
  * checks on the other bits at runtime. This shares the same bits as
  * VECSTRIDE, which is OK as no XScale CPU has VFP.
  * Not cached, because VECLEN+VECSTRIDE are not cached.
  */
-FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
+FIELD(TBFLAG_A32, XSCALE_CPAR, 12, 2)
+FIELD(TBFLAG_A32, VFPEN, 14, 1)         /* Partially cached, minus FPEXC. */
+FIELD(TBFLAG_A32, SCTLR_B, 15, 1)
+FIELD(TBFLAG_A32, HSTR_ACTIVE, 16, 1)
 /*
  * Indicates whether cp register reads and writes by guest code should access
  * the secure or nonsecure bank of banked registers; note that this is not
  * the same thing as the current security state of the processor!
  */
-FIELD(TBFLAG_A32, NS, 6, 1)
-FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC. */
-FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
-FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
-FIELD(TBFLAG_A32, HSTR_ACTIVE, 17, 1)
+FIELD(TBFLAG_A32, NS, 17, 1)
 
-/* For M profile only, set if FPCCR.LSPACT is set */
-FIELD(TBFLAG_A32, LSPACT, 18, 1)        /* Not cached. */
-/* For M profile only, set if we must create a new FP context */
-FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1) /* Not cached. */
-/* For M profile only, set if FPCCR.S does not match current security state */
-FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1) /* Not cached. */
-/* For M profile only, Handler (ie not Thread) mode */
-FIELD(TBFLAG_A32, HANDLER, 21, 1)
-/* For M profile only, whether we should generate stack-limit checks */
-FIELD(TBFLAG_A32, STACKCHECK, 22, 1)
+/*
+ * Bit usage when in AArch32 state, for M-profile only.
+ */
+/* Handler (ie not Thread) mode */
+FIELD(TBFLAG_M32, HANDLER, 9, 1)
+/* Whether we should generate stack-limit checks */
+FIELD(TBFLAG_M32, STACKCHECK, 10, 1)
+/* Set if FPCCR.LSPACT is set */
+FIELD(TBFLAG_M32, LSPACT, 11, 1)                 /* Not cached. */
+/* Set if we must create a new FP context */
+FIELD(TBFLAG_M32, NEW_FP_CTXT_NEEDED, 12, 1)     /* Not cached. */
+/* Set if FPCCR.S does not match current security state */
+FIELD(TBFLAG_M32, FPCCR_S_WRONG, 13, 1)          /* Not cached. */
 
-/* Bit usage when in AArch64 state */
+/*
+ * Bit usage when in AArch64 state
+ */
 FIELD(TBFLAG_A64, TBII, 0, 2)
 FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
 FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7ee4197456..5609bb18e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11353,11 +11353,8 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
 {
     uint32_t flags = 0;
 
-    /* v8M always enables the fpu.  */
-    flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
-
     if (arm_v7m_is_handler_mode(env)) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
+        flags = FIELD_DP32(flags, TBFLAG_M32, HANDLER, 1);
     }
 
     /*
@@ -11368,7 +11365,7 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     if (arm_feature(env, ARM_FEATURE_V8) &&
         !((mmu_idx & ARM_MMU_IDX_M_NEGPRI) &&
           (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
+        flags = FIELD_DP32(flags, TBFLAG_M32, STACKCHECK, 1);
     }
 
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
@@ -11561,7 +11558,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
                 FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
                 != env->v7m.secure) {
-                flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
+                flags = FIELD_DP32(flags, TBFLAG_M32, FPCCR_S_WRONG, 1);
             }
 
             if ((env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
@@ -11573,12 +11570,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                  * active FP context; we must create a new FP context before
                  * executing any FP insn.
                  */
-                flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
+                flags = FIELD_DP32(flags, TBFLAG_M32, NEW_FP_CTXT_NEEDED, 1);
             }
 
             bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
             if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
-                flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
+                flags = FIELD_DP32(flags, TBFLAG_M32, LSPACT, 1);
             }
         } else {
             /*
@@ -11599,8 +11596,8 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             }
         }
 
-        flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-        flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
+        flags = FIELD_DP32(flags, TBFLAG_AM32, THUMB, env->thumb);
+        flags = FIELD_DP32(flags, TBFLAG_AM32, CONDEXEC, env->condexec_bits);
         pstate_for_ss = env->uncached_cpsr;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 91e2ca5515..c169984374 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10848,38 +10848,48 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
      */
     dc->secure_routed_to_el3 = arm_feature(env, ARM_FEATURE_EL3) &&
                                !arm_el_is_aa64(env, 3);
-    dc->thumb = FIELD_EX32(tb_flags, TBFLAG_A32, THUMB);
-    dc->sctlr_b = FIELD_EX32(tb_flags, TBFLAG_A32, SCTLR_B);
-    dc->hstr_active = FIELD_EX32(tb_flags, TBFLAG_A32, HSTR_ACTIVE);
+    dc->thumb = FIELD_EX32(tb_flags, TBFLAG_AM32, THUMB);
     dc->be_data = FIELD_EX32(tb_flags, TBFLAG_ANY, BE_DATA) ? MO_BE : MO_LE;
-    condexec = FIELD_EX32(tb_flags, TBFLAG_A32, CONDEXEC);
+    condexec = FIELD_EX32(tb_flags, TBFLAG_AM32, CONDEXEC);
     dc->condexec_mask = (condexec & 0xf) << 1;
     dc->condexec_cond = condexec >> 4;
+
     core_mmu_idx = FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
     dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
-    dc->ns = FIELD_EX32(tb_flags, TBFLAG_A32, NS);
     dc->fp_excp_el = FIELD_EX32(tb_flags, TBFLAG_ANY, FPEXC_EL);
-    dc->vfp_enabled = FIELD_EX32(tb_flags, TBFLAG_A32, VFPEN);
-    dc->vec_len = FIELD_EX32(tb_flags, TBFLAG_A32, VECLEN);
-    if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-        dc->c15_cpar = FIELD_EX32(tb_flags, TBFLAG_A32, XSCALE_CPAR);
-        dc->vec_stride = 0;
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        dc->vfp_enabled = 1;
+        dc->be_data = MO_TE;
+        dc->v7m_handler_mode = FIELD_EX32(tb_flags, TBFLAG_M32, HANDLER);
+        dc->v8m_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+            regime_is_secure(env, dc->mmu_idx);
+        dc->v8m_stackcheck = FIELD_EX32(tb_flags, TBFLAG_M32, STACKCHECK);
+        dc->v8m_fpccr_s_wrong =
+            FIELD_EX32(tb_flags, TBFLAG_M32, FPCCR_S_WRONG);
+        dc->v7m_new_fp_ctxt_needed =
+            FIELD_EX32(tb_flags, TBFLAG_M32, NEW_FP_CTXT_NEEDED);
+        dc->v7m_lspact = FIELD_EX32(tb_flags, TBFLAG_M32, LSPACT);
     } else {
-        dc->vec_stride = FIELD_EX32(tb_flags, TBFLAG_A32, VECSTRIDE);
-        dc->c15_cpar = 0;
+        dc->be_data =
+            FIELD_EX32(tb_flags, TBFLAG_ANY, BE_DATA) ? MO_BE : MO_LE;
+        dc->debug_target_el =
+            FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_TARGET_EL);
+        dc->sctlr_b = FIELD_EX32(tb_flags, TBFLAG_A32, SCTLR_B);
+        dc->hstr_active = FIELD_EX32(tb_flags, TBFLAG_A32, HSTR_ACTIVE);
+        dc->ns = FIELD_EX32(tb_flags, TBFLAG_A32, NS);
+        dc->vfp_enabled = FIELD_EX32(tb_flags, TBFLAG_A32, VFPEN);
+        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
+            dc->c15_cpar = FIELD_EX32(tb_flags, TBFLAG_A32, XSCALE_CPAR);
+        } else {
+            dc->vec_len = FIELD_EX32(tb_flags, TBFLAG_A32, VECLEN);
+            dc->vec_stride = FIELD_EX32(tb_flags, TBFLAG_A32, VECSTRIDE);
+        }
     }
-    dc->v7m_handler_mode = FIELD_EX32(tb_flags, TBFLAG_A32, HANDLER);
-    dc->v8m_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
-        regime_is_secure(env, dc->mmu_idx);
-    dc->v8m_stackcheck = FIELD_EX32(tb_flags, TBFLAG_A32, STACKCHECK);
-    dc->v8m_fpccr_s_wrong = FIELD_EX32(tb_flags, TBFLAG_A32, FPCCR_S_WRONG);
-    dc->v7m_new_fp_ctxt_needed =
-        FIELD_EX32(tb_flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED);
-    dc->v7m_lspact = FIELD_EX32(tb_flags, TBFLAG_A32, LSPACT);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
@@ -10901,9 +10911,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->ss_active = FIELD_EX32(tb_flags, TBFLAG_ANY, SS_ACTIVE);
     dc->pstate_ss = FIELD_EX32(tb_flags, TBFLAG_ANY, PSTATE_SS);
     dc->is_ldex = false;
-    if (!arm_feature(env, ARM_FEATURE_M)) {
-        dc->debug_target_el = FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_TARGET_EL);
-    }
 
     dc->page_start = dc->base.pc_first & TARGET_PAGE_MASK;
 
@@ -11340,10 +11347,10 @@ static const TranslatorOps thumb_translator_ops = {
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
-    DisasContext dc;
+    DisasContext dc = { };
     const TranslatorOps *ops = &arm_translator_ops;
 
-    if (FIELD_EX32(tb->flags, TBFLAG_A32, THUMB)) {
+    if (FIELD_EX32(tb->flags, TBFLAG_AM32, THUMB)) {
         ops = &thumb_translator_ops;
     }
 #ifdef TARGET_AARCH64
-- 
2.20.1


