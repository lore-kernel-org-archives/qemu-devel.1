Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F28C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F61A20675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJYwvjPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F61A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56449 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOABe-0002gY-AU
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:11:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6o-0007BZ-MQ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6l-0005yI-Th
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:39898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA6l-0005vE-Lk
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:51 -0400
Received: by mail-pf1-x433.google.com with SMTP id z26so9490360pfg.6
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=AanUBMHanpwrjwo9ZikXB7drp+mtu0UU+3Z1Mu+1SJ0=;
	b=KJYwvjPKXJIFWJhQXQHOAvA18kClfMddi0AdXvypyYDHPD6XhEqHniCReIiMZynY3W
	W/lhkjB3LsbsE1dNEC5y2KrkidHttD+hnrNzMx232AEkh/SQtUqsoOJh/wxtYTSA+DsB
	ibnD1zuSwg+OCbGXS4b53zLJO6i7OeKrvLSq/rzTgXRuCcmKWsfw0i3Q4zVn5sFokpP+
	LLUSTH0hS1FftY77j2cwAL5thnPk/eZ6ppjkPfd9oXlI5+oHGdPbxro8jaFVoYVCvwc9
	PYolWs3ggIIqDimT5vQUUbt/VL7lmi3FMOgOox33rhjwbo7tX7KB4V8vJoCSGyU+/j8H
	cnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=AanUBMHanpwrjwo9ZikXB7drp+mtu0UU+3Z1Mu+1SJ0=;
	b=Su4T8PdnOpIlYoZ4LHKf3SuQyr6lcqFQ/WBbxnBeQrfAuL2vdPv96kfgD7z+swNWbh
	sFjVQR94b+D9fTWSG65jxOZuQt5cIrhOq1XRoBQCHwLlm4wvLSlIX+k01+1Ep1Q4Rkts
	19PSSG+KhT9z6Fa3Kv+z05E22xVvwNO7mXS7VBPnfBRuMe7+uD6NbBNm0pNegY/nf2Tz
	ukf65MIWdjVwPfq5c49LluBSGBdqOpNYgt4KWE5/fkLmBtGs4AT7wkfyx9ZYZk34AO+n
	aZjV0xchd2Zjx3r/pAzWhfVmSDfITU2zuxc9lws9/409qtoAc3I49jdc2A+bKrucj4N5
	KLmQ==
X-Gm-Message-State: APjAAAViKyP0YwX+vW7ufdBq+GnTotu/vSGCek7pQdmMT/PL5MtCvD/L
	u7TBOrsxvM6JoUdCAybky2PNb1pBeaM=
X-Google-Smtp-Source: APXvYqzZzTbsNaEh0j8pbTzxuATAuVxW4CMHWrTWmVb+xNsTGPBp71IzKCNVXhMUjCcYVXmKtEWpPA==
X-Received: by 2002:a65:5304:: with SMTP id m4mr43123287pgq.281.1557274010274; 
	Tue, 07 May 2019 17:06:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.06.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:06:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:07 -0700
Message-Id: <20190508000641.19090-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: [Qemu-devel] [PATCH v3 05/39] cpu: Define ArchCPU
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
index 56d1eade4f..ce470b9089 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -300,6 +300,7 @@ void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #define cpu_signal_handler cpu_alpha_signal_handler
 
 typedef CPUAlphaState CPUArchState;
+typedef AlphaCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9b4874112f..d943bb0fed 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3113,6 +3113,7 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 }
 
 typedef CPUARMState CPUArchState;
+typedef ARMCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 94e1a2aed7..9f1fbd2f81 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -284,6 +284,7 @@ int cris_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
 #define SFR_RW_MM_TLB_HI   env->pregs[PR_SRS]][6
 
 typedef CPUCRISState CPUArchState;
+typedef CRISCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c9bb16af9b..9038fa3c13 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -231,6 +231,7 @@ static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
 #define ENV_OFFSET      offsetof(HPPACPU, env)
 
 typedef CPUHPPAState CPUArchState;
+typedef HPPACPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2ccd796e9b..6bd01ebb83 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1751,6 +1751,7 @@ static inline target_long lshift(target_long x, int n)
 void tcg_x86_init(void);
 
 typedef CPUX86State CPUArchState;
+typedef X86CPU ArchCPU;
 
 #include "exec/cpu-all.h"
 #include "svm.h"
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index bd23c39d7a..9132397066 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -256,6 +256,7 @@ int lm32_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
 
 typedef CPULM32State CPUArchState;
+typedef LM32CPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2f92972dca..ce0f93343b 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -535,6 +535,7 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr,
                                 unsigned size);
 
 typedef CPUM68KState CPUArchState;
+typedef M68kCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index ac3e785927..161d18546d 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -365,6 +365,7 @@ int mb_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                             int mmu_idx);
 
 typedef CPUMBState CPUArchState;
+typedef MicroBlazeCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 522d2ebadc..3fdd075f8e 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1091,6 +1091,7 @@ static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
 }
 
 typedef CPUMIPSState CPUArchState;
+typedef MIPSCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index dcc319adf6..8691185162 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -118,6 +118,7 @@ static inline int cpu_mmu_index(CPUMoxieState *env, bool ifetch)
 }
 
 typedef CPUMoxieState CPUArchState;
+typedef MoxieCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 915ddd386f..fce08e3575 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -245,6 +245,7 @@ static inline int cpu_interrupts_enabled(CPUNios2State *env)
 }
 
 typedef CPUNios2State CPUArchState;
+typedef Nios2CPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index e327c81703..a6abcc7d2c 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -363,6 +363,7 @@ void cpu_openrisc_count_stop(OpenRISCCPU *cpu);
 #define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
 
 typedef CPUOpenRISCState CPUArchState;
+typedef OpenRISCCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2bf526403e..a2134fe83a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1377,6 +1377,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #endif /* defined(TARGET_PPC64) */
 
 typedef CPUPPCState CPUArchState;
+typedef PowerPCCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0f7124132e..4cf4516cc3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -324,6 +324,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
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
index 4df8cb0471..8b175c58b4 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -280,6 +280,7 @@ static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
 }
 
 typedef CPUSH4State CPUArchState;
+typedef SuperHCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 620bb74329..5a108b5532 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -729,6 +729,7 @@ static inline int cpu_pil_allowed(CPUSPARCState *env1, int pil)
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
index 39376e4e1e..56164e42b5 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -379,6 +379,7 @@ static inline int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
 }
 
 typedef CPUTriCoreState CPUArchState;
+typedef TriCoreCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 6d7439b368..90aac6a38e 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -152,6 +152,7 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 }
 
 typedef CPUUniCore32State CPUArchState;
+typedef UniCore32CPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 979a5fde7e..56fc21c8bb 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -787,6 +787,7 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
 }
 
 typedef CPUXtensaState CPUArchState;
+typedef XtensaCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
-- 
2.17.1


