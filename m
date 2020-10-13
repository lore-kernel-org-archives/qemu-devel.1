Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6ABC43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFA02333D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQL5uy8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFA02333D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKNQ-00029x-DX
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKJO-0007I7-JK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:25:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKJJ-0000pm-Ar
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:25:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id g12so24025031wrp.10
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uGbM5jKuXUuO3WPo7AsNXrE7a/70TUhurMbvDUz4SoY=;
 b=kQL5uy8uKaDMe6/zNuBdF8ZCp0pgVc0eNH/quI0Y5X3oGlmtP1Egr49b0aDLhVmv/0
 Z0iDzP78m2xWud8CKH7YD89lceHyrqYkXtAFQUqopb/23vFhLmsNjSfcysoL36cD825c
 FqD2Nl/MAj2Hea5CF6CSdEe0DwG9UUFI1R+7pG4aCXKGYpxDXTsSdH3xnMueJ8ckAYDg
 lMDJcmgwmY7LBfRg7a+Qvmemx/oMiAgj7eAm0AfZ+QhHweJRc9aLrE2DZooQz+I0xCBv
 84r0ZiFv9xWXfFRUIFDJsmRX+QIYN9O3wsJdCd9K2GQizRWo9Zrsxx4m+6pkAs0eA0Gw
 RD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uGbM5jKuXUuO3WPo7AsNXrE7a/70TUhurMbvDUz4SoY=;
 b=SHSRY+1QUE5Uki+f0XyVObdE6u0X2N7REU4FDdM8UlHZt/+OXK2e/tqcLf21LyY2MF
 GmVj4VK0q9GRLluBSunJ5PFdbaGr9nXxbIFbK+auFdt+Pvngn9bB4xt4BqNtowWIGUdZ
 eLhLRh4B5arb0oR7oPFT7SmWE9OAhQMBf7r11Wk1pxJq6DKjVn51ShosHRESFv1q3LrC
 8wlV8hd8on3iNyoBpTtjjyrIHgE/hYekDep+AObBK7gJcnoUC1QWV/G8toLo1NS6eN/4
 BH9DaxG0D2KF6gAjK/btlRetdn/mZMeIua9vhXQodsk9DbBiATrKCzCkMVMv9mJRc7fB
 mPCA==
X-Gm-Message-State: AOAM530PKgO4wT3ugq7AF/bfp5iaedTGUT5KJ0+UBE8IwJ6M4RbcOZ3Y
 Qea+p4RDSavdHU9Tf37PCVRkb00y9Bs=
X-Google-Smtp-Source: ABdhPJx9gj23uXTAel4tspKSKMEK1H2Zj2STo9L4fmMA8sIUVKoqqvYVCebc5WLsfRrQ5orE0BeHuQ==
X-Received: by 2002:adf:a345:: with SMTP id d5mr38716089wrb.55.1602595547436; 
 Tue, 13 Oct 2020 06:25:47 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id m1sm26001774wmm.34.2020.10.13.06.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 06:25:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Victor Kamensky <kamensky@cisco.com>
Subject: [RFC PATCH 2/3] target/mips: Store number of TLB entries in
 CPUMIPSState
Date: Tue, 13 Oct 2020 15:25:34 +0200
Message-Id: <20201013132535.3599453-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013132535.3599453-1-f4bug@amsat.org>
References: <20201013132535.3599453-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to make the number of TLB entries configurable,
store it in CPUMIPSState.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.h                | 1 +
 target/mips/translate.c          | 4 +++-
 target/mips/translate_init.c.inc | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7cf7f5239f7..b84e9a8fcae 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1140,6 +1140,7 @@ struct CPUMIPSState {
 #endif
 
     const mips_def_t *cpu_model;
+    uint8_t tlb_entries;
     void *irq[8];
     QEMUTimer *timer; /* Internal timer */
     struct MIPSITUState *itu;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4c9b6216321..9d13e164c2e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -31319,6 +31319,7 @@ void mips_tcg_init(void)
 bool cpu_mips_realize_env(CPUMIPSState *env, Error **errp)
 {
     env->exception_base = (int32_t)0xBFC00000;
+    env->tlb_entries = 1 + extract32(env->cpu_model->CP0_Config1, CP0C1_MMU, 6);
 
 #ifndef CONFIG_USER_ONLY
     mmu_init(env, env->cpu_model);
@@ -31357,7 +31358,8 @@ void cpu_state_reset(CPUMIPSState *env)
 #ifdef TARGET_WORDS_BIGENDIAN
     env->CP0_Config0 |= (1 << CP0C0_BE);
 #endif
-    env->CP0_Config1 = env->cpu_model->CP0_Config1;
+    env->CP0_Config1 = deposit32(env->cpu_model->CP0_Config1, CP0C1_MMU, 6,
+                                 env->tlb_entries - 1);
     env->CP0_Config2 = env->cpu_model->CP0_Config2;
     env->CP0_Config3 = env->cpu_model->CP0_Config3;
     env->CP0_Config4 = env->cpu_model->CP0_Config4;
diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index 637caccd890..a426463c434 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -946,7 +946,7 @@ static void fixed_mmu_init (CPUMIPSState *env, const mips_def_t *def)
 
 static void r4k_mmu_init (CPUMIPSState *env, const mips_def_t *def)
 {
-    env->tlb->nb_tlb = 1 + ((def->CP0_Config1 >> CP0C1_MMU) & 63);
+    env->tlb->nb_tlb = env->tlb_entries;
     env->tlb->map_address = &r4k_map_address;
     env->tlb->helper_tlbwi = r4k_helper_tlbwi;
     env->tlb->helper_tlbwr = r4k_helper_tlbwr;
-- 
2.26.2


