Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42617C00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9F9205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZVk2glhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9F9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieO0D-0000bz-34
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbO-00085A-DT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbM-0007nT-8y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:46 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7465)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbL-0007jP-Oy; Mon, 09 Dec 2019 13:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915490; x=1607451490;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L857ExhJENxSR/+Z6K+9XajkuCcaWe+5h46rnLX3kfI=;
 b=ZVk2glhe8oFT8Fhp+fGY95j4ia0qQkY6yiGhyHucC5T0RalHOi9KP5ZJ
 6DLo6+1VljZHYf4jnT4yLP8zGaqMzlJNh88X8i96bTfonCihzOPn1E5Pq
 aIgUv/bNQlo3ehyU2dvslfgSIQduLtw4s3QXvtX9UPWHmF06F4+VmHgFi
 6nQAxDf2QWonSjAQTdRDGwsyUZHFJqU8ilK3T8vMTXMENz3ygM8ztFkgf
 9vM34QS1uZyC6KZadGP11KBh8A8Il0QLwHwa5SwUcw12uk5Ms0v5NaRH/
 2BjOKnR89C7K53TOJsxsctt9gZLLuN5yGK9UNCTCd0PkM+ozQ/GbCGFED w==;
IronPort-SDR: BPDcCIlxdbagRrWR7/bpMjX2AJmgPnidqqDpoUxViYlAiI7kXRWovNorjG5Cp5LYGvfy8deeFS
 kDZm5SddOsYVZKYM8wGki5OdDPATsfu5cPfn06KoXVB3VtpCNf5N4JQQZByPxQW7uj/bqbLjxE
 45hk6XlX2gcSYHysArPMxYIFACf5shpEnMMgKZkLNjnGzUqo6aGqg+ilbj0Muy6ZR3dxAyoe23
 T3M0bkGLhKRAK3blM6piLO8oWh1Ea4lpkezOcVREK/ZVmCtaE2B0f5UNXCRTPNbLZO+uUn5E9J
 VYE=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226412036"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:18:10 +0800
IronPort-SDR: hJI7SqTbJTNKRJMrjdYa66sJKOO7T4Kx2dtQ+dbyMItHHuRRSbkJNsxt59bkvmlJvfm8f0glz0
 oHqv7hfLGfzZ3ntcxlnfp8fJlLm7UKKohLumpe32kaSinc+fGpu18sOutj6i3bANU43NQMMXWk
 LcIGEd9u5VO8cuycRRHZxuNmSoLsU+g2f+b3crMRGuX7ssM5fBpEfG8OXgjAL4fU7gxSQ56/yq
 R6NaVLr5Fbs+W4+VtBAPHCfdyY3n0T9t+c61RZiurHGouZUF2ZTa8Orbxk/+jjOHCA1uEDGlCL
 68f5fDrI4Su/R5IPvJbUbNo+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:12:21 -0800
IronPort-SDR: U4cSZfziMNAqVjrvPGSIZIIr40l3KT5uV8dDJIwmpCo0gTF1CD5Ia3taJZkPVP6KopjTkmHDPq
 dTnojnen8B/fS63qExjwl4McIKV014p/gHVpGts/ijkYjir2VBQrowaaqE9AyrhCnBQNBVLZF9
 9dX+kl0VYbnkR19eCvaySPvPGAd7oaJnua5vEUjKJoB2kMifsAtnNbnwEB81X0PsXRHC3CdBaA
 aTz2dO0o18vn55/IP2uTg7kqnvXPDRNIZuLLTaVh5jqANv6fXwGtoLBLvByJavsa83qKDvrlwr
 2Oo=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:17:43 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 31/36] target/riscv: Implement second stage MMU
Date: Mon,  9 Dec 2019 10:12:01 -0800
Message-Id: <a40c558e15a57e8d4a15fe7ef3860018d0b8ab11.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |   1 +
 target/riscv/cpu_helper.c | 193 ++++++++++++++++++++++++++++++++++----
 2 files changed, 175 insertions(+), 19 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index eb089fbdb6..b411a1f900 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -104,6 +104,7 @@ struct CPURISCVState {
     target_ulong frm;
 
     target_ulong badaddr;
+    target_ulong guest_phys_fault_addr;
 
     target_ulong priv_ver;
     target_ulong misa;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8b234790a7..8667e5ffce 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -287,11 +287,12 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
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
@@ -299,13 +300,40 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
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
@@ -315,13 +343,30 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
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
@@ -339,6 +384,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
           g_assert_not_reached();
         }
     } else {
+        widened = 0;
         base = (hwaddr)(env->sptbr) << PGSHIFT;
         sum = !get_field(*env->mstatus, MSTATUS_PUM);
         vm = get_field(*env->mstatus, MSTATUS_VM);
@@ -359,9 +405,16 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
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
@@ -373,11 +426,29 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
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
@@ -474,7 +545,12 @@ restart:
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
@@ -533,14 +609,23 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
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
 
@@ -594,17 +679,37 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 #ifndef CONFIG_USER_ONLY
+    vaddr im_address;
     hwaddr pa = 0;
     int prot;
     bool pmp_violation = false;
+    bool m_mode_two_stage = false;
+    bool hs_mode_two_stage = false;
+    bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
 
+    env->guest_phys_fault_addr = 0;
+
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
@@ -612,9 +717,55 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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
+        if (ret != TRANSLATE_FAIL) {
+            /* Second stage lookup */
+            im_address = pa;
+
+            ret = get_physical_address(env, &pa, &prot, im_address,
+                                       access_type, mmu_idx, false, true);
+
+            qemu_log_mask(CPU_LOG_MMU,
+                    "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
+                    TARGET_FMT_plx " prot %d\n",
+                    __func__, im_address, ret, pa, prot);
+
+            if (riscv_feature(env, RISCV_FEATURE_PMP) &&
+                (ret == TRANSLATE_SUCCESS) &&
+                !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
+                ret = TRANSLATE_PMP_FAIL;
+            }
+
+            if (ret != TRANSLATE_SUCCESS) {
+                /*
+                 * Guest physical address translation failed, this is a HS
+                 * level exception
+                 */
+                first_stage_error = false;
+                env->guest_phys_fault_addr = (im_address |
+                                              (address &
+                                               (TARGET_PAGE_SIZE - 1))) >> 2;
+            }
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
 
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
@@ -624,6 +775,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (ret == TRANSLATE_PMP_FAIL) {
         pmp_violation = true;
     }
+
     if (ret == TRANSLATE_SUCCESS) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
                      prot, mmu_idx, TARGET_PAGE_SIZE);
@@ -631,9 +783,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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
2.24.0


