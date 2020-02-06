Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB3CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECC720659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/DDXFcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECC720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izepg-0004qk-0Y
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoA-0002mj-PF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeo9-00066j-Jr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:54 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeo9-0005zh-D3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:53 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so6452059wmi.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FZeJr7acmem3so7kKI6JCX15xe9EzLydDuX9CFgpclU=;
 b=P/DDXFcZPyIbZXdLdmGohk3kAmd+Z6ELaWMhuPxG+4vCI7G10QQJYmXLVhXJPKX0KN
 Y359pUX5L4FSxe6l+6++XECrNXlGazpQ3Al/0O42Z6Km5VxqeYiPNa1OtFBNldYOU5BE
 mCsaDICyyuwpHgerGiFcos7xOuc/HSiEOI1JugmuLdjLXceJTXLVxMdT8z4NQ/Qis0r5
 YO44JuVfk+uFgRHmoqcWsNGz6Wi9/Xn/OQPNq6IMvKgljM3LSuD3GPoxgnOGPpATxyAX
 VcqCrzLS6E2MrRiUHByIzW52QAYEWMSFQFVbYxxXK/kWVsw66A3ofeWMqrzRSeamTjM9
 M6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FZeJr7acmem3so7kKI6JCX15xe9EzLydDuX9CFgpclU=;
 b=ktb/cBVuvIXMo6gbG8m+1m/Q7h9JFRjN9t6HNYxSQkD6lQqSFAT4rN81HRxUf+/6bm
 ARQPJ2x0sn9fJ9pfO4CeiyD0Rw/nbKIr0OxOSFGUr5XXFpaRm+dRj1C6T9RZeazbF1Eq
 SpZXYmyqsbyYyYpjn5tViwhJURlpBinxHoB0qTD3ay/INuB5tXgItL+kD87zxYCO4XAF
 8FOZgE07YM3+MJvFizRLE37BPSoJ2hP2GmmMJaF8vZO5NmTVZZej4Bdpgz2tUxQ+RPeM
 FjFEduwA0tlcS4loLZqPVSk+pIRhesChleO02elDEI2QHx1C85oSVIZVCS6BjuokT1Ny
 2wFQ==
X-Gm-Message-State: APjAAAWekR0YMB4xyklg466+FCFzEJ8rrE0UH48oa5Ao2uMtV86uVB82
 4vL6Fg3+L72MrbbFECXq+C/UWZPmwaeT4w==
X-Google-Smtp-Source: APXvYqxvdzELF/oWF4g/M3AmM+p/oqmj3u6Zr48pPjygy4AfqoQCmChrZqxLlkYZVCJPKtBL2aVhxw==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr4095800wmh.129.1580986492028; 
 Thu, 06 Feb 2020 02:54:52 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:54:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/41] target/arm: Add CONTEXTIDR_EL2
Date: Thu,  6 Feb 2020 10:54:10 +0000
Message-Id: <20200206105448.4726-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all of the breakpoint types are supported, but those that
only examine contextidr are extended to support the new register.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Move reginfo to file scope.
---
 target/arm/debug_helper.c | 50 +++++++++++++++++++++++++++++----------
 target/arm/helper.c       | 12 ++++++++++
 2 files changed, 50 insertions(+), 12 deletions(-)

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
index f5ce05fdf3..fe7991864a 100644
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


