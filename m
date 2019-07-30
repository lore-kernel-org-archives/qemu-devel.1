Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE93C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EB12087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DUV4T0h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EB12087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsbj7-00071e-2U
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 19:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhe-0005eV-OF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhb-0002BX-I2
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbha-00025U-45; Tue, 30 Jul 2019 19:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564529922; x=1596065922;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hVtBKdzYjqRlGaozMF9hQt/mWrHXuNhNv7qXXrqCGcs=;
 b=DUV4T0h7qREHAVy8ySlAfSSoG9hE2dRDQLnF/s/T62NKbKwgF4i42Zkc
 bKJ1Hyviar1cUESOzFBQ4FjYZZqqw/BMpKYwcsPBfcLw4CZ0a5rqfjPN1
 zQ3lHpxSnTfjx6SLqlqRC84s//F3Wqj0nc+y8OE+ZwgAMq6FBb/ohUCwm
 MAqkuVwkOJR9AnFadaIvRu0vCKe3GM8jgIKdRlyV9Vace6RllbsKJoiX4
 +K8CLqcjynMN5LXfjBidSBqjcphTArmbGkFQ3XEyhY18jbArcEm0UAvA8
 GSMouTu34LVPAWIn3ZS7WtmQeLWJ2AbN4PFd5MW4GGhuc8EstkXQ2jJGW A==;
IronPort-SDR: jph4Yg4CrAZksgeWyB0HQsXeQJkp2D9VD5Lo1Z3AShbGuOccMRCHSMshhX4OSOG4Bnk0ZIOje5
 LfKdoMAL+OCr4eh4deig82Gs27cy0KRIMTyUJVTQJkeFMh6hxDMJOxDNW15ZIQD6SqCeEDxPDy
 BvXmRihvHh6gGfIZ1QaScE6iCb/vI7ljo3GPA/KAbYrSoI1MCXEoZe4NCezwO577NedsqTTowb
 kMYJ/HmJTR094K1qKhY3kiv4kGYtsDuKzMpY+aOZXb1y0B/StXup0eSQsJNDSnb3WwOFR5qY30
 mq0=
X-IronPort-AV: E=Sophos;i="5.64,327,1559491200"; d="scan'208";a="221001698"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 07:38:37 +0800
IronPort-SDR: /zWBL13yKuIYKTbiMDN+s2SovuFzAJzWVy3jRkYUGG1FbXUjcAn2rX9MQzYDS3G/x3aNnjOg1C
 ne30CcVSqlJ8I9INUqTHRcq73IQezbiQZO7NPrddInh3djbXpDdBBwYDnTopJ3vaGjw63mP57Z
 dTUCeDza1G+FZbsV1K7N2I1DUlUR98DqBisiVqZBUpM+RHpAEei6sSDvboVsno/5rc6X0IYISV
 XJZk74WasrxbtReM/2hY/3Vyp3sTrThW4a968Jdj/hxIZhCVfQSm5El6Tg+iLpDqkK/SFWkue+
 7sO9wm4uUn1gXuk99bFMkEXb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 30 Jul 2019 16:36:39 -0700
IronPort-SDR: OzXitxnBWjdCOwP+EqWVtQPHRyzpEiqnlN6eeLleh35Mxf+Mm9Wfs+LabT9DofhU0Bx3Q1ETuc
 dMHeaK1EOw1i6rnw26NdShSobSrUbWNGicWkxXXEJ6fweKGcPfwVStXJMbCwQZA9Aq0JhdrwgD
 pu9vtTA68qt5NRosOLMQfqXFmtzv46fEbYAO6TTmWYzJjayqCacBEN3ObJByxAQX1zJ4RsLCW5
 jW/K2Y+xMGFKRrevoRAYlcns9m+jXT9Hk3ycu9pernOVs/7eBwiDEoWp/4FaP+ADWCGtIIbdTy
 +A8=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Jul 2019 16:38:37 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 30 Jul 2019 16:35:24 -0700
Message-Id: <d35fb37b43115418a497bcb0bfea187a0c1c46bf.1564529681.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564529681.git.alistair.francis@wdc.com>
References: <cover.1564529681.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH-4.2 v2 3/5] target/riscv: Create function to
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

Let's create a function that tests if floating point support is
enabled. We can then protect all floating point operations based on if
they are enabled.

This patch so far doesn't change anything, it's just preparing for the
Hypervisor support for floating point operations.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>
---
 target/riscv/cpu.h        |  6 +++++-
 target/riscv/cpu_helper.c | 10 ++++++++++
 target/riscv/csr.c        | 20 +++++++++++---------
 3 files changed, 26 insertions(+), 10 deletions(-)

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
index e0d4586760..2789215b5e 100644
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
@@ -340,8 +341,9 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
-    int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
-                ((mstatus & MSTATUS_XS) == MSTATUS_XS);
+    dirty = (riscv_cpu_fp_enabled(env) &&
+             ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
+            ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
     env->mstatus = mstatus;
 
-- 
2.22.0


