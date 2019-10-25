Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D3BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFB621D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yul4k41L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFB621D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9HA-0002eR-KL
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91N-0005YY-Er
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91L-0004gi-It
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91L-0004Yx-5X; Fri, 25 Oct 2019 19:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046167; x=1603582167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9KX4fmzs48B9AnTsmnSKVgxCb5UksLo0R1oD8BBOlRk=;
 b=Yul4k41LTLY5Xugzw8Qfmp4smWF2Km9edOE3P2vm0LloCWeasY8SkKxT
 eeLstD1E5AoXWzwUCQxPQB2mh5wof3LrV6JArG/n86avdCqkkoanM+s5Z
 Av2vy2yknRLMKywMHyGS8Xxu6GdAL4mW62EZGex11I1Ny/V4OMlBu6SEO
 iIv6FiNoWB7VuD8fT1SfrSQkB5Fwv8jXNzZYx4CeElPBUO4J6MbqjC/Fb
 +U+V00rfcJ1f/oJtrs+3nV44QJO3jbrZtV71eif73YKEaR18QEJk7W6M/
 vAxXj76miAyXgA2lkRd/tFVrpvdBYKaS/6jw+w/Zy/djskAAsRZAv4nR8 A==;
IronPort-SDR: w+qKtb/UCC3vtfRetBHUJb3jweTUcGoC089Q7KNASCP96TqYmAkFgpd6+UVbSNC7Zvs7u+BVCS
 f+biLqbscYkFuIZvfeopdqT8dip6UmOpn/HoH4pWo2mQUoclOMdnuLlivKHt6VoJnqgoBwO6nQ
 vJE6SCHXLI6St8V9LgTzzwjEwguhQJt0+yOArpg9QzKGg42qB/ONwVR82twTO10x4CbEzaXJe7
 1uZO3APIsgRTAxpXgvmVtDD9nQciLQWxV9RnHja1RDhWb1kC4AlbXXnrJ9yV/GZumqwZ2AE3mi
 1UE=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="122956701"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:27 +0800
IronPort-SDR: t2pCTgNCBFefpbw9eqAauyLsSktOAxUk429XIMI6dqveF7G3BQS2Znfpovd/yfoFktxA4aclYy
 7ia3d4RJQg+WGSg2jV+HgwLQ7m20mkbKFIXufYshxn9mMhCrnbmLjwTicUpJ7lHDiDd+QFKrK7
 3mH1Pks9dHQT3W0Iw7cT5Tfy0M3y5aA4DZAyQPSUeg6XxPsD0eBZJvzddCNV/0Cmcx+jN9B04T
 69YXFQ7YMcAFq1tBrNd/+DBie1b2F6ymn2lcVhsSSSWWxIo5vBRMtNzgDSRRH6opEWBktq4ZgO
 EXvb1N7q+Ekw/LeQhqeCc27m
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:52 -0700
IronPort-SDR: GwzkvduGhMLVOQRVkoOSJJ9U1FAGYelBfiEAX+dqtL4KfCmTtI1i7tEDTe+lHNIe6BdJNBkTfA
 hmPgRpio7HyScIzjJ9FhZ/0byfnMmptwKgmC4SO5fbJbWvZsWLGKRks7sMgejOi6s07QPPC54R
 3bVD0U/plCIiT8mfFtqrRfAggDTFbI/LPtj8vVGjXnUJu7g9R7GJMYfU+08BUKACaVnbAbcJLY
 yst42tuH3meWtKYS0osGMFeihMlI8GN5ruK/pkgfffl3lrbs3M+1/SpqAZVQ8JeM6v2p1Lx3Ab
 NrI=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:29:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 24/27] target/riscv: Implement second stage MMU
Date: Fri, 25 Oct 2019 16:24:31 -0700
Message-Id: <6e999bd94410ca9f6aba6dee33d5335c87444606.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 193 ++++++++++++++++++++++++++++++++++----
 1 file changed, 174 insertions(+), 19 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 275b6c2a67..b3ce345f81 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -304,11 +304,12 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
  * @mmu_idx: Indicates current privilege level
  * @first_stage: Are we in first stage translation?
  *               Second stage is used for hypervisor guest translation
+ * @two_stage: Are we going to perform two stage translation
  */
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *prot, target_ulong addr,
                                 int access_type, int mmu_idx,
