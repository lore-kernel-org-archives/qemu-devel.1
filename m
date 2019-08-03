Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A81C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BFC2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dO8sJijZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BFC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzA4-0001iI-OR
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60726)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4l-0006FM-L1
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4k-0007C8-4W
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4i-0007Aq-9e
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:16 -0400
Received: by mail-pg1-x541.google.com with SMTP id o13so37653042pgp.12
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ebweW1bxG4mlr4zUkxD0Pv+fcpZzn603jNjjqkso5Rc=;
 b=dO8sJijZ1OJHBbtBkNrBGZwgxZqhDR3pnZ17F4RG48Q+rZ2YYG+zmyWKMdUWJgYasD
 npGZFmyiQ+SppHzUz0YshpFHT2cj/buuGGrgh6aROftTUI9XolXqun8J9P5EhmWip+ze
 Bp0dYd2RLKbOSIOmH3ZOElHSGMHsJ0a+RudWjmrdPGtZNqYbT3WSKKumXM3D5Q5ZjFeg
 f0fLiQwKRm/adsq7n+R+xANG4DA6lWtGQfIIjrlDHkyRD2yTYz1fACiEGO3OxFEHVpED
 oErG27FbDZuX3lNsJGA1vopDmV4jeiHvqNwZlt49WL/y73eqCBV908eDQtKxRA7afIxZ
 eaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ebweW1bxG4mlr4zUkxD0Pv+fcpZzn603jNjjqkso5Rc=;
 b=j4nJ2iRDrxfC3uSWE9vlq507Eae+3Aa/heUaIM94opmX0YQ2lKK57JEOBJg2k5TDCK
 57qr7D3cB/u2Oi+AjZqj7bqYhyTNSowC3dtiHKH8ox5QPoPV+qwq8te6YFdUC0zD5aU6
 Z7nlKHrVgOB7FnCVUBgeuV2yCcYf0QZxDf395fFHB/NMjQq7bdqPn/Fy1nDHHMUz6l9K
 s4vBGZJiEQbwt/p8vMVtahkRlvNOoxUAX8hiW5IV62eX8rGPOuPZm/XhDdz7s+M6puYz
 a86edMYTBRry1AGEnvsbY/rFk4N6vOO2mAoeyQoCXZEiWqR9xGYgGZmAhI3nlQK1UMCa
 4BqQ==
X-Gm-Message-State: APjAAAXlyAzyCljjN0FFmL2Ily5HyhZhMVTt94OuIBeP6GSW66tMEVNK
 ULaRzfo9VOk/48LIv/lAsz+NT/XyML4=
X-Google-Smtp-Source: APXvYqzESc5O7rN+zLAS85mB8ekDyYCTLf/IJJ0EFezaffKKgvlIv9CQteMSbBvCYvSLesZLKBEGdQ==
X-Received: by 2002:a62:e710:: with SMTP id s16mr67733969pfh.183.1564858095005; 
 Sat, 03 Aug 2019 11:48:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:36 -0700
Message-Id: <20190803184800.8221-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 10/34] target/arm: Update CNTVCT_EL0 for VHE
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

The virtual offset may be 0 depending on EL, E2H and TGE.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8d8b3cc40e..e2fcb03da5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2484,9 +2484,31 @@ static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gt_get_countervalue(env);
 }
 
+static uint64_t gt_virt_cnt_offset(CPUARMState *env)
+{
+    uint64_t hcr;
+
+    switch (arm_current_el(env)) {
+    case 2:
+        hcr = arm_hcr_el2_eff(env);
+        if (hcr & HCR_E2H) {
+            return 0;
+        }
+        break;
+    case 0:
+        hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            return 0;
+        }
+        break;
+    }
+
+    return env->cp15.cntvoff_el2;
+}
+
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - env->cp15.cntvoff_el2;
+    return gt_get_countervalue(env) - gt_virt_cnt_offset(env);
 }
 
 static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2501,7 +2523,13 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
                       (gt_get_countervalue(env) - offset));
@@ -2511,7 +2539,13 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           int timeridx,
                           uint64_t value)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     trace_arm_gt_tval_write(timeridx, value);
     env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
-- 
2.17.1


