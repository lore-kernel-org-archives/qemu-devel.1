Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED786C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92142086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwlhFhZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92142086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fcS-0002Sd-V0
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVO-0004Kp-PL
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVM-000062-S1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:58 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVM-00005e-Ja
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:56 -0500
Received: by mail-pg1-x544.google.com with SMTP id d9so5353830pgu.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yuUusOCzpkaCF7XSY4s6jOjJNMax37vMLlyW3jWBGpE=;
 b=RwlhFhZIemAzDANaXXLgLvrWJdhU1rS2aHWE37Z5bcpzOPNKprdcW+w16M49XbCVkq
 ZxrIKzCnjgC5IOta7QZpQSS9PJCsQl9YggHWwSf0VWqxYpSo1gpz2SOihf2svhVvI6ZG
 2fLNTRyWKwUofQFyMWX/9ZoOBF/f57IllmX2/HcMG+4nEXV0QU8nUzOlxU3mMmhpXjhZ
 oHFVxpxxs10iqAG+Qi1igT3HInBjj0yt5DymxJ2cdVYHxchKnhxXnjbRaPtECeD13h02
 XFPI6qtAgmr5vxeIwtJ4VNkVaqpNS6zsYf87g0fODRPAltR4yeDf808qx279TeTYpyYb
 Fduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yuUusOCzpkaCF7XSY4s6jOjJNMax37vMLlyW3jWBGpE=;
 b=cRPzQRnyxoebGFX8lK1qmw/kumj5/R2Y8cHvr2Iflf9mI0RakxI4wdcaSks03pZjRc
 kHJ/AcwOHEdryHv439V/9VzXPxusvwG1jhws+qN8OJUnAijTiSaW2zMDdvu3yYf5zKoX
 zDfg0uStLtuXt7o99OD0DSjZvEzrIB4FaWXtU4siFILTlejNyUTdnCx7mxvbXzPWoG4Y
 q6xCTKthjR753UoCXUOUWOFBjzPlzIlotNafpJHjycti/yn2lT1NCM62uFjbd21Rh3gm
 wNcmc4ikJq51R7fVB7wK7sWppFtY++Ey7ngwOAyH/RyFZMPWhiTd7Izdn4ij7fcY8fBn
 6u2g==
X-Gm-Message-State: APjAAAWMNsm8B50PCT6e9PfKv3mkGOTER0AI9THh2ZDWPbmQosdAYcla
 7PKdG5GKURj6BoRSAYS5DYe67q0SyrQ=
X-Google-Smtp-Source: APXvYqyZ3CtTIpNDXitfTN/u0yLypA0Tf0g+0sCSw3DaNpGIRQPgyA+N4Csr1ZE1D9ouSCFMOorv7A==
X-Received: by 2002:a65:4b83:: with SMTP id t3mr4718725pgq.195.1581704154773; 
 Fri, 14 Feb 2020 10:15:54 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:15:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/19] target/arm: Add isar_feature_aa32_simd_r16
Date: Fri, 14 Feb 2020 10:15:33 -0800
Message-Id: <20200214181547.21408-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use this in the places that were checking ARM_FEATURE_VFP, and
are obviously testing for the existance of the register set
as opposed to testing for some particular instruction extension.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h        |  6 ++++++
 hw/intc/armv7m_nvic.c   | 20 ++++++++++----------
 linux-user/arm/signal.c |  4 ++--
 target/arm/arch_dump.c  | 11 ++++++-----
 target/arm/cpu.c        |  8 ++++----
 target/arm/helper.c     |  4 ++--
 target/arm/m_helper.c   | 11 ++++++-----
 target/arm/machine.c    |  3 +--
 8 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f7139db02d..85b90eaed2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3412,6 +3412,12 @@ static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
 }
 
