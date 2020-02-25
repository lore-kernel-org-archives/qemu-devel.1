Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839B4C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4057B20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiMCnCKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4057B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ekS-0001Yz-Fw
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6eda-0002ix-3n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6edY-0004mF-9T
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:53 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6edY-0004ko-1o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:52 -0500
Received: by mail-pf1-x444.google.com with SMTP id i19so7617513pfa.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XSq3h8eAOylAKZlE56of8ferQEzDe3R6wID0JCCEJjA=;
 b=oiMCnCKTwt+ySdRPwFSeo5Q8Z5l9k+4mZxN6gOAn1BRWIa1u1FUYE5AbQtDP/s/rK2
 YbVWtLUOa6KEYcxJyU9/SS87alehtb5SKfxgsWiq/HS3iGKtq9WKZonAI7kpqOyLmyPJ
 m+hvD7ZQV3iKZcMngcYIzciE2hd2hw1mMrqD2Ly/J3d6II0k8+XVNHbih5AMjEpi7nlU
 mAygIMu0/KL8uT4kG5IQLiQpiwsYTdeXUFm3ZYrE6/G03gFIJHzZdvRe+D9bosqL7f4B
 Q+L7o7j9Gb3kKa1Lvv7XH3WDpIFTQo0IhFXGJnsDe9fdc1PcHEGcsNCCgOYfyQXGGIlc
 /UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XSq3h8eAOylAKZlE56of8ferQEzDe3R6wID0JCCEJjA=;
 b=ucSRW+MVrcwQ45qhO3R2toVqC8+9rNOQbPrr/TRg9f17Vflr7b3Vc4RH8ElyAv2tjZ
 p328Mzsiz/H/j6wRtkk0lIcEe6tLXTq3gaMt8eiTHPMxyoV3IRhSWC5iUM9X9AM+G/bU
 mrGC6U4hxBkHepYcdPqoaxh5MD4Pe/1K5FmqHvMh4e43RiiP6lyuzcaLNTYnGljQahT5
 BybgXwlqyDItDxK8j7jJd4iQ1uXC4gDWh6XsiQzDvknM7LPCtr5Fz/SxF+mnl8+yoD87
 SPiU9tXm+dH6/bKnu3YSzTi1WUt4u2H1vV9BxASIcpU2eKOpVXQ4i2wTWOmJok7ALsih
 JMFw==
X-Gm-Message-State: APjAAAWMMtJo0yj0xU2nDdcSk+JkJioSI9vemdG/sXXIp+LkxSmbANe9
 paukUaMZzrwsB3TAbQ3Ycv5D6QiZbLU=
X-Google-Smtp-Source: APXvYqyiGBMUbAJ5qqNEWKEJjt7jt+ZzLG1zUDESAYHseCzR+q7xJp4ZKnLtnOEDTzv0Z+/3bGpdIg==
X-Received: by 2002:a63:1a50:: with SMTP id a16mr57812863pgm.389.1582654130035; 
 Tue, 25 Feb 2020 10:08:50 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id d69sm19069704pfd.72.2020.02.25.10.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 10:08:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/7] target/arm: Honor the HCR_EL2.TTLB bit
Date: Tue, 25 Feb 2020 10:08:31 -0800
Message-Id: <20200225180831.26078-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225180831.26078-1-richard.henderson@linaro.org>
References: <20200225180831.26078-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bit traps EL1 access to tlb maintenance insns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 85 +++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ca67d6a770..20688d1a18 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -563,6 +563,16 @@ static CPAccessResult access_tacr(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/* Check for traps from EL1 due to HCR_EL2.TTLB. */
+static CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TTLB)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -2285,41 +2295,53 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .type = ARM_CP_NO_RAW, .access = PL1_R, .readfn = isr_read },
     /* 32 bit ITLB invalidates */
     { .name = "ITLBIALL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbiall_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiall_write },
     { .name = "ITLBIMVA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimva_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_write },
     { .name = "ITLBIASID", .cp = 15, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 2,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbiasid_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiasid_write },
     /* 32 bit DTLB invalidates */
     { .name = "DTLBIALL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbiall_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiall_write },
     { .name = "DTLBIMVA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimva_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_write },
     { .name = "DTLBIASID", .cp = 15, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 2,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbiasid_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiasid_write },
     /* 32 bit TLB invalidates */
     { .name = "TLBIALL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbiall_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiall_write },
     { .name = "TLBIMVA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimva_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_write },
     { .name = "TLBIASID", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 2,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbiasid_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiasid_write },
     { .name = "TLBIMVAA", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 3,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimvaa_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimvaa_write },
     REGINFO_SENTINEL
 };
 
 static const ARMCPRegInfo v7mp_cp_reginfo[] = {
     /* 32 bit TLB invalidates, Inner Shareable */
     { .name = "TLBIALLIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbiall_is_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbiall_is_write },
     { .name = "TLBIMVAIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimva_is_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_is_write },
     { .name = "TLBIASIDIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
-      .type = ARM_CP_NO_RAW, .access = PL1_W,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
       .writefn = tlbiasid_is_write },
     { .name = "TLBIMVAAIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
-      .type = ARM_CP_NO_RAW, .access = PL1_W,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
       .writefn = tlbimvaa_is_write },
     REGINFO_SENTINEL
 };
@@ -4780,51 +4802,51 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     /* TLBI operations */
     { .name = "TLBI_VMALLE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_ASIDE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VALE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VAALE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VMALLE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vmalle1_write },
     { .name = "TLBI_VAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_ASIDE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vmalle1_write },
     { .name = "TLBI_VAAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 3,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_VALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_VAALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_IPAS2E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
@@ -4910,14 +4932,17 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
 #endif
     /* TLB invalidate last level of translation table walk */
     { .name = "TLBIMVALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimva_is_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_is_write },
     { .name = "TLBIMVAALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
-      .type = ARM_CP_NO_RAW, .access = PL1_W,
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
       .writefn = tlbimvaa_is_write },
     { .name = "TLBIMVAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimva_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimva_write },
     { .name = "TLBIMVAAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimvaa_write },
+      .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
+      .writefn = tlbimvaa_write },
     { .name = "TLBIMVALH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
       .writefn = tlbimva_hyp_write },
-- 
2.20.1


