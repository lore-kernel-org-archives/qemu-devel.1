Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA5DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DEC20716
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGqYmsVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DEC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxJX-0006dt-HY
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC2-0003ZJ-JS
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC1-0006ld-Di
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:22 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxC1-0006ij-6x
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:21 -0500
Received: by mail-pf1-x442.google.com with SMTP id 84so490995pfy.6
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jzDTKnTCcjosfdRZyFi04xD1b88UR01u1kjrxtS41SA=;
 b=AGqYmsVMSzsv3p/264kaBpdo2suSuLYntk7knkTtT/+Ne2dXK3l5mHlaRqjg/s7C06
 m4DRDvzx7/jEeTHNa25/UgklQ1KAkW70vulYgoYuGAO32yxKAMyi6mtrzfMgiO6aucdu
 zU+vDouFOUiGCeVzCpWH6EHzaBIQsLArjNdntCVC0qcAJ4mrixzySnHqsIhO6zNyBZ0z
 u+9UI3fIuoMnI14HPgOOayBhm+6b3JMUIBMFv7jDoUJkOYbhPlJ8AOeo0gfbBnA6iEs+
 hoGWunfcbiGVAzQ2ijSTQzzINgk/H5iJNiOMh5VnYgUH1oKZDZC6paLbmeIyLb9vwkWw
 SsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jzDTKnTCcjosfdRZyFi04xD1b88UR01u1kjrxtS41SA=;
 b=QYsJO+9bTVFarrT9i5w9uL/1aJgtej7TUmdpFL8xkoZGlhfxrTpX08GEztE+8S3Xy7
 gtpT8mIAgoe6853ZgNwJ56PWMKrY11wxyj9+hG/HilasMkBBkBVgPm+YF4M+beSRDNak
 humiiCtEeV+/sRIgP/Hhw+2RT4KMpRz9S52fkayTlAHPOvxW2NaWpxki53f24qSLNNwX
 H7CYnIERT5F2UgmGcSIRY7ted0V7dlEVBf4alSHAYP0ZiHCEweIioGu6VNaCirylHKhj
 gnGPoBcKiBZ+QV8nBnCpsWKlyPIYuqg3O9t/h4oV9nX2yqnX3nFkFaXrgltbiBuD4Ff7
 LJvQ==
X-Gm-Message-State: APjAAAX/zjplxMMrBtPv6QK+LvrIlCqSqxo/p4iTvyAPggCWHBd9Nfpn
 ze+wgbyVMTs8reHIsmrYeum03IL6NLk=
X-Google-Smtp-Source: APXvYqzXNNmVjkr/93Wao7Mxk9nXVX7k2ia8bawXveGhRBOIasthq7xyFDUMaVDxN6y5EoH9CywQLw==
X-Received: by 2002:a63:3245:: with SMTP id y66mr1691237pgy.234.1580342179739; 
 Wed, 29 Jan 2020 15:56:19 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/41] target/arm: Add CONTEXTIDR_EL2
Date: Wed, 29 Jan 2020 15:55:36 -0800
Message-Id: <20200129235614.29829-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all of the breakpoint types are supported, but those that
only examine contextidr are extended to support the new register.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/debug_helper.c | 50 +++++++++++++++++++++++++++++----------
 target/arm/helper.c       | 11 +++++++++
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index dde80273ff..2e3e90c6a5 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -20,6 +20,7 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     int ctx_cmps = extract32(cpu->dbgdidr, 20, 4);
     int bt;
     uint32_t contextidr;
+    uint64_t hcr_el2;
 
     /*
      * Links to unimplemented or non-context aware breakpoints are
@@ -40,24 +41,44 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     }
 
     bt = extract64(bcr, 20, 4);
-
-    /*
-     * We match the whole register even if this is AArch32 using the
-     * short descriptor format (in which case it holds both PROCID and ASID),
-     * since we don't implement the optional v7 context ID masking.
-     */
-    contextidr = extract64(env->cp15.contextidr_el[1], 0, 32);
+    hcr_el2 = arm_hcr_el2_eff(env);
 
     switch (bt) {
     case 3: /* linked context ID match */
-        if (arm_current_el(env) > 1) {
-            /* Context matches never fire in EL2 or (AArch64) EL3 */
+        switch (arm_current_el(env)) {
+        default:
+            /* Context matches never fire in AArch64 EL3 */
             return false;
+        case 2:
+            if (!(hcr_el2 & HCR_E2H)) {
+                /* Context matches never fire in EL2 without E2H enabled. */
+                return false;
+            }
+            contextidr = env->cp15.contextidr_el[2];
+            break;
+        case 1:
+            contextidr = env->cp15.contextidr_el[1];
+            break;
+        case 0:
+            if ((hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                contextidr = env->cp15.contextidr_el[2];
+            } else {
+                contextidr = env->cp15.contextidr_el[1];
+            }
+            break;
         }
-        return (contextidr == extract64(env->cp15.dbgbvr[lbn], 0, 32));
-    case 5: /* linked address mismatch (reserved in AArch64) */
+        break;
+
+    case 7:  /* linked contextidr_el1 match */
+        contextidr = env->cp15.contextidr_el[1];
+        break;
+    case 13: /* linked contextidr_el2 match */
+        contextidr = env->cp15.contextidr_el[2];
+        break;
+
     case 9: /* linked VMID match (reserved if no EL2) */
     case 11: /* linked context ID and VMID match (reserved if no EL2) */
+    case 15: /* linked full context ID match */
     default:
         /*
          * Links to Unlinked context breakpoints must generate no
@@ -66,7 +87,12 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
         return false;
     }
 
-    return false;
+    /*
+     * We match the whole register even if this is AArch32 using the
+     * short descriptor format (in which case it holds both PROCID and ASID),
+     * since we don't implement the optional v7 context ID masking.
+     */
+    return contextidr == (uint32_t)env->cp15.dbgbvr[lbn];
 }
 
 static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f5ce05fdf3..b3ba81dc0a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7089,6 +7089,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, lor_reginfo);
     }
 
+    if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
+        static const ARMCPRegInfo vhe_reginfo[] = {
+            { .name = "CONTEXTIDR_EL2", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 1,
+              .access = PL2_RW,
+              .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[2]) },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, vhe_reginfo);
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         define_one_arm_cp_reg(cpu, &zcr_el1_reginfo);
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-- 
2.20.1


