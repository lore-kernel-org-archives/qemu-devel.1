Received: from eggs.gnu.org ([209.51.188.92]:60095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0b-0005XH-OK
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0W-0004Oq-1S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:53 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:05:57 +1000
Message-Id: <20190426060627.18153-7-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/36] target/ppc: Style fixes for cpu.[ch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/cpu.h | 237 ++++++++++++++++++++++++++---------------------
 1 file changed, 129 insertions(+), 108 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d5259f7dd3..8a79db0c43 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -23,23 +23,28 @@
 #include "qemu-common.h"
 #include "qemu/int128.h"
=20
-//#define PPC_EMULATE_32BITS_HYPV
+/* #define PPC_EMULATE_32BITS_HYPV */
=20
-#if defined (TARGET_PPC64)
+#if defined(TARGET_PPC64)
 /* PowerPC 64 definitions */
 #define TARGET_LONG_BITS 64
 #define TARGET_PAGE_BITS 12
=20
 #define TCG_GUEST_DEFAULT_MO 0
=20
-/* Note that the official physical address space bits is 62-M where M
-   is implementation dependent.  I've not looked up M for the set of
-   cpus we emulate at the system level.  */
+/*
+ * Note that the official physical address space bits is 62-M where M
+ * is implementation dependent.  I've not looked up M for the set of
+ * cpus we emulate at the system level.
+ */
 #define TARGET_PHYS_ADDR_SPACE_BITS 62
=20
-/* Note that the PPC environment architecture talks about 80 bit virtual
-   addresses, with segmentation.  Obviously that's not all visible to a
-   single process, which is all we're concerned with here.  */
+/*
+ * Note that the PPC environment architecture talks about 80 bit
+ * virtual addresses, with segmentation.  Obviously that's not all
+ * visible to a single process, which is all we're concerned with
+ * here.
+ */
 #ifdef TARGET_ABI32
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #else
@@ -49,7 +54,7 @@
 #define TARGET_PAGE_BITS_64K 16
 #define TARGET_PAGE_BITS_16M 24
=20
-#else /* defined (TARGET_PPC64) */
+#else /* defined(TARGET_PPC64) */
 /* PowerPC 32 definitions */
 #define TARGET_LONG_BITS 32
 #define TARGET_PAGE_BITS 12
@@ -57,14 +62,14 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
=20
-#endif /* defined (TARGET_PPC64) */
+#endif /* defined(TARGET_PPC64) */
=20
 #define CPUArchState struct CPUPPCState
=20
 #include "exec/cpu-defs.h"
 #include "cpu-qom.h"
=20
-#if defined (TARGET_PPC64)
+#if defined(TARGET_PPC64)
 #define PPC_ELF_MACHINE     EM_PPC64
 #else
 #define PPC_ELF_MACHINE     EM_PPC
@@ -237,9 +242,11 @@ struct ppc_spr_t {
     const char *name;
     target_ulong default_value;
 #ifdef CONFIG_KVM
-    /* We (ab)use the fact that all the SPRs will have ids for the
+    /*
+     * We (ab)use the fact that all the SPRs will have ids for the
      * ONE_REG interface will have KVM_REG_PPC to use 0 as meaning,
-     * don't sync this */
+     * don't sync this
+     */
     uint64_t one_reg_id;
 #endif
 };
@@ -656,39 +663,39 @@ enum {
 #define fpscr_eex (((env->fpscr) >> FPSCR_XX) & ((env->fpscr) >> FPSCR_X=
E) &  \
                    0x1F)
