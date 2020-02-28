Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA032C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E132468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfU9YQtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E132468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ihv-0004UZ-IW
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if8-0007J6-6c
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if6-0001pV-AC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:54 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7if6-0001ow-2u
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id f15so3835251wml.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XwFayHGAlgtbTjyBRhE/jLwf5sdkAmef4Kxh8ptCpD4=;
 b=CfU9YQtP8xBdClxjEp3azxpFYBaJW7FVffYGR2yLnHzgH2JFDSaTki10YoBSfy9wd3
 z0aG2844lAarA2J5HOi0NIigYlOMvmkKx08FLHd2v0SLY8Y1eRQ6c2P2Ep0NdsowMmbl
 PhTBCSG+WZM2HHykTMpf43naxGqtT3nePbdxZ4fP3LS7PsqywvBnGATNkLMT2yoGMS9Z
 eZmQYQ5Eq80Mxj+fNQYCLayjMaL7BOIxNZ6ggCqFYagBG4Kj0O46DmTqN7fkG7ZuGGDb
 84AJQHAgYlSCAhv5/V2PlAQw6yyMc1GBrkORj7W1ilteLZSrXzzG8fNvaO4VQA+LpXi/
 +gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XwFayHGAlgtbTjyBRhE/jLwf5sdkAmef4Kxh8ptCpD4=;
 b=i90K9lUTfKI+zwKQw8zE1nBdOYA7dVnIvdGHUYNa6hFvm4wfudDPfxK5wrvHiEz8Gr
 qSudxuK76AINCGVzDsKnfvpbm3tkd3n65Id71GYGQwggXk7CUM690U94Dv+uDFI/AkLG
 g/BR/3T0bR1T7fF6VZVwCJvJzl/ezyC/uD/mtMeuA3kETz2Y3fy9XQd3Wmlj0gmDT5wp
 4wr+V4iqq008an6JBkqRMw05WESwyZIvwYVbAvxJviVvW/KMwoUArGi6CkNxBYfSakFQ
 LaI7X0oy/jwL8ccpr6Qf2FoRuXVnk48SvgJl5Mh6A0fPDp9p5nWoZqPyptrcApLJ8s8s
 u3wA==
X-Gm-Message-State: APjAAAUrCJkhZxX+FuP1RE5HaHDcF/wDgGKaWicKRCYhW+E/W01mWnJs
 bSGmnjylutYJQW3xRebMkvq3/wQgCs0aSA==
X-Google-Smtp-Source: APXvYqyOxe8+mDcSccIGhTxKMzzBCVpwg0Y9ev9lYOgQ1vZCeLsUxXSZzIAiMq7anBOilekePoUbJQ==
X-Received: by 2002:a1c:e908:: with SMTP id q8mr1204180wmc.77.1582907930547;
 Fri, 28 Feb 2020 08:38:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/33] target/arm: Add isar_feature_aa32_vfp_simd
Date: Fri, 28 Feb 2020 16:38:14 +0000
Message-Id: <20200228163840.23585-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

Use this in the places that were checking ARM_FEATURE_VFP, and
are obviously testing for the existance of the register set
as opposed to testing for some particular instruction extension.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200224222232.13807-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        |  9 +++++++++
 hw/intc/armv7m_nvic.c   | 20 ++++++++++----------
 linux-user/arm/signal.c |  4 ++--
 target/arm/arch_dump.c  | 11 ++++++-----
 target/arm/cpu.c        |  4 ++--
 target/arm/helper.c     |  4 ++--
 target/arm/m_helper.c   | 11 ++++++-----
 7 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65171cb30ee..a128d48d405 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3450,6 +3450,15 @@ static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
 }
 
