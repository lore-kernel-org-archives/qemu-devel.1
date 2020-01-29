Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4372C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC04F206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psEh/io5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC04F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxRL-0004Du-S1
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCX-0004HQ-4e
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCU-0008Mk-Mu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:53 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCU-0008IX-F2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:50 -0500
Received: by mail-pj1-x1041.google.com with SMTP id d5so496308pjz.5
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4LNMqoKrAUb5BX3LSJiath1cwmnPLv9qWjW/bP/ednQ=;
 b=psEh/io55IjZNdWD+Yp4UiBT3fWefRcE+FhmiyjycaN83cqGenGWtdCU2JV2N5JdGA
 PvF3oWRo6ePPX9satYCCgudQxURx1ZpopvsLCFxuvodyLWMu6HF0l7eENzFsBpu0gzEx
 j5/u9ei3ryvg/dXjgt7tmcAyyWAxf6X29+Zcg+Di1pQ2E0lpATTmwK6JFjJ+FEHr0hke
 aDW9/ONaG9nIiMc0Y3WZywAobL7zeI06fKKLXNQ0e8uf06f0uz85MRJZHvLf8Req1pJi
 Bd9fx6arLzK6teCUxnVg00kmLA5rvVMRNZtU3JxneG2q3NSpGBlpV2mfwOjtC13tkfyt
 kv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4LNMqoKrAUb5BX3LSJiath1cwmnPLv9qWjW/bP/ednQ=;
 b=S+GKE3aG5OAigv10bMhP6JBNt3EN5BC6nWwnqDEePI7sCXdrmnnci/HvqMaB97z0lz
 iO0CyrN9vcWviNokd4RMz9eCY/oCm7te1iI9mPwupwfcYmxa7uIJL1tqUgrxl3+b+KYy
 s8/wyhdNOnO+eDUx+QJ1V4bXScXAQFB4U3yYkZff8pfWFSau1eq7CISsN+epy7Q14IPT
 rOTdYcOArnGUA79pdQSy6qhP6Tn/9OFNSMxUzVjw2IsS6yjnrAquGdDXNLDiutJYuCKZ
 lTQCrcCSbM9rQ0AXTNIRS32g46p13mPBcc9kcxzDbTIxXHDvMTkeXaksmzgWdw4HjCGW
 pheg==
X-Gm-Message-State: APjAAAWtfqqcwkODL1PewjasrsQThE4UXLBp1dN2y5v5YlCqWIFnUxq6
 Gc6CFw9/MTREOkBCEsCPoi2+T4A/dvY=
X-Google-Smtp-Source: APXvYqwSA5quj+jfnZi+CbcQqBykK+LW581vxOkLUvJksST30P1BRfv/HXKie70jfPPf4B84rIRksQ==
X-Received: by 2002:a17:902:7c85:: with SMTP id
 y5mr1861830pll.227.1580342209163; 
 Wed, 29 Jan 2020 15:56:49 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 26/41] target/arm: Update timer access for VHE
Date: Wed, 29 Jan 2020 15:55:59 -0800
Message-Id: <20200129235614.29829-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 102 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f633554678..37e8bf4949 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2324,10 +2324,18 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
      * Writable only at the highest implemented exception level.
      */
     int el = arm_current_el(env);
