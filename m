Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60115C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0332077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KA26RLb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0332077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNo8-0001fR-H8
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaj-0007HX-J1
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNah-0007P4-DE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53135)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNah-0007NS-1u; Mon, 09 Dec 2019 13:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915423; x=1607451423;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jwPJhvctw0+AZI06HWBCSo4SRwqTXKZHSpaKiuoBN38=;
 b=KA26RLb+V+XO4Mda2aueo7g04WY1W2FohsTRfgHITzzCYkFN6qYvnE7m
 XqIQ3EJQGv0PIgXGduMseB0eR3ubkric9hB+24SLabcf63DOiDG7WNJOP
 RSEIYqVED4CkAzIAc5V1jm/NbspCeDMThEK9jqMxbta4RdihbVKHebFZ3
 KHOsKRtfM4KybIWfOsNwO9JzFYmzlBhNs1v/TKsGW9S+9sIQRYsp6lV1f
 qS4LdrjLKt38OjU8AIofthhj6dxuHBEHxGxI9c3DZhmw5x2pjw94WX+3N
 C9r1YjrPjom6JfvK7rS8Wq7hYenHPAdeZ6H1bvm4uXOEEAfahf+nKBCUi w==;
IronPort-SDR: dBSkXLV23XBS8IOKEIv1q90jXV/9C4PWTvrsbkiHrvD8b9T5hm2qg6fdqHtNFOFB/8Di9wGDxL
 rIzE6JTFpoKOtGR8pJRvQygIrrfhA2ld8TkKK4x5HIfEMBe9ZoSXjtZLQ+zP6TyiRLgltjCRb9
 gEJ1stInmzPIk6zT926191KkOt6zjwMWAAIo5yLVA7Qc4zS0qUgxxCY1WwX2Rn5YAT9J9/jRaH
 4fMdZQoDYRBJnRsIMr1+0XKnj3rRlC3uwnHt9/jNTOJgQ4frRO7hKrg2PQMqOgh79Nsn+rKcV6
 7jQ=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="125706050"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:02 +0800
IronPort-SDR: uQyaHjf26Ya3J74ZCISkB1rln+iUiqTOlsrRiC427zRT/z9wtxpb2+phv2DGDrCCwe2i/qAhpL
 pYdvsWFYpKoZqIxSjH1m6xh/RppgKfRnu23m2+1yNDy7DhB8loWx32Glc+wViVFV1zbg9ZGFQv
 mB97HPXsOC/p9svi91ap2mWQqabjsFIgnzCapZ4ANdTnDf+XrnHXfMoqQvYsLcV1BGJiBTey0/
 k74vF5ldwCE+J3TQi55Bx+ScbJppn8go3h/8yWGFzozc1Kt53mnWItuf9IMyFyElAmtMeTxs18
 QVf6ks1ny9QKwh64G6ALa5Wn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:17 -0800
IronPort-SDR: V+iOzYURZzhtTgnniCVgiXNuK0ex9eEOX8Hy8ZitkIvBp8Btg9QFqj75yge9p08eTBX5c4/p9O
 CC5JUYv9PzVCh8jICGN2af0bFkQ0bFBO5A9WBCLeA+WKiOYAtHiVC8r1TmHhi7o8s9oanr23NJ
 tqgW6tjrzuHwwC3jcGuZgRyLMKfTGZ5Sd2u48PYDCAvS1YRXPpLG6knNK3i9EQ80N5ddHRH8GF
 pJmvktpqBGpyHW6zBpRvW/FIQrlbENb0Ob9vdzGjpzNonwx436Hsy1ZgLl1aIbLz+0zoOSHRJq
 AJA=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:17:01 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 15/36] target/riscv: Convert mstatus to pointers
Date: Mon,  9 Dec 2019 10:11:19 -0800
Message-Id: <8c0eebc3868757e9ed312ac35e1f5325d5a18e76.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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

To handle the new Hypervisor CSR register aliasing let's use pointers.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        | 11 +++++++++--
 target/riscv/cpu.h        |  9 ++++++++-
 target/riscv/cpu_helper.c | 30 +++++++++++++++---------------
 target/riscv/csr.c        | 20 ++++++++++----------
 target/riscv/op_helper.c  | 14 +++++++-------
 5 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a07c5689b3..e61cf46a73 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -236,7 +236,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", *env->mstatus);
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
@@ -336,7 +336,7 @@ static void riscv_cpu_reset(CPUState *cs)
     mcc->parent_reset(cs);
 #ifndef CONFIG_USER_ONLY
     env->priv = PRV_M;
