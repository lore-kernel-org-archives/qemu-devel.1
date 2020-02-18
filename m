Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32215C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F005A20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXQTHFae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F005A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48Qj-0002ws-5U
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48G3-00054E-Rh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48G1-0001yw-Dt
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:11 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48G1-0001x4-6r
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:09 -0500
Received: by mail-pf1-x442.google.com with SMTP id i6so11138768pfc.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5k7tlvEB9/rsMbuI3aToULa8WUIjX1E0iDo+FSiobiY=;
 b=GXQTHFae6PA4ZmF7WMXLg+OhuuEv40//FDA0oPWididXI2Twdh/xJ3wlzSIMF8yvI0
 X/A6rXSCnI7RFv8KXc9MIF+qnqU5CSTJw8IsHqvl+ahBd3yP77C3Kaq8Fag26oAAyZ8P
 9EqTaLH8ExANR8bEartWhJeVxWdwFqr9gv0cwncFCQ9elT+N/smaXJ9YiaEKWVFCyoob
 Uij33shXnhWd40f/vn5TBZKTzAXvbvxoqM7cU4eslexAv+6m5VncCNsEAu+qoocWq2US
 UT5bfoSJbBp+SAGmSRf0n8Cm+iYL8JNWox47kqCls+CW0rbcwOgn5XjWbch6hln15Zs7
 GLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5k7tlvEB9/rsMbuI3aToULa8WUIjX1E0iDo+FSiobiY=;
 b=kWpyjsyG7Vjcs72NKOdVJ4bFsujLVjgam3qzDo10aoLY2yGNHSOUYvcVmsROD/Orhr
 2VOmgOjyT0HxsW2mqHE1V6LSAR6UyLnPsPhET/W0bCFOCLVStjPpOJ/W7bNGY9ptX5mr
 os2BNO2HNpzUVz67OVkeoW7hy4QTYbw+bIivV5nT+68ZjEb76QrQjZ8eeeuwYu6UBacj
 Dph2e38ynCkLXKiqVtQu7CjBfOq9xwrw9drigrzkNTU+HasPNxxV/Mb/R81kuVw93GD7
 cVntvUYfAL/O9/cGe5+bq1NV49Z3SnkztLTzI4SS9bHD4PjR3nyeuINcTAgBqcwRs4c4
 A4Lw==
X-Gm-Message-State: APjAAAVZUi95qakKBAxIGDXep7uc4bavi9mIdCLZI9KOkbgT0Q90lpya
 yt6erGuxqGnInkE/LqmlfeoJb2yqfXk=
X-Google-Smtp-Source: APXvYqxVTISRphPBB9JPw4QZ4d+q+MPyjrtw/FU+dLV+vcqhj/5sOaOGINFNYxafAeg7Xr3wXQS7nA==
X-Received: by 2002:a63:5345:: with SMTP id t5mr23936562pgl.254.1582053007849; 
 Tue, 18 Feb 2020 11:10:07 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i68sm5139399pfe.173.2020.02.18.11.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:10:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] target/arm: Honor the HCR_EL2.TPCP bit
Date: Tue, 18 Feb 2020 11:09:56 -0800
Message-Id: <20200218190958.745-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218190958.745-1-richard.henderson@linaro.org>
References: <20200218190958.745-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bit traps EL1 access to cache maintenance insns that operate
to the point of coherency or persistence.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 52b6e68659..ed34d4200f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4314,6 +4314,28 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
+                                              const ARMCPRegInfo *ri,
+                                              bool isread)
+{
+    /* Cache invalidate/clean to Point of Coherency or Persistence...  */
+    switch (arm_current_el(env)) {
+    case 0:
+        /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
+        if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
+            return CP_ACCESS_TRAP;
+        }
+        break;
+    case 1:
+        /* ... EL1 must trap to EL2 if HCR_EL2.TPCP is set.  */
+        if (arm_hcr_el2_eff(env) & HCR_TPCP) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        break;
+    }
+    return CP_ACCESS_OK;
+}
+
 /* See: D4.7.2 TLB maintenance requirements and the TLB maintenance instructions
  * Page D4-1736 (DDI0487A.b)
  */
@@ -4721,14 +4743,15 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .accessfn = aa64_cacheop_access },
     { .name = "DC_IVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .accessfn = aa64_cacheop_poc_access,
+      .type = ARM_CP_NOP },
     { .name = "DC_ISW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 2,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
     { .name = "DC_CVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
-      .accessfn = aa64_cacheop_access },
+      .accessfn = aa64_cacheop_poc_access },
     { .name = "DC_CSW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
@@ -4739,7 +4762,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "DC_CIVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
-      .accessfn = aa64_cacheop_access },
+      .accessfn = aa64_cacheop_poc_access },
     { .name = "DC_CISW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
@@ -4921,17 +4944,17 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "BPIMVA", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 7,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_poc_access },
     { .name = "DCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 2,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_poc_access },
     { .name = "DCCSW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 11, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_poc_access },
     { .name = "DCCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     /* MMU Domain access control / MPU write buffer control */
@@ -6715,7 +6738,7 @@ static const ARMCPRegInfo dcpop_reg[] = {
     { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
-      .accessfn = aa64_cacheop_access, .writefn = dccvap_writefn },
+      .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
     REGINFO_SENTINEL
 };
 
@@ -6723,7 +6746,7 @@ static const ARMCPRegInfo dcpodp_reg[] = {
     { .name = "DC_CVADP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
-      .accessfn = aa64_cacheop_access, .writefn = dccvap_writefn },
+      .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
     REGINFO_SENTINEL
 };
 #endif /*CONFIG_USER_ONLY*/
-- 
2.20.1


