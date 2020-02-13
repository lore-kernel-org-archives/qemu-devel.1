Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A2C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D630C2073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2kB4yHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D630C2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fvj-0007Ml-TX
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh7-0004a4-3X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh4-00025r-S8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:20 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fh4-00022a-Kg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:18 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so7011187wru.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=io7OAgKGiS3YeaCrWPyK/MAdXhm40+eWtarxm3Kge30=;
 b=V2kB4yHQ+xdxJ1KcY7NNn82D4JlZGJ0Ww1IcYDQDDzMQxwKfuxd61TQGb3oS1qLM6k
 18mxDcKYn97AO+UmdLtZX7LgQ6afFPy3S4M1bH8YbzaMckDzo2oePdQLcFotX0F2Diue
 snCwrBWL9/9PA8dTBygMCJRJQ0alcHzdDf8ueFleZeAL81DplgZFRMDOznyDDKny7lkI
 q7jo3/Lb+78f/UBGFbNq1JaHjWfkcUeD2GDdx9fgv4yqr+U4aeGGipV5JPACN+F/eItb
 mrBXtzLvJASltSdasknomfMPL3jc4JaR0Y4KgqqyNyh1CdMNjKR2dsoeoZo9h+PaHyi7
 0uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=io7OAgKGiS3YeaCrWPyK/MAdXhm40+eWtarxm3Kge30=;
 b=QKGrFw8RbtQ8xieG9P1eKCxYp0sNhBGpU922isoKAg0mYXY1JpvB/8LK7Q69nYej/4
 leN01zC9wNsY3l6/IOWasI2UW5QGISXmhxiERQn+1XDvdh5ScRRP2BigFp2SaRI1kWjS
 Com6XeUahvEt19YuINoDVGLoEuLUrwu7H2WQLI3oPxBUBx7sQIkh6UDoKmld3PD6m1ZV
 uFFFzIo5lhDs/UFdm1KF9REjaRR+7U36jn3jdOvcH7ZLiFQuOgorN4JVTjOq2evUpDSJ
 INY1LqEyLqJAI7G+JFwMkT3neQ7WtIjpQd6ccT/sAeWmSkpeWFzMTD6gmBafhOnHGIKj
 ycqg==
X-Gm-Message-State: APjAAAVSLpoHgv6XQorvuTB+kCFaAULSaErsgXIdQXxALbLFEoskAKQ4
 7TJTtAD3mTi02Obj/8O7nnzohV2GWNs=
X-Google-Smtp-Source: APXvYqw1S4yUbSOJIutHtRO5210ep052YhbzC3CRlq90xCPq4eU3Ho+R7fe/5X43+rnHbXPZQhK4Og==
X-Received: by 2002:adf:c453:: with SMTP id a19mr22318723wrg.341.1581604935917; 
 Thu, 13 Feb 2020 06:42:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/46] target/arm: Implement ATS1E1 system registers
Date: Thu, 13 Feb 2020 14:41:23 +0000
Message-Id: <20200213144145.818-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

This is a minor enhancement over ARMv8.1-PAN.
The *_PAN mmu_idx are used with the existing do_ats_write.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 56 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index de16ce79add..d99661d4ea5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3409,16 +3409,21 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 
     switch (ri->opc2 & 6) {
     case 0:
-        /* stage 1 current state PL1: ATS1CPR, ATS1CPW */
+        /* stage 1 current state PL1: ATS1CPR, ATS1CPW, ATS1CPRP, ATS1CPWP */
         switch (el) {
         case 3:
             mmu_idx = ARMMMUIdx_SE3;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_Stage1_E1;
-            break;
+            g_assert(!secure);  /* TODO: ARMv8.4-SecEL2 */
+            /* fall through */
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+            if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
+                mmu_idx = (secure ? ARMMMUIdx_SE10_1_PAN
+                           : ARMMMUIdx_Stage1_E1_PAN);
+            } else {
+                mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+            }
             break;
         default:
             g_assert_not_reached();
@@ -3487,8 +3492,13 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     switch (ri->opc2 & 6) {
     case 0:
         switch (ri->opc1) {
-        case 0: /* AT S1E1R, AT S1E1W */
-            mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+        case 0: /* AT S1E1R, AT S1E1W, AT S1E1RP, AT S1E1WP */
+            if (ri->crm == 9 && (env->pstate & PSTATE_PAN)) {
+                mmu_idx = (secure ? ARMMMUIdx_SE10_1_PAN
+                           : ARMMMUIdx_Stage1_E1_PAN);
+            } else {
+                mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+            }
             break;
         case 4: /* AT S1E2R, AT S1E2W */
             mmu_idx = ARMMMUIdx_E2;
@@ -6683,6 +6693,32 @@ static const ARMCPRegInfo vhe_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+#ifndef CONFIG_USER_ONLY
+static const ARMCPRegInfo ats1e1_reginfo[] = {
+    { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
+    { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
+    REGINFO_SENTINEL
+};
+
+static const ARMCPRegInfo ats1cp_reginfo[] = {
+    { .name = "ATS1CPRP",
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write },
+    { .name = "ATS1CPWP",
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write },
+    REGINFO_SENTINEL
+};
+#endif
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7620,6 +7656,14 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_pan, cpu)) {
         define_one_arm_cp_reg(cpu, &pan_reginfo);
     }
+#ifndef CONFIG_USER_ONLY
+    if (cpu_isar_feature(aa64_ats1e1, cpu)) {
+        define_arm_cp_regs(cpu, ats1e1_reginfo);
+    }
+    if (cpu_isar_feature(aa32_ats1e1, cpu)) {
+        define_arm_cp_regs(cpu, ats1cp_reginfo);
+    }
+#endif
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         define_arm_cp_regs(cpu, vhe_reginfo);
-- 
2.20.1


