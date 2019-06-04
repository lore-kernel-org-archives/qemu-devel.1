Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780BDC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356B42070B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqBUoRha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356B42070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGAE-0002Kl-CK
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:36:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8D-0000xb-7r
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8B-00042m-7Z
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:05 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8B-00042Q-0N
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:03 -0400
Received: by mail-ot1-x343.google.com with SMTP id d17so6677714oth.5
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=EmYLkcDIGbKn3Eu+glogkhw4R1ShZ/FLvb3Vj23ThZ4=;
	b=YqBUoRhaP+50SA4uiTr/hg7nf5TYAAB+bzH70ysRLOc34f6W81n0NAXYF56p3vhM1T
	a4tk5AOo8rDCVLeY6dXiNsV+KNbMXfAW+FwYHKM6M3TGxRC0wqeUaZQNhlV93R0i3iIK
	7Gk24c9uKPxWsw5q0TQjNxJ9a1pZFXDgwFQRzjPMotu4rAZTx8NS4i5e4C8e2CNlxHzQ
	4TeZKZ9jF+Wg//LyKT6FfDGm3+J14N3eODxRkzP2ZHCYrZBaQqLm+yYQ47b5nqlkx0y7
	WE2tk64lF6VJXE/mP4i7vsXryiz9MExiGyyLG43ku4M7atuTNiTomUFgvYURaPSZlAi1
	yQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=EmYLkcDIGbKn3Eu+glogkhw4R1ShZ/FLvb3Vj23ThZ4=;
	b=D6Fo/i8j4u7sULuxibP6vgJ8W2tuCKVN0tn1ePA44ydapV+pPcJXoKOYH2x8JBK3H8
	Z42+Pug7LYtI9atN26VG6+9wiEoB8f9QDAy4yTql0I3JBuin1L7z1QuCjjVLi6/2d7tG
	jsc8U2gZmNHtdSwg6kH/k2WYVAw6WOUHUAAs1XXh2+KsRyKf2WzrE5v7miaC35YcFTds
	1WQq13LQZRQDZG8b48dw6i/lTBm+vlXllUQkyba4hN576mzjSacuxAL69/3PrgKRcyeF
	+7sVnNF0s9G6BT7tkHA2EypvYQIPFDrzas3d8Ecwo2eN/XAqWwONe+AqivT4Ll8tx+Ot
	ITXg==
X-Gm-Message-State: APjAAAVQOUkgRIgZVTZZqR0rHk52NwnbyI98HyeyEGa4sjKC1HgfdI1B
	TsDBGSOfucxv3L99JWmhgBdu3UtDboUQyw==
X-Google-Smtp-Source: APXvYqxaYPbkfHMxPIMT5Lb8E6KyUm+zx69SmiIwpjLfvIbn2lELLIzzw1lamopMcKgfZC/6L4NyQw==
X-Received: by 2002:a9d:4d05:: with SMTP id n5mr6215027otf.361.1559680441681; 
	Tue, 04 Jun 2019 13:34:01 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.33.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:16 -0500
Message-Id: <20190604203351.27778-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH v4 04/39] cpu: Define CPUArchState with typedef
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
 target/alpha/cpu.h      | 4 ++--
 target/arm/cpu.h        | 4 ++--
 target/cris/cpu.h       | 4 ++--
 target/hppa/cpu.h       | 4 ++--
 target/i386/cpu.h       | 5 ++---
 target/lm32/cpu.h       | 5 ++---
 target/m68k/cpu.h       | 4 ++--
 target/microblaze/cpu.h | 5 ++---
 target/mips/cpu.h       | 6 ++----
 target/moxie/cpu.h      | 4 ++--
 target/nios2/cpu.h      | 5 ++---
 target/openrisc/cpu.h   | 4 ++--
 target/ppc/cpu.h        | 4 ++--
 target/riscv/cpu.h      | 4 ++--
 target/s390x/cpu.h      | 8 ++++----
 target/sh4/cpu.h        | 4 ++--
 target/sparc/cpu.h      | 4 ++--
 target/tilegx/cpu.h     | 4 ++--
 target/tricore/cpu.h    | 6 +-----
 target/unicore32/cpu.h  | 4 ++--
 target/xtensa/cpu.h     | 4 ++--
 21 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index dc1883f0f1..9ec92bf09d 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -26,8 +26,6 @@
 
 #define ALIGNED_ONLY
 
