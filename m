Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0165C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903712171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGPtrJi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903712171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvTX-0002Iv-RW
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60897)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMn-0004d9-MO
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMl-0003UA-SS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:33 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMl-0003TB-LH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:31 -0400
Received: by mail-pf1-x443.google.com with SMTP id b13so32516048pfo.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mRFuXKk2Gwl0/7zE7hzogtQkhwOwZ57w0oxCxJ+Y7Jc=;
 b=fGPtrJi5lMT5db66q3lUVogvy1stjLkaPyGvAtBruficEjFf1GvyrkRNhgkQl2/+Uy
 PytEwlEo6zjLNTsti/sxJCtyURJN1c/GHPruTRIM1qdfdeGgutEryRyGQzlFZf3pHqLg
 Ivkq3Qq+R8rFUk1KnhllUNqnojOcSoCOVLX7du2gD/3wM79ZmeOsXB2Wf0y3GtSDQALc
 GhobsRrQjPV5M+S6svitEK/ZjYtfMlEMiPYsUmhs+baG/X8wrbFaR6i3R+WEYrcHhMCs
 Wn9bbbjAM4C7USvW50fi5Q3F/jskctSNB5bIl4bqsgo4trJQTP8k6b3sLRTJoHx8CD9i
 7Gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mRFuXKk2Gwl0/7zE7hzogtQkhwOwZ57w0oxCxJ+Y7Jc=;
 b=eWWXuaPj9iwz5aT2Kfs7+b5BYHmE6LLAlOHJEq8wgfVv/gFW9aV0T8WJKdf4kAaP0s
 xz+NP09D4QaciTFwwJyneRu5gYxk2Stph44oQQeaUnyCE+rMmBL/DIhp9Xp/7uSzwGoi
 Zv6gpcoEsP5+WwHu/D/v+Q/17HTg7jTCtfLfvAlkk1IP2GVZnddQtd51k6WmKhGopxny
 b7kMIb9lqNq05IIj79lL5Em+8aiRorY1MJQ2OatzulDuj8tvAl9ZD/owEWcvLl1sJ7s1
 g1WannuvAbiaXD1Q/lBQXHarYK8w41B/crPO2VRsRJSMCUCRrYCIKUcCgjKoekxW5Gyz
 Nx5A==
X-Gm-Message-State: APjAAAU8TIe+xjWzivo8FPfzU66XYYSn0TxGMhOlrGuawhQM3uXy2YFx
 yqSvf12wid6fuhKKKHlZYxQAKMnW5eM=
X-Google-Smtp-Source: APXvYqyhjZ5R+/B2YsiAszESP1POQNreO4Dns6HtEA1jSw4p0zZceg6blvW5kby/+CZe7bN6Hj4pxg==
X-Received: by 2002:a65:610a:: with SMTP id
 z10mr115874511pgu.178.1564605510226; 
 Wed, 31 Jul 2019 13:38:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:53 -0700
Message-Id: <20190731203813.30765-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 12/32] target/arm: Add VHE system register
 redirection and aliasing
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

Several of the EL1/0 registers are redirected to the EL2 version when in
EL2 and HCR_EL2.E2H is set.  Many of these registers have side effects.
Link together the two ARMCPRegInfo structures after they have been
properly instantiated.  Install common dispatch routines to all of the
relevant registers.