+    uint64_t hcr;
+    uint32_t cntkctl;
 
     switch (el) {
     case 0:
-        if (!extract32(env->cp15.c14_cntkctl, 0, 2)) {
+        hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            cntkctl = env->cp15.cnthctl_el2;
+        } else {
+            cntkctl = env->cp15.c14_cntkctl;
+        }
+        if (!extract32(cntkctl, 0, 2)) {
             return CP_ACCESS_TRAP;
         }
         break;
@@ -2355,17 +2363,47 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
 {
     unsigned int cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
+    uint64_t hcr = arm_hcr_el2_eff(env);
 
-    /* CNT[PV]CT: not visible from PL0 if ELO[PV]CTEN is zero */
-    if (cur_el == 0 &&
-        !extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
-        return CP_ACCESS_TRAP;
-    }
+    switch (cur_el) {
+    case 0:
+        /* If HCR_EL2.<E2H,TGE> == '11': check CNTHCTL_EL2.EL0[PV]CTEN. */
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            return (extract32(env->cp15.cnthctl_el2, timeridx, 1)
+                    ? CP_ACCESS_OK : CP_ACCESS_TRAP_EL2);
+        }
 
-    if (arm_feature(env, ARM_FEATURE_EL2) &&
-        timeridx == GTIMER_PHYS && !secure && cur_el < 2 &&
-        !extract32(env->cp15.cnthctl_el2, 0, 1)) {
-        return CP_ACCESS_TRAP_EL2;
+        /* CNT[PV]CT: not visible from PL0 if EL0[PV]CTEN is zero */
+        if (!extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
+            return CP_ACCESS_TRAP;
+        }
+
+        /* If HCR_EL2.<E2H,TGE> == '10': check CNTHCTL_EL2.EL1PCTEN. */
+        if (hcr & HCR_E2H) {
+            if (timeridx == GTIMER_PHYS &&
+                !extract32(env->cp15.cnthctl_el2, 10, 1)) {
+                return CP_ACCESS_TRAP_EL2;
+            }
+        } else {
+            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
+            if (arm_feature(env, ARM_FEATURE_EL2) &&
+                timeridx == GTIMER_PHYS && !secure &&
+                !extract32(env->cp15.cnthctl_el2, 1, 1)) {
+                return CP_ACCESS_TRAP_EL2;
+            }
+        }
+        break;
+
+    case 1:
+        /* Check CNTHCTL_EL2.EL1PCTEN, which changes location based on E2H. */
+        if (arm_feature(env, ARM_FEATURE_EL2) &&
+            timeridx == GTIMER_PHYS && !secure &&
+            (hcr & HCR_E2H
+             ? !extract32(env->cp15.cnthctl_el2, 10, 1)
+             : !extract32(env->cp15.cnthctl_el2, 0, 1))) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        break;
     }
     return CP_ACCESS_OK;
 }
@@ -2375,19 +2413,41 @@ static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
 {
     unsigned int cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
+    uint64_t hcr = arm_hcr_el2_eff(env);
 
-    /* CNT[PV]_CVAL, CNT[PV]_CTL, CNT[PV]_TVAL: not visible from PL0 if
-     * EL0[PV]TEN is zero.
-     */
-    if (cur_el == 0 &&
-        !extract32(env->cp15.c14_cntkctl, 9 - timeridx, 1)) {
-        return CP_ACCESS_TRAP;
-    }
+    switch (cur_el) {
+    case 0:
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            /* If HCR_EL2.<E2H,TGE> == '11': check CNTHCTL_EL2.EL0[PV]TEN. */
+            return (extract32(env->cp15.cnthctl_el2, 9 - timeridx, 1)
+                    ? CP_ACCESS_OK : CP_ACCESS_TRAP_EL2);
+        }
 
-    if (arm_feature(env, ARM_FEATURE_EL2) &&
-        timeridx == GTIMER_PHYS && !secure && cur_el < 2 &&
-        !extract32(env->cp15.cnthctl_el2, 1, 1)) {
-        return CP_ACCESS_TRAP_EL2;
+        /*
+         * CNT[PV]_CVAL, CNT[PV]_CTL, CNT[PV]_TVAL: not visible from
+         * EL0 if EL0[PV]TEN is zero.
+         */
+        if (!extract32(env->cp15.c14_cntkctl, 9 - timeridx, 1)) {
+            return CP_ACCESS_TRAP;
+        }
+        /* fall through */
+
+    case 1:
+        if (arm_feature(env, ARM_FEATURE_EL2) &&
+            timeridx == GTIMER_PHYS && !secure) {
+            if (hcr & HCR_E2H) {
+                /* If HCR_EL2.<E2H,TGE> == '10': check CNTHCTL_EL2.EL1PTEN. */
+                if (!extract32(env->cp15.cnthctl_el2, 11, 1)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
+                if (!extract32(env->cp15.cnthctl_el2, 1, 1)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        }
+        break;
     }
     return CP_ACCESS_OK;
 }
-- 
2.20.1