-#define CPUArchState struct CPUAlphaState
-
 /* Alpha processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
@@ -306,6 +304,8 @@ void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #define cpu_list alpha_cpu_list
 #define cpu_signal_handler cpu_alpha_signal_handler
 
+typedef CPUAlphaState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 enum {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f8020b4823..ccf581a84c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -29,8 +29,6 @@
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
-#define CPUArchState struct CPUARMState
-
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
 #define EXCP_PREFETCH_ABORT  3
@@ -3127,6 +3125,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
     }
 }
 
+typedef CPUARMState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 /* Bit usage in the TB flags field: bit 31 indicates whether we are
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 25408c2bf7..2ee5417ead 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -25,8 +25,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 
-#define CPUArchState struct CPUCRISState
-
 #define EXCP_NMI        1
 #define EXCP_GURU       2
 #define EXCP_BUSFAULT   3
@@ -286,6 +284,8 @@ bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #define SFR_RW_MM_TLB_LO   env->pregs[PR_SRS]][5
 #define SFR_RW_MM_TLB_HI   env->pregs[PR_SRS]][6
 
+typedef CPUCRISState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 static inline void cpu_get_tb_cpu_state(CPUCRISState *env, target_ulong *pc,
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index fb527eba88..7fd755a753 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -31,8 +31,6 @@
    basis.  It's probably easier to fall back to a strong memory model.  */
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
 
-#define CPUArchState struct CPUHPPAState
-
 #define ALIGNED_ONLY
 #define MMU_KERNEL_IDX   0
 #define MMU_USER_IDX     3
@@ -232,6 +230,8 @@ static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
 #define ENV_GET_CPU(e)  CPU(hppa_env_get_cpu(e))
 #define ENV_OFFSET      offsetof(HPPACPU, env)
 
+typedef CPUHPPAState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 36f5095768..81931fc510 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1,4 +1,3 @@
-
 /*
  * i386 virtual CPU header
  *
@@ -44,8 +43,6 @@
 #define ELF_MACHINE_UNAME "i686"
 #endif
 
-#define CPUArchState struct CPUX86State
-
 enum {
     R_EAX = 0,
     R_ECX = 1,
@@ -1755,6 +1752,8 @@ static inline target_long lshift(target_long x, int n)
 /* translate.c */
 void tcg_x86_init(void);
 
+typedef CPUX86State CPUArchState;
+
 #include "exec/cpu-all.h"
 #include "svm.h"
 
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index e75110c4e0..86f6c7b0af 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -24,9 +24,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 
-#define CPUArchState struct CPULM32State
-
-struct CPULM32State;
 typedef struct CPULM32State CPULM32State;
 
 static inline int cpu_mmu_index(CPULM32State *env, bool ifetch)
@@ -259,6 +256,8 @@ bool lm32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
 
+typedef CPULM32State CPUArchState;
+
 #include "exec/cpu-all.h"
 
 static inline void cpu_get_tb_cpu_state(CPULM32State *env, target_ulong *pc,
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index e99c102302..4465a66145 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -25,8 +25,6 @@
 #include "exec/cpu-defs.h"
 #include "cpu-qom.h"
 
-#define CPUArchState struct CPUM68KState
-
 #define OS_BYTE     0
 #define OS_WORD     1
 #define OS_LONG     2
@@ -538,6 +536,8 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  int mmu_idx, MemTxAttrs attrs,
                                  MemTxResult response, uintptr_t retaddr);
 
+typedef CPUM68KState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 /* TB flags */
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b8db8ca9a3..6170fd452f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -25,9 +25,6 @@
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat-types.h"
 
