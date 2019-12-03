Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41978C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D678206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROljyHfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D678206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyMp-00023d-Re
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxL-0003Pi-VM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxJ-0000Ch-Tr
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:27 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:46177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxH-00008j-MV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:24 -0500
Received: by mail-pj1-x1041.google.com with SMTP id z21so799042pjq.13
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wrciTI1v/mNpw+XObN5cyZ1jMW9FF/u8Ocv1yHt3lTU=;
 b=ROljyHfZLuEU7PDLX5pc8bRpKTjz3BSqEn6fOyHa83GBVEttSWWx9z5tvzkEkjvI8h
 UKRTQkhq6zi+qaE44qNM1eDK1a+gnALoa6zbi5Jel34Kngqm+ulgFwYfSKUXHLLDnd1A
 Cc6MEdcHCLo7QDD/acEBz4+3mEARCOtkeN/jCp3ozTn2tJPSmDMQjrRWEJgNFm9/8B4T
 KENKnHcrmg9ScOh1nokDBPdJBsALUgKUTEfIqKzhHp9UIZOwKSV9iv/qThMZvGj3CzdE
 e9B9eofKxugshmVPgsfzmUP6GrewLR0liAm1cy6A9RM5MFUtNn5FtBd/45prCeE6CbM/
 1aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wrciTI1v/mNpw+XObN5cyZ1jMW9FF/u8Ocv1yHt3lTU=;
 b=oy39EynBvYCjKufsDMHGQNnIdAEudnh2ObrxBDfmMqq2fXBdlbysUnJAp1j+6hnLXC
 iquhm7etA5UXWgJnyfRxqmypR0zySj3rS+qHWgEMTxPSlT2KHZhyusYHBLKe7ra9J1v5
 bj92J7386mKTlKBA8ONXyp+CB+/FfHsD0+u99tYTNwuas/vsqFELCgETZDXWR9VMd2uH
 cE8MTf0W/9zwWcxrzxiHGtguP9gMWvXyJzVF7I7JH/UgjBvzTVg1er8h2X6JBQ9fxXpL
 lR0Trwg+Qk04OyKOAnuBkG+4W++m6r0/z94WRR6Ywe5L9aD5Poj0TC27S8BHVtHeJ6yM
 y0VQ==
X-Gm-Message-State: APjAAAUZgzRelLPcwZyisRstEWYxqavQOYFyjgOxtuoAGURIqwL1tTeJ
 VuFcY7kbvD2VajcknfqwUcKwFWThIMQ=
X-Google-Smtp-Source: APXvYqzzJ3EurqVqGxJuXn7PuuK8fu1euMl5j1oDXin3Jy2Pd2UxBg14lSlxn2vxEPnr68XfEMIHRA==
X-Received: by 2002:a17:902:322:: with SMTP id
 31mr2709960pld.244.1575340220163; 
 Mon, 02 Dec 2019 18:30:20 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 32/40] target/arm: Update {fp,sve}_exception_el for VHE
Date: Mon,  2 Dec 2019 18:29:29 -0800
Message-Id: <20191203022937.1474-33-richard.henderson@linaro.org>
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

When TGE+E2H are both set, CPACR_EL1 is ignored.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e0b8c81c5f..3e025eb22e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5743,7 +5743,9 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
 int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
-    if (el <= 1) {
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+
+    if (el <= 1 && (hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
         bool disabled = false;
 
         /* The CPACR.ZEN controls traps to EL1:
@@ -5758,8 +5760,7 @@ int sve_exception_el(CPUARMState *env, int el)
         }
         if (disabled) {
             /* route_to_el2 */
-            return (arm_feature(env, ARM_FEATURE_EL2)
-                    && (arm_hcr_el2_eff(env) & HCR_TGE) ? 2 : 1);
+            return hcr_el2 & HCR_TGE ? 2 : 1;
         }
 
         /* Check CPACR.FPEN.  */
@@ -11565,8 +11566,6 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
-    int fpen;
-
     /* CPACR and the CPTR registers don't exist before v6, so FP is
      * always accessible
      */
@@ -11594,30 +11593,34 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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