-    env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
+    *env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     env->mcause = 0;
     env->pc = env->resetvec;
 #endif
@@ -465,8 +465,15 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 static void riscv_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
+#ifndef CONFIG_USER_ONLY
+    CPURISCVState *env = &cpu->env;
+#endif
 
     cpu_set_cpustate_pointers(cpu);
+
+#ifndef CONFIG_USER_ONLY
+    env->mstatus = &env->mstatus_novirt;
+#endif
 }
 
 static const VMStateDescription vmstate_riscv_cpu = {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 21ae5a8b19..9dc8303c62 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -122,7 +122,7 @@ struct CPURISCVState {
     target_ulong resetvec;
 
     target_ulong mhartid;
-    target_ulong mstatus;
+    target_ulong *mstatus;
 
     target_ulong mip;
     uint32_t miclaim;
@@ -145,6 +145,13 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    /* The following registers are the "real" versions that the pointer
+     * versions point to. These should never be used unless you know what you
+     * are doing. To access these use the pointer versions instead. This is
+     * required to handle the Hypervisor register swapping.
+     */
+    target_ulong mstatus_novirt;
+
     /* Hypervisor CSRs */
     target_ulong hstatus;
     target_ulong hedeleg;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b00f66824a..9684da7f7d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -37,8 +37,8 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 #ifndef CONFIG_USER_ONLY
 static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
-    target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
-    target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
+    target_ulong mstatus_mie = get_field(*env->mstatus, MSTATUS_MIE);
+    target_ulong mstatus_sie = get_field(*env->mstatus, MSTATUS_SIE);
     target_ulong pending = env->mip & env->mie;
     target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
     target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
@@ -75,7 +75,7 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 /* Return true is floating point support is currently enabled */
 bool riscv_cpu_fp_enabled(CPURISCVState *env)
 {
-    if (env->mstatus & MSTATUS_FS) {
+    if (*env->mstatus & MSTATUS_FS) {
         return true;
     }
 
@@ -198,8 +198,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     int mode = mmu_idx;
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
-        if (get_field(env->mstatus, MSTATUS_MPRV)) {
-            mode = get_field(env->mstatus, MSTATUS_MPP);
+        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
+            mode = get_field(*env->mstatus, MSTATUS_MPP);
         }
     }
 
@@ -213,11 +213,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     hwaddr base;
     int levels, ptidxbits, ptesize, vm, sum;
-    int mxr = get_field(env->mstatus, MSTATUS_MXR);
+    int mxr = get_field(*env->mstatus, MSTATUS_MXR);
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
         base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
-        sum = get_field(env->mstatus, MSTATUS_SUM);
+        sum = get_field(*env->mstatus, MSTATUS_SUM);
         vm = get_field(env->satp, SATP_MODE);
         switch (vm) {
         case VM_1_10_SV32:
@@ -237,8 +237,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
     } else {
         base = (hwaddr)(env->sptbr) << PGSHIFT;
-        sum = !get_field(env->mstatus, MSTATUS_PUM);
-        vm = get_field(env->mstatus, MSTATUS_VM);
+        sum = !get_field(*env->mstatus, MSTATUS_PUM);
+        vm = get_field(*env->mstatus, MSTATUS_VM);
         switch (vm) {
         case VM_1_09_SV32:
           levels = 2; ptidxbits = 10; ptesize = 4; break;
@@ -492,8 +492,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
-        if (get_field(env->mstatus, MSTATUS_MPRV)) {
-            mode = get_field(env->mstatus, MSTATUS_MPP);
+        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
+            mode = get_field(*env->mstatus, MSTATUS_MPP);
         }
     }
 
@@ -599,12 +599,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
         /* handle the trap in S-mode */
-        target_ulong s = env->mstatus;
+        target_ulong s = *env->mstatus;
         s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
-        env->mstatus = s;
+        *env->mstatus = s;
         env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
         env->sepc = env->pc;
         env->sbadaddr = tval;
@@ -613,12 +613,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
-        target_ulong s = env->mstatus;
+        target_ulong s = *env->mstatus;
         s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
-        env->mstatus = s;
+        *env->mstatus = s;
         env->mcause = cause | ~(((target_ulong)-1) >> async);
         env->mepc = env->pc;
         env->mbadaddr = tval;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 74e911af08..a4b598d49a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -136,7 +136,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
-    env->mstatus |= MSTATUS_FS;
+    *env->mstatus |= MSTATUS_FS;
 #endif
     riscv_cpu_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
     return 0;
@@ -159,7 +159,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
-    env->mstatus |= MSTATUS_FS;
+    *env->mstatus |= MSTATUS_FS;
 #endif
     env->frm = val & (FSR_RD >> FSR_RD_SHIFT);
     return 0;
@@ -183,7 +183,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
-    env->mstatus |= MSTATUS_FS;
+    *env->mstatus |= MSTATUS_FS;
 #endif
     env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
     riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
@@ -313,7 +313,7 @@ static int read_mhartid(CPURISCVState *env, int csrno, target_ulong *val)
 /* Machine Trap Setup */
 static int read_mstatus(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = env->mstatus;
+    *val = *env->mstatus;
     return 0;
 }
 
@@ -325,7 +325,7 @@ static int validate_vm(CPURISCVState *env, target_ulong vm)
 
 static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
-    target_ulong mstatus = env->mstatus;
+    target_ulong mstatus = *env->mstatus;
     target_ulong mask = 0;
     int dirty;
 
@@ -365,7 +365,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
              ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
             ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
-    env->mstatus = mstatus;
+    *env->mstatus = mstatus;
 
     return 0;
 }
@@ -614,7 +614,7 @@ static int read_sstatus(CPURISCVState *env, int csrno, target_ulong *val)
 {
     target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
                          sstatus_v1_10_mask : sstatus_v1_9_mask);
-    *val = env->mstatus & mask;
+    *val = *env->mstatus & mask;
     return 0;
 }
 
@@ -622,7 +622,7 @@ static int write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
     target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
                          sstatus_v1_10_mask : sstatus_v1_9_mask);
-    target_ulong newval = (env->mstatus & ~mask) | (val & mask);
+    target_ulong newval = (*env->mstatus & ~mask) | (val & mask);
     return write_mstatus(env, CSR_MSTATUS, newval);
 }
 
