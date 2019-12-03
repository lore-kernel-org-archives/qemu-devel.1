Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F33FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1F620674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWviWWm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1F620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyIJ-0004Wo-L1
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxI-0003M8-TY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxB-0008SL-Br
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:21 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxA-0008N2-Ml
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:16 -0500
Received: by mail-pj1-x1041.google.com with SMTP id ep17so824973pjb.4
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=foIQHgib5OJD+DVqFbHLebtrbVaKenjz5fFYNBd8YXw=;
 b=PWviWWm9BJulpYkjnp1LHoe0Zud2ZXYzUSId23LGfqJDKRQWf3NvXfbimwqjUlcxSf
 vWp4vKvajwyQ1m5WZotOINZBjlkDt7bBlhzDw/XG8e/VwipuGa/xul4XDSnG/Pz7t4yp
 COPRdx9RLwXKzV41a5yQO45g99IIMOlUYQiwbsxUN8vp2UCbTwA67krcitxr75MVzdLA
 TLCQvCZCRd/IIeLNAvFzgMUcZXIO01vHE3JDXzgeoQWSPsqEfxxRNYiyE5pe3Hmko1lh
 6f8zKzZrnef+Ao+H4LTdaAFiomMYlbHG05E/Oo6FQfS7ltCP3hOkZYWiokwJetOGjFU7
 PSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=foIQHgib5OJD+DVqFbHLebtrbVaKenjz5fFYNBd8YXw=;
 b=W7srrR3aCJNvWxoE5KyQtvznP4kZTx8Dglc39d1drsD/yK+8rA1Gx338hpJ2TdKC5M
 msd0fABjQEa0r53lBtug7wa4HqtFcrOJT2wE4bx3Iy52+eR63e+gXhslYEHKuUikv5ee
 xrEn3N8zTm+i92wpJxm3PhGdJBtBg/j9ET1CMRygvJeDk4nqTrsO6j/Pe0sHYUBgDv5V
 zhb2+sALJkMPMLeTBWunsB5elhhJuPghsAMXfJWtx++D6LN2Ba46Qo7bjk92BwcWtV3a
 liJCfu4TgCokvhaqkW71SoIOKpdZW491ZTACmMv+ndxET8qnCGPuMcEiF4Xls4tp/BfD
 jcCA==
X-Gm-Message-State: APjAAAW3Bj4jBryEGSAoyPH/Td3pB+9apzCGPUWFxWbyPF0rhmS2iC8k
 Ha0Ea2I+Kge0F0GHVRUZFqHbS36/YJQ=
X-Google-Smtp-Source: APXvYqwASr95QiG2wt5dhr6jKrC9ecTNFg88ozaCXty3QZJbUQgqES13S2c26i9aabVvPXPYhB33ZQ==
X-Received: by 2002:a17:90a:ff12:: with SMTP id
 ce18mr85891pjb.117.1575340211814; 
 Mon, 02 Dec 2019 18:30:11 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 25/40] target/arm: Update timer access for VHE
Date: Mon,  2 Dec 2019 18:29:22 -0800
Message-Id: <20191203022937.1474-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 102 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a4a7f82661..023b8963cf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2287,10 +2287,18 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -2318,17 +2326,47 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
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
@@ -2338,19 +2376,41 @@ static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
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
2.17.1


