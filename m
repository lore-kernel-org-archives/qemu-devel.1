Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A77C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C84206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwmKw1zZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C84206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnon8-0002hj-1p
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojL-0003Ss-Hh
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:15 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojJ-0005ZK-FN
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so24938pgh.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MM8DwWcq9hOSHM42D5IzB2vhHpCdrEbYJvs5bn0zsdM=;
 b=gwmKw1zZH2XhERQD0gIHGyRd7zW05Glm/Q7IhSZ5z+n3ppmFPT7ZpNKEdHtVxO3k6v
 0gOpd6OY6XHjdxJcUShbvZYeTSOkOAuFGteg5FvP0/lTg8afJMtxQMQbFlRZvM56DBFR
 jVYDrVDDOcn2OynlnR0WvOEoXwgdjH40r5SfP0MOjpJNDfd5PLIPS3UiqJGTLsAVLRXW
 v3ciesGWHAPw9MEP5CDm9AlSOgJTnLwP95uo3rIuLEOryRYC3bnHvmfKN89ipw7ukBTP
 tl/SIqIM3oKKCMphAiROsUe0al5xQNav4aesU3LZUe4pg7RpHJZC1xmXb6N/hyV4umAB
 A5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MM8DwWcq9hOSHM42D5IzB2vhHpCdrEbYJvs5bn0zsdM=;
 b=EFO+Nc7efDOrkSwOVQJtzKw3mnj79DrDFuVuSzIfJGLwXvEoQEkgHF6VznPo6n/oOr
 4wFAvSeJi5YLjowUQGkYkXEoPnzx6dAgdw5I7LM38Q6dyP2hCYVaq3LmCfhGsgs5tVu1
 nrp5MNIljrxCAGKn4WfWGnJiMfcwLQRH1HD/PxDcyLInZ3V8o14QcfkF1W81dX0789vk
 oPXVf1Xzy13rCUKLjeGxL6o8cu2d0X/C/o1LU+8XZxn0JJoXlyrTgd/ls+pKBPvRyjop
 MfoIeZTktNbYklt6eMC5p2Bdj9YLkFVxMpE6fj96rwvRym5Sk2qXhgfS868VK2kPI8xW
 fInA==
X-Gm-Message-State: AOAM531WGrAQa5KT3tznh0ci/c3jvT/yv1kCt67lNo2cgOuA1R6da6/4
 EAq03ud5K05WxbZBmar0KakA859j4oc=
X-Google-Smtp-Source: ABdhPJxmWOm+rtGe+q50wNF7oLrFI9K1gsyeUa9OYCR52KJWHFPJGKfLEaOSDgGMQb6NoQHBMH40QA==
X-Received: by 2002:a63:c44b:: with SMTP id m11mr17553111pgg.404.1592941031511; 
 Tue, 23 Jun 2020 12:37:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 08/45] target/arm: Add MTE bits to tb_flags
Date: Tue, 23 Jun 2020 12:36:21 -0700
Message-Id: <20200623193658.623279-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cache the composite ATA setting.

Cache when MTE is fully enabled, i.e. access to tags are enabled
and tag checks affect the PE.  Do this for both the normal context
and the UNPRIV context.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index c6f9376000..dbbf6145cb 100644
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
index b4842ea23e..2c6ec244af 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10655,6 +10655,16 @@ static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
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
@@ -12679,6 +12689,36 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
index efdfd50fb6..717cb96a40 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14183,6 +14183,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->mmu_idx = core_to_aa64_mmu_idx(core_mmu_idx);
     dc->tbii = FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
     dc->tbid = FIELD_EX32(tb_flags, TBFLAG_A64, TBID);
+    dc->tcma = FIELD_EX32(tb_flags, TBFLAG_A64, TCMA);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
@@ -14194,6 +14195,9 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
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


