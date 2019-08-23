Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DFCC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11A821655
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QIbaJTPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11A821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JLm-00028q-Gi
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBd-0000Ye-Si
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBb-0008TU-H1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBb-0008T1-6X; Fri, 23 Aug 2019 19:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603699; x=1598139699;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MkAG/VVwdeaPegkumfVuWkFQ4o+fxkzqvGgyYa5u9Yo=;
 b=QIbaJTPlyUwuVcoE5aBCDKpk9ZhcMIvjpqd82Cb+BU+E5Tx7RQcisnPD
 VXt9UN/5fXadZOWzKGZFx39oSJuiZlYy2x1ej4cP89Z6UmoE0rp0JTwsd
 H3SsrE+PtCT98JWnL5+3+iOzBe5tVcNXWPjB/Ak78woZpZyFCbkanj7+6
 c9yCV883NJtQB95Cj2APrdkaqP3grJq1SNZbmaoIEA71nrHASxUMZN41b
 Vg0JMKTjOLLZWC+MduGUKiqO1xiStrH9OoCu1H/tL5uK21YvuB+dqNpeQ
 FJMdJqChXpcjPHWmyqlmeY2xsSM+Oc3HsprZiPD7+pO2S0XXzIfegW6op g==;
IronPort-SDR: j/eZmZCXPvDnHrgPfeeNWI9cZ8Sk5tyvXj23R2/0gxaOUSwr5ti0Q1wTGzSYr2242t+lKxlEf8
 156snnBPflq4OrtExmiLnx5yjK0zQTxWT7qKq8AyWhnZmG0ZeDOvjXlg85P4f2l1VvIG28IJuG
 m4+ntWM6KkbWZXvF2Agqe/ikfRPrpGXzU4Xmr7pUrNO2CPfIyxILJJjN04VRvdOlY2zFcu/p/D
 Efmsjr5udHxOyA30kSmqim0yIcilRrCmp2XTimlqydKK8F9Gxb9jCK2xTWSRzyqraVmjXGBVIv
 9kE=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="121144253"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:41:38 +0800
IronPort-SDR: hz+bknSYVYFx5qxYqRoq//czlGyN0WkjV9Od2xhGb+k9zCn+Inpso0KL0aQijerYRNQS+gHl1p
 1vEqoZEhKPIJt3ZMKp4R4iAnqqZBdUCmclPklfJ7er8ipD4DFWcAOrgs5bxlUl2ftkbBRh8KL7
 SmUPtikRSrSkBU7eVx2SamfLvcMsr5+hCVLHZgDsABCysiVF0wCSvihNGwsmDJzxj6Z+MmCen4
 8QeiJPymyAJllY3mQQhcIvrPX81f8s7rxCzriHDoL9rIqkvro5Z34M/BvklH90rKcdBQVoh8pI
 eiLubOj0qUkvdTfQfVEwNV2x
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:38:55 -0700
IronPort-SDR: 1hA7UBIge4s9pp47fxQa/uVP0C9HiddQMptrpWfq7fyzX5ShkhhEn8g3UY/bbdPfoZIEGFwr1T
 AX5Fq+pGJLrbKCYRIRIRovlARUPaYPBGss5Noxj7b9EP6+wdsdWth9k0AYnyNEL8iSWu+h9Vwc
 UkZhMm7O9lfYjClMhchJfIN19+KPRqoKeSm9UZOOGsQkTiLdCECfegzAgnRY0XeMc9XNAHlq6/
 DQQoJO0yzgdwu3PXNUyPiV/MX0AOOg0hPYtDrxtL9YQAvdme0qbTWBs+/Of0aIA8H7mgN/nqp5
 Dkw=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 16:41:38 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:37:57 -0700
Message-Id: <9db2403d223b3e6d2d20086176a975dffabb175b.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 03/28] target/riscv: Add the force HS
 exception mode
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
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0ef1ecb0e0..3a95c41428 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -261,6 +261,8 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
 bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 1fbde516be..204d9d9a79 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -428,6 +428,12 @@
 #define VIRT_MODE_SHIFT     0
 #define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
 
+/* HS-level exception modes */
+#define CLEAR_HS_EXCEP        0
+#define FORCE_HS_EXCEP        1
+#define FORCE_HS_EXCEP_SHIFT  1
+#define FORCE_HS_EXCEP_MASK   (1 << FORCE_HS_EXCEP_SHIFT)
+
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
 #define SATP32_ASID         0x7fc00000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7b0bb14c01..5bcfc2e090 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -104,6 +104,29 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
     env->virt |= enable << VIRT_MODE_SHIFT;
 }
 
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env)
+{
+    bool tmp;
+
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    tmp = (env->virt & FORCE_HS_EXCEP_MASK) >> FORCE_HS_EXCEP_SHIFT;
+
+    return tmp == FORCE_HS_EXCEP;
+}
+
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt &= ~FORCE_HS_EXCEP_MASK;
+    env->virt |= enable << FORCE_HS_EXCEP_SHIFT;
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.22.0


