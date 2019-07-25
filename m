Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF5C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05B822C7E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q6MKACx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05B822C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqiuq-00035O-9c
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitY-0005tq-Lk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitX-0007jw-4G
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitW-0007UQ-H7; Thu, 25 Jul 2019 14:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564080914; x=1595616914;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uG+2YaSHQU6xVjUZFZRIGwj39Oo0ZuoiehAmF5ZQwZg=;
 b=Q6MKACx/8UDVyEasXkU9JsvsS+hEvFkVxUvxewF2jNgWzdC/mb4oFaXi
 KKXwYn1C776ddeBHFvlnpQYpvmL4aave0WLTkynone+Kkzahm37wU/u/I
 qq/1LeOT+qjB54bVInzfpxdwhJhsX3JCZcHmXvobHjQMw/JweClED/mzF
 z+WKm+Sw7h+nj7hxBHHdGy8yqDv04TxPJrU3e/Y4yUoSb2L0cBZ0DIw2H
 gxFs8iftJajUWjNSC4/1zzwEtRZ3nrfgKGnPw0RZxhfcP758+tSG216Ig
 dXp6tFwfYY8545AlYaaanXMytZF77Qydi9M+JHb3D/q6Rj4CfLuFley1A A==;
IronPort-SDR: s/0XeVtlf4BMgn8Z3qGJ+DB9ItsfGNtID6XCClOqdBLXpnbIT8Ym3HNp5JSvUk687jPNeT8pVB
 y3XR5dFOQ6ZAojzrOKj7w7oklwssd8Q6FirgZI/bcYl6ocSDoAwQHi6h380RocxUkwWpZfhA5M
 30N/86TM1lTaiRlNh9iUw+mj6wmUNWqXn+GrJOwuW6gV+JgbLM2qXhXNu6B4z6ijPbwyxuJWI0
 l4S1u/ODKB6vpywrd4aOQew7+8HcIkXMyW7423LCAU0IEdKgG4v2zRkCAR9Q7eh87N7R9wh1AL
 hGQ=
X-IronPort-AV: E=Sophos;i="5.64,307,1559491200"; d="scan'208";a="220533152"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 02:55:13 +0800
IronPort-SDR: 6y2TJXBsXJqiEW7H0IRlq8Gskl5uch3EpqHnUox44uUXpuVjrMcgiSo/3M1oPeT9Yil5S4bXPH
 BR6IiuYvPTlyUtF2UuA/refABNY3h8vII2A07FOAd8tkz3SnkDzEkZoiJuAUO3gSbba2ElOej7
 8gMKZAEenOh9WhkaTFLuMT3HhVY6Zi2uhdC6iVp8cNgi/GqRyuPqqinMrrQ5DaO/HFW/RhhJa/
 qnG5l2CpicYwZSOATvE/zJ6c/Az/0PYd/ACH+uvuMnMhIrz903S9nhkZ770yR7PFrTE6YTLh+Y
 94/EicYVH3pYdkyKZwlhBoXt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 25 Jul 2019 11:53:24 -0700
IronPort-SDR: Qs4z0ii4JlUtoiuWAbDhT2dVcrzxC5KgxljZIBBHzsShmFcMNR1Svufr2yzwVE/wTPPlnV7NDb
 nyDLk5KKSUow65YgIdu0VAIOI9wRR3nhJ15ES7eLLAEs/LCK/rfaFUfX6oXCw9bG/T23XBucR3
 WeEx4O6M+WgHVgdCvYZBVhbarjTLVIh38Pl/WQg+XGCf7wRQv2QZbd6/1EsUuDol67anLs06/S
 I8cDhV/dU3XA0+0+2+HbXN8VhZnyN/rBF+50LyYIJBSLER6unQgd1WoEEGji7vwN1Vu8jGDrHP
 Qpc=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Jul 2019 11:55:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 25 Jul 2019 11:52:09 -0700
Message-Id: <edea77ff4aa6900d01ab7146d5b52c2dae4a856e.1564080680.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564080680.git.alistair.francis@wdc.com>
References: <cover.1564080680.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH-4.2 v1 4/6] target/riscv: Create function to
 test if FP is enabled
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

Let's creaate a function that tests if floating point support is
enabled. We can then protect all floating point operations based on if
they are enabled.

This patch so far doesn't change anything, it's just preparing for the
Hypervisor support for floating point operations.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  6 +++++-
 target/riscv/cpu_helper.c | 10 ++++++++++
 target/riscv/csr.c        | 19 ++++++++++---------
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0adb307f32..2dc9b17678 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -255,6 +255,7 @@ void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
+bool riscv_cpu_fp_enabled(CPURISCVState *env);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
@@ -298,7 +299,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #ifdef CONFIG_USER_ONLY
     *flags = TB_FLAGS_MSTATUS_FS;
 #else
-    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
+    *flags = cpu_mmu_index(env, 0);
+    if (riscv_cpu_fp_enabled(env)) {
+        *flags |= env->mstatus & MSTATUS_FS;
+    }
 #endif
 }
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f027be7f16..225e407cff 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -71,6 +71,16 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #if !defined(CONFIG_USER_ONLY)
 
+/* Return true is floating point support is currently enabled */
+bool riscv_cpu_fp_enabled(CPURISCVState *env)
+{
+    if (env->mstatus & MSTATUS_FS) {
+        return true;
+    }
+
+    return false;
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index af3b762c8b..7b73b73cf7 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -46,7 +46,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
 static int fs(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -108,7 +108,7 @@ static int pmp(CPURISCVState *env, int csrno)
 static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -119,7 +119,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -131,7 +131,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -142,7 +142,7 @@ static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -154,7 +154,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -166,7 +166,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -307,6 +307,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
     target_ulong mstatus = env->mstatus;
     target_ulong mask = 0;
+    int dirty;
 
     /* flush tlb on mstatus fields that affect VM */
     if (env->priv_ver <= PRIV_VERSION_1_09_1) {
@@ -340,8 +341,8 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
-    int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
-                ((mstatus & MSTATUS_XS) == MSTATUS_XS);
+    dirty = riscv_cpu_fp_enabled(env) |
+            ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
     env->mstatus = mstatus;
 
-- 
2.22.0


