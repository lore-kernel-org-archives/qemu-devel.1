Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7877CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4385D206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSQ3l3AN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4385D206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf0R-0000s7-DC
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoc-0003S9-96
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoa-0008Kq-8w
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:22 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoZ-0008Bz-Vc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:20 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so6492302wma.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wVQPgESetZfJWAa1wxaT4MKLDuUV7BeQOZ/chqO69oU=;
 b=nSQ3l3ANj0BHCDqKKeT0NMDRvSWbcNIEGRMsAyhyZg/vAT5pNeeZ8DV6ae1zC2t9dp
 Un0bkQw0uq8Zv801OlhybU7KmPl07j9dj8V5fp1S4uFuJta5iberArVvm5s+GHiMVWdX
 qFB6n/tTa7fVD72YbYwRQZYxTJJZLqJWqHiAvlCcH9G3ekLhkKXMTy0qiVxLzyDzElOQ
 0LInqFRNyWiihmBJavKhtFbmJCN4oRk5yvKjF+69TkDtKn8ijOgHQBcwoV8XyK0CaUWo
 DIIDN3nYYQd2ts9IIIZ/CUq+rDfo8ji72tmLeZcyTfpDHxEagJhUtyGjrX0QTCDkC/oy
 f/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wVQPgESetZfJWAa1wxaT4MKLDuUV7BeQOZ/chqO69oU=;
 b=dnlRA9W1i9Gni8iXb24PtRMla1DIdYkrleCEMtOkpk1XWd3dkIR2ZrhA+HbiPtY3Q0
 x63xnRJFIFwk5jrIwyBXqSCA02EaHxPTyLOyePBzLwhctFS82xkTdfNo4GeG/QuHVP4q
 OItDBV48mGjP1PYsIISDUORIUv2tmMAFGSM8EZ8lQZ1bBZA74+wEduY4cger0ywBhCo3
 YCdlIqyvGqe3fPwWtVZwPtmhnVgEmz0wEOU6iH06ag2NPVBiVM5fvCDPX3RJN0ZTyr6W
 irCCEfSAVTlq7z8VSzdlIxSH891TgQ8oGK9YrZPBGV7RZz5aAI7e1vn+guDrmO7abzr8
 8iAQ==
X-Gm-Message-State: APjAAAWCfryKflOCtz7rJo2LDhUkTz+RhQ9baLU7xL7ow9cjelUBXs6N
 EGoXnjtZBTU/HSGpfU+2bXU3I5AUD1JjCQ==
X-Google-Smtp-Source: APXvYqw2ZqBn7zIVndIFauOGEcnCd5u+kTHF4deLdiQ+zWx4ZUnbzb6Pq8reyT4lL3mGKJJoYpsGsA==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr4079916wmi.118.1580986517816; 
 Thu, 06 Feb 2020 02:55:17 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 33/41] target/arm: Update {fp,sve}_exception_el for VHE
Date: Thu,  6 Feb 2020 10:54:40 +0000
Message-Id: <20200206105448.4726-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When TGE+E2H are both set, CPACR_EL1 is ignored.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 56a62b11d0..9627b4aab1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5791,7 +5791,9 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
 int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
-    if (el <= 1) {
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+
+    if (el <= 1 && (hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
         bool disabled = false;
 
         /* The CPACR.ZEN controls traps to EL1:
@@ -5806,8 +5808,7 @@ int sve_exception_el(CPUARMState *env, int el)
         }
         if (disabled) {
             /* route_to_el2 */
-            return (arm_feature(env, ARM_FEATURE_EL2)
-                    && (arm_hcr_el2_eff(env) & HCR_TGE) ? 2 : 1);
+            return hcr_el2 & HCR_TGE ? 2 : 1;
         }
 
         /* Check CPACR.FPEN.  */
@@ -11691,8 +11692,6 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
-    int fpen;
-
     /* CPACR and the CPTR registers don't exist before v6, so FP is
      * always accessible
      */
@@ -11720,30 +11719,34 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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


