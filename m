Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E76C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084BC20731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TAUHvB4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084BC20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYJ5D-0007mx-0n
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIby-0004HY-0p
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:33587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbs-0001r7-II
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:45 -0400
Received: by mail-pl1-x636.google.com with SMTP id b19so2153637pld.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EDW5N3EY6pf0lhD/cP7nYSG7huQisBooduf1CEfu/zQ=;
 b=TAUHvB4pqOIv0vWpopXB42N27xLW5dFaE5S29PvwH08w4HyakhXgtuWel5KZag0z0z
 oKF+z0IecUMs+hGvxsZ0p7MAJROxVC8r6NIIcElI9azno0dXBMvGzvZekUDOoFGra/aQ
 nKTYwC0kSzlLQoM/j8/XeP/oB7zVkQ2n2qTaz6vu/WZMA2eoHsiBptvM/eX6c0JbjT8S
 l5wnz7R2VwP4fyCuEJpQutxNMrpbaqsXtH9It15NTIOYHEkQnqPWzRpe7kK3VZ7Rhsck
 zQ5plhOYNA/QFJ8HPJ+iXN/HuMDpeZGtqzNwLksnPbB5amAs1LyDrhGly/Bqkl3tRCK1
 9Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EDW5N3EY6pf0lhD/cP7nYSG7huQisBooduf1CEfu/zQ=;
 b=nGJIyOBofaz+bcbrrz7Ye5PoUpdCm5B0LVSA5mnLcxphCDH9tFm6WwWj3RpgV6YsSU
 rl0IrYtLlnvhYuvcLW9CW5Oslb52zIct796rLYJpj3AamrVy4ujfL7+6TltgH6VuLjBH
 5cL5kaMmjc5Mm3SBnmau8FDePIN62cTThpJn/tXCV265EiwmVqkacdc3x72jZ6FlMMhR
 neFBFkO3vown3Pu9odyrdCep7Vwjg4joSnpVabLRHsUQtedGAXsqT6NmMDEoDuR2p+yw
 iit6lX3n4Fld8yGWVvSzsjjpv7bTKA8g2VllD1tCo0OV/ugd3KBsTpU+10OQPknOk8Qn
 BmVA==
X-Gm-Message-State: AOAM530JSuEa20sXhvHNFPH0zUBK5VIRoBAaD3RoUhZ5Nbplclu0zu5q
 mLTUEkv6nnUk7xHOj6pbu9fNbPH/IAWpAg==
X-Google-Smtp-Source: ABdhPJyaNbeE4ETrqpdhiCArPacK6Fl1D/SGkdW9CNIxJOO2yVw/3Kocp06RLhMXTiq1AhTnzZO6kA==
X-Received: by 2002:a17:902:6ac4:b029:d5:edd9:43c with SMTP id
 i4-20020a1709026ac4b02900d5edd9043cmr6626788plt.16.1604018977274; 
 Thu, 29 Oct 2020 17:49:37 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/19] tcg: Make tb arg to synchronize_from_tb const
Date: Thu, 29 Oct 2020 17:49:12 -0700
Message-Id: <20201030004921.721096-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing within the translators that ought to be
changing the TranslationBlock data, so make it const.

This does not actually use the read-only copy of the
data structure that exists within the rx mirror.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h   | 3 ++-
 target/arm/cpu.c        | 3 ++-
 target/avr/cpu.c        | 3 ++-
 target/hppa/cpu.c       | 3 ++-
 target/i386/cpu.c       | 3 ++-
 target/microblaze/cpu.c | 3 ++-
 target/mips/cpu.c       | 3 ++-
 target/riscv/cpu.c      | 3 ++-
 target/rx/cpu.c         | 3 ++-
 target/sh4/cpu.c        | 3 ++-
 target/sparc/cpu.c      | 3 ++-
 target/tricore/cpu.c    | 2 +-
 12 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9c3a45ad7b..67253e662b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -189,7 +189,8 @@ struct CPUClass {
     void (*get_memory_mapping)(CPUState *cpu, MemoryMappingList *list,
                                Error **errp);
     void (*set_pc)(CPUState *cpu, vaddr value);
-    void (*synchronize_from_tb)(CPUState *cpu, struct TranslationBlock *tb);
+    void (*synchronize_from_tb)(CPUState *cpu,
+                                const struct TranslationBlock *tb);
     bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 07492e9f9a..2f9be1c0ee 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -54,7 +54,8 @@ static void arm_cpu_set_pc(CPUState *cs, vaddr value)
     }
 }
 
-static void arm_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void arm_cpu_synchronize_from_tb(CPUState *cs,
+                                        const TranslationBlock *tb)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 5d9c4ad5bf..6f3d5a9e4a 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -41,7 +41,8 @@ static bool avr_cpu_has_work(CPUState *cs)
             && cpu_interrupts_enabled(env);
 }
 
-static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void avr_cpu_synchronize_from_tb(CPUState *cs,
+                                        const TranslationBlock *tb)
 {
     AVRCPU *cpu = AVR_CPU(cs);
     CPUAVRState *env = &cpu->env;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 71b6aca45d..e28f047d10 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -35,7 +35,8 @@ static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.iaoq_b = value + 4;
 }
 
-static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void hppa_cpu_synchronize_from_tb(CPUState *cs,
+                                         const TranslationBlock *tb)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d8606958e..01a8acafe3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7012,7 +7012,8 @@ static void x86_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.eip = value;
 }
 
-static void x86_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void x86_cpu_synchronize_from_tb(CPUState *cs,
+                                        const TranslationBlock *tb)
 {
     X86CPU *cpu = X86_CPU(cs);
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 9b2482159d..c8e754cfb1 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -83,7 +83,8 @@ static void mb_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.iflags = 0;
 }
 
-static void mb_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void mb_cpu_synchronize_from_tb(CPUState *cs,
+                                       const TranslationBlock *tb)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 76d50b00b4..79eee215cf 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -44,7 +44,8 @@ static void mips_cpu_set_pc(CPUState *cs, vaddr value)
     }
 }
 
-static void mips_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void mips_cpu_synchronize_from_tb(CPUState *cs,
+                                         const TranslationBlock *tb)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0bbfd7f457..faaa9d1e8f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -282,7 +282,8 @@ static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
     env->pc = value;
 }
 
-static void riscv_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void riscv_cpu_synchronize_from_tb(CPUState *cs,
+                                          const TranslationBlock *tb)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 23ee17a701..2bb14144a7 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -33,7 +33,8 @@ static void rx_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.pc = value;
 }
 
-static void rx_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void rx_cpu_synchronize_from_tb(CPUState *cs,
+                                       const TranslationBlock *tb)
 {
     RXCPU *cpu = RX_CPU(cs);
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 3c68021c56..1e0f05a15b 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -34,7 +34,8 @@ static void superh_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.pc = value;
 }
 
-static void superh_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void superh_cpu_synchronize_from_tb(CPUState *cs,
+                                           const TranslationBlock *tb)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index cf21efd85f..b9241208b1 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -691,7 +691,8 @@ static void sparc_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.npc = value + 4;
 }
 
-static void sparc_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+static void sparc_cpu_synchronize_from_tb(CPUState *cs,
+                                          const TranslationBlock *tb)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
 
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 2f2e5b029f..4bff1d4718 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -42,7 +42,7 @@ static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
 }
 
 static void tricore_cpu_synchronize_from_tb(CPUState *cs,
-                                            TranslationBlock *tb)
+                                            const TranslationBlock *tb)
 {
     TriCoreCPU *cpu = TRICORE_CPU(cs);
     CPUTriCoreState *env = &cpu->env;
-- 
2.25.1