=20
-#define FP_FX		(1ull << FPSCR_FX)
-#define FP_FEX		(1ull << FPSCR_FEX)
-#define FP_VX		(1ull << FPSCR_VX)
-#define FP_OX		(1ull << FPSCR_OX)
-#define FP_UX		(1ull << FPSCR_UX)
-#define FP_ZX		(1ull << FPSCR_ZX)
-#define FP_XX		(1ull << FPSCR_XX)
-#define FP_VXSNAN	(1ull << FPSCR_VXSNAN)
-#define FP_VXISI	(1ull << FPSCR_VXISI)
-#define FP_VXIDI	(1ull << FPSCR_VXIDI)
-#define FP_VXZDZ	(1ull << FPSCR_VXZDZ)
-#define FP_VXIMZ	(1ull << FPSCR_VXIMZ)
-#define FP_VXVC		(1ull << FPSCR_VXVC)
-#define FP_FR		(1ull << FSPCR_FR)
-#define FP_FI		(1ull << FPSCR_FI)
-#define FP_C		(1ull << FPSCR_C)
-#define FP_FL		(1ull << FPSCR_FL)
-#define FP_FG		(1ull << FPSCR_FG)
-#define FP_FE		(1ull << FPSCR_FE)
-#define FP_FU		(1ull << FPSCR_FU)
-#define FP_FPCC		(FP_FL | FP_FG | FP_FE | FP_FU)
-#define FP_FPRF		(FP_C  | FP_FL | FP_FG | FP_FE | FP_FU)
-#define FP_VXSOFT	(1ull << FPSCR_VXSOFT)
-#define FP_VXSQRT	(1ull << FPSCR_VXSQRT)
-#define FP_VXCVI	(1ull << FPSCR_VXCVI)
-#define FP_VE		(1ull << FPSCR_VE)
-#define FP_OE		(1ull << FPSCR_OE)
-#define FP_UE		(1ull << FPSCR_UE)
-#define FP_ZE		(1ull << FPSCR_ZE)
-#define FP_XE		(1ull << FPSCR_XE)
-#define FP_NI		(1ull << FPSCR_NI)
-#define FP_RN1		(1ull << FPSCR_RN1)
-#define FP_RN		(1ull << FPSCR_RN)
+#define FP_FX           (1ull << FPSCR_FX)
+#define FP_FEX          (1ull << FPSCR_FEX)
+#define FP_VX           (1ull << FPSCR_VX)
+#define FP_OX           (1ull << FPSCR_OX)
+#define FP_UX           (1ull << FPSCR_UX)
+#define FP_ZX           (1ull << FPSCR_ZX)
+#define FP_XX           (1ull << FPSCR_XX)
+#define FP_VXSNAN       (1ull << FPSCR_VXSNAN)
+#define FP_VXISI        (1ull << FPSCR_VXISI)
+#define FP_VXIDI        (1ull << FPSCR_VXIDI)
+#define FP_VXZDZ        (1ull << FPSCR_VXZDZ)
+#define FP_VXIMZ        (1ull << FPSCR_VXIMZ)
+#define FP_VXVC         (1ull << FPSCR_VXVC)
+#define FP_FR           (1ull << FSPCR_FR)
+#define FP_FI           (1ull << FPSCR_FI)
+#define FP_C            (1ull << FPSCR_C)
+#define FP_FL           (1ull << FPSCR_FL)
+#define FP_FG           (1ull << FPSCR_FG)
+#define FP_FE           (1ull << FPSCR_FE)
+#define FP_FU           (1ull << FPSCR_FU)
+#define FP_FPCC         (FP_FL | FP_FG | FP_FE | FP_FU)
+#define FP_FPRF         (FP_C  | FP_FL | FP_FG | FP_FE | FP_FU)
+#define FP_VXSOFT       (1ull << FPSCR_VXSOFT)
+#define FP_VXSQRT       (1ull << FPSCR_VXSQRT)
+#define FP_VXCVI        (1ull << FPSCR_VXCVI)
+#define FP_VE           (1ull << FPSCR_VE)
+#define FP_OE           (1ull << FPSCR_OE)
+#define FP_UE           (1ull << FPSCR_UE)
+#define FP_ZE           (1ull << FPSCR_ZE)
+#define FP_XE           (1ull << FPSCR_XE)
+#define FP_NI           (1ull << FPSCR_NI)
+#define FP_RN1          (1ull << FPSCR_RN1)
+#define FP_RN           (1ull << FPSCR_RN)
=20
 /* the exception bits which can be cleared by mcrfs - includes FX */
 #define FP_EX_CLEAR_BITS (FP_FX     | FP_OX     | FP_UX     | FP_ZX     =
