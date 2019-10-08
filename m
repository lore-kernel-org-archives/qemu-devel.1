Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D47C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 22:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245BE21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 22:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LNRGGCte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245BE21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHxg6-0007IL-BN
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 18:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHxf4-0006he-6L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 18:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHxf2-0008Am-M8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 18:08:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36491)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHxf2-0008AH-08; Tue, 08 Oct 2019 18:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570572531; x=1602108531;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2D71ShVWQmbAREtPnbXkwle0omkehlKkJ+5BUQcFZvc=;
 b=LNRGGCte8X36+TMo3KFHumthw4gHMf+J3C40VvLCCC40wPLXPNZj4V9x
 KAcv6ei5kElWeqsp89Ml97UL5ig/M1O1ReNZ7plQb6XlKUBoiaP5x/pdn
 6v/fNjyWQPb49LVTYVudk6R82cPrjA8uoLQtfurXTYCRkqPsA2kB07ONO
 yfh0EGIQ77o/hVDYae5cfjKvmm/i/7bIcCg+Omx5fspT/65uL9XkxXM5s
 v0dJWKiOA7e2AyhqTRQtvrMFxvlledLZatYs5UqASFM8VXmtlAI7WUY5p
 KkCH2beF5vnE9kjSPSHC70qdhf+pfa+FZMYnNwcqpAdibNlhtIGptCrWI w==;
IronPort-SDR: Kr9kbKSg0lpc8bcj8NsmCthrgmUozdbDS6CChVkuxFp0hmCs4u6wxEw0wMyaoHX8RLsrnfU9Wy
 wmutqmlpSfMeX+EVCrIRcpWWfOzrFnvdHyAcH7FmpcmCtPaMWFf3xqZFi8HEJH9cJHulZhnkGs
 r2NOA1rrMNgU3dLlXo1COfdJsZ2QQHMBCtO7sJwT6Cg9AF9pBkml4edcZ2mrkVtotcOSDIU+22
 ndMpYpnpLhQtn+PhOK+BgYGymQ0ZlP6oFNmyXOYn9dNIlAEykk6BXytefUAzXpRIl5zXOY789t
 6xg=
X-IronPort-AV: E=Sophos;i="5.67,272,1566835200"; d="scan'208";a="120078350"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 06:08:49 +0800
IronPort-SDR: IAAG9xlLPUaGZeGpe6xQz9b7rk5wsLkk9yql+za8aI6yFFCg3RL7sBdcwVovSlCS939w94qGez
 TVSgS2yzVy4qVtMybIuhZ2HhfWJLTt0bPmDBPxIdrloVV5/cKI6tW5OVcuhUjTez3sPEHR16pH
 98MrWh4NRP32SaYtbw3pZstdWe/a0D2RPlWbpMZQhLw4zheaV9sQTVFuzH6ctzanvdxWVuKRD2
 QTFR97HQNjg9cwlHQILB9GoOoRJCdM6lKVtYGoXOHfdjVtaN50VGo2H1yVLPehgM06UARwZAo+
 9gVjMNTNapaBihsFzEky8ADS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 15:04:43 -0700
IronPort-SDR: eTpjG3x/uoyMBkVIXztyaye0BPuPv+QIEeYuuZ/MZiwG7yZGsNuU8cJtn8q5t731p53/pRdLN4
 YWbQEoIpUpvPgzNygpvDippvyKa1rWaZC2I4n4evHym9tv3QfB+aA00FFzXmVoIa2VAiJasuH6
 ti+ujRx6lRpB+h9xQDbB/nkGJ30+rEJymznI4GiNe+inCGtSJx2OZkbtJ+/5dJnlaKtqLl7KaA
 rsrzRVz9vyGifbzWe3qnkRbnlcDnX6T0gNuymD0fqnTLpqwq8VVjnMF552vxijt8EJf90+mJT3
 7l8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Oct 2019 15:08:49 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/1] target/riscv: Remove atomic accesses to MIP CSR