The same set of registers that are redirected also have additional
EL12/EL02 aliases created to access the original register that was
redirected.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  44 +++++++----
 target/arm/helper.c | 175 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bba4e1f984..a0f10b60eb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2455,19 +2455,6 @@ struct ARMCPRegInfo {
      */
     ptrdiff_t fieldoffset; /* offsetof(CPUARMState, field) */
 
-    /* Offsets of the secure and non-secure fields in CPUARMState for the
-     * register if it is banked.  These fields are only used during the static
-     * registration of a register.  During hashing the bank associated
-     * with a given security state is copied to fieldoffset which is used from
-     * there on out.
-     *
-     * It is expected that register definitions use either fieldoffset or
-     * bank_fieldoffsets in the definition but not both.  It is also expected
-     * that both bank offsets are set when defining a banked register.  This
-     * use indicates that a register is banked.
-     */
-    ptrdiff_t bank_fieldoffsets[2];
-
     /* Function for making any access checks for this register in addition to
      * those specified by the 'access' permissions bits. If NULL, no extra
      * checks required. The access check is performed at runtime, not at
@@ -2502,6 +2489,37 @@ struct ARMCPRegInfo {
      * fieldoffset is 0 then no reset will be done.
      */
     CPResetFn *resetfn;
+
+    union {
+        /*
+         * Offsets of the secure and non-secure fields in CPUARMState for
+         * the register if it is banked.  These fields are only used during
+         * the static registration of a register.  During hashing the bank
+         * associated with a given security state is copied to fieldoffset
+         * which is used from there on out.
+         *
+         * It is expected that register definitions use either fieldoffset
+         * or bank_fieldoffsets in the definition but not both.  It is also
+         * expected that both bank offsets are set when defining a banked
+         * register.  This use indicates that a register is banked.
+         */
+        ptrdiff_t bank_fieldoffsets[2];
+
+        /*
+         * "Original" writefn and readfn.
+         * For ARMv8.1-VHE register aliases, we overwrite the read/write
+         * accessor functions of various EL1/EL0 to perform the runtime
+         * check for which sysreg should actually be modified, and then
+         * forwards the operation.  Before overwriting the accessors,
+         * the original function is copied here, so that accesses that
+         * really do go to the EL1/EL0 version proceed normally.
+         * (The corresponding EL2 register is linked via opaque.)
+         */
+        struct {
+            CPReadFn *orig_readfn;
+            CPWriteFn *orig_writefn;
+        };
+    };
 };
 
 /* Macros which are lvalues for the field in CPUARMState for the
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e0f5627218..e9f4cae5e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5225,6 +5225,171 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+#ifndef CONFIG_USER_ONLY
+/* Test if system register redirection is to occur in the current state.  */
+static bool redirect_for_e2h(CPUARMState *env)
+{
+    return arm_current_el(env) == 2 && (arm_hcr_el2_eff(env) & HCR_E2H);
+}
+
+static uint64_t el2_e2h_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    CPReadFn *readfn;
+
+    if (redirect_for_e2h(env)) {
+        /* Switch to the saved EL2 version of the register.  */
+        ri = ri->opaque;
+        readfn = ri->readfn;
+    } else {
+        readfn = ri->orig_readfn;
+    }
+    if (readfn == NULL) {
+        readfn = raw_read;
+    }
+    return readfn(env, ri);
+}
+
+static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    CPWriteFn *writefn;
+
+    if (redirect_for_e2h(env)) {
+        /* Switch to the saved EL2 version of the register.  */
+        ri = ri->opaque;
+        writefn = ri->writefn;
+    } else {
+        writefn = ri->orig_writefn;
+    }
+    if (writefn == NULL) {
+        writefn = raw_write;
+    }
+    writefn(env, ri, value);
+}
+
+static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
+{
+    struct E2HAlias {
+        uint32_t src_key, dst_key, new_key;
+        const char *src_name, *dst_name, *new_name;
+        bool (*feature)(const ARMISARegisters *id);
+    };
+
+#define K(op0, op1, crn, crm, op2) \
+    ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
+
+    static const struct E2HAlias aliases[] = {
+        { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
+          "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
+        { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
+          "CPACR", "CPTR_EL2", "CPACR_EL12" },
+        { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
+          "TTBR0_EL1", "TTBR0_EL2", "TTBR0_EL12" },
+        { K(3, 0,  2, 0, 1), K(3, 4,  2, 0, 1), K(3, 5, 2, 0, 1),
+          "TTBR1_EL1", "TTBR1_EL2", "TTBR1_EL12" },
+        { K(3, 0,  2, 0, 2), K(3, 4,  2, 0, 2), K(3, 5, 2, 0, 2),
+          "TCR_EL1", "TCR_EL2", "TCR_EL12" },
+        { K(3, 0,  4, 0, 0), K(3, 4,  4, 0, 0), K(3, 5, 4, 0, 0),
+          "SPSR_EL1", "SPSR_EL2", "SPSR_EL12" },
+        { K(3, 0,  4, 0, 1), K(3, 4,  4, 0, 1), K(3, 5, 4, 0, 1),
+          "ELR_EL1", "ELR_EL2", "ELR_EL12" },
+        { K(3, 0,  5, 1, 0), K(3, 4,  5, 1, 0), K(3, 5, 5, 1, 0),
+          "AFSR0_EL1", "AFSR0_EL2", "AFSR0_EL12" },
+        { K(3, 0,  5, 1, 1), K(3, 4,  5, 1, 1), K(3, 5, 5, 1, 1),
+          "AFSR1_EL1", "AFSR1_EL2", "AFSR1_EL12" },
+        { K(3, 0,  5, 2, 0), K(3, 4,  5, 2, 0), K(3, 5, 5, 2, 0),
+          "ESR_EL1", "ESR_EL2", "ESR_EL12" },
+        { K(3, 0,  6, 0, 0), K(3, 4,  6, 0, 0), K(3, 5, 6, 0, 0),
+          "FAR_EL1", "FAR_EL2", "FAR_EL12" },
+        { K(3, 0, 10, 2, 0), K(3, 4, 10, 2, 0), K(3, 5, 10, 2, 0),
+          "MAIR_EL1", "MAIR_EL2", "MAIR_EL12" },
+        { K(3, 0, 10, 3, 0), K(3, 4, 10, 3, 0), K(3, 5, 10, 3, 0),
+          "AMAIR0", "AMAIR_EL2", "AMAIR_EL12" },
+        { K(3, 0, 12, 0, 0), K(3, 4, 12, 0, 0), K(3, 5, 12, 0, 0),
+          "VBAR", "VBAR_EL2", "VBAR_EL12" },
+        { K(3, 0, 13, 0, 1), K(3, 4, 13, 0, 1), K(3, 5, 13, 0, 1),
+          "CONTEXTIDR_EL1", "CONTEXTIDR_EL2", "CONTEXTIDR_EL12" },
+        { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
+          "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
+        { K(3, 3, 14, 2, 0), K(3, 4, 14, 2, 0), K(3, 5, 14, 2, 0),
+          "CNTP_TVAL_EL0", "CNTHP_TVAL_EL2", "CNTP_TVAL_EL02" },
+        { K(3, 3, 14, 2, 1), K(3, 4, 14, 2, 1), K(3, 5, 14, 2, 1),
+          "CNTP_CTL_EL0", "CNTHP_CTL_EL2", "CNTP_CTL_EL02" },
+        { K(3, 3, 14, 2, 2), K(3, 4, 14, 2, 2), K(3, 5, 14, 2, 2),
+          "CNTP_CVAL_EL0", "CNTHP_CVAL_EL2", "CNTP_CVAL_EL02" },
+        { K(3, 3, 14, 3, 0), K(3, 4, 14, 3, 0), K(3, 5, 14, 3, 0),
+          "CNTV_TVAL_EL0", "CNTHV_TVAL_EL2", "CNTV_TVAL_EL02" },
+        { K(3, 3, 14, 3, 1), K(3, 4, 14, 3, 1), K(3, 5, 14, 3, 1),
+          "CNTV_CTL_EL0", "CNTHV_CTL_EL2", "CNTV_CTL_EL02" },
+        { K(3, 3, 14, 3, 2), K(3, 4, 14, 3, 2), K(3, 5, 14, 3, 2),
+          "CNTV_CVAL_EL0", "CNTHV_CVAL_EL2", "CNTV_CVAL_EL02" },
+        /*
+         * CNTHV_CVAL is a special case because there is no separate
+         * AArch32 EL2 register to which CNTV_CVAL may be directed.
+         * The effect can be achieved via CNTHV_CVAL_EL2.
+         */
+        { ENCODE_CP_REG(15, 1, 1, 0, 14, 3, 0), K(3, 4, 14, 3, 2), 0,
+          "CNTV_CVAL", "CNTHV_CVAL_EL2", NULL },
+
+        /*
+         * Note that redirection of ZCR is mentioned in the description
+         * of ZCR_EL2, and aliasing in the description of ZCR_EL1, but
+         * not in the summary table.
+         */
+        { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
+          "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
+
+        /* TODO: ARMv8.2-SPE -- PMSCR_EL2 */
+        /* TODO: ARMv8.4-Trace -- TRFCR_EL2 */
+    };
+#undef K
+
+    size_t i;
+
+    for (i = 0; i < ARRAY_SIZE(aliases); i++) {
+        const struct E2HAlias *a = &aliases[i];
+        ARMCPRegInfo *src_reg, *dst_reg;
+
+        if (a->feature && !a->feature(&cpu->isar)) {
+            continue;
+        }
+
+        src_reg = g_hash_table_lookup(cpu->cp_regs, &a->src_key);
+        dst_reg = g_hash_table_lookup(cpu->cp_regs, &a->dst_key);
+        g_assert(src_reg != NULL);
+        g_assert(dst_reg != NULL);
+
+        /* Cross-compare names to detect typos in the keys.  */
+        g_assert(strcmp(src_reg->name, a->src_name) == 0);
+        g_assert(strcmp(dst_reg->name, a->dst_name) == 0);
+
+        /* None of the core system registers use opaque; we will.  */
+        g_assert(src_reg->opaque == NULL);
+
+        /* Create alias before redirection so we dup the right data. */
+        if (a->new_key) {
+            ARMCPRegInfo *new_reg = g_memdup(src_reg, sizeof(ARMCPRegInfo));
+            uint32_t *new_key = g_memdup(&a->new_key, sizeof(uint32_t));
+            bool ok;
+
+            new_reg->name = a->new_name;
+            new_reg->type |= ARM_CP_ALIAS;
+            /* Remove PL1/PL0 access, leaving PL2/PL3 R/W in place.  */
+            new_reg->access &= 0xf0;
+
+            ok = g_hash_table_insert(cpu->cp_regs, new_key, new_reg);
+            g_assert(ok);
+        }
+
+        src_reg->opaque = dst_reg;
+        src_reg->orig_readfn = src_reg->readfn;
+        src_reg->orig_writefn = src_reg->writefn;
+        src_reg->readfn = el2_e2h_read;
+        src_reg->writefn = el2_e2h_write;
+    }
+}
+#endif
+
 static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -6942,6 +7107,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         : cpu_isar_feature(aa32_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
+
+#ifndef CONFIG_USER_ONLY
+    /*
+     * Register redirections and aliases must be done last,
+     * after the registers from the other extensions have been defined.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
+        define_arm_vh_e2h_redirects_aliases(cpu);
+    }
+#endif
 }
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
-- 
2.17.1


