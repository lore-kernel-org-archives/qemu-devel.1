Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D89C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7263521848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l8LYyTO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7263521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JIH-0006lt-Uh
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC1-0000sN-BQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBy-0000BA-Fp
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBx-0000A6-Ha; Fri, 23 Aug 2019 19:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603722; x=1598139722;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YdDCHokQ8hIpE80LbgpGrbTwapmRbwefuRuX4jpHcx0=;
 b=l8LYyTO6gedUft9uPPxsV1rsCd7mkKiEFD9nWfWNbU13eQg5xRVA0B15
 drQjg22+yxw+k93MoCQCDOKC3npUKPO16ERSKV4Ee8RMx8OzgywXhse5M
 uxtXj54eIUhtf2R5+4ESL+Xlg89JMzU6e2hX3NHNa37bmDd6Xu7h+0qpP
 pYIk7CXGedrcQ5k051rm+zZAYTvw2sgveOhr2FdE0i3+2DRXBy9jA67DD
 iMykTDEHxduB/6bftB8S06qNbZV1w03QKCfGKjcFLfWQGLF5+XiPstmUm
 EEMyQgA0oZSvJ8gABvw9oAJ70wF4sPD25XTCzwpLY9659QnZHqdjaW4qk Q==;
IronPort-SDR: xPw7Bce0gJtHFe4Vmur67NU0DlBRv+/v+j6FV73ptSatskiaK6Iu1kY/s9mKFH+X5wvbDLc3SP
 jOnqXjOTW121iBbRWPysH5Xq3gWOZP2jp2ILJlgykhcLWDnxox04jt4yc8Q6hVdxu7ls+Cpp9j
 G+UX8OkwfjTZXXqYp1nKPhK36lnVP8YrJMifWc62lDnwWnnCXY1gVi3adqvDBUAf5ARlDScnnW
 vqGjY2LEohSxq0Lx9zBjgmj7mEqhyjo8XQAh1FIZHqmLWpuQcv7iE2Mc8WrwYGHJuEwLCu20np
 J10=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="118154423"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:41:59 +0800
IronPort-SDR: EF4BRh92KChyYVqvuA78I37C/JgF8YetLwl9bMDIkOoi+7JFqSyG8jKVY08AbHBdZ9Mj/+fMYg
 xvZWW8/VN7B4CBb4vYmeNiosM3jyfYZguOamsY3mY8DRCOHM8Cz2UkNNCsGWONwSOFTvt5Yehs
 615f0ruoQLpjkucsCfoJ+L31IUnTgxLEVrFBtq73hGrbS71emUFTLyWeZcf53cYlPJhLT0yX7+
 ZFvqQKUBWCIxMzg2xjJ+t3ZUAYzdedanIJEzPfLsnDRb23bay+i7epwzpu7dCTzFJxbSFu8VLJ
 b/J4qFSFclI88zcSXw56ifN+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:16 -0700
IronPort-SDR: FflD5vFkyIBiZ+kWPZFsMKRQwqYEOCCGwAf6jBTiNQI0xzGiQE+D+HqDc65uxB3yF6RHzGpdlG
 wHfw4rcz4KMuPVhSlHbLZq1u3OANK5pKB1qvGncwaZBSdNMdnXxX9qqK2kjJ3+IPW6VQDPK7rN
 go4aG3m08aYgY7uL17LLtX33MrWaOQ66uSudVmsyQeOskKHXUAwPYdRCznpuuiHvVpRn7prWxV
 I1bLFIOLddb5vYYZ/XpMHZy+MoyNHI1hYnPMV/bRkjgg2tGL+KvX/pE6fkYzoyIRpy4h3X4qk8
 0Xs=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:41:58 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:18 -0700
