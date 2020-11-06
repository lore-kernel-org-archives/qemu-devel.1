Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2261C388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D6D20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqR/bUhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D6D20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasb7-0003Qt-Eo
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRf-0004qz-4L
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:47 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:34694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRc-0006wb-EZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:46 -0500
Received: by mail-pl1-x633.google.com with SMTP id p4so33365plr.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EZoWS2rDJTXqXpM5kSibnRtpefjrKqjOzA1oHfZm56Y=;
 b=oqR/bUhrHnAHVQoxbHf53anIdc7hqhvPg2ocOAywG6Q5um8Ug7uTuRjWwz9vWYEMvd
 zD04VzsFq5pR1fU6WVmmgn42aMFBp8votNgdOMel6fZBhyiUpkSNPO3x6KS2cx7vLX7J
 s9m8gfnGoRRAz8uCrVKyYg8SjLYZJJ+oAcMwFRFtyTi4Dc7RpdiEfsYqq7mBK/vw4UZ3
 4B/T2uDhH4PkdILH4ZCf6T853eOPzXBIxm+gyjzD98+V0ZxoUukFjtKjF1hB2Ugj2iRI
 vQrM5xLy3m7mBFe7j4OOPSO5EkVTZz+rWwYC7yBQsgqbQTkWVtd4zmN6Oymz1bFpQkEK
 +JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EZoWS2rDJTXqXpM5kSibnRtpefjrKqjOzA1oHfZm56Y=;
 b=XuauZahu9DvhWx4tpIy0SH5QsnFwZkH31HaH1ggJCQsYtcTy7KQhodVtUvGCaQs3hU
 KlBrqLgWfXH0Db0CAuBB6WI2wrRYfXatJL2w3RcocW5TPq6PThtP7E7b+ZFgy20qu5lM
 Nz+/0NmOwYkaiBB5l1qD4yxnItSw2+dljwssVbKTh2hZtAe8K2Eef8QcfqDBOOTrxoPv
 Ot/gKYFeQ9iJJ/8lSWS+LX93+JtJIoEFTF1b8gk0FqpFYTsfXSVnfhfFb6/J4m5ia6b+
 wAT4cBZgJ8wC4NQro6+8t5Bdz6xctKZU3nXu2X2GvqKTENQl5/omyMdN7OTNSyVIxGmi
 3HpA==
X-Gm-Message-State: AOAM531KTn8eInZRUxRGWCQ2lyERpwGy+b+gDfZq03CXPFqkDjqoe72e
 SFSYCUVnCzBXlxXPiodWFp0sTF4g5lq0Xg==
X-Google-Smtp-Source: ABdhPJyttSIGD0mcUUeLALdD8kxbNkkL6IfS1x6hnw9nJXZOku8mvpWY9+5iWuZ0KU3C0lnB9K5sjg==
X-Received: by 2002:a17:902:6f10:b029:d6:e6f5:1dab with SMTP id
 w16-20020a1709026f10b02900d6e6f51dabmr4989074plk.1.1604633378748; 
 Thu, 05 Nov 2020 19:29:38 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/41] tcg: Make tb arg to synchronize_from_tb const
Date: Thu,  5 Nov 2020 19:28:52 -0800
Message-Id: <20201106032921.600200-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing within the translators that ought to be
changing the TranslationBlock data, so make it const.

This does not actually use the read-only copy of the
data structure that exists within the rx region.

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
index 3d92c967ff..44c336a96a 100644
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
index 6a0264fc6b..1b2f40de47 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -285,7 +285,8 @@ static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
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


