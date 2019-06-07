Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36706C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D1A207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YMQFhDdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D1A207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNAR-0005W4-9f
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsF-0004mB-Oi
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsC-000255-Vf
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2737)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsC-00024S-Jp; Fri, 07 Jun 2019 17:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944688; x=1591480688;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HKvkT8hdJm5Ch0w5xzwUljGaH9FsAA3qVR8+WN12biQ=;
 b=YMQFhDdIOKvF7MRvI9V6l5+ik1e+4l/tGVIheDoW+PlWmvtXsYBnyFVq
 2Cb1R3UhZdANF8HwBfruX5SpJKcEXLpLBoE9GsgSYOvuSwYWMFiFn2uvu
 8lkcs9fmhJvUBuA5e6fbd3DSrgcX5JI+/423ai703dnq5dwXbZdTkK2qz
 XKu/qXdMYsWA3J48lCDumVItmIvEjwPKh7ySaznWQcN4P0PaOv6ScEe7/
 lIF8yjbJEL5+BXcXQtVPSFXCSoRHhsFWQvGFfRFslHivfphTD8XHiUCSx
 0P6OcKELZAlgojgAYQhyRqsFukvYB6igwGbJm4OQgtdTUOO+XWN7rmEZo A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="111342550"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:06 +0800
IronPort-SDR: faHMm1TeW8qWkhN5ZZG5crKxYzPFrH7MCpCHUZTI1H7A/UVFjW1oMwSUlNFRXfsmmHszj9j94I
 hFC+p4tvs6QQ+DPOVdkMcdOb76wAVjaZAEfx6y/H8737FF7AXuBH80Zpfdwtnf1p8cloofqJ5r
 433FYzvZCZDMuw65TGuM0M/dJUHEL8OTl7XhrYQwsMeCsS7Cu9oKmvWlVrJ+mUh8WXB7eI/C3o
 3G9Cm9+CjdFGDgpdsuTvEezdzFqzhRPlETf+xVkyKSXLt5DpLx5A5mpoxFvQ6cgWWq2tkaLS2A
 2LAyOopmsIUuwn6qxj2cEtJN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 14:32:59 -0700
IronPort-SDR: fGPfOtUoNDjh395aELL8oez1tu3xuarpozIIlWGUUiJs873HUnQgeJDddkAoQHVO8JMSR0uhko
 bp5cNKKyOQRdK18fZIu/L/DCFLCUbLF1naEyaVTpI3Y4ti67Sr8ZXMaaHEf9CSY4lBEX1ax8Ws
 cUFDPVe/TFmeCgb2wnbp5LRxDiTXK/aDiep+knxq7rl/zYPmOcpfz7Q/Edp20KOUzYAIiZC7pc
 UNjQ7JekVm6/VC9zM44iADyYJK/0oqm7gY6r9o7RnU6qkADkTXWodVM1o8c9HPDC1ybv/RJfuC
 sMU=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2019 14:58:06 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:56 -0700
Message-Id: <df531fa0e7634eb1b5aea4a47d4cec470a4bc0ea.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 12/27] target/riscv: Add background register
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_bits.h   |  5 ++++
 target/riscv/cpu_helper.c | 52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index eed561d56e..5b3b32dbbc 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -320,6 +320,7 @@ void riscv_cpu_list(void);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_swap_background_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 9c27727e6f..28117bdd32 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -550,3 +550,8 @@
 #define SIP_SSIP                           MIP_SSIP
 #define SIP_STIP                           MIP_STIP
 #define SIP_SEIP                           MIP_SEIP
+
+/* MIE masks */
+#define MIE_SEIE                           (1 << IRQ_S_EXT)
+#define MIE_STIE                           (1 << IRQ_S_TIMER)
+#define MIE_SSIE                           (1 << IRQ_S_SOFT)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0116d2499c..5e5029ac0b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -86,6 +86,58 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #if !defined(CONFIG_USER_ONLY)
 
+void riscv_cpu_swap_background_regs(CPURISCVState *env)
+{
+    RISCVCPU *cpu = riscv_env_get_cpu(env);
+    target_ulong tmp;
+    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
+                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
+    target_ulong sie_mask = MIE_SEIE | MIE_STIE | MIE_SSIE;
+
+    g_assert(riscv_has_ext(env, RVH));
+
+#if defined(TARGET_RISCV64)
+    mstatus_mask |= MSTATUS64_UXL;
+#endif
+
+    tmp = env->bsstatus & mstatus_mask;
+    env->bsstatus = env->mstatus & mstatus_mask;
+    env->mstatus = (env->mstatus & ~mstatus_mask) | tmp;
+
+    tmp = env->bsie & sie_mask;
+    env->bsie = env->mie & sie_mask;
+    env->mie = (env->mie & ~sie_mask) | tmp;
+
+    tmp = env->bstvec;
+    env->bstvec = env->stvec;
+    env->stvec = tmp;
+
+    tmp = env->bsscratch;
+    env->bsscratch = env->sscratch;
+    env->sscratch = tmp;
+
+    tmp = env->bsepc;
+    env->bsepc = env->sepc;
+    env->sepc = tmp;
+
+    tmp = env->bscause;
+    env->bscause = env->scause;
+    env->scause = tmp;
+
+    tmp = env->bstval;
+    env->bstval = env->sbadaddr;
+    env->sbadaddr = tmp;
+
+    tmp = env->bsatp;
+    env->bsatp = env->satp;
+    env->satp = tmp;
+
+    tmp = (target_ulong)atomic_read(&env->bsip);
+    tmp = riscv_cpu_update_mip(cpu, (MIP_SSIP | MIP_STIP | MIP_SEIP), tmp);
+    tmp &= MIP_SSIP | MIP_STIP | MIP_SEIP;
+    atomic_set(&env->bsip, tmp);
+}
+
 bool riscv_cpu_virt_enabled(CPURISCVState *env)
 {
     bool tmp;
-- 
2.21.0


