Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CCAC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF57206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dj+Avin1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF57206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6eeX-00046z-VB
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6edO-0002FI-NV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6edN-0004OE-1g
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:42 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6edM-0004Kz-RW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:40 -0500
Received: by mail-pf1-x444.google.com with SMTP id 2so7584380pfg.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oDXzsq0/YvSiQdzdpF94Ig5JPRMqXV2OYmMtHFtNL2o=;
 b=Dj+Avin13YTXRoFhgeuU/WW/jvjBnqXw/h3/iQXc7B/TESIkkXIZlponud6ocxp1M+
 2QlNczoDFKT4JUmWHuXn77kGM7GPVAG8GeconevLLl9qS8QxkB4GasXgnuP/DSX3ShlF
 s+jjtHanP7Uxl7Oi0ZWbivrvYI2vx8NBTD3Xdfi6q4HiWNyC790dXGjdtev8NetN/QVb
 I1YarIgfiSG8uzwmaoyRPf2hfeS3t4Rk2a1GQcfljS0bHgBFgg0geyPSfE0TsfQ8pym2
 b9/VvuowBkYaHu9vVqtmPi1SNvRYSgJMr3hIJ+pDNm0afdx5NC4PLwymSTenJOBtucE6
 jljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oDXzsq0/YvSiQdzdpF94Ig5JPRMqXV2OYmMtHFtNL2o=;
 b=SIpupKQDnUIKUe9HEGfZy27M0jZ9Vd4EiC+5ynJ/WNyAIeC30lajsPdL9z0Z7dx0Ys
 w7/dmKxmSG3GmwyfvajRKBXVMh6IHhJZs62u1PYHMQgFdGIJAabHw2eR7INA5Znvjr0S
 qVswySfy7aqiVh8phc6mwQxRrrA9wEeIA1FE+2VB3+uOnv1i+Obq3Ww65e0TctqFFF9o
 gb8w3dK3fnWnYQuB8Z3GgVeYxbJ6LBRiRmz2Adc9Y0qZZpXDlrHa14jlRZ86MrbiHL8Q
 qWmdsHIy+U3E5ZUjCxBuFhrBN2p7TCCWUDTGb96KxKQahZWVnCxQ/amPGva8TF0zH9gG
 kqlg==
X-Gm-Message-State: APjAAAVGeRFmwbDRe5H8mSJczfUIJIeyWuuSmxyDHCnw0OXLqBTH2IvR
 GlJR/X+nnulJRwvwMf+KhbS4s0Ndl9A=
X-Google-Smtp-Source: APXvYqwEiCMM6UsDa1BYIFY+1eGVH01I1jOsF1NwtHWtOioUMTnx3T/DbEcqycxiZz6W9YvsUBMrGw==
X-Received: by 2002:aa7:9a52:: with SMTP id x18mr58712858pfj.73.1582654118239; 
 Tue, 25 Feb 2020 10:08:38 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id d69sm19069704pfd.72.2020.02.25.10.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 10:08:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/7] target/arm: Honor the HCR_EL2.TSW bit
Date: Tue, 25 Feb 2020 10:08:27 -0800
Message-Id: <20200225180831.26078-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225180831.26078-1-richard.henderson@linaro.org>
References: <20200225180831.26078-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These bits trap EL1 access to set/way cache maintenance insns.

Buglink: https://bugs.launchpad.net/bugs/1863685
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e45d717cf3..ea42e0d26d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -543,6 +543,16 @@ static CPAccessResult access_tvm_trvm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/* Check for traps from EL1 due to HCR_EL2.TSW.  */
+static CPAccessResult access_tsw(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TSW)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -4704,14 +4714,14 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .access = PL1_W, .type = ARM_CP_NOP },
     { .name = "DC_ISW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
     { .name = "DC_CVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
       .accessfn = aa64_cacheop_access },
     { .name = "DC_CSW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
     { .name = "DC_CVAU", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 11, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
@@ -4722,7 +4732,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .accessfn = aa64_cacheop_access },
     { .name = "DC_CISW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
     /* TLBI operations */
     { .name = "TLBI_VMALLE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
@@ -4903,17 +4913,17 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "DCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 2,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCCSW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 11, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     /* MMU Domain access control / MPU write buffer control */
     { .name = "DACR", .cp = 15, .opc1 = 0, .crn = 3, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm, .resetvalue = 0,
-- 
2.20.1