-#define CPUArchState struct CPUMBState
-
-struct CPUMBState;
 typedef struct CPUMBState CPUMBState;
 #if !defined(CONFIG_USER_ONLY)
 #include "mmu.h"
@@ -368,6 +365,8 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
 
+typedef CPUMBState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, target_ulong *pc,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 34e7aec4d0..6f65822bb1 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -3,8 +3,6 @@
 
 #define ALIGNED_ONLY
 
-#define CPUArchState struct CPUMIPSState
-
 #include "qemu-common.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
@@ -13,8 +11,6 @@
 
 #define TCG_GUEST_DEFAULT_MO (0)
 
-struct CPUMIPSState;
-
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
 /* MSA Context */
@@ -1116,6 +1112,8 @@ static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
     return hflags_mmu_index(env->hflags);
 }
 
+typedef CPUMIPSState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 /*
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 7164dd7f5f..1de0515848 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -23,8 +23,6 @@
 #include "qemu-common.h"
 #include "exec/cpu-defs.h"
 
-#define CPUArchState struct CPUMoxieState
-
 #define MOXIE_EX_DIV0        0
 #define MOXIE_EX_BAD         1
 #define MOXIE_EX_IRQ         2
@@ -119,6 +117,8 @@ static inline int cpu_mmu_index(CPUMoxieState *env, bool ifetch)
     return 0;
 }
 
+typedef CPUMoxieState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 static inline void cpu_get_tb_cpu_state(CPUMoxieState *env, target_ulong *pc,
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index c4ccea9cf0..cc8e0ab771 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -25,9 +25,6 @@
 #include "exec/cpu-defs.h"
 #include "qom/cpu.h"
 
-#define CPUArchState struct CPUNios2State
-
-struct CPUNios2State;
 typedef struct CPUNios2State CPUNios2State;
 #if !defined(CONFIG_USER_ONLY)
 #include "mmu.h"
@@ -249,6 +246,8 @@ static inline int cpu_interrupts_enabled(CPUNios2State *env)
     return env->regs[CR_STATUS] & CR_STATUS_PIE;
 }
 
+typedef CPUNios2State CPUArchState;
+
 #include "exec/cpu-all.h"
 
 static inline void cpu_get_tb_cpu_state(CPUNios2State *env, target_ulong *pc,
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 3727efabf3..98361cb041 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -24,8 +24,6 @@
 #include "exec/cpu-defs.h"
 #include "qom/cpu.h"
 
-#define CPUArchState struct CPUOpenRISCState
-
 /* cpu_openrisc_map_address_* in CPUOpenRISCTLBContext need this decl.  */
 struct OpenRISCCPU;
 
@@ -365,6 +363,8 @@ void cpu_openrisc_count_stop(OpenRISCCPU *cpu);
 #define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
 
+typedef CPUOpenRISCState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 #define TB_FLAGS_SM    SR_SM
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 02ca453df3..6478fe7c91 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -34,8 +34,6 @@
 #define TARGET_PAGE_BITS_64K 16
 #define TARGET_PAGE_BITS_16M 24
 
-#define CPUArchState struct CPUPPCState
-
 #if defined(TARGET_PPC64)
 #define PPC_ELF_MACHINE     EM_PPC64
 #else
@@ -1377,6 +1375,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
                              Error **errp);
 #endif /* defined(TARGET_PPC64) */
 
+typedef CPUPPCState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 /*****************************************************************************/
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bc517dbad8..509aae0613 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -27,8 +27,6 @@
 
 #define TCG_GUEST_DEFAULT_MO 0
 
-#define CPUArchState struct CPURISCVState
-
 #define TYPE_RISCV_CPU "riscv-cpu"
 
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
@@ -336,6 +334,8 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
+typedef CPURISCVState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 #endif /* RISCV_CPU_H */
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 3a82ea53e1..5ca53f48f8 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -28,13 +28,9 @@
 
 #define ELF_MACHINE_UNAME "S390X"
 
