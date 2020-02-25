Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74CAC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8458D20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xrg+UwIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8458D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ehk-0007xB-Og
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6edS-0002Ox-JU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6edR-0004Wc-7g
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:46 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6edR-0004Ux-1X
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:45 -0500
Received: by mail-pl1-x644.google.com with SMTP id p11so100991plq.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1+nBZoDaBAGVfWBfiFQULthtVj8wbsWbsm7r45A6ZqY=;
 b=Xrg+UwIgd2VBTIgfHkiRViOB/P9/VAD+BIIOqXfQwaIXs5Ftn9Ditm163s1n3zOy0v
 xOAw1N3iRm7RIb1EjgSwtu1dki+HaETltEUgBs0bd5v1YTnuwSLPmcarpEGM9eqNMcd2
 De3jWgICdh+1WeUynrTS6d9rcbykWI/kSYFhmQ0tHI6KBSjMCaW1E9mX3U4ykmrONJ1e
 yVETPDL/tiDmB81oGrbVSS/GE/SMiyGUCO3ybAB05A2ouH1fij6Ve9kIcGFBZuEmtjeY
 lgJZ492NUf1JolZLDchcg671CIu9mKIT9gUK/wjHpVsgSdDWMprTCscJkTE9OCZcFO5I
 s1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1+nBZoDaBAGVfWBfiFQULthtVj8wbsWbsm7r45A6ZqY=;
 b=dV5syXtUO7nrA+ar9vibuQOu9O0ad7f2qibOrgZNmiIWlkejEzBPB+U3xr/DxEOAtb
 Pn/8Rf6iDNvUQEhce1j6NEhib2uhbssrwxbfEGBYLHrzILHZuNvrMJKs0HEmitmDvoy9
 gF9KRIZd2FRZJXOsBhqk89G6bGwGRbvqRjX4Ob7vK/IS4/iI+/D8m3LZvV0fyyUNZOTB
 Kp2nXnRKTzlbYRYMXCOSAv79CEXu+KCRnNnl8Whf4nHu7eB+Ol8JSdmArpsbSw8vn4/J
 GDUDkgY/6T5was8BRcZX/ZF2ugRIuurVEiWvsbyL01Vj0G+HSBJXKehLKmreS9uEe+1y
 3RxA==
X-Gm-Message-State: APjAAAXWh7cmnO5aN/L69HKu2Hm9VkWrhE+zBF4edOJUc0i30ywAWhO3
 jhmsiOxISIRFgXPLA+XsI8rPgiCf2kA=
X-Google-Smtp-Source: APXvYqw2XNWhjtXR9XCV0qHnJqgpI0vFH4EdI2IPxgypKcLEOokI2/RIsrLdEFzsb+/1Am0G1THKkw==
X-Received: by 2002:a17:90a:3841:: with SMTP id
 l1mr242449pjf.108.1582654122942; 
 Tue, 25 Feb 2020 10:08:42 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id d69sm19069704pfd.72.2020.02.25.10.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 10:08:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/7] target/arm: Honor the HCR_EL2.TPCP bit
Date: Tue, 25 Feb 2020 10:08:29 -0800
Message-Id: <20200225180831.26078-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225180831.26078-1-richard.henderson@linaro.org>
References: <20200225180831.26078-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
v4: Fix el0 fallthru (pmm).
---
 target/arm/helper.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5cb7844f3f..2d488554b7 100644
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
+        /* fall through */
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
@@ -6728,7 +6751,7 @@ static const ARMCPRegInfo dcpop_reg[] = {
     { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
-      .accessfn = aa64_cacheop_access, .writefn = dccvap_writefn },
+      .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
     REGINFO_SENTINEL
 };
 
@@ -6736,7 +6759,7 @@ static const ARMCPRegInfo dcpodp_reg[] = {
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