Message-Id: <ec79c985398944a8443eac5673d40bc0969f8380.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 11/28] target/riscv: Add background register
 swapping function
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 24 ++++++++---
 target/riscv/cpu_bits.h   |  7 ++++
 target/riscv/cpu_helper.c | 88 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 680592cb60..05957f32a8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -125,15 +125,18 @@ struct CPURISCVState {
     target_ulong *mstatus;
 
     /*
-     * CAUTION! Unlike the rest of this struct, mip is accessed asynchonously
-     * by I/O threads. It should be read with atomic_read. It should be updated
-     * using riscv_cpu_update_mip with the iothread mutex held. The iothread
-     * mutex must be held because mip must be consistent with the CPU inturrept
-     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_interrupt
-     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-zero.
+     * CAUTION! Unlike the rest of this struct, mip and mip_novirt is accessed
+     * asynchonously by I/O threads. It should be read with atomic_read. It should
+     * be updated using riscv_cpu_update_mip with the iothread mutex held. The
+     * iothread mutex must be held because mip must be consistent with the CPU
+     * inturrept state. riscv_cpu_update_mip calls cpu_interrupt or
+     * cpu_reset_interrupt wuth the invariant that CPU_INTERRUPT_HARD is set if
+     * mip is non-zero.
      * mip is 32-bits to allow atomic_read on 32-bit hosts.
      */
     uint32_t mip;
+    uint32_t mip_novirt;
+
     uint32_t miclaim;
 
     target_ulong *mie;
@@ -179,6 +182,14 @@ struct CPURISCVState {
     target_ulong vstval;
     target_ulong vsatp;
 
+    /* HS Backup CSRs */
+    target_ulong stvec_hs;
+    target_ulong sscratch_hs;
+    target_ulong sepc_hs;
+    target_ulong scause_hs;
+    target_ulong stval_hs;
+    target_ulong satp_hs;
+
     target_ulong scounteren;
     target_ulong mcounteren;
 
@@ -306,6 +317,7 @@ void riscv_cpu_list(void);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 78067901a2..5cee72b726 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -556,4 +556,11 @@
 #define SIP_STIP                           MIP_STIP
 #define SIP_SEIP                           MIP_SEIP
 
+/* MIE masks */
+#define MIE_SEIE                           (1 << IRQ_S_EXT)
+#define MIE_UEIE                           (1 << IRQ_U_EXT)
+#define MIE_STIE                           (1 << IRQ_S_TIMER)
+#define MIE_UTIE                           (1 << IRQ_U_TIMER)
+#define MIE_SSIE                           (1 << IRQ_S_SOFT)
+#define MIE_USIE                           (1 << IRQ_U_SOFT)
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c597523d74..41d4368128 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -81,6 +81,94 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
     return false;
 }
 
+void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
+{
+    RISCVCPU *cpu = RISCV_CPU(env_cpu(env));
+    uint32_t tmp;
+    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
+                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
+    target_ulong sie_mask = MIE_SEIE | MIE_STIE | MIE_SSIE |
+                            MIE_UEIE | MIE_UTIE | MIE_USIE;
+    target_ulong mip_mask = MIP_SSIP | MIP_STIP | MIP_SEIP;
+    bool current_virt = riscv_cpu_virt_enabled(env);
+
+    g_assert(riscv_has_ext(env, RVH));
+
+#if defined(TARGET_RISCV64)
+    mstatus_mask |= MSTATUS64_UXL;
+#endif
+
+    if (current_virt) {
+        /* Current V=1 and we are about to change to V=0 */
+        env->mstatus = &env->mstatus_novirt;
+        *env->mstatus &= mstatus_mask;
+        *env->mstatus |= env->vsstatus & ~mstatus_mask;
+        /* Ensure that vsstatus only holds the correct bits */
+        env->vsstatus &= mstatus_mask;
+
+        env->mie = &env->mie_novirt;
+        *env->mie &= sie_mask;
+        *env->mie |= env->vsie & ~sie_mask;
+        /* Ensure that vsie only holds the correct bits */
+        env->vsie &= sie_mask;
+
+        env->vstvec = env->stvec;
+        env->stvec = env->stvec_hs;
+
+        env->vsscratch = env->sscratch;
+        env->sscratch = env->sscratch_hs;
+
+        env->vsepc = env->sepc;
+        env->sepc = env->sepc_hs;
+
+        env->vscause = env->scause;
+        env->scause = env->scause_hs;
+
+        env->vstval = env->sbadaddr;
+        env->sbadaddr = env->stval_hs;
+
+        env->vsatp = env->satp;
+        env->satp = env->satp_hs;
+
+        tmp = (uint32_t)atomic_read(&env->mip_novirt);
+        tmp = riscv_cpu_update_mip(cpu, mip_mask, tmp);
+        tmp &= mip_mask;
+        atomic_set(&env->vsip, tmp);
+    } else {
+        /* Current V=0 and we are about to change to V=1 */
+        env->mstatus = &env->vsstatus;
+        *env->mstatus &= mstatus_mask;
+        *env->mstatus |= env->mstatus_novirt & ~mstatus_mask;
+
+        env->mie = &env->vsie;
+        *env->mie &= sie_mask;
+        *env->mie |= env->mie_novirt & ~sie_mask;
+
+        env->stvec_hs = env->stvec;
+        env->stvec = env->vstvec;
+
+        env->sscratch_hs = env->sscratch;
+        env->sscratch = env->vsscratch;
+
+        env->sepc_hs = env->sepc;
+        env->sepc = env->vsepc;
+
+        env->scause_hs = env->scause;
+        env->scause = env->vscause;
+
+        env->stval_hs = env->sbadaddr;
+        env->sbadaddr = env->vstval;
+
+        env->satp_hs = env->satp;
+        env->satp = env->vsatp;
+
+        tmp = (uint32_t)atomic_read(&env->vsip);
+        tmp = riscv_cpu_update_mip(cpu, mip_mask, tmp);
+        tmp &= mip_mask;
+        atomic_set(&env->mip_novirt, tmp);
+    }
+}
+
 bool riscv_cpu_virt_enabled(CPURISCVState *env)
 {
     bool tmp;
-- 
2.22.0


