Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2079DC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2665207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMrzjTut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2665207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGFW-00077c-4N
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:41:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8E-0000yD-57
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8C-00043g-LP
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:06 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:42487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8C-00043F-F1
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:04 -0400
Received: by mail-ot1-x329.google.com with SMTP id l15so1105506otn.9
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=PI0su7trYCoD3sct0VZFP1uvxziQurlc4L3/S26QeHg=;
	b=IMrzjTutNl8LhWPKdClnBXF94HnlQORWIbb4TIkg/5oBwCmRl2SqRbnfZNDltP1Kd3
	pFycdfWVQaajAJ8YrNlsmvgEXl6WLzOWF1U56sgUvgIEFxDRc0mH3o/zOIr5jR5GtbdG
	jRgjOyjFMtRkj5/f9FqOL9IttVfBPHEm4BYzacgeQPepzwHCiqOuAz631EiYdVpJzT+/
	VAERGSEBhMA+Nfw+5XS8V3yF3LrhDyRhOQtf/2X6dEoYXNG8PuTkddfhm8gcmZRmVhYP
	A0AEEKgTGcBLORMRrSjjRafMLb7zhygxGxi+YFyGFA5EeKMfJpYHI/JTRe/lUVM1xk1/
	npRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=PI0su7trYCoD3sct0VZFP1uvxziQurlc4L3/S26QeHg=;
	b=Ny4yFdE+5IFqlU6OcfkUcCfOhozWuy26TQiuefGz/tUcQ6pY9jYZnvDIlI51hkhGS3
	IzhcJb3YKnPgtEVYcghOnV9QN6yCjSvUiB0cbcRJg8BWytmmsU1ueAiDjaWCN87bVVgY
	9C6PgMevO3GS+WSg80vUtruHJlsHm8v/jfY5VydiGRZFHbMlJOsHej7/TbxOor+k/tOu
	ESymo0pA6IGP4tFKPhRHXnsmmhaS6WyWrpK5wIbNi8HIoSBl5jWXd8Fg3y14T/8nZwsh
	v1tiTcYlIOsvgP+jQpoDsRO5xJ4S1nH4aXxiuAXZRd02r48wJjQlRhL5ROA0uCUEWeo/
	ZeJQ==
X-Gm-Message-State: APjAAAXe6aQDDS0y/Alq/4kIBAaBDrdl+41C95FWxuWkTpTYQrQjqlGb
	fUDFGPyYwQw3o3NqwPKN0gNbWLzSQ1PnIg==
X-Google-Smtp-Source: APXvYqyB1fUrtGb7XuIZ4wyrcEMVZJnk36IwIWCgtyouQa76UK46MIVN17QdCxB/lKYPLdGY5fh7mA==
X-Received: by 2002:a05:6830:1050:: with SMTP id
	b16mr1744690otp.228.1559680443219; 
	Tue, 04 Jun 2019 13:34:03 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.01
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:17 -0500
Message-Id: <20190604203351.27778-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: [Qemu-devel] [PATCH v4 05/39] cpu: Define ArchCPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For all targets, do this just before including exec/cpu-all.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h      | 1 +
 target/arm/cpu.h        | 1 +
 target/cris/cpu.h       | 1 +
 target/hppa/cpu.h       | 1 +
 target/i386/cpu.h       | 1 +
 target/lm32/cpu.h       | 1 +
 target/m68k/cpu.h       | 1 +
 target/microblaze/cpu.h | 1 +
 target/mips/cpu.h       | 1 +
 target/moxie/cpu.h      | 1 +
 target/nios2/cpu.h      | 1 +
 target/openrisc/cpu.h   | 1 +
 target/ppc/cpu.h        | 1 +
 target/riscv/cpu.h      | 1 +
 target/s390x/cpu.h      | 1 +
 target/sh4/cpu.h        | 1 +
 target/sparc/cpu.h      | 1 +
 target/tilegx/cpu.h     | 1 +
 target/tricore/cpu.h    | 1 +
 target/unicore32/cpu.h  | 1 +
 target/xtensa/cpu.h     | 1 +
 21 files changed, 21 insertions(+)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 9ec92bf09d..5af0b6c542 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -305,6 +305,7 @@ void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #define cpu_signal_handler cpu_alpha_signal_handler
 
 typedef CPUAlphaState CPUArchState;
