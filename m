Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B13C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56CF206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mSSLifda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56CF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhTU-0003hp-T1
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHb-0002G5-LR
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHa-0006Nq-Ba
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHa-00069K-0O; Fri, 31 Jan 2020 20:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519349; x=1612055349;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WX8yZ6wKk7Bz2GCCNWa0L40pUiNjQzjDBbQ15tWCYBw=;
 b=mSSLifdaKrLMdtdz90GJQSHlp5NsBnZ2ExhPXn0Abf1L/Dvu/v6cVmD4
 mnezZn8uG5vlGfBcQDuQOAkB1an9co6OdsAaFGAp+RKM/VMqfVOOVxvYj
 hGeN7JWT7P7nXH6zlbSDQXRl1Dl4bVil5V6lPGNmFLVBOUaRUSczifdhY
 K888Nmhh5DSJJNOAI37aSYzesyq7jiE8SHVlX8uWdLf/stzpFRWoA/qqL
 FwGGd8N38BSRm8eKYO1NYceF0DuxiJbQNXrdbqhP/KhO+Eij0relDItCl
 dwNs3Yj76nSEkSHdTT8RJJFtmJdI1R7o1SdgxuGFzCxvLmJniQjdk5F62 w==;
IronPort-SDR: QRzq2wUkGVx64nFNWe71FyROw5KnxAx0lJQAnHCaiyJoD1gNRfbGz1BftIk3aQcRLHuLN3nWnH
 rmFQtMMU2v7oTnfl7ygDJzkzK2H1STDmXohqCRva7P9XgNWlsj5FACPpYgqIuB/GOtdT7RuMBu
 HNo+U/LrWwhH3X6+tgCirnI2wsnX0/WXdHXlA3WZdWpoh5vHxJ3K4S95RMOpwQe0vLO1mYXZnK
 n319MnWRhRWLXd8Hc5s0zNSTPa6gFC3l4kk6zMuS7kv+UNwDibfBL79NIFyMl9B3JA6vDdt3Sw
 34g=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872449"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:49 +0800
IronPort-SDR: sBgEbgDXsOpGmMskRaE2Ibkj+zGY3ELNxT7TRNA7f4/nER+kNPgn2gQJzWazQPpkmacyfk4Gbi
 aTyq2Bw0bzDEIC8LKsFFT1pkBF5UeQdJbonmGhhJwiYYG+8C8B+MRC9ow/dAC10+NFl3sdr3Uy
 UKAxlnDVdUKA6fh+lVQRovHIafJMfrFf1k2HKRB1wyuEpQfFOCaBmEGCzLmEgbJkBw4VbqLqbD
 VawBb5y2wEMAIZyJZXHnFI9Oma/pwWF/n8Ilqaklob2WrWyRCtSDuYpw27HsU5DIwfJY/mZeYg
 E2JP8MCK2sBK+mvVziAOjFXZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:57 -0800
IronPort-SDR: 9SybjkUcxiSjmDCtWbslr8DDunNFMKs25wqYzlyWpFY/KistsCxSRLEl3etCFjHBzZShTqR6RU
 6OhuU4bGO9YKhMtSIKIj60//fX6L9Hqow/FDg77RgQDmyln4p3pNO6ryDMJHTfcG8OyZP2/Y00
 6PF7OHaoNnTsKHBK9hM00NP5/e55/rgvARqCMZyyhMtC6U8BN9cHHnGTOj3+ogAHOdK+8N8QOI
 uKZO20cM2FR7os8Z/POgJrEr96qodtNxK9Ycql6AVZydl1rfSF3/rklPXukvGMrm8mxOKBsWjC
 Ync=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:08:49 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 14/35] target/riscv: Add virtual register swapping function
Date: Fri, 31 Jan 2020 17:02:12 -0800
Message-Id: <a512a7e5fa0ecd3ec48aa5f65f6f8f69e72d1c3c.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
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
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h        | 11 +++++++
 target/riscv/cpu_bits.h   |  7 +++++
 target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 42720d65f9..5b889a0065 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -125,6 +125,7 @@ struct CPURISCVState {
     target_ulong mstatus;
 
     target_ulong mip;
+
     uint32_t miclaim;
 
     target_ulong mie;
@@ -166,6 +167,15 @@ struct CPURISCVState {
     target_ulong mtval2;
     target_ulong mtinst;
 
+    /* HS Backup CSRs */
+    target_ulong stvec_hs;
+    target_ulong sscratch_hs;
+    target_ulong sepc_hs;
+    target_ulong scause_hs;
+    target_ulong stval_hs;
+    target_ulong satp_hs;
+    target_ulong mstatus_hs;
+
     target_ulong scounteren;
     target_ulong mcounteren;
 
@@ -296,6 +306,7 @@ void riscv_cpu_list(void);
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
index 1e28103500..e9d75b45d6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -82,6 +82,67 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
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
+        env->vsstatus = env->mstatus & mstatus_mask;
+        env->mstatus &= ~mstatus_mask;
+        env->mstatus |= env->mstatus_hs;
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
+        env->mstatus_hs = env->mstatus & mstatus_mask;
+        env->mstatus &= ~mstatus_mask;
+        env->mstatus |= env->vsstatus;
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
2.25.0


