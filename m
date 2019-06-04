Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AE5C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2ED22075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQXpIkho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ED22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57929 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGUX-0003PZ-NV
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:57:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8g-0001OE-E9
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8f-0004Uy-3Z
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:34 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8e-0004UV-Ur
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:33 -0400
Received: by mail-oi1-x244.google.com with SMTP id q186so16643841oia.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=BPOSGSRwnnlDmzKutwLcU2dnjTQ5x21/pJ7MvOt5Ozw=;
	b=zQXpIkhoLJ2PE18jawcfmuA8iNFcDbP/w12SvOjJfI42egHFlCyc99T0AaimN2Rzqh
	gmWqPnuJQs871qfZ3zeIwXGgGlyrB+1oBvMrXYRXdjcbM/dtC+oQJpHXDlKuoAURqgc4
	YyBk0Lmvb1534tWlNx2GRCO7rUJFf2FX0HBJb3SB62IYzkjpGYR4gvP1pDW8TTncRV7m
	2WXua+cNpPu+F2oJQisrWJ/gs2sm9EXhMxPqqefgjm94c8jZeKBVZeZiE2Yx5tiMk6bK
	90OgEC24oOXfIx44CR2eqvIgoID9z1EFnEbvfzjwJsaSG2NSGYiA49gr3nhVAv/7fkhj
	UZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=BPOSGSRwnnlDmzKutwLcU2dnjTQ5x21/pJ7MvOt5Ozw=;
	b=QpuOAuwElth15s81tNTvwne/xPIg2zjf4DvBoPp8mUzJSkPGpshJRYTxbwdgCZ8SBx
	vocQ8J5hxkKjKIhOa8wPgcvMzMmaKBtaR6j/6diGHtYmW0VhLr7SwUv8w2qzCWPlanvn
	gg7YbBDZcUlSQRU5yOv2VbcEUVWb/hIKAWg+qzo6nBq0Mf5E3rFM6fKQFu+shGT59vI6
	xkVX5kqVoD2VhPPVhZaKvGGovjRb7FWdwn5ZQfjqn7HCBZBJLTKpXRX6vPVgA/WMk3uH
	QEFUL+S6zvIyiGELqQb0wKXsu8ypxJfgWlg87c3Q55mWJFeXX/JkigrGMzAg0IE5qbIO
	bpsQ==
X-Gm-Message-State: APjAAAUeKit4a4/yiwvP52bh0vNBb9Zah8GZtgbreFxuIWYkbXx22+ID
	VpoIoh6d5tYBCqI0GJFc5Ija0irxC8sblg==
X-Google-Smtp-Source: APXvYqzx+vBy0YDlrr3wxgshRQgayL9nCRIroF0Jkr1xrzGzeczxHruScDLdt2BKXfOaP3d69coHkQ==
X-Received: by 2002:aca:3c86:: with SMTP id j128mr5594952oia.1.1559680471865; 
	Tue, 04 Jun 2019 13:34:31 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.29
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:35 -0500
Message-Id: <20190604203351.27778-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: [Qemu-devel] [PATCH v4 23/39] target/riscv: Use env_cpu, env_archcpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace riscv_env_get_cpu with env_archcpu.  The combination
CPU(riscv_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h          |  5 -----
 linux-user/riscv/cpu_loop.c |  2 +-
 target/riscv/cpu_helper.c   | 10 ++++------
 target/riscv/csr.c          | 12 ++++++------
 target/riscv/op_helper.c    |  7 +++----
 5 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9ab038bac3..29a1e08f03 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -221,11 +221,6 @@ typedef struct RISCVCPU {
     } cfg;
 } RISCVCPU;
 
