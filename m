Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D42C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98AB2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kA7nCogz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98AB2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa5T-0006ka-0r
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3h-0000Ab-2p
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3f-0005eT-59
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:52 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3e-0005Dx-BA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:50 -0400
Received: by mail-pl1-x642.google.com with SMTP id a93so16143133pla.7
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qk9GipHOYNw6KZI4F5q4n7Nxd19EnnKx5R5hRD58GS0=;
 b=kA7nCogzBq55OAVpDWbuClTYj92FI9iJjlxZz2aRmuEXvdfU1+zQX7NqWSZ1S1jO6k
 lnRsC+F1HpX5OJruDSiWWdc9p+wOX5egnkN+GY2nwRRY6bQDb3J0zVzLoUbd2u+J8ft9
 jqoeZWuWUUa9Qv9zkEEuz/dz2XhevWRskkQ9AbLyoF+Ll67AKFrd59NC8Gk2SxKqLU/Z
 CfBVr7WS5HeoC991tZLSHvQQ0Iy5GBj0Dtgz1CHbiQ4pQ0EHxyy2Jxm2yEIzzAORHHDy
 ei1Z9Z1uAQEfK9yIKuo6URelRKkVnD1NZVTeYrWpZV1uqAwbMZizQ03YiehPeNhxeSAe
 uX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qk9GipHOYNw6KZI4F5q4n7Nxd19EnnKx5R5hRD58GS0=;
 b=RVvm+BoQBYsQuUZXQIBwDnAXVZ/4i1jhVV95icnlsdeMFqn5bLcqommx6sc7TfKo/5
 gnkfaBQB9o8v/HzK00DmrifD09pL46f0jH0wEcvgOemQUQTEJUpQt2fB9hUZBrrZ0JOD
 FiLeiTH1YPspZelQfeqr0axqmxaLSioYlbMQV3JlBSyl+E+juVBtJOOUy1NI6X77IgzE
 DLBRsLTU99ysKRW1GkL+CAs2xSRBhRUsbM0iYRZUC46KANimTSCu0H28YMtyb6RAXjd4
 okIYDhMHjH95/R7S+xgQLous45dh2KbU7MyVszUvaElgsAyiS0Fpyhs7SwR52ubJaKm0
 15CA==
X-Gm-Message-State: APjAAAV3Z+VD7nAwhb3vnqlunwvnbe3M4ndBndNDlughMZMOx/0ojovc
 alSGhXyyhkuzs9Oz5LJjgATG4LUI1OY=
X-Google-Smtp-Source: APXvYqxUIQE1tA8PuT0lCcEWh7Q661tHuQ7v+tQrBKM5nezsETmIb6u0jzuF3q8qcJrTYd7ywp3OrQ==
X-Received: by 2002:a17:902:934a:: with SMTP id
 g10mr60234914plp.18.1563570235782; 
 Fri, 19 Jul 2019 14:03:55 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:25 -0700
Message-Id: <20190719210326.15466-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH for-4.2 23/24] target/arm: Update {fp,
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When TGE+E2H are both set, CPACR_EL1 is ignored.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 53 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ae3ec9ea67..bbe36eb3a9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5501,7 +5501,9 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
 int sve_exception_el(CPUARMState *env, int el)
 {
 #ifndef CONFIG_USER_ONLY
-    if (el <= 1) {
+    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+
+    if (el <= 1 && (hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
         bool disabled = false;
 
         /* The CPACR.ZEN controls traps to EL1:
@@ -5516,8 +5518,7 @@ int sve_exception_el(CPUARMState *env, int el)
         }
         if (disabled) {
             /* route_to_el2 */
-            return (arm_feature(env, ARM_FEATURE_EL2)
-                    && (arm_hcr_el2_eff(env) & HCR_TGE) ? 2 : 1);
+            return hcr_el2 & HCR_TGE ? 2 : 1;
         }
 
         /* Check CPACR.FPEN.  */
@@ -11212,8 +11213,6 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
 int fp_exception_el(CPUARMState *env, int cur_el)
 {
 #ifndef CONFIG_USER_ONLY
-    int fpen;
-
     /* CPACR and the CPTR registers don't exist before v6, so FP is
      * always accessible
      */
@@ -11241,30 +11240,34 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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