+typedef AlphaCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ccf581a84c..4ebb6349f1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3126,6 +3126,7 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 }
 
 typedef CPUARMState CPUArchState;
+typedef ARMCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 2ee5417ead..e978eb9539 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -285,6 +285,7 @@ bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #define SFR_RW_MM_TLB_HI   env->pregs[PR_SRS]][6
 
 typedef CPUCRISState CPUArchState;
+typedef CRISCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7fd755a753..6eef107370 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -231,6 +231,7 @@ static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
 #define ENV_OFFSET      offsetof(HPPACPU, env)
 
 typedef CPUHPPAState CPUArchState;
+typedef HPPACPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 81931fc510..65f8f4d16c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1753,6 +1753,7 @@ static inline target_long lshift(target_long x, int n)
 void tcg_x86_init(void);
 
 typedef CPUX86State CPUArchState;
+typedef X86CPU ArchCPU;
 
 #include "exec/cpu-all.h"
 #include "svm.h"
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 86f6c7b0af..08c360bd16 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -257,6 +257,7 @@ bool lm32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        bool probe, uintptr_t retaddr);
 
 typedef CPULM32State CPUArchState;
+typedef LM32CPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 4465a66145..1d30b73bdf 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -537,6 +537,7 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  MemTxResult response, uintptr_t retaddr);
 
 typedef CPUM68KState CPUArchState;
+typedef M68kCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 6170fd452f..5a7fe3cbf8 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -366,6 +366,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      bool probe, uintptr_t retaddr);
 
 typedef CPUMBState CPUArchState;
+typedef MicroBlazeCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 6f65822bb1..12527ca104 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1113,6 +1113,7 @@ static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
 }
 
 typedef CPUMIPSState CPUArchState;
+typedef MIPSCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 1de0515848..b27b0eabae 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -118,6 +118,7 @@ static inline int cpu_mmu_index(CPUMoxieState *env, bool ifetch)
 }
 
 typedef CPUMoxieState CPUArchState;
+typedef MoxieCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index cc8e0ab771..5e51f1ae3f 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -247,6 +247,7 @@ static inline int cpu_interrupts_enabled(CPUNios2State *env)
 }
 
 typedef CPUNios2State CPUArchState;
+typedef Nios2CPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 98361cb041..496895693e 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -364,6 +364,7 @@ void cpu_openrisc_count_stop(OpenRISCCPU *cpu);
 #define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
 
 typedef CPUOpenRISCState CPUArchState;
+typedef OpenRISCCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6478fe7c91..17e7213be9 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1376,6 +1376,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #endif /* defined(TARGET_PPC64) */
 
 typedef CPUPPCState CPUArchState;
+typedef PowerPCCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 509aae0613..8ee5051119 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -335,6 +335,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
 typedef CPURISCVState CPUArchState;
+typedef RISCVCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5ca53f48f8..6d1b0f273a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -794,6 +794,7 @@ void s390_init_sigp(void);
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
 
 typedef CPUS390XState CPUArchState;
+typedef S390CPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index d7a8723d39..1bdc997290 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -281,6 +281,7 @@ static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
 }
 
 typedef CPUSH4State CPUArchState;
+typedef SuperHCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index fc392c6e87..ba5904e05a 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -730,6 +730,7 @@ static inline int cpu_pil_allowed(CPUSPARCState *env1, int pil)
 }
 
 typedef CPUSPARCState CPUArchState;
+typedef SPARCCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 2fbf14d508..042a7a0c71 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -151,6 +151,7 @@ static inline TileGXCPU *tilegx_env_get_cpu(CPUTLGState *env)
 #define MMU_USER_IDX    0  /* Current memory operation is in user mode */
 
 typedef CPUTLGState CPUArchState;
+typedef TileGXCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 5d3072f2db..8d660df34a 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -379,6 +379,7 @@ static inline int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
 }
 
 typedef CPUTriCoreState CPUArchState;
+typedef TriCoreCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 48562949b1..5c9c4d98c0 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -152,6 +152,7 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 }
 
 typedef CPUUniCore32State CPUArchState;
+typedef UniCore32CPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index e164e18f18..6e6fb1d893 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -800,6 +800,7 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
 }
 
 typedef CPUXtensaState CPUArchState;
+typedef XtensaCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
-- 
2.17.1