| \
@@ -698,8 +705,8 @@ enum {
=20
 /***********************************************************************=
******/
 /* Vector status and control register */
-#define VSCR_NJ		16 /* Vector non-java */
-#define VSCR_SAT	0 /* Vector saturation */
+#define VSCR_NJ         16 /* Vector non-java */
+#define VSCR_SAT        0 /* Vector saturation */
=20
 /***********************************************************************=
******/
 /* BookE e500 MMU registers */
@@ -962,9 +969,10 @@ struct ppc_radix_page_info {
 /***********************************************************************=
******/
 /* The whole PowerPC CPU context */
=20
-/* PowerPC needs eight modes for different hypervisor/supervisor/guest +
- * real/paged mode combinations. The other two modes are for external PI=
D
- * load/store.
+/*
+ * PowerPC needs eight modes for different hypervisor/supervisor/guest
+ * + real/paged mode combinations. The other two modes are for
+ * external PID load/store.
  */
 #define NB_MMU_MODES    10
 #define MMU_MODE8_SUFFIX _epl
@@ -976,8 +984,9 @@ struct ppc_radix_page_info {
 #define PPC_CPU_INDIRECT_OPCODES_LEN 0x20
=20
 struct CPUPPCState {
-    /* First are the most commonly used resources
-     * during translated code execution
+    /*
+     * First are the most commonly used resources during translated
+     * code execution
      */
     /* general purpose registers */
     target_ulong gpr[32];
@@ -1023,8 +1032,8 @@ struct CPUPPCState {
     /* High part of 128-bit helper return.  */
     uint64_t retxh;
=20
-    int access_type; /* when a memory exception occurs, the access
-                        type is stored here */
+    /* when a memory exception occurs, the access type is stored here */
+    int access_type;
=20
     CPU_COMMON
=20
@@ -1072,8 +1081,10 @@ struct CPUPPCState {
     /* SPE registers */
     uint64_t spe_acc;
     uint32_t spe_fscr;
-    /* SPE and Altivec can share a status since they will never be used
-     * simultaneously */
+    /*
+     * SPE and Altivec can share a status since they will never be
+     * used simultaneously
+     */
     float_status vec_status;
=20
     /* Internal devices resources */
@@ -1103,7 +1114,8 @@ struct CPUPPCState {
     int error_code;
     uint32_t pending_interrupts;
 #if !defined(CONFIG_USER_ONLY)
-    /* This is the IRQ controller, which is implementation dependent
+    /*
+     * This is the IRQ controller, which is implementation dependent
      * and only relevant when emulating a complete machine.
      */
     uint32_t irq_input_state;
@@ -1117,7 +1129,8 @@ struct CPUPPCState {
     hwaddr mpic_iack;
     /* true when the external proxy facility mode is enabled */
     bool mpic_proxy;
-    /* set when the processor has an HV mode, thus HV priv
+    /*
+     * set when the processor has an HV mode, thus HV priv
      * instructions and SPRs are diallowed if MSR:HV is 0
      */
     bool has_hv_mode;
@@ -1149,8 +1162,10 @@ struct CPUPPCState {
=20
     /* booke timers */
=20
-    /* Specifies bit locations of the Time Base used to signal a fixed t=
imer
-     * exception on a transition from 0 to 1. (watchdog or fixed-interva=
l timer)
+    /*
+     * Specifies bit locations of the Time Base used to signal a fixed
+     * timer exception on a transition from 0 to 1. (watchdog or
+     * fixed-interval timer)
      *
      * 0 selects the least significant bit.
      * 63 selects the most significant bit.
@@ -1290,53 +1305,54 @@ extern const struct VMStateDescription vmstate_pp=
c_cpu;
=20
 /***********************************************************************=
******/
 void ppc_translate_init(void);
-/* you can call this signal handler from your SIGBUS and SIGSEGV
-   signal handlers to inform the virtual CPU of exceptions. non zero
-   is returned if the signal was handled by the virtual CPU.  */
-int cpu_ppc_signal_handler (int host_signum, void *pinfo,
-                            void *puc);
+/*
+ * you can call this signal handler from your SIGBUS and SIGSEGV
+ * signal handlers to inform the virtual CPU of exceptions. non zero
+ * is returned if the signal was handled by the virtual CPU.
+ */
+int cpu_ppc_signal_handler(int host_signum, void *pinfo, void *puc);
 #if defined(CONFIG_USER_ONLY)
 int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int=
 rw,
                              int mmu_idx);
 #endif
=20
 #if !defined(CONFIG_USER_ONLY)
-void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
+void ppc_store_sdr1(CPUPPCState *env, target_ulong value);
 void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
 #endif /* !defined(CONFIG_USER_ONLY) */
-void ppc_store_msr (CPUPPCState *env, target_ulong value);
+void ppc_store_msr(CPUPPCState *env, target_ulong value);
=20
 void ppc_cpu_list(void);
=20
 /* Time-base and decrementer management */
 #ifndef NO_CPU_IO_DEFS
-uint64_t cpu_ppc_load_tbl (CPUPPCState *env);
-uint32_t cpu_ppc_load_tbu (CPUPPCState *env);
-void cpu_ppc_store_tbu (CPUPPCState *env, uint32_t value);
-void cpu_ppc_store_tbl (CPUPPCState *env, uint32_t value);
-uint64_t cpu_ppc_load_atbl (CPUPPCState *env);
-uint32_t cpu_ppc_load_atbu (CPUPPCState *env);
-void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value);
-void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value);
+uint64_t cpu_ppc_load_tbl(CPUPPCState *env);
+uint32_t cpu_ppc_load_tbu(CPUPPCState *env);
+void cpu_ppc_store_tbu(CPUPPCState *env, uint32_t value);
+void cpu_ppc_store_tbl(CPUPPCState *env, uint32_t value);
+uint64_t cpu_ppc_load_atbl(CPUPPCState *env);
+uint32_t cpu_ppc_load_atbu(CPUPPCState *env);
+void cpu_ppc_store_atbl(CPUPPCState *env, uint32_t value);
+void cpu_ppc_store_atbu(CPUPPCState *env, uint32_t value);
 bool ppc_decr_clear_on_delivery(CPUPPCState *env);
 target_ulong cpu_ppc_load_decr(CPUPPCState *env);
 void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value);
 target_ulong cpu_ppc_load_hdecr(CPUPPCState *env);
 void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
-uint64_t cpu_ppc_load_purr (CPUPPCState *env);
-uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
-uint32_t cpu_ppc601_load_rtcu (CPUPPCState *env);
+uint64_t cpu_ppc_load_purr(CPUPPCState *env);
+uint32_t cpu_ppc601_load_rtcl(CPUPPCState *env);
+uint32_t cpu_ppc601_load_rtcu(CPUPPCState *env);
 #if !defined(CONFIG_USER_ONLY)
-void cpu_ppc601_store_rtcl (CPUPPCState *env, uint32_t value);
-void cpu_ppc601_store_rtcu (CPUPPCState *env, uint32_t value);
-target_ulong load_40x_pit (CPUPPCState *env);
-void store_40x_pit (CPUPPCState *env, target_ulong val);
-void store_40x_dbcr0 (CPUPPCState *env, uint32_t val);
-void store_40x_sler (CPUPPCState *env, uint32_t val);
-void store_booke_tcr (CPUPPCState *env, target_ulong val);
-void store_booke_tsr (CPUPPCState *env, target_ulong val);
-void ppc_tlb_invalidate_all (CPUPPCState *env);
-void ppc_tlb_invalidate_one (CPUPPCState *env, target_ulong addr);
+void cpu_ppc601_store_rtcl(CPUPPCState *env, uint32_t value);
+void cpu_ppc601_store_rtcu(CPUPPCState *env, uint32_t value);
+target_ulong load_40x_pit(CPUPPCState *env);
+void store_40x_pit(CPUPPCState *env, target_ulong val);
+void store_40x_dbcr0(CPUPPCState *env, uint32_t val);
+void store_40x_sler(CPUPPCState *env, uint32_t val);
+void store_booke_tcr(CPUPPCState *env, target_ulong val);
+void store_booke_tsr(CPUPPCState *env, target_ulong val);
+void ppc_tlb_invalidate_all(CPUPPCState *env);
+void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
 #endif
 #endif
@@ -1349,7 +1365,8 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *en=
v, int gprn)
=20
     gprv =3D env->gpr[gprn];
     if (env->flags & POWERPC_FLAG_SPE) {
-        /* If the CPU implements the SPE extension, we have to get the
+        /*
+         * If the CPU implements the SPE extension, we have to get the
          * high bits of the GPR from the gprh storage area
          */
         gprv &=3D 0xFFFFFFFFULL;
@@ -1360,8 +1377,8 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *en=
v, int gprn)
 }
=20
 /* Device control registers */
-int ppc_dcr_read (ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
-int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
+int ppc_dcr_read(ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
+int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
=20
 #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
 #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
@@ -1372,7 +1389,7 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, ui=
nt32_t val);
=20
 /* MMU modes definitions */
 #define MMU_USER_IDX 0
-static inline int cpu_mmu_index (CPUPPCState *env, bool ifetch)
+static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
 {
     return ifetch ? env->immu_idx : env->dmmu_idx;
 }
@@ -1990,17 +2007,17 @@ void ppc_compat_add_property(Object *obj, const c=
har *name,
 /* External Input Interrupt Directed to Guest State */
 #define EPCR_EXTGS            (1 << 31)
=20
-#define   L1CSR0_CPE		0x00010000	/* Data Cache Parity Enable */
-#define   L1CSR0_CUL		0x00000400	/* (D-)Cache Unable to Lock */
-#define   L1CSR0_DCLFR		0x00000100	/* D-Cache Lock Flash Reset */
-#define   L1CSR0_DCFI		0x00000002	/* Data Cache Flash Invalidate */
-#define   L1CSR0_DCE		0x00000001	/* Data Cache Enable */
+#define   L1CSR0_CPE    0x00010000  /* Data Cache Parity Enable */
+#define   L1CSR0_CUL    0x00000400  /* (D-)Cache Unable to Lock */
+#define   L1CSR0_DCLFR  0x00000100  /* D-Cache Lock Flash Reset */
+#define   L1CSR0_DCFI   0x00000002  /* Data Cache Flash Invalidate */
+#define   L1CSR0_DCE    0x00000001  /* Data Cache Enable */
=20
-#define   L1CSR1_CPE		0x00010000	/* Instruction Cache Parity Enable */
-#define   L1CSR1_ICUL		0x00000400	/* I-Cache Unable to Lock */
-#define   L1CSR1_ICLFR		0x00000100	/* I-Cache Lock Flash Reset */
-#define   L1CSR1_ICFI		0x00000002	/* Instruction Cache Flash Invalidate =
*/
-#define   L1CSR1_ICE		0x00000001	/* Instruction Cache Enable */
+#define   L1CSR1_CPE    0x00010000  /* Instruction Cache Parity Enable *=
/
+#define   L1CSR1_ICUL   0x00000400  /* I-Cache Unable to Lock */
+#define   L1CSR1_ICLFR  0x00000100  /* I-Cache Lock Flash Reset */
+#define   L1CSR1_ICFI   0x00000002  /* Instruction Cache Flash Invalidat=
e */
+#define   L1CSR1_ICE    0x00000001  /* Instruction Cache Enable */
=20
 /* HID0 bits */
 #define HID0_DEEPNAP        (1 << 24)           /* pre-2.06 */
@@ -2226,7 +2243,8 @@ enum {
 };
=20
 /***********************************************************************=
******/
-/* Memory access type :
+/*
+ * Memory access type :
  * may be needed for precise access rights control and precise exception=
s.
  */
 enum {
@@ -2242,8 +2260,9 @@ enum {
     ACCESS_CACHE =3D 0x60, /* Cache manipulation               */
 };
=20
-/* Hardware interruption sources:
- * all those exception can be raised simulteaneously
+/*
+ * Hardware interrupt sources:
+ *   all those exception can be raised simulteaneously
  */
 /* Input pins definitions */
 enum {
@@ -2325,9 +2344,11 @@ enum {
 enum {
     /* POWER7 input pins */
     POWER7_INPUT_INT        =3D 0,
-    /* POWER7 probably has other inputs, but we don't care about them
+    /*
+     * POWER7 probably has other inputs, but we don't care about them
      * for any existing machine.  We can wire these up when we need
-     * them */
+     * them
+     */
     POWER7_INPUT_NB,
 };
=20
--=20
2.20.1
