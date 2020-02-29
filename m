Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F9FC3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20B6246A2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iF5RAbD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20B6246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7r0l-0006I1-VA
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvd-0004vI-37
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvb-00065u-O8
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:28 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7qva-00064j-9w
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:26 -0500
Received: by mail-pf1-x444.google.com with SMTP id l7so2596339pff.6
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ohQYIa+ztFNnbKsJpZfcxKi5WgxlXIdIZEVtzv1Cd+Q=;
 b=iF5RAbD4McjE5ael1cVN0Dr06ePAj0CVJWs6KjQDBEMVLZZr0/wMSLsCz5Sxu2Y9Kq
 /snTikKt/jQjIlLOD2e+h3T/f3hzE1B5DR5Oor1MvMavAIjwJN9sIqJglaNHnTxSvkL/
 RKmlF47g0KKO64CH4ChVnThi/ayvdCtPdFCMlOkyjaMyQU8nhtDvVzXl8oLFpvtD6V13
 I1FUaKm9PkRTUuqpAJwNCvo6paooZi93s3smwCDru+SHmCfLssrQ+20HBh2FEssQS8dr
 S2QhTJHNzJlS2APpmscgVtL5ZyZVtSdEzfTbK94noapuwjBxY21IEgaXvNFR6Rzo4AKJ
 obew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ohQYIa+ztFNnbKsJpZfcxKi5WgxlXIdIZEVtzv1Cd+Q=;
 b=jjZqtHhp5vh6itH0VqBpWTw6xrCA+pBfDQTR5tlu2R9OH8ycE6dRz4Ns80uJ3zQtTD
 upGPTKm0fuUOuSahzsFmO4+i/e3eLNtiEcvSSQ6xyUna1iZGz3Cu5N0HAhM1Wyg8+0Ky
 9EW1Ylm7oQmny5dP9tj9GGdgWugnXOXL1bkYoRvFa0yX3HeFLI3qiJgSogsBUsElTGZg
 mdnqlqAq5KvA+xJjsjS2x7RjxUMsrLS18HeCBfl5Unl/Bai5BcVQptBeYq+MXHeY4M7U
 RRjtMcSnVNCByMPoja4naApOV6mxxa/6rDIoV63ebefp17e1ZAAgS82Za+l1fIfsh/ds
 tE7w==
X-Gm-Message-State: APjAAAX6r/N9PU4m70ilRlBiapu1GLcYySz9+wgN7Gw5YXYgftAsRlBU
 MfXclPFYPonsbxp5E39s+GAcGuYLAPE=
X-Google-Smtp-Source: APXvYqwmvAXsrvzNmoC7aQPN09WZy6WS73irdMp5VIKVAt4IjCGbACSQ5ZehhY2le38nqQ0NQFnSBg==
X-Received: by 2002:a65:6843:: with SMTP id q3mr7346064pgt.269.1582939704957; 
 Fri, 28 Feb 2020 17:28:24 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm4606313pfq.126.2020.02.28.17.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 17:28:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/12] target/arm: Honor the HCR_EL2.TACR bit
Date: Fri, 28 Feb 2020 17:28:07 -0800
Message-Id: <20200229012811.24129-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
References: <20200229012811.24129-1-richard.henderson@linaro.org>
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

This bit traps EL1 access to the auxiliary control registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ddef3d7dc3..2c06ac8d02 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -553,6 +553,16 @@ static CPAccessResult access_tsw(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/* Check for traps from EL1 due to HCR_EL2.TACR.  */
+static CPAccessResult access_tacr(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TACR)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -6961,8 +6971,8 @@ static const ARMCPRegInfo ats1cp_reginfo[] = {
 static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
     { .name = "ACTLR2", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 3,
-      .access = PL1_RW, .type = ARM_CP_CONST,
-      .resetvalue = 0 },
+      .access = PL1_RW, .accessfn = access_tacr,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "HACTLR2", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 3,
       .access = PL2_RW, .type = ARM_CP_CONST,
@@ -7718,8 +7728,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         ARMCPRegInfo auxcr_reginfo[] = {
             { .name = "ACTLR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 1,
-              .access = PL1_RW, .type = ARM_CP_CONST,
-              .resetvalue = cpu->reset_auxcr },
+              .access = PL1_RW, .accessfn = access_tacr,
+              .type = ARM_CP_CONST, .resetvalue = cpu->reset_auxcr },
             { .name = "ACTLR_EL2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 1,
               .access = PL2_RW, .type = ARM_CP_CONST,
-- 
2.20.1