+static inline bool isar_feature_aa32_simd_r16(const ARMISARegisters *id)
+{
+    /* Return true if D0-D15 are implemented */
+    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) > 0;
+}
+
 static inline bool isar_feature_aa32_simd_r32(const ARMISARegisters *id)
 {
     /* Return true if D16-D31 are implemented */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index f9e0eeaace..e5da962bb6 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1262,12 +1262,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd84: /* CSSELR */
         return cpu->env.v7m.csselr[attrs.secure];
     case 0xd88: /* CPACR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         return cpu->env.v7m.cpacr[attrs.secure];
     case 0xd8c: /* NSACR */
-        if (!attrs.secure || !arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!attrs.secure || !cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         return cpu->env.v7m.nsacr;
@@ -1417,7 +1417,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return cpu->env.v7m.sfar;
     case 0xf34: /* FPCCR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         if (attrs.secure) {
@@ -1444,12 +1444,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             return value;
         }
     case 0xf38: /* FPCAR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         return cpu->env.v7m.fpcar[attrs.secure];
     case 0xf3c: /* FPDSCR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         return cpu->env.v7m.fpdscr[attrs.secure];
@@ -1711,13 +1711,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     case 0xd88: /* CPACR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             /* We implement only the Floating Point extension's CP10/CP11 */
             cpu->env.v7m.cpacr[attrs.secure] = value & (0xf << 20);
         }
         break;
     case 0xd8c: /* NSACR */
-        if (attrs.secure && arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (attrs.secure && cpu_isar_feature(aa32_simd_r16, cpu)) {
             /* We implement only the Floating Point extension's CP10/CP11 */
             cpu->env.v7m.nsacr = value & (3 << 10);
         }
@@ -1951,7 +1951,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         break;
     }
     case 0xf34: /* FPCCR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             /* Not all bits here are banked. */
             uint32_t fpccr_s;
 
@@ -2005,13 +2005,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     case 0xf38: /* FPCAR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             value &= ~7;
             cpu->env.v7m.fpcar[attrs.secure] = value;
         }
         break;
     case 0xf3c: /* FPDSCR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             value &= 0x07c00000;
             cpu->env.v7m.fpdscr[attrs.secure] = value;
         }
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index b0e753801b..2871a7cc21 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -346,7 +346,7 @@ static void setup_sigframe_v2(struct target_ucontext_v2 *uc,
     setup_sigcontext(&uc->tuc_mcontext, env, set->sig[0]);
     /* Save coprocessor signal frame.  */
     regspace = uc->tuc_regspace;
-    if (arm_feature(env, ARM_FEATURE_VFP)) {
+    if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env))) {
         regspace = setup_sigframe_v2_vfp(regspace, env);
     }
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
@@ -671,7 +671,7 @@ static int do_sigframe_return_v2(CPUARMState *env,
 
     /* Restore coprocessor signal frame */
     regspace = uc->tuc_regspace;
-    if (arm_feature(env, ARM_FEATURE_VFP)) {
+    if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env))) {
         regspace = restore_sigframe_v2_vfp(env, regspace);
         if (!regspace) {
             return 1;
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 2345dec3c2..a5a4f4e1f8 100644
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
+    bool fpvalid = cpu_isar_feature(aa32_simd_r16, cpu);
 
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
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             note_size += ARM_VFP_NOTE_SIZE;
         }
     }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 92006e56c8..8d3eff8cb3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -293,7 +293,7 @@ static void arm_cpu_reset(CPUState *s)
             env->v7m.ccr[M_REG_S] |= R_V7M_CCR_UNALIGN_TRP_MASK;
         }
 
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             env->v7m.fpccr[M_REG_NS] = R_V7M_FPCCR_ASPEN_MASK;
             env->v7m.fpccr[M_REG_S] = R_V7M_FPCCR_ASPEN_MASK |
                 R_V7M_FPCCR_LSPEN_MASK | R_V7M_FPCCR_S_MASK;
