Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD69C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEAA20663
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsCrpmOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEAA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI1v-0001i1-QJ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyF-0003dP-Ng
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:31 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyE-0003Xl-Nc
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id t7so571966pgt.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Daiw2EtJyD/dc/N0oqXfOg3YFjBed/k9utJsMidR3kc=;
 b=DsCrpmOiVKG2vmtyDCwQJQQOthyPaVs60oHTNNtknbRuSLJ+9M+c8gHavPCM7zh0K6
 n1yvMYwkPw0VpG0C5sk7F5GoegE2ZSkZnmVoBG9VzoiG2WfcBo1YoFPRw6KLVzY2inPt
 VPoeOTV/jWUbBhPojkRqPrqTnyUDLAo8Lz5biVacTlk+r96zZWhKQtHvgwz7xAhzmYlk
 WsW4ny5ixbHCCCi9xi5/SoJGOoiZtqO0aONRJkiwSVdbiF8jUtPZ7iXbC1tKaXjF4yte
 DDONKSc0tuCuHnGV7Wy+CPTPwXaP8Bv4ZtwidCz3gCxe2+/35hsmYqiHBZ5bV/75RRkC
 0sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Daiw2EtJyD/dc/N0oqXfOg3YFjBed/k9utJsMidR3kc=;
 b=LnAyZ3jDnrHNtiaAwEzx4lnEmn3FCxorespuUvHc5d11eNaZ4Z8rxktVke3PeVzae1
 WJxgIV3xTtRsGSFaeaat59CCuCttsnAEjXhLkGcdleHG0gPGL/OfxyWXRRpmpuXKoZZq
 aNLvi2GlEUjzo8Y5/a0rFRiStBXovwzl6iEVoAZs40wtwMW3NXf9Bk6T5L7jeAW0+O09
 P/e2oaJ7GPS8wVcD9qsW71WBUtfoJL2zqiqH3XgxT337t/gwEsiarDLjnHoyUPVJkF3d
 SXVy7YIwtQBcuvR4UVUKL0wghjzDmFw6jt6ZbFcY1bGpWI+xbXPl7Q86Zn1EOGelHr6A
 lvVg==
X-Gm-Message-State: AOAM530RzxgLQhuFESPaUhpy23PTtrUaaeQ1YbIoYFLuioyDvSvpXB2o
 FNtNGr4JyZtbk45+4OR2CuXLyMkwhbU=
X-Google-Smtp-Source: ABdhPJw40EYdRFwTAbLvKVpxABvwz2rCG3CMmzrd2jKtdcKD6is/BhEelv+rl6nKYwC7B0XRdxQHxw==
X-Received: by 2002:a65:6790:: with SMTP id e16mr27471091pgr.145.1591146808805; 
 Tue, 02 Jun 2020 18:13:28 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/42] target/arm: Add MTE bits to tb_flags
Date: Tue,  2 Jun 2020 18:12:43 -0700
Message-Id: <20200603011317.473934-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cache the composite ATA setting.

Cache when MTE is fully enabled, i.e. access to tags are enabled
and tag checks affect the PE.  Do this for both the normal context
and the UNPRIV context.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Remove stub helper_mte_check; moved to a later patch.
v6: Add mte0_active and ata bits; drop reviewed-by.
---
 target/arm/cpu.h           | 12 ++++++++----
 target/arm/internals.h     | 18 +++++++++++++++++
 target/arm/translate.h     |  5 +++++
 target/arm/helper.c        | 40 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  4 ++++
 5 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 49cf37d43b..a5d3b6c9ee 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3187,10 +3187,10 @@ typedef ARMCPU ArchCPU;
  * |              |     |   TBFLAG_A32   |              |
  * |              |     +-----+----------+  TBFLAG_AM32 |
  * |  TBFLAG_ANY  |           |TBFLAG_M32|              |
- * |              |         +-+----------+--------------|
- * |              |         |         TBFLAG_A64        |
- * +--------------+---------+---------------------------+
- *  31          20        15                           0
+ * |              +-----------+----------+--------------|
+ * |              |            TBFLAG_A64               |
+ * +--------------+-------------------------------------+
+ *  31          20                                     0
  *
  * Unless otherwise noted, these bits are cached in env->hflags.
  */
@@ -3257,6 +3257,10 @@ FIELD(TBFLAG_A64, BT, 9, 1)
 FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
 FIELD(TBFLAG_A64, TBID, 12, 2)
 FIELD(TBFLAG_A64, UNPRIV, 14, 1)
