Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063BEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B157B246A2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjYVbNuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B157B246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7r08-0005YI-Ab
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvc-0004uW-2n
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvZ-00064y-Qb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:27 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7qvZ-00063s-3R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:25 -0500
Received: by mail-pl1-x642.google.com with SMTP id p11so1898731plq.10
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4ajglCXwTcimWMRoub0cmqXlu4Sl0gLTr8uSkY1gHjo=;
 b=PjYVbNuYXVZoO+Mh/NKpUDUhSzgPCyft37XZStvJiaTAIM1YCc5dFu3SipLwyMAKx7
 MCZWF6PZms87SW5nHBZyqJNEGX4PSNPXXdIijvbNcW9LBy8YEaXYbkCuyBvNN0tg6kc+
 yBpt7khsm31kTgPzDNntZyRfAi8HCeymDo0Xu6W7oA3dEkfGWAGsXLiDh4K4Y4eGJg6k
 aCEGzl872u5UgCehWevbnapogNuwwxAHuW73yCSsJsAcTFf1UEGAcThkdrytO/tHtHjk
 hNf+s75ia5bP7qgDj2XpHUS5u3tA/zwIK/UGaTHoEWTGxO1UK2rAs0hh2xHfHMyPhq4L
 lkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4ajglCXwTcimWMRoub0cmqXlu4Sl0gLTr8uSkY1gHjo=;
 b=QLdkMTqWvvw2onn9hTMuave2cK/20QbnKwNemJ3IDeXEZ6Kgau5jgw++ZeZtHDx7ih
 BOzpW1WCmlj5fvpm6XbLh6K2FS4aK5vHByK6t2mso6AgTjEF8mLhPz5uVS5bcfUGRUml
 tXYupJQadv6iRvu6WhrmKFEwlHWsduWERaRGY5ETo0HHZNAyi8MwF4ilMGjfHvXBt7tx
 neu2e6BX0fwclSWfwtoucvEnV34TCHnxjGDfSTeIwGI48JAXDsxYLiA0kiAOo1QLMzkJ
 mlo8QI91ZQlbYzJpfZcI6f9B4Pu5+0Y1dPmqhwtcOZmDAPy6zApm3xKL6CBvIUoVNJN8
 MAqA==
X-Gm-Message-State: APjAAAW9CtEXpXgZ9MmMb3UdOiKnI3PQkks5+Ti2v7mOdaZSHzF54S5L
 NhoHiCyGXMbLm7v9br7EbHBNeIcaWzU=
X-Google-Smtp-Source: APXvYqwxjT8WmpcNfaZyO3zhxj2SVC+RytPu1JKr760+clemVJNOwvIRn4us2FuIzC9Pk8kwaSKz2A==
X-Received: by 2002:a17:902:bf41:: with SMTP id
 u1mr6547110pls.207.1582939703650; 
 Fri, 28 Feb 2020 17:28:23 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm4606313pfq.126.2020.02.28.17.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 17:28:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/12] target/arm: Honor the HCR_EL2.TSW bit
Date: Fri, 28 Feb 2020 17:28:06 -0800
Message-Id: <20200229012811.24129-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
References: <20200229012811.24129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
index 1f371b0391..ddef3d7dc3 100644
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


