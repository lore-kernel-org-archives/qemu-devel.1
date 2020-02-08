Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FCDC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0121D21775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6gd0Ky3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0121D21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PqI-0002Ko-46
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgx-0000ql-Dz
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgw-0005CL-81
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:35 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgw-0005Be-1o
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:34 -0500
Received: by mail-wm1-x343.google.com with SMTP id f129so5631367wmf.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m4T2G+2BVRE0tpK6F0FDHxQ98vwNbb8dIt/PD3r4gkg=;
 b=y6gd0Ky3n40UiSJHg7tyPyzONl/LEN7FFq+MWh9yQVBU47K3ruqXkTJ/DkW6ABSpnN
 L4QyLFDt7qyqhwAO3Ook/7jhUpFDybrOZ0dYKiCqhkYr/9GQvsBqmn9Sxo5giCGrMvPs
 5C5yYbLfkN7QDHFxO+5ZZoRwT7e7SVqWdlx0/vNSqQ/8GeOUD19KKTJ0Rmv3kOr72X1l
 5oS8XbbwMg4rgxwD6+1KgsHS4Q6epAfYjvUDCPYs18RYnTYtavhfwvq+Xa231DrjqlLm
 h27AWWHmDiasDZjOAO8TaQYNp++Ix0ONcwqxa2WmbZm1nvLIxjGVLdCm09Ial+qYogeY
 FI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m4T2G+2BVRE0tpK6F0FDHxQ98vwNbb8dIt/PD3r4gkg=;
 b=Iv7mLqzAYKxch+/COtvcqBx1f0MG5Lck08P8C1pHKNfAiAIiWPpfNtB++FnFJ1y9gw
 kGNLEskfOxfHgvXm5rpZOBz+V5sNj1SJzWuLbeieZgGESJeR3TYIWBq5IAUdyfte9Tvh
 vLmUX6A39CZU1iuvcrvxNhaLgAymaESy41tEZ6ZTbNVm4vDvoIa8vhyFmyVan7XytDF4
 piIxoCVnJ0RIwwaqPbpF9mFodv4gJlT9N3VelbY60Ny0cd18w+evq56WEWQFAcwzPDOT
 MMprBAQxj+XP/nIPwibsg84pMgghwDWSqKVznlAejDMIiuReFy3LZNLNH0y60tivUgLb
 HYEw==
X-Gm-Message-State: APjAAAWfkO7uXbxy6Jb3KqOEYDWRe4eVlJECr7Y0/Y7f0K7fY6cR4vqe
 CeMSWFTyMhzewiihTkLy60apHGnEaNwAlA==
X-Google-Smtp-Source: APXvYqxgFzV2Zj1dzrhpTGnr56uXRAUFbQgWP/99wc2Ud7fl5jUzEhLJvlGUpKSfSJ27Q0aSDbZ4bg==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr4508928wma.171.1581166712854; 
 Sat, 08 Feb 2020 04:58:32 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/20] target/arm: Implement ATS1E1 system registers
Date: Sat,  8 Feb 2020 12:58:11 +0000
Message-Id: <20200208125816.14954-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

This is a minor enhancement over ARMv8.1-PAN.
The *_PAN mmu_idx are used with the existing do_ats_write.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Move regdefs to file scope (pmm).
---
 target/arm/helper.c | 56 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index de16ce79ad..d99661d4ea 100644
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