-                                bool first_stage)
+                                bool first_stage, bool two_stage)
 {
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
@@ -316,13 +317,40 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int mode = mmu_idx;
+    bool use_background = false;
 
+    /*
+     * Check if we should use the background registers for the two
+     * stage translation. We don't need to check if we actually need
+     * two stage translation as that happened before this function
+     * was called. Background registers will be used if the guest has
+     * forced a two stage translation to be on (in HS or M mode).
+     */
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(*env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(*env->mstatus, MSTATUS_MPP);
+
+            if (riscv_has_ext(env, RVH) &&
+                get_field(*env->mstatus, MSTATUS_MPV)) {
+                use_background = true;
+            }
+        }
+    }
+
+    if (mode == PRV_S && access_type != MMU_INST_FETCH &&
+        riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
+        if (get_field(env->hstatus, HSTATUS_SPRV)) {
+            mode = get_field(*env->mstatus, SSTATUS_SPP);
+            use_background = true;
         }
     }
 
+    if (first_stage == false) {
+        /* We are in stage 2 translation, this is similar to stage 1. */
+        /* Stage 2 is always taken as U-mode */
+        mode = PRV_U;
+    }
+
     if (mode == PRV_M || !riscv_feature(env, RISCV_FEATURE_MMU)) {
         *physical = addr;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -332,13 +360,30 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     *prot = 0;
 
     hwaddr base;
-    int levels, ptidxbits, ptesize, vm, sum;
-    int mxr = get_field(*env->mstatus, MSTATUS_MXR);
+    int levels, ptidxbits, ptesize, vm, sum, mxr, widened;
+
+    if (first_stage == true) {
+        mxr = get_field(*env->mstatus, MSTATUS_MXR);
+    } else {
+        mxr = get_field(env->vsstatus, MSTATUS_MXR);
+    }
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
+        if (first_stage == true) {
+            if (use_background) {
+                base = (hwaddr)get_field(env->vsatp, SATP_PPN) << PGSHIFT;
+                vm = get_field(env->vsatp, SATP_MODE);
+            } else {
+                base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
+                vm = get_field(env->satp, SATP_MODE);
+            }
+            widened = 0;
+        } else {
+            base = (hwaddr)get_field(env->hgatp, HGATP_PPN) << PGSHIFT;
+            vm = get_field(env->hgatp, HGATP_MODE);
+            widened = 2;
+        }
         sum = get_field(*env->mstatus, MSTATUS_SUM);
-        vm = get_field(env->satp, SATP_MODE);
         switch (vm) {
         case VM_1_10_SV32:
           levels = 2; ptidxbits = 10; ptesize = 4; break;
@@ -356,6 +401,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
           g_assert_not_reached();
         }
     } else {
+        widened = 0;
         base = (hwaddr)(env->sptbr) << PGSHIFT;
         sum = !get_field(*env->mstatus, MSTATUS_PUM);
         vm = get_field(*env->mstatus, MSTATUS_VM);
@@ -376,9 +422,16 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     CPUState *cs = env_cpu(env);
-    int va_bits = PGSHIFT + levels * ptidxbits;
-    target_ulong mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
-    target_ulong masked_msbs = (addr >> (va_bits - 1)) & mask;
+    int va_bits = PGSHIFT + levels * ptidxbits + widened;
+    target_ulong mask, masked_msbs;
+
+    if (TARGET_LONG_BITS > (va_bits - 1)) {
+        mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+    } else {
+        mask = 0;
+    }
+    masked_msbs = (addr >> (va_bits - 1)) & mask;
+
     if (masked_msbs != 0 && masked_msbs != mask) {
         return TRANSLATE_FAIL;
     }
@@ -390,11 +443,29 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 restart:
 #endif
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
-        target_ulong idx = (addr >> (PGSHIFT + ptshift)) &
+        target_ulong idx;
+        if (i == 0) {
+            idx = (addr >> (PGSHIFT + ptshift)) &
+                           ((1 << (ptidxbits + widened)) - 1);
+        } else {
+            idx = (addr >> (PGSHIFT + ptshift)) &
                            ((1 << ptidxbits) - 1);
+        }
 
         /* check that physical address of PTE is legal */
-        hwaddr pte_addr = base + idx * ptesize;
+        hwaddr pte_addr;
+
+        if (two_stage && first_stage) {
+            hwaddr vbase;
+
+            /* Do the second stage translation on the base PTE address. */
+            get_physical_address(env, &vbase, prot, base, access_type,
+                                 mmu_idx, false, true);
+
+            pte_addr = vbase + idx * ptesize;
+        } else {
+            pte_addr = base + idx * ptesize;
+        }
 
         if (riscv_feature(env, RISCV_FEATURE_PMP) &&
             !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
@@ -491,7 +562,12 @@ restart:
             /* for superpage mappings, make a fake leaf PTE for the TLB's
                benefit. */
             target_ulong vpn = addr >> PGSHIFT;
-            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            if (i == 0) {
+                *physical = (ppn | (vpn & ((1L << (ptshift + widened)) - 1))) <<
+                             PGSHIFT;
+            } else {
+                *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            }
 
             /* set permissions on the TLB entry */
             if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
@@ -550,14 +626,23 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
     hwaddr phys_addr;
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
-                             true)) {
+    if (get_physical_address(env, &phys_addr, &prot, addr, 0, mmu_idx,
+                             true, riscv_cpu_virt_enabled(env))) {
         return -1;
     }
+
+    if (riscv_cpu_virt_enabled(env)) {
+        if (get_physical_address(env, &phys_addr, &prot, phys_addr,
+                                 0, mmu_idx, false, true)) {
+            return -1;
+        }
+    }
+
     return phys_addr;
 }
 
