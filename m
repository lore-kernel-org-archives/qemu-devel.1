Received: from eggs.gnu.org ([2001:4830:134:3::10]:58518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejNB4-00032q-4h
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejNB1-0004Zp-Bb
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ejNB1-0004Z5-6K
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3EE7404008D
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 10:42:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  7 Feb 2018 11:40:27 +0100
Message-Id: <1518000027-274608-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1518000027-274608-1-git-send-email-imammedo@redhat.com>
References: <1518000027-274608-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/5] cpu: get rid of unused cpu_init()
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

cpu_init(cpu_model) were replaced by cpu_create(cpu_type) so
no users are left, remove it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc)
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
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
index 46d28af..b4c74eb 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -468,8 +468,6 @@ enum {
 
 void alpha_translate_init(void);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_ALPHA_CPU, cpu_model)
-
 #define ALPHA_CPU_TYPE_SUFFIX "-" TYPE_ALPHA_CPU
 #define ALPHA_CPU_TYPE_NAME(model) model ALPHA_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_ALPHA_CPU
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f5987b7..28a6ed9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2168,8 +2168,6 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     return unmasked || pstate_unmasked;
 }
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_ARM_CPU, cpu_model)
-
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_ARM_CPU
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index cfb877c..8bb1dbc 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -267,8 +267,6 @@ enum {
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_CRIS_CPU, cpu_model)
-
 #define CRIS_CPU_TYPE_SUFFIX "-" TYPE_CRIS_CPU
 #define CRIS_CPU_TYPE_NAME(name) (name CRIS_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_CRIS_CPU
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 368004c..f7acaca 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -267,7 +267,6 @@ static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 
 void hppa_translate_init(void);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_HPPA_CPU, cpu_model)
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
 void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e198ad0..47a8046 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1564,8 +1564,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 #define PHYS_ADDR_MASK MAKE_64BIT_MASK(0, TCG_PHYS_ADDR_BITS)
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_X86_CPU, cpu_model)
-
 #define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
 #define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_X86_CPU
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 6f41955..66157ee 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -255,8 +255,6 @@ void lm32_watchpoint_insert(CPULM32State *env, int index, target_ulong address,
 void lm32_watchpoint_remove(CPULM32State *env, int index);
 bool lm32_cpu_do_semihosting(CPUState *cs);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_LM32_CPU, cpu_model)
-
 #define LM32_CPU_TYPE_SUFFIX "-" TYPE_LM32_CPU
 #define LM32_CPU_TYPE_NAME(model) model LM32_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_LM32_CPU
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index a273ed1..78d32d8 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -526,8 +526,6 @@ enum {
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_M68K_CPU, cpu_model)
-
 #define M68K_CPU_TYPE_SUFFIX "-" TYPE_M68K_CPU
 #define M68K_CPU_TYPE_NAME(model) model M68K_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_M68K_CPU
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 88972cd..37e96bb 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -343,7 +343,6 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_MICROBLAZE_CPU, cpu_model)
 #define CPU_RESOLVING_TYPE TYPE_MICROBLAZE_CPU
 
 #define cpu_signal_handler cpu_mb_signal_handler
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 0fcbfb3..cfe1735 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -739,8 +739,6 @@ enum {
 
 int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_MIPS_CPU, cpu_model)
-
 #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
 #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_MIPS_CPU
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 355bead..df3737f 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -120,8 +120,6 @@ void moxie_translate_init(void);
 int cpu_moxie_signal_handler(int host_signum, void *pinfo,
                              void *puc);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_MOXIE_CPU, cpu_model)
-
 #define MOXIE_CPU_TYPE_SUFFIX "-" TYPE_MOXIE_CPU
 #define MOXIE_CPU_TYPE_NAME(model) model MOXIE_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_MOXIE_CPU
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 2c42067..3130129 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -231,7 +231,6 @@ void nios2_check_interrupts(CPUNios2State *env);
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_NIOS2_CPU, cpu_model)
 #define CPU_RESOLVING_TYPE TYPE_NIOS2_CPU
 
 #define cpu_gen_code cpu_nios2_gen_code
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 9a6f104..bea09e2 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -390,8 +390,6 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
                                int *prot, target_ulong address, int rw);
 #endif
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model)
-
 #define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
 #define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b298b64..76fd533 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1376,8 +1376,6 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
 int ppc_dcr_read (ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
 int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_POWERPC_CPU, cpu_model)
-
 #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
 #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 11bf68e..9591388 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -728,8 +728,6 @@ void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
 
 
 /* helper.c */
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
-
 #define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
 #define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_S390_CPU
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 015bc2b..d7b0b9c 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -274,8 +274,6 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr);
 
 void cpu_load_tlb(CPUSH4State * env);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_SUPERH_CPU, cpu_model)
-
 #define SUPERH_CPU_TYPE_SUFFIX "-" TYPE_SUPERH_CPU
 #define SUPERH_CPU_TYPE_NAME(model) model SUPERH_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_SUPERH_CPU
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 25ac8d4..3de654e 100644
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
 #define CPU_RESOLVING_TYPE TYPE_SPARC_CPU
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index a73215e..238f8d3 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -164,7 +164,6 @@ static inline TileGXCPU *tilegx_env_get_cpu(CPUTLGState *env)
 void tilegx_tcg_init(void);
 int cpu_tilegx_signal_handler(int host_signum, void *pinfo, void *puc);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_TILEGX_CPU, cpu_model)
 #define CPU_RESOLVING_TYPE TYPE_TILEGX_CPU
 
 #define cpu_signal_handler cpu_tilegx_signal_handler
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index a2ef632..13d629d 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -411,8 +411,6 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
     *flags = 0;
 }
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_TRICORE_CPU, cpu_model)
-
 #define TRICORE_CPU_TYPE_SUFFIX "-" TYPE_TRICORE_CPU
 #define TRICORE_CPU_TYPE_NAME(model) model TRICORE_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 82fa759..1a638f9 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -165,8 +165,6 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 
 #include "exec/cpu-all.h"
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model)
-
 #define UNICORE32_CPU_TYPE_SUFFIX "-" TYPE_UNICORE32_CPU
 #define UNICORE32_CPU_TYPE_NAME(model) model UNICORE32_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_UNICORE32_CPU
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 4a76785..ce3cbee 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -514,8 +514,6 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #define XTENSA_DEFAULT_CPU_NOMMU_TYPE \
     XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_NOMMU_MODEL)
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
-
 void xtensa_translate_init(void);
 void xtensa_breakpoint_handler(CPUState *cs);
 void xtensa_finalize_config(XtensaConfig *config);
-- 
2.7.4
