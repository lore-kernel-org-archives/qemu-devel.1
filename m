Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9695FC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520B6205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yvu02UQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520B6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOARX-0000gr-HU
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:28:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7A-0007dX-Lk
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA79-00075x-BJ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:16 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA79-00073Y-1B
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:15 -0400
Received: by mail-pf1-x441.google.com with SMTP id z28so9503446pfk.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=e2MoXSBglROjVW1qX9oGId2d2/qC2uKVSMSH4SFJtck=;
	b=Yvu02UQi6EDj7n6xivaxhG7Cmpi0hRpz6pzCNG/kh72yjN7WLowuu+O14V0d2y2GHt
	BA6RIYRcAlIaz4T+Qm3KyLjwI7SYGK0m8KVovxrTgdG+1Rve7RzF7aK6kJ+WrHjryaU0
	LnR6Drh6QGqAt/Pkf2xIlHh53MtJHMreYqhdd+H70fVOToINauxAcBbw3G0DFv15TSzo
	slTXqbv4U5RlSNemaNbIKMei/v/ewf1Aa1mrPzifXNdE5W36e9L+hnULtFdCX+8pI1VH
	EmVx4AgICQFbtGC0cr0LXeGJsSlu/ATOkFZYAN4y0CANsuJpLn93tH69Lx4zn1QSB4ov
	V3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=e2MoXSBglROjVW1qX9oGId2d2/qC2uKVSMSH4SFJtck=;
	b=aTZxumr/qUKRYe09P3+rmAuJzCU93MvWg8rg+og4S7dOydxsfJ9Gm7hJIAz+AFqbSO
	ePjUA6DyULHaCjC0ngRj8IUP6BCr2+QLbmeu9unSn4OswUfslt/hnkJQAR+qZCwmU/NS
	xqNCJxnVXepSd3Ezt9ed919xdiKjyut9fZWjB4jt2yIdbve6SSf6d4DrYUXvqYOtPiYy
	S+EfN6nXxHNeJIRQL3KUG1u1bnoEdzQg3AHgvEdPkuUUmVqvDlyUA/RFzUKQuLwAVzmM
	NjxoLsKTvmGORZXgm2IPORDvYJ6BEQEsTJPMIqLq34Ha1KG1KmNbfg9CpR95wUf+2+Pq
	z7Jw==
X-Gm-Message-State: APjAAAVvTzKXvM2sO0lSq+DDpKm3HqDq6WF7AlfVQ6keNDo2tWQZ4o+e
	xiwFaIrDX8O5aGXLjIFT+Uvr1sNYETg=
X-Google-Smtp-Source: APXvYqxR1CbHs3TWGp7bwuT09ykl5DjdJIElxxvAI62ZT/4EqthWfhtMAnDfGjnT5TsJIEsWSchbRg==
X-Received: by 2002:aa7:8493:: with SMTP id u19mr26166187pfn.233.1557274033783;
	Tue, 07 May 2019 17:07:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:25 -0700
Message-Id: <20190508000641.19090-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 23/39] target/riscv: Use env_cpu, env_archcpu
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h          |  5 -----
 linux-user/riscv/cpu_loop.c |  2 +-
 target/riscv/cpu_helper.c   |  4 ++--
 target/riscv/csr.c          | 12 ++++++------
 target/riscv/op_helper.c    |  8 ++++----
 5 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index cd4f2de798..c32428a4ef 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -211,11 +211,6 @@ typedef struct RISCVCPU {
     CPURISCVState env;
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
index b17f169681..72f82c1ccf 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -191,7 +191,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
     }
 
-    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int va_bits = PGSHIFT + levels * ptidxbits;
     target_ulong mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
     target_ulong masked_msbs = (addr >> (va_bits - 1)) & mask;
@@ -320,7 +320,7 @@ restart:
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
                                 MMUAccessType access_type)
 {
-    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int page_fault_exceptions =
         (env->priv_ver >= PRIV_VERSION_1_10_0) &&
         get_field(env->satp, SATP_MODE) != VM_1_10_MBARE;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e1d91b6c60..97a4e10e3e 100644
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
         if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
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
@@ -723,7 +723,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
         if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
             return -1;
         } else {
-            tlb_flush(CPU(riscv_env_get_cpu(env)));
+            tlb_flush(env_cpu(env));
             env->satp = val;
         }
     }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index b7dc18a41e..f078bafbe6 100644
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
@@ -143,8 +143,8 @@ void helper_wfi(CPURISCVState *env)
 
 void helper_tlb_flush(CPURISCVState *env)
 {
-    RISCVCPU *cpu = riscv_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+
     if (env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
         get_field(env->mstatus, MSTATUS_TVM)) {
-- 
2.17.1


