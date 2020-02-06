Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACEBC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6072720659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLDqCbLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6072720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35951 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeyo-0005eu-FL
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoY-0003QL-Nk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoX-00086e-Ew
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:18 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoX-00080v-6Y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:17 -0500
Received: by mail-wr1-x442.google.com with SMTP id k11so6550859wrd.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jR28dkVEy3qBagnsRPMx5EF9tlDXOyhdSQMlYFOe+Dw=;
 b=jLDqCbLOJxNo0I0PlTboeR23ievtWA+8CHJnjDm4y809HWdvRFAFvhfrYTIibzWgxp
 duKqf8fCh6mQOBtSvoxeCYPk3jv/Xed5dlH/xCRXs6tbLhb9JOD8fjPeBEiMU1Z7VVh1
 yCt0mJ4PU3AVZpFPMEfS4700hj8/sMTUK28bvLs9w88/kn5KM1ZxTEwKP4IqUl8yXyAK
 AFP9OLN29wFtc4wTfZGH6x7yPAbhWaG0IN9CUZ9Tu3jyDdHN0rPxjITy+xzTkG48W9fn
 nakqdwQx9DKOYJ/npZZxXP5CIXedy0sCtNGX2B7Xkrl9Avs/ZaK/NiprPs5/K6u7EH4S
 X4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jR28dkVEy3qBagnsRPMx5EF9tlDXOyhdSQMlYFOe+Dw=;
 b=oFiNtoYGSBhmln4PT+HKjBmkUf2xljEqZahKW5a3AiRHYDzf0aXnfxoAVViTnomf8C
 4KkbS4tFVeGkNyxduvtBeClmPwwiPNlQda3so1DQMsrXPwOUGFtgI6syo5Ivbd1CA3k/
 jZ5J78B21bWgIeJle/P0wLwGENFh9+p+EBXUjhO3+TJwILaaXwhVMpAL6niHdj/oPPDc
 IKMid1DSh0p37d0nCLT87XFX9BJ+qfD4wFMErP9xKRrPZANlbq6ffYcPaNgPnbs5X7SW
 sFTbiz3ALBaIxs1oAVZRhBE26FF3J8ZfsPdENic5we3ywvPsHXaF2lg6CBS6Y5gCq1H3
 4+wg==
X-Gm-Message-State: APjAAAUySzSwqWjQzODpvpR3upWF/qttb+DbKbvsrXPwrWq5enHHaIrP
 wOJvGpBJoDmMdo17yzTwRh0RF4kwxqyrTQ==
X-Google-Smtp-Source: APXvYqzB1mvBJr1MeNkACdPxceZYiS8PBgRk1Cos2EFQz7Gq2jBzth28RkiIxht1B18kk48s5d2+cQ==
X-Received: by 2002:adf:f012:: with SMTP id j18mr3223225wro.314.1580986515503; 
 Thu, 06 Feb 2020 02:55:15 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 31/41] target/arm: Flush tlbs for E2&0 translation regime
Date: Thu,  6 Feb 2020 10:54:38 +0000
Message-Id: <20200206105448.4726-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Flush all EL2 regimes with TLBI ALLE2 (pmm).
v7: Flush all EL2 regimes with TLBI VAE2 (pmm).
---
 target/arm/helper.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f9be6b052f..3b7b459314 100644
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
 
+static int e2_tlbmask(CPUARMState *env)
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
+    int mask = e2_tlbmask(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4259,8 +4269,9 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = e2_tlbmask(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4278,11 +4289,11 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * Currently handles both VAE2 and VALE2, since we don't support
      * flush-last-level-only.
      */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = e2_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