@@ -1011,7 +1011,7 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         int numvfpregs = 0;
         if (cpu_isar_feature(aa32_simd_r32, cpu)) {
             numvfpregs = 32;
-        } else if (arm_feature(env, ARM_FEATURE_VFP)) {
+        } else if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             numvfpregs = 16;
         }
         for (i = 0; i < numvfpregs; i++) {
@@ -1260,7 +1260,7 @@ void arm_cpu_post_init(Object *obj)
      * KVM does not currently allow us to lie to the guest about its
      * ID/feature registers, so the guest always sees what the host has.
      */
-    if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+    if (cpu_isar_feature(aa32_simd_r16, cpu)) {
         cpu->has_vfp = true;
         if (!kvm_enabled()) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property);
@@ -1634,7 +1634,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * We rely on no XScale CPU having VFP so we can use the same bits in the
      * TB flags field for VECSTRIDE and XSCALE_CPAR.
      */
-    assert(!(arm_feature(env, ARM_FEATURE_VFP) &&
+    assert(!(cpu_isar_feature(aa32_simd_r16, cpu) &&
              arm_feature(env, ARM_FEATURE_XSCALE)));
 
     if (arm_feature(env, ARM_FEATURE_V7) &&
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0eeedc3c18..3f0b8eee8c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -893,7 +893,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          * ASEDIS [31] and D32DIS [30] are both UNK/SBZP without VFP.
          * TRCDIS [28] is RAZ/WI since we do not implement a trace macrocell.
          */
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env))) {
             /* VFP coprocessor: cp10 & cp11 [23:20] */
             mask |= (1 << 31) | (1 << 30) | (0xf << 20);
 
@@ -7757,7 +7757,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     } else if (cpu_isar_feature(aa32_simd_r32, cpu)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  35, "arm-vfp3.xml", 0);
-    } else if (arm_feature(env, ARM_FEATURE_VFP)) {
+    } else if (cpu_isar_feature(aa32_simd_r16, cpu)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  19, "arm-vfp.xml", 0);
     }
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 33d414a684..c024970221 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -738,7 +738,8 @@ static uint32_t v7m_integrity_sig(CPUARMState *env, uint32_t lr)
      */
     uint32_t sig = 0xfefa125a;
 
-    if (!arm_feature(env, ARM_FEATURE_VFP) || (lr & R_V7M_EXCRET_FTYPE_MASK)) {
+    if (!cpu_isar_feature(aa32_simd_r16, env_archcpu(env))
+        || (lr & R_V7M_EXCRET_FTYPE_MASK)) {
         sig |= 1;
     }
     return sig;
@@ -841,7 +842,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
 
     if (dotailchain) {
         /* Sanitize LR FType and PREFIX bits */
-        if (!arm_feature(env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             lr |= R_V7M_EXCRET_FTYPE_MASK;
         }
         lr = deposit32(lr, 24, 8, 0xff);
@@ -1373,7 +1374,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 
     ftype = excret & R_V7M_EXCRET_FTYPE_MASK;
 
-    if (!arm_feature(env, ARM_FEATURE_VFP) && !ftype) {
+    if (!ftype && !cpu_isar_feature(aa32_simd_r16, cpu)) {
         qemu_log_mask(LOG_GUEST_ERROR, "M profile: zero FTYPE in exception "
                       "exit PC value 0x%" PRIx32 " is UNPREDICTABLE "
                       "if FPU not present\n",
@@ -2450,7 +2451,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
              * SFPA is RAZ/WI from NS. FPCA is RO if NSACR.CP10 == 0,
              * RES0 if the FPU is not present, and is stored in the S bank
              */
-            if (arm_feature(env, ARM_FEATURE_VFP) &&
+            if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env)) &&
                 extract32(env->v7m.nsacr, 10, 1)) {
                 env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
                 env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
@@ -2565,7 +2566,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
             env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         }
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env))) {
             /*
              * SFPA is RAZ/WI from NS or if no FPU.
              * FPCA is RO if NSACR.CP10 == 0, RES0 if the FPU is not present.
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 241890ac8c..7050bde459 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -9,9 +9,8 @@
 static bool vfp_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
 
-    return arm_feature(env, ARM_FEATURE_VFP);
+    return cpu_isar_feature(aa32_simd_r16, cpu);
 }
 
 static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
-- 
2.20.1