+FIELD(TBFLAG_A64, ATA, 15, 1)
+FIELD(TBFLAG_A64, TCMA, 16, 2)
+FIELD(TBFLAG_A64, MTE_ACTIVE, 18, 1)
+FIELD(TBFLAG_A64, MTE0_ACTIVE, 19, 1)
 
 /**
  * cpu_mmu_index:
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 56b4672685..53e249687b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1198,6 +1198,24 @@ static inline int exception_target_el(CPUARMState *env)
     return target_el;
 }
 
+/* Determine if allocation tags are available.  */
+static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
+                                                 uint64_t sctlr)
+{
+    if (el < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_ATA)) {
+        return false;
+    }
+    if (el < 2
+        && arm_feature(env, ARM_FEATURE_EL2)
+        && !(arm_hcr_el2_eff(env) & HCR_ATA)) {
+        return false;
+    }
+    sctlr &= (el == 0 ? SCTLR_ATA0 : SCTLR_ATA);
+    return sctlr != 0;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /* Security attributes for an address, as returned by v8m_security_lookup. */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 81e47677c7..4fb0feece9 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -30,6 +30,7 @@ typedef struct DisasContext {
     ARMMMUIdx mmu_idx; /* MMU index to use for normal loads/stores */
     uint8_t tbii;      /* TBI1|TBI0 for insns */
     uint8_t tbid;      /* TBI1|TBI0 for data */
+    uint8_t tcma;      /* TCMA1|TCMA0 for MTE */
     bool ns;        /* Use non-secure CPREG bank on access */
     int fp_excp_el; /* FP exception EL or 0 if enabled */
     int sve_excp_el; /* SVE exception EL or 0 if enabled */
@@ -77,6 +78,10 @@ typedef struct DisasContext {
     bool unpriv;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
+    /* True if v8.5-MTE access to tags is enabled.  */
+    bool ata;
+    /* True if v8.5-MTE tag checks affect the PE; index with is_unpriv.  */
+    bool mte_active[2];
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
     /* True if any CP15 access is trapped by HSTR_EL2 */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 88ca07ad0f..8aaa6f22b2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10653,6 +10653,16 @@ static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
     }
 }
 
+static int aa64_va_parameter_tcma(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 57, 2);
+    } else {
+        /* Replicate the single TCMA bit so we always have 2 bits.  */
+        return extract32(tcr, 30, 1) * 3;
+    }
+}
+
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data)
 {
@@ -12677,6 +12687,36 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    if (cpu_isar_feature(aa64_mte, env_archcpu(env))) {
+        /*
+         * Set MTE_ACTIVE if any access may be Checked, and leave clear
+         * if all accesses must be Unchecked:
+         * 1) If no TBI, then there are no tags in the address to check,
+         * 2) If Tag Check Override, then all accesses are Unchecked,
+         * 3) If Tag Check Fail == 0, then Checked access have no effect,
+         * 4) If no Allocation Tag Access, then all accesses are Unchecked.
+         */
+        if (allocation_tag_access_enabled(env, el, sctlr)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, ATA, 1);
+            if (tbid
+                && !(env->pstate & PSTATE_TCO)
+                && (sctlr & (el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
+                flags = FIELD_DP32(flags, TBFLAG_A64, MTE_ACTIVE, 1);
+            }
+        }
+        /* And again for unprivileged accesses, if required.  */
+        if (FIELD_EX32(flags, TBFLAG_A64, UNPRIV)
+            && tbid
+            && !(env->pstate & PSTATE_TCO)
+            && (sctlr & SCTLR_TCF0)
+            && allocation_tag_access_enabled(env, 0, sctlr)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, MTE0_ACTIVE, 1);
+        }
+        /* Cache TCMA as well as TBI. */
+        flags = FIELD_DP32(flags, TBFLAG_A64, TCMA, 
+                           aa64_va_parameter_tcma(tcr, mmu_idx));
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 284266be67..ec2013782d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14213,6 +14213,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->mmu_idx = core_to_aa64_mmu_idx(core_mmu_idx);
     dc->tbii = FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
     dc->tbid = FIELD_EX32(tb_flags, TBFLAG_A64, TBID);
+    dc->tcma = FIELD_EX32(tb_flags, TBFLAG_A64, TCMA);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
@@ -14224,6 +14225,9 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
     dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
     dc->unpriv = FIELD_EX32(tb_flags, TBFLAG_A64, UNPRIV);
+    dc->ata = FIELD_EX32(tb_flags, TBFLAG_A64, ATA);
+    dc->mte_active[0] = FIELD_EX32(tb_flags, TBFLAG_A64, MTE_ACTIVE);
+    dc->mte_active[1] = FIELD_EX32(tb_flags, TBFLAG_A64, MTE0_ACTIVE);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.25.1


