Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EDFC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2F7206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KM85AzjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2F7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8ds-0002eq-Or
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZQ-0001eb-Mf
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZP-0006zZ-OE
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id z72so9672166wmc.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QY58CXVUaQwf+QAV/2GBzlVDHqKHNdceOqgL9U9QO1k=;
 b=KM85AzjXIH2OScFzV350Jbe+tvJFDJ8X7ooJHab4XInMd77kU4IwuRFeONzM87Q+21
 CDw1urxRjkkcAl15MKL+HrqqHG6G+qs9uUE9clXEhRej9hF3JDoxXsdqbr9Z6Db9Fwfe
 MMbKmkBO558zY3nJhrOQiPDxasRdtSJy0fYZGfuMXWwNn/Lf0E5HWzM+thbLCGCNUHwJ
 WAb419HDGOr1mjmRpXuxFchPaMyeHLw+1VQ8kZ0S56GAxFiOgwaHfzZ54rGu4zx8lrrG
 amtsLg0binF53D4kkdorLtj/FyV/k8R/BzZ7+s5/h1E0SRxy0O2XK7wsKVz5jZSW6kvD
 eNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QY58CXVUaQwf+QAV/2GBzlVDHqKHNdceOqgL9U9QO1k=;
 b=kF6x2IF1MGwotDbT+7OGhNHBgx2B/9BdwrOzM30TVpTbfVla290P97NFaNts55mQ7n
 7GgeTYVz6CyRMucNuv4wXwuuu18P1r5B11oRA1vLmyutyBA8zF3OU7rlilhEZBOyhh9E
 N74u5LmV6Jl9p58VmG97tFBNSuLubjNXUgxlUY0u+N21vtguzz8fA8Hch4lpWCsnVjAG
 sNzEEgYHDOQGVcjdxrYEEfG8fD8vHU6JBmvxLG/tc01nZPfK26b9PvPF/yKtBcpYmgnx
 7fKGWIed18P12zdugcNFoKKDwQ6RZjIiP1Ya5UETt+mD6k0sBLqL3PKIQ2i2oBzYccf2
 4eGQ==
X-Gm-Message-State: AGi0PubFmCh1ofqO8ygahOTSmSS7hXt85FY8Cm8JWbiozTR+wE2cHXY2
 BV+iAtjittn0iimrl/GGiTDbmDpgOpRGbA==
X-Google-Smtp-Source: APiQypLjPexCblnVhZFdsFu4KnRcvGXrCnbttgpWFHUKhlqxx33USgA+KxjC86BkylCcFeU6ViBExQ==
X-Received: by 2002:a1c:bbc4:: with SMTP id
 l187mr12222887wmf.183.1589204049853; 
 Mon, 11 May 2020 06:34:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/34] target/arm: Drop access_el3_aa32ns_aa64any()
Date: Mon, 11 May 2020 14:33:33 +0100
Message-Id: <20200511133405.5275-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Calling access_el3_aa32ns() works for AArch32 only cores
but it does not handle 32-bit EL2 on top of 64-bit EL3
for mixed 32/64-bit cores.

Merge access_el3_aa32ns_aa64any() into access_el3_aa32ns()
and only use the latter.

Fixes: 68e9c2fe65 ("target-arm: Add VTCR_EL2")
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200505141729.31930-2-edgar.iglesias@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a94f6507950..b88d27819d5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -503,35 +503,19 @@ void init_cpreg_list(ARMCPU *cpu)
 }
 
 /*
- * Some registers are not accessible if EL3.NS=0 and EL3 is using AArch32 but
- * they are accessible when EL3 is using AArch64 regardless of EL3.NS.
- *
- * access_el3_aa32ns: Used to check AArch32 register views.
- * access_el3_aa32ns_aa64any: Used to check both AArch32/64 register views.
+ * Some registers are not accessible from AArch32 EL3 if SCR.NS == 0.
  */
 static CPAccessResult access_el3_aa32ns(CPUARMState *env,
                                         const ARMCPRegInfo *ri,
                                         bool isread)
 {
-    bool secure = arm_is_secure_below_el3(env);
-
-    assert(!arm_el_is_aa64(env, 3));
-    if (secure) {
+    if (!is_a64(env) && arm_current_el(env) == 3 &&
+        arm_is_secure_below_el3(env)) {
         return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return CP_ACCESS_OK;
 }
 
-static CPAccessResult access_el3_aa32ns_aa64any(CPUARMState *env,
-                                                const ARMCPRegInfo *ri,
-                                                bool isread)
-{
-    if (!arm_el_is_aa64(env, 3)) {
-        return access_el3_aa32ns(env, ri, isread);
-    }
-    return CP_ACCESS_OK;
-}
-
 /* Some secure-only AArch32 registers trap to EL3 if used from
  * Secure EL1 (but are just ordinary UNDEF in other non-EL3 contexts).
  * Note that an access from Secure EL1 can only happen if EL3 is AArch64.
@@ -5147,7 +5131,7 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
       .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "VTCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
-      .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
+      .access = PL2_RW, .accessfn = access_el3_aa32ns,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "VTTBR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 6, .crm = 2,
@@ -5195,7 +5179,7 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "HPFAR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 6, .crm = 0, .opc2 = 4,
-      .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
+      .access = PL2_RW, .accessfn = access_el3_aa32ns,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "HSTR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 3,
@@ -7537,12 +7521,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             ARMCPRegInfo vpidr_regs[] = {
                 { .name = "VPIDR_EL2", .state = ARM_CP_STATE_BOTH,
                   .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 0,
-                  .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
+                  .access = PL2_RW, .accessfn = access_el3_aa32ns,
                   .type = ARM_CP_CONST, .resetvalue = cpu->midr,
                   .fieldoffset = offsetof(CPUARMState, cp15.vpidr_el2) },
                 { .name = "VMPIDR_EL2", .state = ARM_CP_STATE_BOTH,
                   .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
-                  .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
+                  .access = PL2_RW, .accessfn = access_el3_aa32ns,
                   .type = ARM_CP_NO_RAW,
                   .writefn = arm_cp_write_ignore, .readfn = mpidr_read },
                 REGINFO_SENTINEL
-- 
2.20.1


