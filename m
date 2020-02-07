Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE686C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7588621741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o458jeoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7588621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04lu-0000AI-JP
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hd-00089q-0E
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hb-0002Jh-H0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:52 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hb-0002I4-8a
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:51 -0500
Received: by mail-wr1-x42e.google.com with SMTP id z3so2973753wru.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3ETKFDz9Z/PvfIXUZUChtzex0Nca24K+aFIQa3OFyQA=;
 b=o458jeoLmINJPfZU5xAMljjgVNZrY0TvLuJ54SHjQOHgJYd7N9YyGXN0zlSqqf8lDC
 1i/Wh5snWgAgeVgYxHALZiiuy8rdW2YTMQxFSRQODpsBfgns2ZnkYU7gKus/vWSTced6
 MVO/bNEmZYUJnjmYIQAG1ahxNHFrlIVXss7fVyQpg1dawLxQGSK6aart0O0FDT0Y0m25
 0lMH7txq8A8I+fA+vTeTgCU/cAIE3n+2d7NLdR6WRffKOeExGR1YyjSSiyvC5OapL3MJ
 fYvULMI2oLEWDMklYG3r1xOcskB4vHFxfMM+2IWHJB7QRFDwZzuJLSzkqq1eXsJNYSvw
 DfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3ETKFDz9Z/PvfIXUZUChtzex0Nca24K+aFIQa3OFyQA=;
 b=tF4YUTJF4i8c6RDaP87FP8xOnY4Nk4h1J5MfB3tzvfobXblGTWFmAG31PkW/87Ni4U
 6/faHk9ppHlzwQQwcfWjtnKG6h6uKsaev1VrhPKTwK1DT0zo35IsNzQJNXSZiynbyPM0
 sm/WOiXe6NsqP7PpkMNwShVxC2Gs9CU02I0lxz9yFCGFEFnSuam4MGv54u0oIMU1fmCS
 Tyy1QTKg1KPk7HNPRXsu66Ecuk9h6Onr6N/PhK0A8UT2QuIa3rm3tjb9dPd7nFrHZ/gN
 qCbUeNtBg1F6KDm8qFSckNzqo8m270pK66c/gIgyDHdZk0S0VxtfpCeDFzFJ8Zm7SO3l
 twLw==
X-Gm-Message-State: APjAAAViuvFAC/P9e2rtKcEZeVk3yaeofLw8wFSLp4UWsYT/TPVxr3Lh
 jZqdjzk59xzJuF/EB/tMxzifmoIfucI=
X-Google-Smtp-Source: APXvYqwsinwoB63U64aYdK7OFdZ7PaTwnteiuCX/SvPyKaLNG45Zn+i9f06BYKenXfxehkj0U6lCoQ==
X-Received: by 2002:adf:a746:: with SMTP id e6mr4976980wrd.329.1581086029916; 
 Fri, 07 Feb 2020 06:33:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/48] target/arm: Add CONTEXTIDR_EL2
Date: Fri,  7 Feb 2020 14:32:59 +0000
Message-Id: <20200207143343.30322-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

Not all of the breakpoint types are supported, but those that
only examine contextidr are extended to support the new register.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c | 50 +++++++++++++++++++++++++++++----------
 target/arm/helper.c       | 12 ++++++++++
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index dde80273ff1..2e3e90c6a57 100644
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
index f5ce05fdf33..fe7991864a6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6126,6 +6126,14 @@ static const ARMCPRegInfo jazelle_regs[] = {
     REGINFO_SENTINEL
 };
 
+static const ARMCPRegInfo vhe_reginfo[] = {
+    { .name = "CONTEXTIDR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 1,
+      .access = PL2_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[2]) },
+    REGINFO_SENTINEL
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7089,6 +7097,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, lor_reginfo);
     }
 
+    if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
+        define_arm_cp_regs(cpu, vhe_reginfo);
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         define_one_arm_cp_reg(cpu, &zcr_el1_reginfo);
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-- 
2.20.1


