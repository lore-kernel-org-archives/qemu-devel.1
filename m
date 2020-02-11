Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA01C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D93120661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znBIwIhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D93120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZXi-0003VY-9o
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTj-0005k6-FZ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTg-00044R-SW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:43 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTc-0003zB-FU
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:36 -0500
Received: by mail-wr1-x442.google.com with SMTP id w12so13502869wrt.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/e1L4KBHqvWrooUDR5lzsFsfvdP9rosN0/X6B5pxbVQ=;
 b=znBIwIhDmIxmIoTItLT0q7uzwiIA1KqsWbNUs92C22Qac89yVzNPSPcsdULHf6dxia
 QS7P3j70Mga4qlgBM6wKNwkPjfeOVBNGf93pJOpuLFvq87RFvp/0O8hXInydbaVpEdjH
 Veorn/QTTAqMcJ40itejTs0+6n5+2Z8ukBhYyRpZKrj9O51vKtRgzi5vGZKwO/BI2kHN
 RzG32HLjiwJD3hCKkaJY1wqYx3K0d3hhpOdSB/0pVQ44nz/dgnvFMpsohquApZ2kKE16
 +f4GrpAl5mIaHDDQuwVdQhk8/r7gWvaDRold5DFmxnGtGUaA5NohEtzhAR46i1Q+jQyi
 GZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/e1L4KBHqvWrooUDR5lzsFsfvdP9rosN0/X6B5pxbVQ=;
 b=rKSRnlmBV3oNqLv9WBz5k1NsqrDICfmRN3bKrL6z1lpx0QwWlv4jYumWeuFom7vDhD
 pwl7grNztEmZnfPQuYgPS+soZDQWPDvLzVE82nntZWFlvxdbqSv3N6vBRhX8EpaV4NNz
 AEZrYW9d6GmeBBuHV9pTS9W6j3lFBX/zYwlKSCOAY+gg8Dad1KecMYJ98ZpQzGfDtTn+
 GKDwfcLl0CqRIUI3/GEi12iuwjZKVFGpImnS5exSkxb7iOYl6+dgrC2NLrsnbaCKwGNo
 bCOj3e8HZmLrPvMYH6TTDr2EP2VXNqH3YOkO3De+s6RYe2vmDHOwUs7LdTkbed+Eqqv8
 U5NQ==
X-Gm-Message-State: APjAAAXCffMlQqTEO3i5Sf5ADBiGWQE1div+HqCOc4hpJMmOPo5KYbCS
 IPpN5GMHwr2gBLv5TCOdsCNf6RPl8Nw=
X-Google-Smtp-Source: APXvYqxOWNYW3nNqRyS/ABbF2BhH7ibyYcfByZ6QXJszxXBGdIf7Qepv39FLO5GgnqPwQhDjuejDHg==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr10154631wru.55.1581442655275; 
 Tue, 11 Feb 2020 09:37:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/13] target/arm: Factor out PMU register definitions
Date: Tue, 11 Feb 2020 17:37:17 +0000
Message-Id: <20200211173726.22541-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pull the code that defines the various PMU registers out
into its own function, matching the pattern we have
already for the debug registers.

Apart from one style fix to a multi-line comment, this
is purely movement of code with no changes to it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 158 +++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 76 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bf083c369fc..0011a22f42d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5822,6 +5822,87 @@ static void define_debug_regs(ARMCPU *cpu)
     }
 }
 