+static inline bool isar_feature_aa32_vfp_simd(const ARMISARegisters *id)
+{
+    /*
+     * Return true if either VFP or SIMD is implemented.
+     * In this case, a minimum of VFP w/ D0-D15.
+     */
+    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) > 0;
+}
+
 static inline bool isar_feature_aa32_simd_r32(const ARMISARegisters *id)
 {
     /* Return true if D16-D31 are implemented */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 22a43e49847..a62587eb3f0 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1262,12 +1262,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd84: /* CSSELR */
         return cpu->env.v7m.csselr[attrs.secure];
     case 0xd88: /* CPACR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_vfp_simd, cpu)) {
             return 0;
         }
         return cpu->env.v7m.cpacr[attrs.secure];
     case 0xd8c: /* NSACR */
-        if (!attrs.secure || !arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!attrs.secure || !cpu_isar_feature(aa32_vfp_simd, cpu)) {
             return 0;
         }
         return cpu->env.v7m.nsacr;
@@ -1417,7 +1417,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return cpu->env.v7m.sfar;
     case 0xf34: /* FPCCR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_vfp_simd, cpu)) {
             return 0;
         }
         if (attrs.secure) {
@@ -1444,12 +1444,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             return value;
         }
     case 0xf38: /* FPCAR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_vfp_simd, cpu)) {
             return 0;
         }
         return cpu->env.v7m.fpcar[attrs.secure];
     case 0xf3c: /* FPDSCR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_vfp_simd, cpu)) {
             return 0;
         }
         return cpu->env.v7m.fpdscr[attrs.secure];
@@ -1711,13 +1711,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     case 0xd88: /* CPACR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
             /* We implement only the Floating Point extension's CP10/CP11 */
             cpu->env.v7m.cpacr[attrs.secure] = value & (0xf << 20);
         }
         break;
     case 0xd8c: /* NSACR */
-        if (attrs.secure && arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (attrs.secure && cpu_isar_feature(aa32_vfp_simd, cpu)) {
             /* We implement only the Floating Point extension's CP10/CP11 */
             cpu->env.v7m.nsacr = value & (3 << 10);
         }
@@ -1951,7 +1951,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         break;
     }
     case 0xf34: /* FPCCR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
             /* Not all bits here are banked. */
             uint32_t fpccr_s;
 
@@ -2005,13 +2005,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     case 0xf38: /* FPCAR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
             value &= ~7;
             cpu->env.v7m.fpcar[attrs.secure] = value;
         }
         break;
     case 0xf3c: /* FPDSCR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
             value &= 0x07c00000;
             cpu->env.v7m.fpdscr[attrs.secure] = value;
         }
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index b0e753801b6..d96fc27ce11 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -346,7 +346,7 @@ static void setup_sigframe_v2(struct target_ucontext_v2 *uc,
     setup_sigcontext(&uc->tuc_mcontext, env, set->sig[0]);
     /* Save coprocessor signal frame.  */
     regspace = uc->tuc_regspace;
