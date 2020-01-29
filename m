Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9878DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62663206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3XO9vqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62663206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxP7-0008OJ-I8
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC7-0003ev-Uq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC6-00077T-KY
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:27 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxC6-00074I-E2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:26 -0500
Received: by mail-pj1-x1044.google.com with SMTP id m7so1873566pjs.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sh3g84f+EseEZ5hl4v3l5CwAzzRC5kdP1vtGxWCc2nU=;
 b=Q3XO9vqVuPYJ8mjJYBnN64meKRgfQTsE9O1viDv1wLI+rVeF3ursMtmF3A1YWVX9Mp
 ybHwC+Ixm6XprxIXwGTGHhu6e71sXNE88Xj65gA7ACMZKY/34tkaelRNY5oi/CDZ1FrG
 iAieENDFCMBLQqJJ1X8K0msiCRajnjvOnAYGm9Su5OaJrRDpJyeMrVC7FWzEJZiAl1ka
 9DOlT96gjG9EhNUvHwebHNxPtkDlSoba+2umh509d7xvZzZsLo7JTpc+fZGO9LPZyN7r
 kGcJFFOPvQKo33JGWM7JmAP3zqIAaQcgOLTAWhw4sqnjJChoINK0+OVBKY0w9pfPJ3qW
 eQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sh3g84f+EseEZ5hl4v3l5CwAzzRC5kdP1vtGxWCc2nU=;
 b=RV3tHMZA8rhbd9YUUA8MkXgyTcw42S3r+oX0XVkVJVnNrxgvI72QCjc3Im+lNlWiLZ
 tzCcUTDgKdGPoT6Vv7ihkP1rXyuE23LsuffCHu+s0t9JyLHABiwScyRepM4+nwvkOSSN
 /4aBaPf2PgtEhfhLeZeL8UyIlWHV83XjgLk9BjOX9/xsXEzNke6kZc4S15rv81UVEzCE
 zCRWX0gYyl4n9JJ+HTejFCK9PqiU/FMMS54RFjiy1pVtYc20NPYAmdbQMVPu6vQSDujs
 8JWufSBHgGskl9dWpC0Fa+Ic1sfyuDmJKnbV6g2N2WEgzEZwScINXeVlGLBujnzvX3wW
 TZqw==
X-Gm-Message-State: APjAAAU4ECR4IyqAbJ2V+pm/jGTA38MzNN96qzj9Vj5Yqk9z58bor3ys
 YEcmxC0OM+qCo8PsaGChaPsqBX/VJ6c=
X-Google-Smtp-Source: APXvYqwOS6mTpHChW0brJQ+dalzPkJxyjUJ8hs7YdEHlcnB+cFdkneQUvP8vKryQuq7nvDHM7ZjrrA==
X-Received: by 2002:a17:90a:1785:: with SMTP id
 q5mr2524948pja.143.1580342185068; 
 Wed, 29 Jan 2020 15:56:25 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/41] target/arm: Split out alle1_tlbmask
Date: Wed, 29 Jan 2020 15:55:40 -0800
Message-Id: <20200129235614.29829-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change, but unify code sequences.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Do not confuse things by prefixing "vm".
---
 target/arm/helper.c | 86 +++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 62 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20eb8b53c1..00b770813f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3972,34 +3972,31 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs, mask);
 }
 
-static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  uint64_t value)
+static int alle1_tlbmask(CPUARMState *env)
 {
-    /* Note that the 'ALL' scope must invalidate both stage 1 and
+    /*
+     * Note that the 'ALL' scope must invalidate both stage 1 and
      * stage 2 translations, whereas most other scopes only invalidate
      * stage 1 translations.
      */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
-
     if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S1SE1 |
-                            ARMMMUIdxBit_S1SE0);
+        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+    } else if (arm_feature(env, ARM_FEATURE_EL2)) {
+        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBit_S2NS;
     } else {
-        if (arm_feature(env, ARM_FEATURE_EL2)) {
-            tlb_flush_by_mmuidx(cs,
-                                ARMMMUIdxBit_S12NSE1 |
-                                ARMMMUIdxBit_S12NSE0 |
-                                ARMMMUIdxBit_S2NS);
-        } else {
-            tlb_flush_by_mmuidx(cs,
-                                ARMMMUIdxBit_S12NSE1 |
-                                ARMMMUIdxBit_S12NSE0);
-        }
+        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
     }
 }
 
+static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = alle1_tlbmask(env);
+
+    tlb_flush_by_mmuidx(cs, mask);
+}
+
 static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
@@ -4021,28 +4018,10 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    /* Note that the 'ALL' scope must invalidate both stage 1 and
-     * stage 2 translations, whereas most other scopes only invalidate
-     * stage 1 translations.
-     */
     CPUState *cs = env_cpu(env);
-    bool sec = arm_is_secure_below_el3(env);
-    bool has_el2 = arm_feature(env, ARM_FEATURE_EL2);
+    int mask = alle1_tlbmask(env);
 
-    if (sec) {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S1SE1 |
-                                            ARMMMUIdxBit_S1SE0);
-    } else if (has_el2) {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S12NSE1 |
-                                            ARMMMUIdxBit_S12NSE0 |
-                                            ARMMMUIdxBit_S2NS);
-    } else {
-          tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                              ARMMMUIdxBit_S12NSE1 |
-                                              ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4092,20 +4071,11 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
-    bool sec = arm_is_secure_below_el3(env);
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    if (sec) {
-        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                                 ARMMMUIdxBit_S1SE1 |
-                                                 ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                                 ARMMMUIdxBit_S12NSE1 |
-                                                 ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4116,8 +4086,8 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * since we don't support flush-for-specific-ASID-only or
      * flush-last-level-only.
      */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     if (tlb_force_broadcast(env)) {
@@ -4125,15 +4095,7 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
-    if (arm_is_secure_below_el3(env)) {
-        tlb_flush_page_by_mmuidx(cs, pageaddr,
-                                 ARMMMUIdxBit_S1SE1 |
-                                 ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_page_by_mmuidx(cs, pageaddr,
-                                 ARMMMUIdxBit_S12NSE1 |
-                                 ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


