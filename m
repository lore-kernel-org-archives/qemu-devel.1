Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1051FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09BA2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EriJ7HZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09BA2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44321 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNer-0004RX-Im
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNak-0007JX-W7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaj-0007Q6-KD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:06 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaj-0007PQ-CZ; Mon, 09 Dec 2019 13:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915425; x=1607451425;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d7/DY+YCNJVNKO8sD/VIkO3osyXJIDJnRCYpQIAVre4=;
 b=EriJ7HZsIslk/w+utMRt6CVgTN22YZ/xxUC1noKZKjhM4ajBsFfHUNyt
 hlHTFRkm2/3dY6/i9lxtYQGyMCToPA55SOgb8eaOzGcaYMOYbOU9mJLuR
 RyLAYyE+iUNfF349Jlq83wdS1d94k6d5pRM3g6dGX4JQUbU1tmokxHJ90
 IBuSP/weyPUO8wdobWeYK0EP347HjyukNXLluO7fL2p/xpL1IvdWT5iz9
 BAi9j5UjPTGd56sv/Zqu976NVuEuM+eZJ5/IkRC6UrE2ArnSRXSFHqyLM
 mHvXHzIjXo/mf4t9wcfkNuO9RbUCBq6tZb14Cw3nOYRiBwC/l45KmL3wE g==;
IronPort-SDR: Co8hraGMzuXUfWbnhGykLaNvQEQiX/k7ipBqgpcTMWsU58drwdLFmuBHJuVtIdrzKbuPwP5pd8
 E5ZwPoBX9Gv+5Fmp4pOkB3SoBVFXLx0ZevhrwftLTP1/DVeZa6m3piS9NSKCIKCsskbIuOvHdM
 bf1pTm+SkR995aZ+I9ay2oas1rYsRWP3qIgoa1w/DkcOgzPno+1ILwA6uAE+52th+vEROSfiWC
 C7v2YBSafQztuHBJ//ixgIdyKhxuqy9S5BFU5ORZcoHb+9359eXGZirMin1jCKCqd5uZzhy7dL
 Aew=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="124925569"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:03 +0800
IronPort-SDR: s9HLKL5b/07ARHm61McD2IF4xA1m9bJ2FQ5Zoo0Ogqw+kuO3aynAjdR4cdYHMMnExzqsgmDCoh
 x2XhdlYeh5Vc/m+E64ZINVUd7PoUDJ7G8zlOZ1S7htrBz/uuVJBYaxU6Up2+e2ITl+7FE8xUEk
 jMG1C3VVsf7X88RB9JsnAlK7Sf9+R1xCS+ifVOa7oPgIh+CvcVcoRqOmw/7O4CEBkC+FrqEpa8
 BZ6SwiCtk2+UGS+OeCb7bPF9eVW9FYSoli/GqFsvy2c3zcC27OnA6TxDIhnnvHJ+t8ZNzIYuc5
 ktO7ycxy2LIOOw42D3+hdgO6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:41 -0800
IronPort-SDR: o84C/8/0LrcMBEnlvWHdrLfp41yu5lLib25NPBlEF6y6O2AzvWEknTdwB2UBLIF1zoS5rscr4d
 p3Z3RKnljlhCaGJfw+UXspQ6lt/tBSGMM69Neyu/rQZMj/2XZkCyUTBJaouOHmMDZ5Z1M3Zj+2
 NXoX5zg8MtjwFhzf/d7M45UESMKO7QI2n1eQ35Zp+xTZUGfa5T0YtlvsjNVY/7t8KU9MM2FHlk
 gXQzTMBL/IEGz5aftgYhBHZ3nJ1yyMC2895U5iqVKDaySm9L8lt+oxrkOQxDGBPpLXuZ0jMlsG
 GWc=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:17:04 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 16/36] target/riscv: Add virtual register swapping function
Date: Mon,  9 Dec 2019 10:11:22 -0800
Message-Id: <e89e42f47b337c82ff7fe0ef50986e2df0d7214a.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
 target/riscv/cpu.h        | 10 +++++++
 target/riscv/cpu_bits.h   |  7 +++++
 target/riscv/cpu_helper.c | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9dc8303c62..eb089fbdb6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -125,6 +125,7 @@ struct CPURISCVState {
     target_ulong *mstatus;
 
     target_ulong mip;
+
     uint32_t miclaim;
 
     target_ulong mie;
@@ -173,6 +174,14 @@ struct CPURISCVState {
     target_ulong mtval2;
     target_ulong mtinst;
 
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
 
@@ -303,6 +312,7 @@ void riscv_cpu_list(void);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ad6479796c..a24654d137 100644
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
index 9684da7f7d..63439c9370 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -82,6 +82,69 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
     return false;
 }
 
+void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
+{
+    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
+                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
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
+    } else {
+        /* Current V=0 and we are about to change to V=1 */
+        env->mstatus = &env->vsstatus;
+        *env->mstatus &= mstatus_mask;
+        *env->mstatus |= env->mstatus_novirt & ~mstatus_mask;
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
+    }
+}
+
 bool riscv_cpu_virt_enabled(CPURISCVState *env)
 {
     if (!riscv_has_ext(env, RVH)) {
-- 
2.24.0