-static inline RISCVCPU *riscv_env_get_cpu(CPURISCVState *env)
-{
-    return container_of(env, RISCVCPU, env);
-}
-
 static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
 {
     return (env->misa & ext) != 0;
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 31700f75d0..c1134597fd 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -25,7 +25,7 @@
 
 void cpu_loop(CPURISCVState *env)
 {
-    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr, signum, sigcode;
     target_ulong sigaddr;
     target_ulong ret;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c577a262b8..8b6754b917 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -89,14 +89,12 @@ struct CpuAsyncInfo {
 static void riscv_cpu_update_mip_irqs_async(CPUState *target_cpu_state,
                                             run_on_cpu_data data)
 {
-    CPURISCVState *env = &RISCV_CPU(target_cpu_state)->env;
-    RISCVCPU *cpu = riscv_env_get_cpu(env);
     struct CpuAsyncInfo *info = (struct CpuAsyncInfo *) data.host_ptr;
 
     if (info->new_mip) {
-        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+        cpu_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
     } else {
-        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+        cpu_reset_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
     }
 
     g_free(info);
@@ -212,7 +210,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
     }
 
-    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int va_bits = PGSHIFT + levels * ptidxbits;
     target_ulong mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
     target_ulong masked_msbs = (addr >> (va_bits - 1)) & mask;
@@ -341,7 +339,7 @@ restart:
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
                                 MMUAccessType access_type)
 {
-    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int page_fault_exceptions =
         (env->priv_ver >= PRIV_VERSION_1_10_0) &&
         get_field(env->satp, SATP_MODE) != VM_1_10_MBARE;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f9e2910643..c67d29e206 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -296,7 +296,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
     if (env->priv_ver <= PRIV_VERSION_1_09_1) {
         if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
                 MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
-            tlb_flush(CPU(riscv_env_get_cpu(env)));
+            tlb_flush(env_cpu(env));
         }
         mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
             MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
@@ -307,7 +307,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
         if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
                 MSTATUS_MPRV | MSTATUS_SUM)) {
-            tlb_flush(CPU(riscv_env_get_cpu(env)));
+            tlb_flush(env_cpu(env));
         }
         mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
             MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
@@ -382,7 +382,7 @@ static int write_misa(CPURISCVState *env, int csrno, target_ulong val)
 
     /* flush translation cache */
     if (val != env->misa) {
-        tb_flush(CPU(riscv_env_get_cpu(env)));
+        tb_flush(env_cpu(env));
     }
 
     env->misa = val;
@@ -549,7 +549,7 @@ static int write_mbadaddr(CPURISCVState *env, int csrno, target_ulong val)
 static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
                    target_ulong new_value, target_ulong write_mask)
 {
-    RISCVCPU *cpu = riscv_env_get_cpu(env);
+    RISCVCPU *cpu = env_archcpu(env);
     /* Allow software control of delegable interrupts not claimed by hardware */
     target_ulong mask = write_mask & delegable_ints & ~env->miclaim;
     uint32_t old_mip;
@@ -712,7 +712,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
         return 0;
     }
     if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val ^ env->sptbr)) {
-        tlb_flush(CPU(riscv_env_get_cpu(env)));
+        tlb_flush(env_cpu(env));
         env->sptbr = val & (((target_ulong)
             1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
     }
@@ -724,7 +724,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
             return -1;
         } else {
             if((val ^ env->satp) & SATP_ASID) {
-                tlb_flush(CPU(riscv_env_get_cpu(env)));
+                tlb_flush(env_cpu(env));
             }
             env->satp = val;
         }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 644d0fb35f..331cc36232 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -28,7 +28,7 @@
 void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
                                           uint32_t exception, uintptr_t pc)
 {
-    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
     cs->exception_index = exception;
     cpu_loop_exit_restore(cs, pc);
@@ -128,7 +128,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 
 void helper_wfi(CPURISCVState *env)
 {
-    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     if (env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
@@ -143,8 +143,7 @@ void helper_wfi(CPURISCVState *env)
 
 void helper_tlb_flush(CPURISCVState *env)
 {
-    RISCVCPU *cpu = riscv_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
     if (!(env->priv >= PRV_S) ||
         (env->priv == PRV_S &&
          env->priv_ver >= PRIV_VERSION_1_10_0 &&
-- 
2.17.1


