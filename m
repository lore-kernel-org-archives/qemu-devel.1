Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E734CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3168C21D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qY2uhY/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3168C21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9HI-0002tJ-SU
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91F-0005HP-3c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91D-0004b5-FB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:20 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91D-0004C1-70; Fri, 25 Oct 2019 19:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046159; x=1603582159;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DDHawWi9vnsJIypv9nZN4SVpj32wIDHWs0Ek67NOLVo=;
 b=qY2uhY/N7xUnQgdNWz/FBFpHakDFxJniCKfL1rSvGUAqtrTP364AYR2G
 +1tJX5QWJT2pZAUGrCC7o5vRwAJztl2k6oxQfSLzQn92PwG6d0d2yYaY0
 26sefcRRpEjzCKwoGpPWCGpLF7aJQ1fgs0zGvJXTKer+qbZL8Stl0q/li
 3r3UBwb55j78w2pMDjxNzs4GA+7XweyXePMz1QnNMb1G5sTXvlZEf4c7Q
 8aujmgXU2hJ82wpaanhbrEpZTLTgmSes9qpLleWF88UPhPf8LAhmI3Qlt
 j2214jFGvt93SkZ/kGHsJVf4BOhX51c6L4V9GBxfMGJInxwZGJOS1mVyp Q==;
IronPort-SDR: ORv8EHiq1l37EpE8cSJyIk9clfRpgst0G2rabU4YWPA8ySwOVoZLvFCX4zXzlKTb87AI3PeRqU
 olxEQaH+Amvvd8YqwLWE2QPwkbXUufgl5IRJnyVXLD5xEXUiK0XI8ivUgEl40vRj14/h1FxEKd
 JXqh8avNLRDQR6xJm3siKqLYVliqrSoDN8ThDrSKdC5bsaNjYakE19i7iBIYVOsFg3Wc9z5RCF
 +3Ac6LYwWZO2eKxvxnuxr2LJ9BvLxcqmpptgNP7UixMA3V+Ewq1Ie3v6bl9IdOFTsGW1o76Rvi
 p/U=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520406"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:45 +0800
IronPort-SDR: fB1jOfcEspkE2XFuQ0R1zgPBjVyQ/AJVlwex+rJ+rqCcs98e2LWQL2gIE17iVAiw46kYlqxY1s
 gybJSpusduClEOAl2kW9BFlr4KaTi5CK4IBI9K2QwmhkxdgMLokhA6mSAqI1/sPZP5tN99n0/l
 odCRZk+UxSmOKvJRJeLg/WEisqMJ4UNn9ZS4/qshPNOIlDJMXKM2zpeqlFkmQQoLKUS6YvZy/d
 4ADDXR+8jV1/8bjiWqn9z3xVkYJ4yB7TuMZNocaVE1ROohbaUb6KpEQGxTK+iPe/+tPKViO/mG
 OCF1pyA6mTRhk7R2/3rc64n4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:11 -0700
IronPort-SDR: RVnuOUPkJgD9O5xljwX15sRYig/1M6JgCiOxXL6sdj0Gz/os8lcs+gSQHkI/app0X4naInmULh
 qd3NAcLyVyJWSgSgzjbSK2Vl6QiDP6WZ6nuzzGvJ4hA4klWUXLHk2iqX1MCqQV0kpNohwT63uu
 2tP/8uUmVnruPwPdpyZrQR5BYU/QmueTJ0dePI9oLasFm3vbO51Z2Bef46r/Rd67y2UWIpKRSL
 v8jgUJSONrG5dSdwwl9rZOjZ5An4yC7imzdad+NOMvRKpNA/5+pRMPMiZCIGLg2emlV9QPP7pb
 u+0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:28:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 12/27] target/riscv: Add virtual register swapping function
Date: Fri, 25 Oct 2019 16:23:50 -0700
Message-Id: <9698a0fa88b4716ebc477f9253bd062c889c2a43.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
 target/riscv/cpu.h        | 13 +++++-
 target/riscv/cpu_bits.h   |  7 ++++
 target/riscv/cpu_helper.c | 88 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5b71ee416f..0ea56f9059 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -125,6 +125,8 @@ struct CPURISCVState {
     target_ulong *mstatus;
 
     target_ulong mip;
+    target_ulong mip_novirt;
+
     uint32_t miclaim;
 
     target_ulong *mie;
@@ -161,7 +163,7 @@ struct CPURISCVState {
 
     /* Virtual CSRs */
     target_ulong vsstatus;
-    uint32_t vsip;
+    target_ulong vsip;
     target_ulong vsie;
     target_ulong vstvec;
     target_ulong vsscratch;
@@ -170,6 +172,14 @@ struct CPURISCVState {
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
 
@@ -300,6 +310,7 @@ void riscv_cpu_list(void);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 95909f159a..d66a29bdb1 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -553,4 +553,11 @@
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
index 21d049cdce..12a10e8679 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -82,6 +82,94 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
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
+        tmp = env->mip_novirt;
+        tmp = riscv_cpu_update_mip(cpu, mip_mask, tmp);
+        tmp &= mip_mask;
+        env->vsip = tmp;
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
+        tmp = env->vsip;
+        tmp = riscv_cpu_update_mip(cpu, mip_mask, tmp);
+        tmp &= mip_mask;
+        env->mip_novirt = tmp;
+    }
+}
+
 bool riscv_cpu_virt_enabled(CPURISCVState *env)
 {
     if (!riscv_has_ext(env, RVH)) {
-- 
2.23.0