-#define CPUArchState struct CPUS390XState
-
 /* The z/Architecture has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
-#include "exec/cpu-all.h"
-
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
 #define MMU_MODE0_SUFFIX _primary
@@ -797,4 +793,8 @@ void s390_init_sigp(void);
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
 
+typedef CPUS390XState CPUArchState;
+
+#include "exec/cpu-all.h"
+
 #endif
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 7af6ff5d57..d7a8723d39 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -36,8 +36,6 @@
 #define SH_CPU_SH7750_ALL (SH_CPU_SH7750 | SH_CPU_SH7750S | SH_CPU_SH7750R)
 #define SH_CPU_SH7751_ALL (SH_CPU_SH7751 | SH_CPU_SH7751R)
 
-#define CPUArchState struct CPUSH4State
-
 #define SR_MD 30
 #define SR_RB 29
 #define SR_BL 28
@@ -282,6 +280,8 @@ static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
     }
 }
 
+typedef CPUSH4State CPUArchState;
+
 #include "exec/cpu-all.h"
 
 /* Memory access type */
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index bcfdf513cf..fc392c6e87 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -14,8 +14,6 @@
 #define TARGET_DPREGS 32
 #endif
 
-#define CPUArchState struct CPUSPARCState
-
 /*#define EXCP_INTERRUPT 0x100*/
 
 /* trap definitions */
@@ -731,6 +729,8 @@ static inline int cpu_pil_allowed(CPUSPARCState *env1, int pil)
 #endif
 }
 
+typedef CPUSPARCState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 #ifdef TARGET_SPARC64
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 429a6c6b43..2fbf14d508 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -23,8 +23,6 @@
 #include "qemu-common.h"
 #include "exec/cpu-defs.h"
 
-#define CPUArchState struct CPUTLGState
-
 /* TILE-Gx common register alias */
 #define TILEGX_R_RE    0   /*  0 register, for function/syscall return value */
 #define TILEGX_R_ERR   1   /*  1 register, for syscall errno flag */
@@ -152,6 +150,8 @@ static inline TileGXCPU *tilegx_env_get_cpu(CPUTLGState *env)
 /* TILE-Gx memory attributes */
 #define MMU_USER_IDX    0  /* Current memory operation is in user mode */
 
+typedef CPUTLGState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 void tilegx_tcg_init(void);
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index bccde45a07..5d3072f2db 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -25,10 +25,6 @@
 #include "exec/cpu-defs.h"
 #include "tricore-defs.h"
 
-#define CPUArchState struct CPUTriCoreState
-
-struct CPUTriCoreState;
-
 struct tricore_boot_info;
 
 typedef struct tricore_def_t tricore_def_t;
@@ -382,7 +378,7 @@ static inline int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
     return 0;
 }
 
-
+typedef CPUTriCoreState CPUArchState;
 
 #include "exec/cpu-all.h"
 
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index a4c4ea328e..48562949b1 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -16,8 +16,6 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 
-#define CPUArchState                struct CPUUniCore32State
-
 typedef struct CPUUniCore32State {
     /* Regs for current mode.  */
     uint32_t regs[32];
@@ -153,6 +151,8 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
     return (env->uncached_asr & ASR_M) == ASR_MODE_USER ? 1 : 0;
 }
 
+typedef CPUUniCore32State CPUArchState;
+
 #include "exec/cpu-all.h"
 
 #define UNICORE32_CPU_TYPE_SUFFIX "-" TYPE_UNICORE32_CPU
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0c6afd43a4..e164e18f18 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -38,8 +38,6 @@
 /* Xtensa processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
-#define CPUArchState struct CPUXtensaState
-
 enum {
     /* Additional instructions */
     XTENSA_OPTION_CODE_DENSITY,
@@ -801,6 +799,8 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
     }
 }
 
+typedef CPUXtensaState CPUArchState;
+
 #include "exec/cpu-all.h"
 
 #endif
-- 
2.17.1


