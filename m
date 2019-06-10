Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D8C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEF020820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1A/kUQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEF020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haA2k-00063L-HS
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e7-0006b0-PT
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e6-0001nk-Cl
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:51 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:36248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9e6-0001nJ-6r
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:50 -0400
Received: by mail-pg1-x531.google.com with SMTP id a3so4155831pgb.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BPOSGSRwnnlDmzKutwLcU2dnjTQ5x21/pJ7MvOt5Ozw=;
 b=x1A/kUQIngeKgk36aOdH4fmlltdYL1O9WmCzSkuZhwe/iMfR1K+wj4glBCz6iAo9Lb
 6T0VG7NiU0xZ9LLS+UsfzlYsd1E3/cwyitxbWVuQW1Rw94dw2BAy9aUVgE4UJsknS0kR
 SpVCCd/Xf+hA3ilANcIcKV3HgNIUavXVrAqFX06VRp8Q+2NlE0xeoT4Z3hOQdawxnXdj
 XUiZlL4TMWcQ1Gs5twCjtcFxbpZPSblE/2c/jKmpOUJ0lGEiQRX1CH6gUW1zptSZ9eJg
 LkXhfWsUNA3+eM8CjtnGLUj2ubW2CHzVtHKPoxTLwrrm7aYrbgT0U7GWZxz0gI3AV9iI
 cxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BPOSGSRwnnlDmzKutwLcU2dnjTQ5x21/pJ7MvOt5Ozw=;
 b=lLrvHL35sHSTQfPOrNT8ctggOmllGjGx8JrOWT4w80BlRS38NAJAMOdewvJevS7en7
 EpLASMKFyMoCKxd/CmAKEz+XqLiFmLNnN6WDRhkwXUtcEzQC/PGaJnIUNNFL7iaQq86k
 eYLtNn8tN9V8DY0QeOaXRCLMw/wYZm0SsNaCUme1OOA/1tqmoR/FLiLxYQmyCOvajLwS
 VtR2tlUvPuTYqA5tP8ru2JD7LSkn41qDh37K6M3e034vclHkbyW0/WI+ST+rLgijco0p
 0xNpOl5Ima9pYvb28BOe6ylVvNveJwuZ8q6Jw+aOnvos/10/1mBsn05DVwV/0RLeJ0FE
 MJxg==
X-Gm-Message-State: APjAAAWimA9UDuE1WtW2Ht7Kwm4GatpJw1GvpdIHGI+RMvILm0ciZM8Q
 AO8iVDsULas9THc97PPov/1ENvaVbzw=
X-Google-Smtp-Source: APXvYqzRUfAznsSCLKJTl0m2Ehwb4xgnrYHATo9CGTL2mjbfiJ6rv1aWh6RjfnKaSoKzsWVVYOd6yQ==
X-Received: by 2002:a63:dc4d:: with SMTP id f13mr13361295pgj.417.1560132168830; 
 Sun, 09 Jun 2019 19:02:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:02 -0700
Message-Id: <20190610020218.9228-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
Subject: [Qemu-devel] [PULL 23/39] target/riscv: Use env_cpu, env_archcpu
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
Cc: peter.maydell@linaro.org
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


