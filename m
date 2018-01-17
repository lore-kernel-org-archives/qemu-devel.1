Received: from eggs.gnu.org ([2001:4830:134:3::10]:55881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpv1-0005qn-FA
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuz-00010U-KI
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:27 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:34 +0100
Message-Id: <1516203816-19374-23-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 22/24] cpu: get rid of unused cpu_init() defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

cpu_init(cpu_model) were replaced by cpu_create(cpu_type) so
no users are left, remove it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <rth@twiddle.net> (maintainer:Alpha)
CC: Peter Maydell <peter.maydell@linaro.org>
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Michael Walle <michael@walle.cc>
CC: Laurent Vivier <laurent@vivier.eu>
CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Yongbok Kim <yongbok.kim@mips.com>
CC: Anthony Green <green@moxielogic.com>
CC: Chris Wulff <crwulff@gmail.com>
CC: Marek Vasut <marex@denx.de>
CC: Stafford Horne <shorne@gmail.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Alexander Graf <agraf@suse.de>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
CC: Max Filippov <jcmvbkbc@gmail.com>
CC: qemu-arm@nongnu.org
CC: qemu-ppc@nongnu.org
CC: qemu-s390x@nongnu.org
---
 target/alpha/cpu.h      | 2 --
 target/arm/cpu.h        | 2 --
 target/cris/cpu.h       | 2 --
 target/hppa/cpu.h       | 1 -
 target/i386/cpu.h       | 2 --
 target/lm32/cpu.h       | 2 --
 target/m68k/cpu.h       | 2 --
 target/microblaze/cpu.h | 1 -
 target/mips/cpu.h       | 2 --
 target/moxie/cpu.h      | 2 --
 target/nios2/cpu.h      | 1 -
 target/openrisc/cpu.h   | 2 --
 target/ppc/cpu.h        | 2 --
 target/s390x/cpu.h      | 2 --
 target/sh4/cpu.h        | 2 --
 target/sparc/cpu.h      | 4 ----
 target/tilegx/cpu.h     | 1 -
 target/tricore/cpu.h    | 2 --
 target/unicore32/cpu.h  | 2 --
 target/xtensa/cpu.h     | 2 --
 20 files changed, 38 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index c8dd560..1a1d9a0 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -468,8 +468,6 @@ enum {
 
 void alpha_translate_init(void);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_ALPHA_CPU, cpu_model)
-
 #define ALPHA_CPU_TYPE_SUFFIX "-" TYPE_ALPHA_CPU
 #define ALPHA_CPU_TYPE_NAME(model) model ALPHA_CPU_TYPE_SUFFIX
 #define TARGET_DEFAULT_CPU_TYPE ALPHA_CPU_TYPE_NAME("ev67")
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c87bb76..3c1e1aa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2167,8 +2167,6 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     return unmasked || pstate_unmasked;
 }
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_ARM_CPU, cpu_model)
-
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 #define TARGET_DEFAULT_CPU_TYPE ARM_CPU_TYPE_NAME("any")
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8feabb4..9845d89 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -267,8 +267,6 @@ enum {
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_CRIS_CPU, cpu_model)
-
 #define CRIS_CPU_TYPE_SUFFIX "-" TYPE_CRIS_CPU
 #define CRIS_CPU_TYPE_NAME(name) (name CRIS_CPU_TYPE_SUFFIX)
 #define TARGET_DEFAULT_CPU_TYPE CRIS_CPU_TYPE_NAME("crisv32")
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 04625f7..7a6074e 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -112,7 +112,6 @@ static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 
 void hppa_translate_init(void);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_HPPA_CPU, cpu_model)
 #define TARGET_DEFAULT_CPU_TYPE TYPE_HPPA_CPU
 
 void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f64e5ed..0b4563b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1557,8 +1557,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 #define PHYS_ADDR_MASK MAKE_64BIT_MASK(0, TCG_PHYS_ADDR_BITS)
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_X86_CPU, cpu_model)
-
 #define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
 #define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
 
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 65f58f5..ec9efa7 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -255,8 +255,6 @@ void lm32_watchpoint_insert(CPULM32State *env, int index, target_ulong address,
 void lm32_watchpoint_remove(CPULM32State *env, int index);
 bool lm32_cpu_do_semihosting(CPUState *cs);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_LM32_CPU, cpu_model)
-
 #define LM32_CPU_TYPE_SUFFIX "-" TYPE_LM32_CPU
 #define LM32_CPU_TYPE_NAME(model) model LM32_CPU_TYPE_SUFFIX
 #define TARGET_DEFAULT_CPU_TYPE LM32_CPU_TYPE_NAME("lm32-basic")
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 193e8f8..da4171c 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -401,8 +401,6 @@ void register_m68k_insns (CPUM68KState *env);
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_M68K_CPU, cpu_model)
-
 #define M68K_CPU_TYPE_SUFFIX "-" TYPE_M68K_CPU
 #define M68K_CPU_TYPE_NAME(model) model M68K_CPU_TYPE_SUFFIX
 #define TARGET_DEFAULT_CPU_TYPE M68K_CPU_TYPE_NAME("any")
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index f244efa..3ad1016 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -343,7 +343,6 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_MICROBLAZE_CPU, cpu_model)
 #define TARGET_DEFAULT_CPU_TYPE TYPE_MICROBLAZE_CPU
 
 #define cpu_signal_handler cpu_mb_signal_handler
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index c5ee894..7c66ec0 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -739,8 +739,6 @@ enum {
 
 int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_MIPS_CPU, cpu_model)
