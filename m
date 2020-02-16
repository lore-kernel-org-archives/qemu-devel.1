Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22820C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EA62084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EA62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Rem-0005h3-4S
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j3Re2-0004c9-4X
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j3Re0-0001gr-F8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:40:06 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:26138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j3Rdw-0001OJ-J1; Sun, 16 Feb 2020 16:40:04 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AC299747E00;
 Sun, 16 Feb 2020 22:39:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 19FD1747DF8; Sun, 16 Feb 2020 22:39:51 +0100 (CET)
Message-Id: <8707144ab1ccf9c5c89a39c2d7a0b02307ca25d4.1581888834.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1581888834.git.balaton@eik.bme.hu>
References: <cover.1581888834.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 16 Feb 2020 22:23:54 +0100
Subject: [PATCH 2/2] target/ppc/cpu.h: Clean up comments in the struct
 CPUPPCState definition
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cpu env struct is quite complex but comments supposed to explain
it in its definition just make it harder to read. Reformat and reword
some comments to make it clearer and more readable.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu.h | 145 ++++++++++++++++++-----------------------------
 1 file changed, 54 insertions(+), 91 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c3b0a00064..b283042515 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -960,116 +960,88 @@ struct ppc_radix_page_info {
 #define PPC_CPU_INDIRECT_OPCODES_LEN 0x20
 
 struct CPUPPCState {
-    /*
-     * First are the most commonly used resources during translated
-     * code execution
-     */
-    /* general purpose registers */
-    target_ulong gpr[32];
-    /* Storage for GPR MSB, used by the SPE extension */
-    target_ulong gprh[32];
-    /* LR */
+    /* Most commonly used resources during translated code execution first */
+    target_ulong gpr[32];  /* general purpose registers */
+    target_ulong gprh[32]; /* storage for GPR MSB, used by the SPE extension */
     target_ulong lr;
-    /* CTR */
     target_ulong ctr;
-    /* condition register */
-    uint32_t crf[8];
+    uint32_t crf[8];       /* condition register */
 #if defined(TARGET_PPC64)
-    /* CFAR */
     target_ulong cfar;
 #endif
-    /* XER (with SO, OV, CA split out) */
-    target_ulong xer;
+    target_ulong xer;      /* XER (with SO, OV, CA split out) */
     target_ulong so;
     target_ulong ov;
     target_ulong ca;
     target_ulong ov32;
     target_ulong ca32;
-    /* Reservation address */
-    target_ulong reserve_addr;
-    /* Reservation value */
-    target_ulong reserve_val;
-    target_ulong reserve_val2;
 
-    /* Those ones are used in supervisor mode only */
-    /* machine state register */
-    target_ulong msr;
-    /* temporary general purpose registers */
-    target_ulong tgpr[4]; /* Used to speed-up TLB assist handlers */
+    target_ulong reserve_addr; /* Reservation address */
+    target_ulong reserve_val;  /* Reservation value */
+    target_ulong reserve_val2;
 
-    /* Next instruction pointer */
-    target_ulong nip;
+    /* These are used in supervisor mode only */
+    target_ulong msr;      /* machine state register */
+    target_ulong tgpr[4];  /* temporary general purpose registers, */
+                           /* used to speed-up TLB assist handlers */
 
-    /* High part of 128-bit helper return.  */
-    uint64_t retxh;
+    target_ulong nip;      /* next instruction pointer */
+    uint64_t retxh;        /* high part of 128-bit helper return */
 
     /* when a memory exception occurs, the access type is stored here */
     int access_type;
 
-    /* MMU context - only relevant for full system emulation */
 #if !defined(CONFIG_USER_ONLY)
+    /* MMU context, only relevant for full system emulation */
 #if defined(TARGET_PPC64)
-    /* PowerPC 64 SLB area */
-    ppc_slb_t slb[MAX_SLB_ENTRIES];
-    /* tcg TLB needs flush (deferred slb inval instruction typically) */
+    ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
 #endif
-    /* segment registers */
-    target_ulong sr[32];
-    /* BATs */
-    uint32_t nb_BATs;
+    target_ulong sr[32];   /* segment registers */
+    uint32_t nb_BATs;      /* number of BATs */
     target_ulong DBAT[2][8];
     target_ulong IBAT[2][8];
     /* PowerPC TLB registers (for 4xx, e500 and 60x software driven TLBs) */
-    int32_t nb_tlb;      /* Total number of TLB                              */
+    int32_t nb_tlb;  /* Total number of TLB */
     int tlb_per_way; /* Speed-up helper: used to avoid divisions at run time */
-    int nb_ways;     /* Number of ways in the TLB set                        */
-    int last_way;    /* Last used way used to allocate TLB in a LRU way      */
+    int nb_ways;     /* Number of ways in the TLB set */
+    int last_way;    /* Last used way used to allocate TLB in a LRU way */
     int id_tlbs;     /* If 1, MMU has separated TLBs for instructions & data */
-    int nb_pids;     /* Number of available PID registers                    */
-    int tlb_type;    /* Type of TLB we're dealing with                       */
-    ppc_tlb_t tlb;   /* TLB is optional. Allocate them only if needed        */
-    /* 403 dedicated access protection registers */
-    target_ulong pb[4];
-    bool tlb_dirty;   /* Set to non-zero when modifying TLB                  */
-    bool kvm_sw_tlb;  /* non-zero if KVM SW TLB API is active                */
+    int nb_pids;     /* Number of available PID registers */
+    int tlb_type;    /* Type of TLB we're dealing with */
+    ppc_tlb_t tlb;   /* TLB is optional. Allocate them only if needed */
+    target_ulong pb[4]; /* 403 dedicated access protection registers */
+    bool tlb_dirty;  /* Set to non-zero when modifying TLB */
+    bool kvm_sw_tlb; /* non-zero if KVM SW TLB API is active */
     uint32_t tlb_need_flush; /* Delayed flush needed */
 #define TLB_NEED_LOCAL_FLUSH   0x1
 #define TLB_NEED_GLOBAL_FLUSH  0x2
 #endif
 
     /* Other registers */
-    /* Special purpose registers */
-    target_ulong spr[1024];
+    target_ulong spr[1024]; /* special purpose registers */
     ppc_spr_t spr_cb[1024];
-    /* Vector status and control register, minus VSCR_SAT.  */
+    /* Vector status and control register, minus VSCR_SAT */
     uint32_t vscr;
     /* VSX registers (including FP and AVR) */
     ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
-    /* Non-zero if and only if VSCR_SAT should be set.  */
+    /* Non-zero if and only if VSCR_SAT should be set */
     ppc_vsr_t vscr_sat QEMU_ALIGNED(16);
     /* SPE registers */
     uint64_t spe_acc;
     uint32_t spe_fscr;
-    /*
-     * SPE and Altivec can share a status since they will never be
-     * used simultaneously
-     */
+    /* SPE and Altivec share status as they'll never be used simultaneously */
     float_status vec_status;
-    /* Floating point execution context */
-    float_status fp_status;
-    /* floating point status and control register */
-    target_ulong fpscr;
+    float_status fp_status; /* Floating point execution context */
+    target_ulong fpscr;     /* Floating point status and control register */
 
     /* Internal devices resources */
-    /* Time base and decrementer */
-    ppc_tb_t *tb_env;
-    /* Device control registers */
-    ppc_dcr_t *dcr_env;
+    ppc_tb_t *tb_env;      /* Time base and decrementer */
+    ppc_dcr_t *dcr_env;    /* Device control registers */
 
     int dcache_line_size;
     int icache_line_size;
 
-    /* Those resources are used during exception processing */
+    /* These resources are used during exception processing */
     /* CPU model definition */
     target_ulong msr_mask;
     powerpc_mmu_t mmu_model;
@@ -1088,58 +1060,49 @@ struct CPUPPCState {
     uint32_t pending_interrupts;
 #if !defined(CONFIG_USER_ONLY)
     /*
-     * This is the IRQ controller, which is implementation dependent
-     * and only relevant when emulating a complete machine. Note that
-     * this isn't used by recent Book3s compatible CPUs (POWER7 and
-     * newer).
+     * This is the IRQ controller, which is implementation dependent and only
+     * relevant when emulating a complete machine. Note that this isn't used
+     * by recent Book3s compatible CPUs (POWER7 and newer).
      */
     uint32_t irq_input_state;
     void **irq_inputs;
-    /* Exception vectors */
-    target_ulong excp_vectors[POWERPC_EXCP_NB];
+
+    target_ulong excp_vectors[POWERPC_EXCP_NB]; /* Exception vectors */
     target_ulong excp_prefix;
     target_ulong ivor_mask;
     target_ulong ivpr_mask;
     target_ulong hreset_vector;
     hwaddr mpic_iack;
-    /* true when the external proxy facility mode is enabled */
-    bool mpic_proxy;
-    /*
-     * set when the processor has an HV mode, thus HV priv
-     * instructions and SPRs are diallowed if MSR:HV is 0
-     */
-    bool has_hv_mode;
-
+    bool mpic_proxy;  /* true if the external proxy facility mode is enabled */
+    bool has_hv_mode; /* set when the processor has an HV mode, thus HV priv */
+                      /* instructions and SPRs are diallowed if MSR:HV is 0 */
     /*
-     * On P7/P8/P9, set when in PM state, we need to handle resume in
-     * a special way (such as routing some resume causes to 0x100, ie,
-     * sreset), so flag this here.
+     * On P7/P8/P9, set when in PM state so we need to handle resume in a
+     * special way (such as routing some resume causes to 0x100, i.e. sreset).
      */
     bool resume_as_sreset;
 #endif
 
-    /* Those resources are used only in QEMU core */
-    target_ulong hflags;      /* hflags is a MSR & HFLAGS_MASK         */
+    /* These resources are used only in QEMU core */
+    target_ulong hflags;      /* hflags is MSR & HFLAGS_MASK */
     target_ulong hflags_nmsr; /* specific hflags, not coming from MSR */
-    int immu_idx;         /* precomputed MMU index to speed up insn access */
-    int dmmu_idx;         /* precomputed MMU index to speed up data accesses */
+    int immu_idx;     /* precomputed MMU index to speed up insn accesses */
+    int dmmu_idx;     /* precomputed MMU index to speed up data accesses */
 
     /* Power management */
     int (*check_pow)(CPUPPCState *env);
 
 #if !defined(CONFIG_USER_ONLY)
-    void *load_info;    /* Holds boot loading state.  */
+    void *load_info;  /* holds boot loading state */
 #endif
 
     /* booke timers */
 
     /*
-     * Specifies bit locations of the Time Base used to signal a fixed
-     * timer exception on a transition from 0 to 1. (watchdog or
-     * fixed-interval timer)
+     * Specifies bit locations of the Time Base used to signal a fixed timer
+     * exception on a transition from 0 to 1 (watchdog or fixed-interval timer)
      *
-     * 0 selects the least significant bit.
-     * 63 selects the most significant bit.
+     * 0 selects the least significant bit, 63 selects the most significant bit
      */
     uint8_t fit_period[4];
     uint8_t wdt_period[4];
-- 
2.21.1


