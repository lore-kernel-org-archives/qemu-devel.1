Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E20C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8862520637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzhhlXN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8862520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tXp-0001zO-J2
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPL-0003m0-Es
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPG-0002dj-3X
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:35 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPF-0002am-S7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:30 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so7065813wmb.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=e+/afNoZqx1Svd6138SnxY+KW5NBVyXfjUhJrOnjzdI=;
 b=bzhhlXN284HsCmGfYzBdl07YuwBU7tEZEoGZiJbiGWRSBkj3wfKFhWCwDpTJVEgipT
 tqhJsX6pvF8dtfsUU6rIxahqDjgp6qyzNua61IqJX21uBbYnCTTdBDLInjAXoVdUkXax
 S92m5S9aXVOdsPUcfLmWOAqWD3HncMdXjPGbZ3+pgIrF4zaFgGDqlUqAp9GJiGb7aVXS
 CJA5rK3XmxXoQK3jlRZzVG/WOrDOjF8aiUWcl15U/FWPNsvzoJ5PCwurRS+N/V4ophyW
 a4LZ3zC+sTpkOiSiOi0y+xbeHU3U00O33F7fuWrkyvvjyUp8E+T7/1cZmOCBZFmqcwy+
 WNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e+/afNoZqx1Svd6138SnxY+KW5NBVyXfjUhJrOnjzdI=;
 b=ZOzgJ4rXosrfqPmeAWseU5f0h17pzNU/aBM+aHyO2iooIqlAqUED7ftcGW8CrVFWXX
 DVwXwkllBSrmFSvJwK/+Yt2E8EqxQmmjAt2TfIRopau8MBfgP+4QYXrEs9XdgAVEngsG
 YMOXoWjAfKcpi4E6zjItNlwOfSVibg41i0w2GnShnQTAAXuixf/dLSyjOaWumEXB0fqo
 rc8xyrMX8hYYNvNo1qVmYQ4gW/igvFo1G2tAVFZm+twW8Sp64n9tV0euMR3G7M2xNPUo
 IDOqpSFE2Og+u0Ylmrl5le3DYsDJ82Y7wjAZ3mV+qE7uqfYR6jccjLXITqziKRzD48tG
 REhg==
X-Gm-Message-State: ANhLgQ39vVinGxTQJcQ16n762OxXvkCuDF/befd5kDipEbqR01v7cgS4
 Rmzkx5m4O5kQyHZNbLFKcHWsa1xlJWviTw==
X-Google-Smtp-Source: ADFU+vsy+9BjEQOI/+asEBVPi4zMGLxIAOSLe21iigi5I0HIWooG8VVtbP286Lm7R+JPmtIUtuCtiw==
X-Received: by 2002:a1c:41c3:: with SMTP id o186mr10249722wma.27.1583425888351; 
 Thu, 05 Mar 2020 08:31:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/37] target/arm: Honor the HCR_EL2.TPU bit
Date: Thu,  5 Mar 2020 16:30:47 +0000
Message-Id: <20200305163100.22912-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

This bit traps EL1 access to cache maintenance insns that operate
to the point of unification.  There are no longer any references to
plain aa64_cacheop_access, so remove it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200229012811.24129-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 53 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e6eaec8ad31..09b5022919a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4301,19 +4301,6 @@ static const ARMCPRegInfo uao_reginfo = {
     .readfn = aa64_uao_read, .writefn = aa64_uao_write
 };
 
-static CPAccessResult aa64_cacheop_access(CPUARMState *env,
-                                          const ARMCPRegInfo *ri,
-                                          bool isread)
-{
-    /* Cache invalidate/clean: NOP, but EL0 must UNDEF unless
-     * SCTLR_EL1.UCI is set.
-     */
-    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCI)) {
-        return CP_ACCESS_TRAP;
-    }
-    return CP_ACCESS_OK;
-}
-
 static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
                                               const ARMCPRegInfo *ri,
                                               bool isread)
@@ -4336,6 +4323,28 @@ static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult aa64_cacheop_pou_access(CPUARMState *env,
+                                              const ARMCPRegInfo *ri,
+                                              bool isread)
+{
+    /* Cache invalidate/clean to Point of Unification... */
+    switch (arm_current_el(env)) {
+    case 0:
+        /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
+        if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
+            return CP_ACCESS_TRAP;
+        }
+        /* fall through */
+    case 1:
+        /* ... EL1 must trap to EL2 if HCR_EL2.TPU is set.  */
+        if (arm_hcr_el2_eff(env) & HCR_TPU) {
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
@@ -4733,14 +4742,16 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     /* Cache ops: all NOPs since we don't emulate caches */
     { .name = "IC_IALLUIS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .type = ARM_CP_NOP,
+      .accessfn = aa64_cacheop_pou_access },
     { .name = "IC_IALLU", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .type = ARM_CP_NOP,
+      .accessfn = aa64_cacheop_pou_access },
     { .name = "IC_IVAU", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 5, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
-      .accessfn = aa64_cacheop_access },
+      .accessfn = aa64_cacheop_pou_access },
     { .name = "DC_IVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 1,
       .access = PL1_W, .accessfn = aa64_cacheop_poc_access,
@@ -4758,7 +4769,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "DC_CVAU", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 11, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
-      .accessfn = aa64_cacheop_access },
+      .accessfn = aa64_cacheop_pou_access },
     { .name = "DC_CIVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
@@ -4932,13 +4943,13 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbiipas2_is_write },
     /* 32 bit cache operations */
     { .name = "ICIALLUIS", .cp = 15, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_pou_access },
     { .name = "BPIALLUIS", .cp = 15, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 6,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "ICIALLU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 0,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_pou_access },
     { .name = "ICIMVAU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_pou_access },
     { .name = "BPIALL", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 6,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "BPIMVA", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 7,
@@ -4952,7 +4963,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "DCCSW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 11, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_pou_access },
     { .name = "DCCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_poc_access },
     { .name = "DCCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
-- 
2.20.1