-
 #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
 #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 9fabb93..a3a1bba 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -120,8 +120,6 @@ void moxie_translate_init(void);
 int cpu_moxie_signal_handler(int host_signum, void *pinfo,
                              void *puc);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_MOXIE_CPU, cpu_model)
-
 #define MOXIE_CPU_TYPE_SUFFIX "-" TYPE_MOXIE_CPU
 #define MOXIE_CPU_TYPE_NAME(model) model MOXIE_CPU_TYPE_SUFFIX
 #define TARGET_DEFAULT_CPU_TYPE MOXIE_CPU_TYPE_NAME("any")
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 2d03958..71a48b1 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -231,7 +231,6 @@ void nios2_check_interrupts(CPUNios2State *env);
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_NIOS2_CPU, cpu_model)
 #define TARGET_DEFAULT_CPU_TYPE TYPE_NIOS2_CPU
 
 #define cpu_gen_code cpu_nios2_gen_code
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 8d1a87e..f2d2abb 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -390,8 +390,6 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
                                int *prot, target_ulong address, int rw);
 #endif
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model)
-
 #define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
 #define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
 #define TARGET_DEFAULT_CPU_TYPE OPENRISC_CPU_TYPE_NAME("or1200")
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4af4aff..3dc0359 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1372,8 +1372,6 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
 int ppc_dcr_read (ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
 int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_POWERPC_CPU, cpu_model)
-
 #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
 #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 174624a..3e647df 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -727,8 +727,6 @@ void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
 
 
 /* helper.c */
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
-
 #define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
 #define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
 #define TARGET_DEFAULT_CPU_TYPE S390_CPU_TYPE_NAME("qemu")
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 203d212..ad58e24 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -274,8 +274,6 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr);
 
 void cpu_load_tlb(CPUSH4State * env);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_SUPERH_CPU, cpu_model)
-
 #define SUPERH_CPU_TYPE_SUFFIX "-" TYPE_SUPERH_CPU
 #define SUPERH_CPU_TYPE_NAME(model) model SUPERH_CPU_TYPE_SUFFIX
 #define TARGET_DEFAULT_CPU_TYPE SUPERH_CPU_TYPE_NAME("sh7785")
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 02c55ad..54b3dc7 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -654,10 +654,6 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 #endif
 int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
 
-#ifndef NO_CPU_IO_DEFS
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_SPARC_CPU, cpu_model)
-#endif
-
 #define SPARC_CPU_TYPE_SUFFIX "-" TYPE_SPARC_CPU
 #define SPARC_CPU_TYPE_NAME(model) model SPARC_CPU_TYPE_SUFFIX
 
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 67de53e..6c89b05 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -164,7 +164,6 @@ static inline TileGXCPU *tilegx_env_get_cpu(CPUTLGState *env)
 void tilegx_tcg_init(void);
 int cpu_tilegx_signal_handler(int host_signum, void *pinfo, void *puc);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_TILEGX_CPU, cpu_model)
 #define TARGET_DEFAULT_CPU_TYPE TYPE_TILEGX_CPU
 
 #define cpu_signal_handler cpu_tilegx_signal_handler
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 835d51a..8ed17e0 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -411,8 +411,6 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
     *flags = 0;
 }
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_TRICORE_CPU, cpu_model)
-
 #define TRICORE_CPU_TYPE_SUFFIX "-" TYPE_TRICORE_CPU
 #define TRICORE_CPU_TYPE_NAME(model) model TRICORE_CPU_TYPE_SUFFIX
 #define TARGET_DEFAULT_CPU_TYPE TRICORE_CPU_TYPE_NAME("tc1796")
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index fd3fa81..91b673a 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -165,8 +165,6 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 
 #include "exec/cpu-all.h"
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model)
-
 #define UNICORE32_CPU_TYPE_SUFFIX "-" TYPE_UNICORE32_CPU
 #define UNICORE32_CPU_TYPE_NAME(model) model UNICORE32_CPU_TYPE_SUFFIX
 #define TARGET_DEFAULT_CPU_TYPE UNICORE32_CPU_TYPE_NAME("any")
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 537e151..c21acf9 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -508,8 +508,6 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #endif
 #define TARGET_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
-
 void xtensa_translate_init(void);
 void xtensa_breakpoint_handler(CPUState *cs);
 void xtensa_finalize_config(XtensaConfig *config);
-- 
2.7.4