Date: Tue,  8 Oct 2019 15:04:18 -0700
Message-Id: <34350af3b53fadc50bfe4f1fbc452c7d3a8fe8f7.1570572202.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of relying on atomics to access the MIP register let's update
our helper function to instead just lock the IO mutex thread before
writing. This follows the same concept as used in PPC for handling
interrupts

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  5 ++--
 target/riscv/cpu.h        |  9 --------
 target/riscv/cpu_helper.c | 48 +++++++++++++++------------------------
 target/riscv/csr.c        |  2 +-
 4 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f13e298a36..e09dd7aa23 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -224,8 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
-                 (target_ulong)atomic_read(&env->mip));
+    qemu_fprintf(f, " %s 0x%x\n", "mip     ", env->mip);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
@@ -275,7 +274,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
      * Definition of the WFI instruction requires it to ignore the privilege
      * mode and delegation registers, but respect individual enables
      */
-    return (atomic_read(&env->mip) & env->mie) != 0;
+    return (env->mip & env->mie) != 0;
 #else
     return true;
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 124ed33ee4..a71473b243 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -121,15 +121,6 @@ struct CPURISCVState {
     target_ulong mhartid;
     target_ulong mstatus;
 
-    /*
-     * CAUTION! Unlike the rest of this struct, mip is accessed asynchonously
-     * by I/O threads. It should be read with atomic_read. It should be updated
-     * using riscv_cpu_update_mip with the iothread mutex held. The iothread
-     * mutex must be held because mip must be consistent with the CPU inturrept
-     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_interrupt
-     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-zero.
-     * mip is 32-bits to allow atomic_read on 32-bit hosts.
-     */
     uint32_t mip;
     uint32_t miclaim;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 87dd6a6ece..4334978c2e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
@@ -38,7 +39,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
     target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
     target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
-    target_ulong pending = atomic_read(&env->mip) & env->mie;
+    target_ulong pending = env->mip & env->mie;
     target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
     target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
     target_ulong irqs = (pending & ~env->mideleg & -mie) |
@@ -92,42 +93,29 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
     }
 }
 
-struct CpuAsyncInfo {
-    uint32_t new_mip;
-};
-
-static void riscv_cpu_update_mip_irqs_async(CPUState *target_cpu_state,
-                                            run_on_cpu_data data)
-{
-    struct CpuAsyncInfo *info = (struct CpuAsyncInfo *) data.host_ptr;
-
-    if (info->new_mip) {
-        cpu_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
-    }
-
-    g_free(info);
-}
-
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
 {
     CPURISCVState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
-    struct CpuAsyncInfo *info;
-    uint32_t old, new, cmp = atomic_read(&env->mip);
+    uint32_t old = env->mip;
+    bool locked = false;
+
+    if (!qemu_mutex_iothread_locked()) {
+        locked = true;
+        qemu_mutex_lock_iothread();
+    }
 
-    do {
-        old = cmp;
-        new = (old & ~mask) | (value & mask);
-        cmp = atomic_cmpxchg(&env->mip, old, new);
-    } while (old != cmp);
+    env->mip = (env->mip & ~mask) | (value & mask);
 
-    info = g_new(struct CpuAsyncInfo, 1);
-    info->new_mip = new;
+    if (env->mip) {
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
 
-    async_run_on_cpu(cs, riscv_cpu_update_mip_irqs_async,
-                     RUN_ON_CPU_HOST_PTR(info));
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
 
     return old;
 }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f767ad24be..db0cc6ef55 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -579,7 +579,7 @@ static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
     if (mask) {
         old_mip = riscv_cpu_update_mip(cpu, mask, (new_value & mask));
     } else {
-        old_mip = atomic_read(&env->mip);
+        old_mip = env->mip;
     }
 
     if (ret_value) {
-- 
2.23.0