@@ -611,18 +696,36 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 #ifndef CONFIG_USER_ONLY
+    vaddr im_address;
     hwaddr pa = 0;
     int prot;
     int pmp_size = 0;
     bool pmp_violation = false;
+    bool m_mode_two_stage = false;
+    bool hs_mode_two_stage = false;
+    bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
 
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
-                               true);
+    /*
+     * Determine if we are in M mode and MPRV is set or in HS mode and SPRV is
+     * set and we want to access a virtulisation address.
+     */
+    if (riscv_has_ext(env, RVH)) {
+        m_mode_two_stage = env->priv == PRV_M &&
+                           access_type != MMU_INST_FETCH &&
+                           get_field(*env->mstatus, MSTATUS_MPRV) &&
+                           get_field(*env->mstatus, MSTATUS_MPV);
+
+        hs_mode_two_stage = env->priv == PRV_S &&
+                            !riscv_cpu_virt_enabled(env) &&
+                            access_type != MMU_INST_FETCH &&
+                            get_field(env->hstatus, HSTATUS_SPRV) &&
+                            get_field(env->hstatus, HSTATUS_SPV);
+    }
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(*env->mstatus, MSTATUS_MPRV)) {
@@ -630,9 +733,56 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    qemu_log_mask(CPU_LOG_MMU,
-                  "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
-                  " prot %d\n", __func__, address, ret, pa, prot);
+    if (riscv_cpu_virt_enabled(env) || m_mode_two_stage || hs_mode_two_stage) {
+        /* Two stage lookup */
+        ret = get_physical_address(env, &pa, &prot, address, access_type,
+                                   mmu_idx, true, true);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s 1st-stage address=%" VADDR_PRIx " ret %d physical "
+                      TARGET_FMT_plx " prot %d\n",
+                      __func__, address, ret, pa, prot);
+
+        if (ret == TRANSLATE_FAIL) {
+            goto tlb_lookup_done;
+        }
+
+        /* Second stage lookup */
+        im_address = pa;
+
+        ret = get_physical_address(env, &pa, &prot, im_address, access_type, mmu_idx,
+                                   false, true);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
+                TARGET_FMT_plx " prot %d\n",
+                __func__, im_address, ret, pa, prot);
+
+        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
+            (ret == TRANSLATE_SUCCESS) &&
+            !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
+            ret = TRANSLATE_PMP_FAIL;
+        }
+
+        if (ret != TRANSLATE_SUCCESS) {
+            /*
+             * Guest physical address translation failed, this is a HS
+             * level exception
+             */
+            first_stage_error = false;
+            address = im_address | (address & (TARGET_PAGE_SIZE - 1));
+            goto tlb_lookup_done;
+        }
+    } else {
+        /* Single stage lookup */
+        ret = get_physical_address(env, &pa, &prot, address, access_type,
+                                   mmu_idx, true, false);
+
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s address=%" VADDR_PRIx " ret %d physical "
+                      TARGET_FMT_plx " prot %d\n",
+                      __func__, address, ret, pa, prot);
+    }
 
     /*
      * if size is unknown (0), assume that all bytes
@@ -644,6 +794,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         pmp_size = size;
     }
 
+tlb_lookup_done:
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, pmp_size, 1 << access_type, mode)) {
@@ -652,6 +803,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (ret == TRANSLATE_PMP_FAIL) {
         pmp_violation = true;
     }
+
     if (ret == TRANSLATE_SUCCESS) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
                      prot, mmu_idx, TARGET_PAGE_SIZE);
@@ -659,9 +811,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type, pmp_violation, true);
+        raise_mmu_exception(env, address, access_type, pmp_violation, first_stage_error);
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
+
+    return true;
+
 #else
     switch (access_type) {
     case MMU_INST_FETCH:
-- 
2.23.0


