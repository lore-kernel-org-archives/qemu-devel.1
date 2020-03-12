Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42732C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEF72071B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCrPxJ/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEF72071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTpf-0006s8-2p
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj2-00053X-BM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTiz-0001oS-LS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:35 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTiz-0001nk-E1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:33 -0400
Received: by mail-pf1-x442.google.com with SMTP id b72so3754393pfb.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v3HnglxX56mErtThbg9m+AvU02Yn5gFZNHR0wFCcWrA=;
 b=VCrPxJ/o1V6cV0K9Chu+aAUbIEu8FDZHbV6z4C8wP/8Q25s/VF69pe3Huw5f3pLT9v
 TNORqc0TCXrJgiZkVyKFaKOTQvt8UyY2ztO+9xeXmZqBw5Uqu/kIVB42wlEXJMP6xeZA
 Uz/6yZIOHlNNDs0sM0IMnJQdcGDIXUoixw7PEH115H+LLK79dXbWdlDpXjWmC/yqIkCF
 mGbWduh9Cwhc6XddWag2moqIAJ7sI8DJNT+vMc2w5k9jU2PNzrqDDOWmuhrPlBhuz0z9
 jr+wIMsZtHjww42+GhwMVr1xrT0Hu7GV+yHWN1VGnWVlnsPH+IkZ1GlZPcZ1JxS2DSdz
 eEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v3HnglxX56mErtThbg9m+AvU02Yn5gFZNHR0wFCcWrA=;
 b=JUltXVGiSYmNbFb/mzLFaDdiZsvw4n22CBMcTcf0uglRpiM5JtjiizgzJBZTQ9cQro
 q3j9KKUf9HWJXsQAffLmZ8rQdj4vvhPD7rnQi3bCadVqV5aZFXrn7C+k4zWuSRwHqm29
 XNIaLVtk6CZrwl81ge9oAkcpNBKaiFG2kSGaWbL24Q6uPRQ7nCpgQW7FlNqpfMzOjxea
 KHcELqO7RaWScGnOVg7sL07qvV5NCoxuphdDeZmq9DYRqQSZIrgiR3HctKi/Eq2NDVGE
 Q2A3RA72k/uLOr60De19Ztxtzz0tR1epnqwWAvt3/lUQQ3rnz/jO4OemADPLAqrsY6iN
 dnTQ==
X-Gm-Message-State: ANhLgQ2x0Blz5vlmyN11N7xTDzBrhEvno5piiZU9uCkAsuqOJV5Q/tQG
 enCeyPpu+Eba1eV1sXaq9wAQWIh1wdA=
X-Google-Smtp-Source: ADFU+vua+Ul78TU2QM5yAm3/1cTMui1/mdzF+VHvw4xL93lNILw0dJLOX9Lj6QAStm8sPvDzlVpSJw==
X-Received: by 2002:a62:5213:: with SMTP id g19mr9948702pfb.28.1584042151937; 
 Thu, 12 Mar 2020 12:42:31 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/42] target/arm: Add MTE bits to tb_flags
Date: Thu, 12 Mar 2020 12:41:45 -0700
Message-Id: <20200312194219.24406-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
index 25351abd15..67164d56a1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3155,10 +3155,10 @@ typedef ARMCPU ArchCPU;
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
@@ -3225,6 +3225,10 @@ FIELD(TBFLAG_A64, BT, 9, 1)
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
index 0591f30526..45f445cf3e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1194,6 +1194,24 @@ static inline int exception_target_el(CPUARMState *env)
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
index dbbb167174..e0f5d0be63 100644
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
index b47209be64..01d2fcf2e3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10587,6 +10587,16 @@ static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
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
@@ -12590,6 +12600,36 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
index 528f608408..5eda6ff975 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14335,6 +14335,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->mmu_idx = core_to_aa64_mmu_idx(core_mmu_idx);
     dc->tbii = FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
     dc->tbid = FIELD_EX32(tb_flags, TBFLAG_A64, TBID);
+    dc->tcma = FIELD_EX32(tb_flags, TBFLAG_A64, TCMA);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
@@ -14346,6 +14347,9 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
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
2.20.1


