Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19104C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66AA20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+LMHNsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66AA20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTnI-0001HI-Vx
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTiz-0004xU-VY
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTiy-0001nZ-C9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:33 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTiy-0001mt-6s
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:32 -0400
Received: by mail-pg1-x541.google.com with SMTP id s2so3568187pgv.6
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nHCew20BijBgDTCdBkWUv5DBbqMwI8TECdarYx84Be0=;
 b=V+LMHNsnOVSXALkvL48rkdPvfQ2i2bNIt3vpd28RpLdIpTdHAvnW36jQS3M7iZ8s/D
 e6dv+vkt63XIuUR3IeLYwfh6V5qRIIN5H5WuPe5CFZ+6/WCcOjizs0r18zuz5OaK4hZQ
 nX9utMDBGeCmdBSkxyqGyY1XW+YXUCtRh8CM41XngGGg6roum2QVnumOo+AKsj6CeEEx
 Y08uceS9ihn31NzaxSc+3s9GB+wISnmRmh3sXsTR6Zsi8vdG2LLDLweSeJKS4zPyJaHL
 q6DsHgKgnB9oxRONcvcFmoJvPM5M36IJtFJ3RC8868UCsCce1mV0hwS6EB/qBPsIYrE1
 28UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nHCew20BijBgDTCdBkWUv5DBbqMwI8TECdarYx84Be0=;
 b=c3Wir+wS1yndb/7nQOdlTrp693tOzJaxHIDiAUFrv0AyePqkVfJmJYC1KvUZEH/pmU
 xY4XLhYrNs0uaJMfLL2QcBJraH6eM1AOMpeDXwyn1yFhZq1O0JczEOxTtORfi0IkiD8t
 rGXA9Cy3qg4yXKKU3JuKNrL5F64ex63mvkVt1sYVoHc7NcyzHHthX2uoQr4eKIKnBD75
 Wp1CAVCzkUb/fNVENVPlrlrMGXZNDiMzqPsP1EsMQW1lPj/Wgm28YCBxLLnHtsKdCCXc
 Kys6cp3Cyyjgv2HelNUp5CHGONws9swFTL1h8c/SM/OUH3sCCDQDp+xT0AWb85PLH9GV
 TyNg==
X-Gm-Message-State: ANhLgQ32QmeIx/Q0O6l3Hj50LxDjswz+/gl18hN+ZUnz52ZNItnR0NFz
 8uqA26E7SAB5WWGKyg/Bu8LPGb/+/+Q=
X-Google-Smtp-Source: ADFU+vsZVTOdt+XD+UWal4aT2qMdJ8GwZJTc7l306+QMFq9t4F6bhikps2AAcwLdAfr0rZwEHGqMTA==
X-Received: by 2002:aa7:9811:: with SMTP id e17mr9387051pfl.33.1584042150533; 
 Thu, 12 Mar 2020 12:42:30 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/42] target/arm: Add MTE system registers
Date: Thu, 12 Mar 2020 12:41:44 -0700
Message-Id: <20200312194219.24406-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is TFSRE0_EL1, TFSR_EL1, TFSR_EL2, TFSR_EL3,
RGSR_EL1, GCR_EL1, GMID_EL1, and PSTATE.TCO.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Add GMID; add access_mte.
v4: Define only TCO at mte_insn_reg.
v6: Define RAZ/WI version of TCO at mte_insn_reg;
    honor TID5 for GMID_EL1; fix TFS crn/crm; recalc hflags after TCO.
---
 target/arm/cpu.h           |  4 ++
 target/arm/internals.h     |  6 +++
 target/arm/helper.c        | 94 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 21 +++++++++
 4 files changed, 125 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a77b0d97ac..25351abd15 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -492,6 +492,9 @@ typedef struct CPUARMState {
         uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
         uint64_t vpidr_el2; /* Virtualization Processor ID Register */
         uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register */
+        uint64_t tfsr_el[4]; /* tfsre0_el1 is index 0.  */
+        uint64_t gcr_el1;
+        uint64_t rgsr_el1;
     } cp15;
 
     struct {
@@ -1259,6 +1262,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_SS (1U << 21)
 #define PSTATE_PAN (1U << 22)
 #define PSTATE_UAO (1U << 23)
+#define PSTATE_TCO (1U << 25)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a833e3941d..0591f30526 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1233,4 +1233,10 @@ void arm_log_exception(int idx);
 
 #endif /* !CONFIG_USER_ONLY */
 
+/*
+ * The log2 of the words in the tag block, for GMID_EL1.BS.
+ * The is the maximum, 256 bytes, which manipulates 64-bits of tags.
+ */
+#define GMID_EL1_BS  6
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b9267ddbc2..b47209be64 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5869,6 +5869,9 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
           "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
 
+        { K(3, 0,  5, 6, 0), K(3, 4,  5, 6, 0), K(3, 5, 5, 6, 0),
+          "TFSR_EL1", "TFSR_EL2", "TFSR_EL12", isar_feature_aa64_mte },
+
         /* TODO: ARMv8.2-SPE -- PMSCR_EL2 */
         /* TODO: ARMv8.4-Trace -- TRFCR_EL2 */
     };