@@ -737,7 +737,7 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
     if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
         *val = 0;
     } else if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
+        if (env->priv == PRV_S && get_field(*env->mstatus, MSTATUS_TVM)) {
             return -1;
         } else {
             *val = env->satp;
@@ -762,7 +762,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
         validate_vm(env, get_field(val, SATP_MODE)) &&
         ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
     {
-        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
+        if (env->priv == PRV_S && get_field(*env->mstatus, MSTATUS_TVM)) {
             return -1;
         } else {
             if((val ^ env->satp) & SATP_ASID) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 331cc36232..d150551bc9 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -83,11 +83,11 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
     }
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TSR)) {
+        get_field(*env->mstatus, MSTATUS_TSR)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    target_ulong mstatus = env->mstatus;
+    target_ulong mstatus = *env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
@@ -96,7 +96,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
     mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
-    env->mstatus = mstatus;
+    *env->mstatus = mstatus;
 
     return retpc;
 }
@@ -112,7 +112,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
-    target_ulong mstatus = env->mstatus;
+    target_ulong mstatus = *env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
@@ -121,7 +121,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
     mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
-    env->mstatus = mstatus;
+    *env->mstatus = mstatus;
 
     return retpc;
 }
@@ -132,7 +132,7 @@ void helper_wfi(CPURISCVState *env)
 
     if (env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TW)) {
+        get_field(*env->mstatus, MSTATUS_TW)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         cs->halted = 1;
@@ -147,7 +147,7 @@ void helper_tlb_flush(CPURISCVState *env)
     if (!(env->priv >= PRV_S) ||
         (env->priv == PRV_S &&
          env->priv_ver >= PRIV_VERSION_1_10_0 &&
-         get_field(env->mstatus, MSTATUS_TVM))) {
+         get_field(*env->mstatus, MSTATUS_TVM))) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         tlb_flush(cs);
-- 
2.24.0


