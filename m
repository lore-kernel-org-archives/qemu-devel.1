Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6D6C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66C42171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hb+iG6hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66C42171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvXf-0004KF-6j
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33157)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN9-0005Ui-1Q
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN7-0003o4-Mu
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:54 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvN7-0003lg-FO
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:53 -0400
Received: by mail-pl1-x644.google.com with SMTP id c2so30962335plz.13
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+7keF6G5xzpT4+93ObrzwUEEy1FTEHDioAfRG1ABjog=;
 b=Hb+iG6hikB6nHFx/0MT8WzAVyCuE4kWuAO6EzmOEnNm3pFGP9rMfaa1afO3UPUFGnv
 17DQ2LWK+1yBpJTJLNPFOiJwODFNOF90nLDcIgpHG0kwEYnRZjq0JXk/KkvqdwvJg/CK
 pQch3+YjbwCiE2BwPmod0uoZT2TyuP7J2F6c4Z4mvkyo8QnjfDok7IReDNPNkQlp/tXw
 oDzcFFZZ2bb7UBYwaidmj5/YQClk1pXg8m0qIr38dxZrN1k3QhnzeXRXJcsfiLRAhSic
 fSiROngHfmDmaEwU3JQik0jKTVpRd//AbtSbbZk+IY1/siAwrNC1xfGOGTP91M302qm7
 9SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+7keF6G5xzpT4+93ObrzwUEEy1FTEHDioAfRG1ABjog=;
 b=HRP24J1xQU9UBJRzVh5jWdnC86Uiklpb5veBqUwO+lL9bJkDZI5jiyryr3ZqPf/PVJ
 BsNmPi2DmBA3qAh2HwrxPOVQ63dIdsYnS6miRjUo8Ju8LK0fJqyAS8LM16x1Vvq5ZeNA
 DzO2wH00fNLTjH2o+0y/f2lrXCBm/cmx9V46shcI6z2hOEGPu899sZGV+Xuq9UQRXRfu
 F+wjeWggF+tIDDqh3WN4PjmL05OUtbLsx5dUlHBA51P5R7jn+4d8PICyColeCo5LkqxB
 WHqbIN3WqW0eN+Dh9v3x9mx/3Q3SK5VDvTsVnTepT5bGb2YmuJoqpfkNWusMYj7X0KsY
 wCQw==
X-Gm-Message-State: APjAAAUPO8TzugB+Crq24qqQU6ZwehHAaEIvHSiFgDrw8OCkeVuP5PIx
 Yx0/Dio3VY0ORmuQZAVRaKPZUrBpdZY=
X-Google-Smtp-Source: APXvYqxPqhnHLkD9ZTEK6UndKKSKwUuWx9yFtf49NDBkQ9tTj1uBFc4OcS5nvaMeOGiudvRm9gc63w==
X-Received: by 2002:a17:902:f81:: with SMTP id
 1mr27243792plz.191.1564605530692; 
 Wed, 31 Jul 2019 13:38:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:10 -0700
Message-Id: <20190731203813.30765-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 29/32] target/arm: Update {fp,
 sve}_exception_el for VHE
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When TGE+E2H are both set, CPACR_EL1 is ignored.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 15a054a141..b29717edb6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5507,7 +5507,9 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
 int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
-    if (el <= 1) {
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+
+    if (el <= 1 && (hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
         bool disabled = false;
 
         /* The CPACR.ZEN controls traps to EL1:
@@ -5522,8 +5524,7 @@ int sve_exception_el(CPUARMState *env, int el)
         }
         if (disabled) {
             /* route_to_el2 */
-            return (arm_feature(env, ARM_FEATURE_EL2)
-                    && (arm_hcr_el2_eff(env) & HCR_TGE) ? 2 : 1);
+            return hcr_el2 & HCR_TGE ? 2 : 1;
         }
 
         /* Check CPACR.FPEN.  */
@@ -11221,8 +11222,6 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
-    int fpen;
-
     /* CPACR and the CPTR registers don't exist before v6, so FP is
      * always accessible
      */
@@ -11250,30 +11249,34 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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
2.17.1