@@ -6840,6 +6843,86 @@ static const ARMCPRegInfo dcpodp_reg[] = {
 };
 #endif /*CONFIG_USER_ONLY*/
 
+static CPAccessResult access_aa64_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID5)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el < 2 &&
+        arm_feature(env, ARM_FEATURE_EL2) &&
+        !(arm_hcr_el2_eff(env) & HCR_ATA)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    if (el < 3 &&
+        arm_feature(env, ARM_FEATURE_EL3) &&
+        !(env->cp15.scr_el3 & SCR_ATA)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static uint64_t tco_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return env->pstate & PSTATE_TCO;
+}
+
+static void tco_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t val)
+{
+    env->pstate = (env->pstate & ~PSTATE_TCO) | (val & PSTATE_TCO);
+}
+
+static const ARMCPRegInfo mte_reginfo[] = {
+    { .name = "TFSRE0_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 6, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[0]) },
+    { .name = "TFSR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 6, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
+    { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 6, .opc2 = 0,
+      .access = PL2_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[2]) },
+    { .name = "TFSR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 6, .opc2 = 0,
+      .access = PL3_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[3]) },
+    { .name = "RGSR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 5,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.rgsr_el1) },
+    { .name = "GCR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 6,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcr_el1) },
+    { .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
+      .access = PL1_R, .accessfn = access_aa64_tid5,
+      .type = ARM_CP_CONST, .resetvalue = GMID_EL1_BS },
+    { .name = "TCO", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 2, .opc2 = 7,
+      .type = ARM_CP_NO_RAW,
+      .access = PL0_RW, .readfn = tco_read, .writefn = tco_write },
+    REGINFO_SENTINEL
+};
+
+static const ARMCPRegInfo mte_tco_ro_reginfo[] = {
+    { .name = "TCO", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 2, .opc2 = 7,
+      .type = ARM_CP_CONST, .access = PL0_RW, },
+    REGINFO_SENTINEL
+};
 #endif
 
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -7957,6 +8040,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         }
     }
 #endif /*CONFIG_USER_ONLY*/
+
+    /*
+     * If full MTE is enabled, add all of the system registers.
+     * If only "instructions available at EL0" are enabled,
+     * then define only a RAZ/WI version of PSTATE.TCO.
+     */
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        define_arm_cp_regs(cpu, mte_reginfo);
+    } else if (cpu_isar_feature(aa64_mte_insn_reg, cpu)) {
+        define_arm_cp_regs(cpu, mte_tco_ro_reginfo);
+    }
 #endif
 
     if (cpu_isar_feature(any_predinv, cpu)) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 943d6034de..528f608408 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1664,6 +1664,27 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         s->base.is_jmp = DISAS_UPDATE_EXIT;
         break;
 
+    case 0x1c: /* TCO */
+        if (dc_isar_feature(aa64_mte, s)) {
+            /* Full MTE is enabled -- set the TCO bit as directed. */
+            if (crm & 1) {
+                set_pstate_bits(PSTATE_TCO);
+            } else {
+                clear_pstate_bits(PSTATE_TCO);
+            }
+            t1 = tcg_const_i32(s->current_el);
+            gen_helper_rebuild_hflags_a64(cpu_env, t1);
+            tcg_temp_free_i32(t1);
+            /* Many factors, including TCO, go into MTE_ACTIVE. */
+            s->base.is_jmp = DISAS_UPDATE_NOCHAIN;
+        } else if (dc_isar_feature(aa64_mte_insn_reg, s)) {
+            /* Only "instructions accessible at EL0" -- PSTATE.TCO is WI.  */
+            s->base.is_jmp = DISAS_NEXT;
+        } else {
+            goto do_unallocated;
+        }
+        break;
+
     default:
     do_unallocated:
         unallocated_encoding(s);
-- 
2.20.1


