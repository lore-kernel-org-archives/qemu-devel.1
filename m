Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E592CC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B301D206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tn3+R9XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B301D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxUQ-0001Ns-R9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCj-0004Wk-JO
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCi-0000MR-EN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:05 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCi-0000Go-23
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:04 -0500
Received: by mail-pf1-x443.google.com with SMTP id y73so508046pfg.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y6J1gtRsiQA/1xrwB+aYUfsw1CVCt2k8FwxE4jflO30=;
 b=tn3+R9XEs5EJCXH3mwD5atkFjhMrMxM7Qlg4WZXax6+mvAvYxHvHl1xyFXvWyY6Jun
 dN3ypWl5XXPt8fzeUCXys2D2dC5/tiDoZfJHpj0ICvCYu39lsfb54GhG4I/X6bCknUL5
 6UxcP1TVMNjAOHYgb8N/cFTfZeePodtfR17c6Rydyr3YYKBg39wwaf8gdFYw7bWHOEnb
 JrkFE77+RyQTkpCvhBkUQ5PvhrZE273PrjaPLSfpdJOxnLYjbXfk4n0Lmhlh5uWc4FUF
 CeGa0Y7/oLD2XaX1kCZ5BqCKnyDFgsoA8fGOmVdq6m7KvEsrJ3l9z634e66iQZmrbCO8
 v8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y6J1gtRsiQA/1xrwB+aYUfsw1CVCt2k8FwxE4jflO30=;
 b=r9pCVv/LQ6PMEIpTSja1K9VwGu1jZe8XMZGvlenB0P6biOC8LvoBKWnMwjpUDR8Vif
 K7F2rzMKxOFi/VKfy+ojO3T7DzHUpWzMXffZRNSzdy4RKiWP2tFKnbN6JievQIXodvCA
 Ao7t1KEXEppaUYQ7ZTujrGIp+qhfk6fuw80qhesYWTqtSApQla7pkU7zMjFFYcYw/dkB
 RmcTd2wcm2p927SjDEDDbW+MGGM3jJ4G41tYS5LptUSBhpjkST9ALcxF9NpdSYUFxYW2
 M8UdbbEVlEGHjhYNdu+CD8OqZGkILlFPnLjDcsfyKWMqnvJ3sbZ3AKch7Dvutkb5EV+B
 +Q6A==
X-Gm-Message-State: APjAAAWXyIkt1goMxxLw6XG90ptHn+cqqZbyz4On851L9Z7/3QKWOHYC
 xAZpOdow+ynVEFlV4qQdm9oxqDW3DYY=
X-Google-Smtp-Source: APXvYqxWjP7nMofZ/AAYR+R/TwaD+RE5foHAF77VJbu8VaxU3jMtxTA648w3BklCVwnyrTZ2r1/lNg==
X-Received: by 2002:a62:1cd6:: with SMTP id c205mr2093232pfc.179.1580342218248; 
 Wed, 29 Jan 2020 15:56:58 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 33/41] target/arm: Update {fp,sve}_exception_el for VHE
Date: Wed, 29 Jan 2020 15:56:06 -0800
Message-Id: <20200129235614.29829-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

When TGE+E2H are both set, CPACR_EL1 is ignored.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0c1414acae..6f11b821f7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5800,7 +5800,9 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
 int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
-    if (el <= 1) {
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+
+    if (el <= 1 && (hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
         bool disabled = false;
 
         /* The CPACR.ZEN controls traps to EL1:
@@ -5815,8 +5817,7 @@ int sve_exception_el(CPUARMState *env, int el)
         }
         if (disabled) {
             /* route_to_el2 */
-            return (arm_feature(env, ARM_FEATURE_EL2)
-                    && (arm_hcr_el2_eff(env) & HCR_TGE) ? 2 : 1);
+            return hcr_el2 & HCR_TGE ? 2 : 1;
         }
 
         /* Check CPACR.FPEN.  */
@@ -11710,8 +11711,6 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
-    int fpen;
-
     /* CPACR and the CPTR registers don't exist before v6, so FP is
      * always accessible
      */
@@ -11739,30 +11738,34 @@ int fp_exception_el(CPUARMState *env, int cur_el)
      * 0, 2 : trap EL0 and EL1/PL1 accesses
      * 1    : trap only EL0 accesses
      * 3    : trap no accesses
+     * This register is ignored if E2H+TGE are both set.
      */
-    fpen = extract32(env->cp15.cpacr_el1, 20, 2);
-    switch (fpen) {
-    case 0:
-    case 2:
-        if (cur_el == 0 || cur_el == 1) {
-            /* Trap to PL1, which might be EL1 or EL3 */
-            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
+    if ((arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+        int fpen = extract32(env->cp15.cpacr_el1, 20, 2);
+
+        switch (fpen) {
+        case 0:
+        case 2:
+            if (cur_el == 0 || cur_el == 1) {
+                /* Trap to PL1, which might be EL1 or EL3 */
+                if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
+                    return 3;
+                }
+                return 1;
+            }
+            if (cur_el == 3 && !is_a64(env)) {
+                /* Secure PL1 running at EL3 */
                 return 3;
             }
-            return 1;
+            break;
+        case 1:
+            if (cur_el == 0) {
+                return 1;
+            }
+            break;
+        case 3:
+            break;
         }
-        if (cur_el == 3 && !is_a64(env)) {
-            /* Secure PL1 running at EL3 */
-            return 3;
-        }
-        break;
-    case 1:
-        if (cur_el == 0) {
-            return 1;
-        }
-        break;
-    case 3:
-        break;
     }
 
     /*
-- 
2.20.1