+static void define_pmu_regs(ARMCPU *cpu)
+{
+    /*
+     * v7 performance monitor control register: same implementor
+     * field as main ID register, and we implement four counters in
+     * addition to the cycle count register.
+     */
+    unsigned int i, pmcrn = 4;
+    ARMCPRegInfo pmcr = {
+        .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
+        .access = PL0_RW,
+        .type = ARM_CP_IO | ARM_CP_ALIAS,
+        .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcr),
+        .accessfn = pmreg_access, .writefn = pmcr_write,
+        .raw_writefn = raw_write,
+    };
+    ARMCPRegInfo pmcr64 = {
+        .name = "PMCR_EL0", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 0,
+        .access = PL0_RW, .accessfn = pmreg_access,
+        .type = ARM_CP_IO,
+        .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
+        .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
+        .writefn = pmcr_write, .raw_writefn = raw_write,
+    };
+    define_one_arm_cp_reg(cpu, &pmcr);
+    define_one_arm_cp_reg(cpu, &pmcr64);
+    for (i = 0; i < pmcrn; i++) {
+        char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
+        char *pmevcntr_el0_name = g_strdup_printf("PMEVCNTR%d_EL0", i);
+        char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
+        char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
+        ARMCPRegInfo pmev_regs[] = {
+            { .name = pmevcntr_name, .cp = 15, .crn = 14,
+              .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
+              .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
+              .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
+              .accessfn = pmreg_access },
+            { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 8 | (3 & (i >> 3)),
+              .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
+              .type = ARM_CP_IO,
+              .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
+              .raw_readfn = pmevcntr_rawread,
+              .raw_writefn = pmevcntr_rawwrite },
+            { .name = pmevtyper_name, .cp = 15, .crn = 14,
+              .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
+              .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
+              .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
+              .accessfn = pmreg_access },
+            { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 12 | (3 & (i >> 3)),
+              .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
+              .type = ARM_CP_IO,
+              .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
+              .raw_writefn = pmevtyper_rawwrite },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, pmev_regs);
+        g_free(pmevcntr_name);
+        g_free(pmevcntr_el0_name);
+        g_free(pmevtyper_name);
+        g_free(pmevtyper_el0_name);
+    }
+    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
+            FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
+        ARMCPRegInfo v81_pmu_regs[] = {
+            { .name = "PMCEID2", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 4,
+              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
+              .resetvalue = extract64(cpu->pmceid0, 32, 32) },
+            { .name = "PMCEID3", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 5,
+              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
+              .resetvalue = extract64(cpu->pmceid1, 32, 32) },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, v81_pmu_regs);
+    }
+}
+
 /* We don't know until after realize whether there's a GICv3
  * attached, and that is what registers the gicv3 sysregs.
  * So we have to fill in the GIC fields in ID_PFR/ID_PFR1_EL1/ID_AA64PFR0_EL1
@@ -6244,67 +6325,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, pmovsset_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_V7)) {
-        /* v7 performance monitor control register: same implementor
-         * field as main ID register, and we implement four counters in
-         * addition to the cycle count register.
-         */
-        unsigned int i, pmcrn = 4;
-        ARMCPRegInfo pmcr = {
-            .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
-            .access = PL0_RW,
-            .type = ARM_CP_IO | ARM_CP_ALIAS,
-            .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcr),
-            .accessfn = pmreg_access, .writefn = pmcr_write,
-            .raw_writefn = raw_write,
-        };
-        ARMCPRegInfo pmcr64 = {
-            .name = "PMCR_EL0", .state = ARM_CP_STATE_AA64,
-            .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 0,
-            .access = PL0_RW, .accessfn = pmreg_access,
-            .type = ARM_CP_IO,
-            .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
-            .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
-            .writefn = pmcr_write, .raw_writefn = raw_write,
-        };
-        define_one_arm_cp_reg(cpu, &pmcr);
-        define_one_arm_cp_reg(cpu, &pmcr64);
-        for (i = 0; i < pmcrn; i++) {
-            char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
-            char *pmevcntr_el0_name = g_strdup_printf("PMEVCNTR%d_EL0", i);
-            char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
-            char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
-            ARMCPRegInfo pmev_regs[] = {
-                { .name = pmevcntr_name, .cp = 15, .crn = 14,
-                  .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
-                  .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
-                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
-                  .accessfn = pmreg_access },
-                { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
-                  .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 8 | (3 & (i >> 3)),
-                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
-                  .type = ARM_CP_IO,
-                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
-                  .raw_readfn = pmevcntr_rawread,
-                  .raw_writefn = pmevcntr_rawwrite },
-                { .name = pmevtyper_name, .cp = 15, .crn = 14,
-                  .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
-                  .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
-                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
-                  .accessfn = pmreg_access },
-                { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
-                  .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 12 | (3 & (i >> 3)),
-                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
-                  .type = ARM_CP_IO,
-                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
-                  .raw_writefn = pmevtyper_rawwrite },
-                REGINFO_SENTINEL
-            };
-            define_arm_cp_regs(cpu, pmev_regs);
-            g_free(pmevcntr_name);
-            g_free(pmevcntr_el0_name);
-            g_free(pmevtyper_name);
-            g_free(pmevtyper_el0_name);
-        }
         ARMCPRegInfo clidr = {
             .name = "CLIDR", .state = ARM_CP_STATE_BOTH,
             .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 1,
@@ -6315,24 +6335,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &clidr);
         define_arm_cp_regs(cpu, v7_cp_reginfo);
         define_debug_regs(cpu);
+        define_pmu_regs(cpu);
     } else {
         define_arm_cp_regs(cpu, not_v7_cp_reginfo);
     }
-    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
-            FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
-        ARMCPRegInfo v81_pmu_regs[] = {
-            { .name = "PMCEID2", .state = ARM_CP_STATE_AA32,
-              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 4,
-              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
-              .resetvalue = extract64(cpu->pmceid0, 32, 32) },
-            { .name = "PMCEID3", .state = ARM_CP_STATE_AA32,
-              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 5,
-              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
-              .resetvalue = extract64(cpu->pmceid1, 32, 32) },
-            REGINFO_SENTINEL
-        };
-        define_arm_cp_regs(cpu, v81_pmu_regs);
-    }
     if (arm_feature(env, ARM_FEATURE_V8)) {
         /* AArch64 ID registers, which all have impdef reset values.
          * Note that within the ID register ranges the unused slots
-- 
2.20.1


