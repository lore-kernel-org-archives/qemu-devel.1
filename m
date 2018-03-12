Received: from eggs.gnu.org ([2001:4830:134:3::10]:35964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evW2n-0004Le-EN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evW2k-000429-5f
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evW2j-0003zy-T7
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 19:34:52 -0300
Message-Id: <20180312223455.18124-5-ehabkost@redhat.com>
In-Reply-To: <20180312223455.18124-1-ehabkost@redhat.com>
References: <20180312223455.18124-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] cpu: add CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine tests, so
that when switch to CPU_RESOLVING_TYPE happens,
it would ensure that null-machine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu> (m68k)
Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc)
Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de> (tricore)
Message-Id: <1518000027-274608-4-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
[ehabkost: Added macro to riscv too]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
index a79fc2e780..905855a2a1 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -470,6 +470,7 @@ void alpha_translate_init(void);
 
 #define ALPHA_CPU_TYPE_SUFFIX "-" TYPE_ALPHA_CPU
 #define ALPHA_CPU_TYPE_NAME(model) model ALPHA_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_ALPHA_CPU
 
 void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1e7e1f8a7e..f4b4258655 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2306,6 +2306,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_ARM_CPU
 
 #define cpu_signal_handler cpu_arm_signal_handler
 #define cpu_list arm_cpu_list
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 764b35cbae..cfb877c488 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -271,6 +271,7 @@ enum {
 
 #define CRIS_CPU_TYPE_SUFFIX "-" TYPE_CRIS_CPU
 #define CRIS_CPU_TYPE_NAME(name) (name CRIS_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_CRIS_CPU
 
 #define cpu_signal_handler cpu_cris_signal_handler
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c88d844938..6ea5f4c4e4 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -267,6 +267,7 @@ static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 void hppa_translate_init(void);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_HPPA_CPU, cpu_model)
+#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
 void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index faf39ec1ce..3f7333ba28 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1564,6 +1564,7 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 #define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
 #define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_X86_CPU
 
 #ifdef TARGET_X86_64
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index ce0a2f24c4..6f41955528 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -259,6 +259,7 @@ bool lm32_cpu_do_semihosting(CPUState *cs);
 
 #define LM32_CPU_TYPE_SUFFIX "-" TYPE_LM32_CPU
 #define LM32_CPU_TYPE_NAME(model) model LM32_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_LM32_CPU
 
 #define cpu_list lm32_cpu_list
 #define cpu_signal_handler cpu_lm32_signal_handler
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2259bf22dc..f102e7216d 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -531,6 +531,7 @@ enum {
 
 #define M68K_CPU_TYPE_SUFFIX "-" TYPE_M68K_CPU
 #define M68K_CPU_TYPE_NAME(model) model M68K_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_M68K_CPU
 
 #define cpu_signal_handler cpu_m68k_signal_handler
 #define cpu_list m68k_cpu_list
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 1fe21c8539..55f63f7b24 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -344,6 +344,7 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_MICROBLAZE_CPU, cpu_model)
+#define CPU_RESOLVING_TYPE TYPE_MICROBLAZE_CPU
 
 #define cpu_signal_handler cpu_mb_signal_handler
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7f8ba5ff3e..0fcbfb3553 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -743,6 +743,7 @@ int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
 
 #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
 #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_MIPS_CPU
 
 bool cpu_supports_cps_smp(const char *cpu_type);
 bool cpu_supports_isa(const char *cpu_type, unsigned int isa);
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index d85e1fc061..5e88c02dfb 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -123,6 +123,7 @@ int cpu_moxie_signal_handler(int host_signum, void *pinfo,
 
 #define MOXIE_CPU_TYPE_SUFFIX "-" TYPE_MOXIE_CPU
 #define MOXIE_CPU_TYPE_NAME(model) model MOXIE_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_MOXIE_CPU
 
 #define cpu_signal_handler cpu_moxie_signal_handler
 
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index cd4e40d1b4..4ab1da3285 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -231,6 +231,7 @@ void nios2_check_interrupts(CPUNios2State *env);
 #endif
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_NIOS2_CPU, cpu_model)
+#define CPU_RESOLVING_TYPE TYPE_NIOS2_CPU
 
 #define cpu_gen_code cpu_nios2_gen_code
 #define cpu_signal_handler cpu_nios2_signal_handler
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 5050b1135c..87018c7b8e 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -393,6 +393,7 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
 
 #define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
 #define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
 
 #include "exec/cpu-all.h"
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7bde1884a1..f6d0cd2f0f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1379,6 +1379,7 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
 #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
 #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
 
 #define cpu_signal_handler cpu_ppc_signal_handler
 #define cpu_list ppc_cpu_list
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index cff02a2857..41e06ac0f9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -46,6 +46,7 @@
 
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
 
 #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
 #define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5f357a4e2d..fa76236bf0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -723,6 +723,7 @@ void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
 
 #define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
 #define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_S390_CPU
 
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index a649b68d78..04b3d6c09b 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -276,6 +276,7 @@ void cpu_load_tlb(CPUSH4State * env);
 
 #define SUPERH_CPU_TYPE_SUFFIX "-" TYPE_SUPERH_CPU
 #define SUPERH_CPU_TYPE_NAME(model) model SUPERH_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_SUPERH_CPU
 
 #define cpu_signal_handler cpu_sh4_signal_handler
 #define cpu_list sh4_cpu_list
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9724134a5b..dfe143a963 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -658,6 +658,7 @@ int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
 
 #define SPARC_CPU_TYPE_SUFFIX "-" TYPE_SPARC_CPU
 #define SPARC_CPU_TYPE_NAME(model) model SPARC_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_SPARC_CPU
 
 #define cpu_signal_handler cpu_sparc_signal_handler
 #define cpu_list sparc_cpu_list
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 71cea04589..a73215e6cf 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -165,6 +165,7 @@ void tilegx_tcg_init(void);
 int cpu_tilegx_signal_handler(int host_signum, void *pinfo, void *puc);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_TILEGX_CPU, cpu_model)
+#define CPU_RESOLVING_TYPE TYPE_TILEGX_CPU
 
 #define cpu_signal_handler cpu_tilegx_signal_handler
 
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 07b8b59f58..9241a91faa 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -417,6 +417,7 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
 
 #define TRICORE_CPU_TYPE_SUFFIX "-" TYPE_TRICORE_CPU
 #define TRICORE_CPU_TYPE_NAME(model) model TRICORE_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
 
 /* helpers.c */
 int cpu_tricore_handle_mmu_fault(CPUState *cpu, target_ulong address,
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 42e1d52478..1db9b6cdf9 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -168,6 +168,7 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 
 #define UNICORE32_CPU_TYPE_SUFFIX "-" TYPE_UNICORE32_CPU
 #define UNICORE32_CPU_TYPE_NAME(model) model UNICORE32_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_UNICORE32_CPU
 
 static inline void cpu_get_tb_cpu_state(CPUUniCore32State *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 49c2e3cf9a..0e7383b2be 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -499,6 +499,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 
 #define XTENSA_CPU_TYPE_SUFFIX "-" TYPE_XTENSA_CPU
 #define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
 
 #ifdef TARGET_WORDS_BIGENDIAN
 #define XTENSA_DEFAULT_CPU_MODEL "fsf"
-- 
2.14.3