-    if (arm_feature(env, ARM_FEATURE_VFP)) {
+    if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
         regspace = setup_sigframe_v2_vfp(regspace, env);
     }
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
@@ -671,7 +671,7 @@ static int do_sigframe_return_v2(CPUARMState *env,
 
     /* Restore coprocessor signal frame */
     regspace = uc->tuc_regspace;
-    if (arm_feature(env, ARM_FEATURE_VFP)) {
+    if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
         regspace = restore_sigframe_v2_vfp(env, regspace);
         if (!regspace) {
             return 1;
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 2345dec3c2c..7693e17e964 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -363,9 +363,11 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, void *opaque)
 {
     struct arm_note note;
-    CPUARMState *env = &ARM_CPU(cs)->env;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
     DumpState *s = opaque;
-    int ret, i, fpvalid = !!arm_feature(env, ARM_FEATURE_VFP);
+    int ret, i;
+    bool fpvalid = cpu_isar_feature(aa32_vfp_simd, cpu);
 
     arm_note_init(&note, s, "CORE", 5, NT_PRSTATUS, sizeof(note.prstatus));
 
@@ -444,7 +446,6 @@ int cpu_get_dump_info(ArchDumpInfo *info,
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
-    CPUARMState *env = &cpu->env;
     size_t note_size;
 
     if (class == ELFCLASS64) {
@@ -452,12 +453,12 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
         note_size += AARCH64_PRFPREG_NOTE_SIZE;
 #ifdef TARGET_AARCH64
         if (cpu_isar_feature(aa64_sve, cpu)) {
-            note_size += AARCH64_SVE_NOTE_SIZE(env);
+            note_size += AARCH64_SVE_NOTE_SIZE(&cpu->env);
         }
 #endif
     } else {
         note_size = ARM_PRSTATUS_NOTE_SIZE;
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
             note_size += ARM_VFP_NOTE_SIZE;
         }
     }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2eadf4dcb8b..be4c2a1253d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -293,7 +293,7 @@ static void arm_cpu_reset(CPUState *s)
             env->v7m.ccr[M_REG_S] |= R_V7M_CCR_UNALIGN_TRP_MASK;
         }
 
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
             env->v7m.fpccr[M_REG_NS] = R_V7M_FPCCR_ASPEN_MASK;
             env->v7m.fpccr[M_REG_S] = R_V7M_FPCCR_ASPEN_MASK |
                 R_V7M_FPCCR_LSPEN_MASK | R_V7M_FPCCR_S_MASK;
@@ -1011,7 +1011,7 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         int numvfpregs = 0;
         if (cpu_isar_feature(aa32_simd_r32, cpu)) {
             numvfpregs = 32;
-        } else if (arm_feature(env, ARM_FEATURE_VFP)) {
+        } else if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
             numvfpregs = 16;
         }
         for (i = 0; i < numvfpregs; i++) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 79db169e046..8841cc7fde8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -894,7 +894,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          * ASEDIS [31] and D32DIS [30] are both UNK/SBZP without VFP.
          * TRCDIS [28] is RAZ/WI since we do not implement a trace macrocell.
          */
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
             /* VFP coprocessor: cp10 & cp11 [23:20] */
             mask |= (1 << 31) | (1 << 30) | (0xf << 20);
 
@@ -7814,7 +7814,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     } else if (cpu_isar_feature(aa32_simd_r32, cpu)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  35, "arm-vfp3.xml", 0);
-    } else if (arm_feature(env, ARM_FEATURE_VFP)) {
+    } else if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  19, "arm-vfp.xml", 0);
     }
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 33d414a684b..5e8a795d202 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -738,7 +738,8 @@ static uint32_t v7m_integrity_sig(CPUARMState *env, uint32_t lr)
      */
     uint32_t sig = 0xfefa125a;
 
-    if (!arm_feature(env, ARM_FEATURE_VFP) || (lr & R_V7M_EXCRET_FTYPE_MASK)) {
+    if (!cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))
+        || (lr & R_V7M_EXCRET_FTYPE_MASK)) {
         sig |= 1;
     }
     return sig;
@@ -841,7 +842,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
 
     if (dotailchain) {
         /* Sanitize LR FType and PREFIX bits */
-        if (!arm_feature(env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_vfp_simd, cpu)) {
             lr |= R_V7M_EXCRET_FTYPE_MASK;
         }
         lr = deposit32(lr, 24, 8, 0xff);
@@ -1373,7 +1374,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 
     ftype = excret & R_V7M_EXCRET_FTYPE_MASK;
 
-    if (!arm_feature(env, ARM_FEATURE_VFP) && !ftype) {
+    if (!ftype && !cpu_isar_feature(aa32_vfp_simd, cpu)) {
         qemu_log_mask(LOG_GUEST_ERROR, "M profile: zero FTYPE in exception "
                       "exit PC value 0x%" PRIx32 " is UNPREDICTABLE "
                       "if FPU not present\n",
@@ -2450,7 +2451,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
              * SFPA is RAZ/WI from NS. FPCA is RO if NSACR.CP10 == 0,
              * RES0 if the FPU is not present, and is stored in the S bank
              */
-            if (arm_feature(env, ARM_FEATURE_VFP) &&
+            if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env)) &&
                 extract32(env->v7m.nsacr, 10, 1)) {
                 env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
                 env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
@@ -2565,7 +2566,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
             env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         }
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
             /*
              * SFPA is RAZ/WI from NS or if no FPU.
              * FPCA is RO if NSACR.CP10 == 0, RES0 if the FPU is not present.
-- 
2.20.1


