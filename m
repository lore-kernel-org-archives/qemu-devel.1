Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A8DC3F68F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940DC205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTXjsKOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940DC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixymG-0006tg-RG
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySr-0007qT-Gu
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySp-00071s-UN
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:57 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySp-00071D-OE
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:55 -0500
Received: by mail-pl1-x641.google.com with SMTP id p11so4173023plq.10
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lx6/vKYYp72gTf4UzAbSPEaYbohru43Bb1YVjGxSPOk=;
 b=VTXjsKOXLLDWu/8fnM+GyNmzUeqOH2g+GM6CPoaywnMdCUnVIfGuLd65u3xaYez5kr
 FpKS+8oLi3frkPErtqgorMxAuUUea+OEdPdyzHLPOZ5NEo0SFKmfvlD1aCCX8ghzVQfL
 4lhMbBuSfkhLm51PJqMIvcZS3fywxMwTQxL4AGVB3pK6fVrAvuevijYZKzKupXvDMxVK
 JngcWJgCZWiYy5Jl3qPbsMXqVJmPIUoXnvO/jRSoRKY1cQM6QOu+E1IXhcbUADpUZDLo
 7K93pXS+t1VLEmFJtTigNPk480XRh0TdjsrYTurAeC67scUU3UWDA9eEsvaUwkrichAx
 LAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lx6/vKYYp72gTf4UzAbSPEaYbohru43Bb1YVjGxSPOk=;
 b=ZdKVppyhK3I2zZLfbz1VLohWlF2PhZk0M0tf7zOYkfMrp1j7AyeU6mQP4DL3d+2PU9
 R29T3TZWWaX+6KmgwPuW2XwxAkvPMbVn1aDtAJTn4J3THdqeeQPzDvzfd148E2sxqrmc
 sz2fcRPhsrlCmuIB2keIF+OVDnthdAThrONbyQcYtYqDmyYWeSSO7PYE7iA3nVWwJA5V
 WGxnemIJBWPSm82GfOvcYme5eCqtJ82TVHqMkHOh873qryrNWiLmnosd9nzBP8CN7K36
 W5INk9tPGEqj68B5Yvk1pGmzJP3rSGlwarA++ywb7odnyKvlnvwPKiPjdcRK8QQyf7VE
 OLpA==
X-Gm-Message-State: APjAAAUhfJ5B0n1qt2t/E9JPPtgGwWSZO1PH20/gG0ZQz5wrs3MVsAkM
 oEq13r/di2G6cGcxsxQDWqntB01Ve3M=
X-Google-Smtp-Source: APXvYqw3Quxvlf+KoHLVh7anwxb+t9irTmm6KkeZ61Xt8zeaYnS3mfCBukLr9WAkhxEjgrti0Muaqw==
X-Received: by 2002:a17:90a:858c:: with SMTP id
 m12mr18764534pjn.127.1580585394346; 
 Sat, 01 Feb 2020 11:29:54 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 31/41] target/arm: Flush tlbs for E2&0 translation regime
Date: Sat,  1 Feb 2020 11:29:06 -0800
Message-Id: <20200201192916.31796-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Flush all EL2 regimes with TLBI ALLE2 (pmm).
---
 target/arm/helper.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f9be6b052f..0e2278b5aa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4174,8 +4174,12 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 
 static int vae1_tlbmask(CPUARMState *env)
 {
+    /* Since we exclude secure first, we may read HCR_EL2 directly. */
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
+    } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
+               == (HCR_E2H | HCR_TGE)) {
+        return ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0;
     } else {
         return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
     }
@@ -4219,6 +4223,12 @@ static int alle1_tlbmask(CPUARMState *env)
     }
 }
 
+static int alle2_tlbmask(CPUARMState *env)
+{
+    /* TODO: ARMv8.4-SecEL2 */
+    return ARMMMUIdxBit_E20_0 | ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E2;
+}
+
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
@@ -4231,10 +4241,10 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = alle2_tlbmask(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4259,8 +4269,9 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = alle2_tlbmask(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4271,6 +4282,15 @@ static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_SE3);
 }
 
+static int vae2_tlbmask(CPUARMState *env)
+{
+    if (arm_hcr_el2_eff(env) & HCR_E2H) {
+        return ARMMMUIdxBit_E20_0 | ARMMMUIdxBit_E20_2;
+    } else {
+        return ARMMMUIdxBit_E2;
+    }
+}
+
 static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -4278,11 +4298,11 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * Currently handles both VAE2 and VALE2, since we don't support
      * flush-last-level-only.
      */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


