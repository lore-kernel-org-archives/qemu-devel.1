Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C26C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A21020675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJddtHUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A21020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAEP-0004x6-IO
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:14:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA73-0007SS-1v
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA70-0006hZ-QF
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:09 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA70-0006fG-J5
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:06 -0400
Received: by mail-pg1-x544.google.com with SMTP id z3so5411539pgp.8
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=24QTuNurxDA6IjfxBsoXkaXUs6rhn3fln8yy1ImvJtY=;
	b=hJddtHUcH853T2Aal7AoumOX47KW6xCeJx7vlYHC5S/FwdDsYTlskDbSbG310djA69
	+NRpazkBYgcipD41GGBjtDAnuJLFReZmN2OlKIHMQf6vP0ad3vMu0sao0W7uAFbRxJud
	zoOOEFn9FQhAnaGxSPkwGRuZbzVeO/cwgoyg1MF98rwkZQ3bE9c8XVZzeYxa+WohwBBa
	7TtZMd+QzKteIY075NpD8M8XlJGjP6VsmzlZrvsZh6Et65tP+RSFUrOqFn/KbQTFDme3
	o7vBm2wgnMDm3WRejBlVCyX9oDPOAS16lsLcc9FLR8QarBL3G9CfPDQ0vQA78ahwvuNq
	+ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=24QTuNurxDA6IjfxBsoXkaXUs6rhn3fln8yy1ImvJtY=;
	b=aEgYXB6TPPxYGzVD9W2MKeXrED4xu17p755anJgTlldntocCHXC0sz4Bbt1hW1b/sz
	OMxmwH2uSgi5lk7lajaAGoJV42Q0d6A30SbEq/cpHxDbJxbEtr+o/yKp4+ZscWvPeLpE
	RKvPEat+Hgm3KZ8HM7pi4vTRgzswUE83ie0KawtzD4ueFOtZAZiGITs+O8uP6Pnd04af
	S0m7b6yRwV5aoOloLUoD3DGaTkfQ6Eg2FS5w6rJjwjVNt0TXc9/ZMrk/qNd7ZVEya1r1
	5T0rQrNk7qETi2nOoUsPmgca+sV/OYt4unkCflL5maXJCzWWXCWOVUmrzRFPbDtsbjrJ
	WU3A==
X-Gm-Message-State: APjAAAXvVnJ863hW9n3/iUVNQfUdMl7cbpzvb4Vdc2GyW/Vs2rP9LjcH
	6wh7EpOg5DVvUzfwr63tprBBA96PanE=
X-Google-Smtp-Source: APXvYqy2tg4DonsfuexzwGJA1UVgdtJFZVnPWSbL/8Iqo3OkUlm6EEh8H1aW+frirR/pcxDi3HIMCg==
X-Received: by 2002:a63:778b:: with SMTP id s133mr1367401pgc.198.1557274025356;
	Tue, 07 May 2019 17:07:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:19 -0700
Message-Id: <20190508000641.19090-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 17/39] target/microblaze: Use env_cpu,
 env_archcpu
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

Move cpu_mmu_index below the include of "exec/cpu-all.h",
so that the definition of env_archcpu is available.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h          | 35 ++++++++++++++------------------
 linux-user/microblaze/cpu_loop.c |  2 +-
 target/microblaze/mmu.c          |  5 ++---
 target/microblaze/op_helper.c    |  2 +-
 target/microblaze/translate.c    |  2 +-
 5 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index c5af1c6076..7b85beb556 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -310,11 +310,6 @@ struct MicroBlazeCPU {
     CPUMBState env;
 };
 
-static inline MicroBlazeCPU *mb_env_get_cpu(CPUMBState *env)
-{
-    return container_of(env, MicroBlazeCPU, env);
-}
-
 #define ENV_OFFSET offsetof(MicroBlazeCPU, env)
 
 void mb_cpu_do_interrupt(CPUState *cs);
@@ -344,21 +339,6 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define MMU_USER_IDX    2
 /* See NB_MMU_MODES further up the file.  */
 
-static inline int cpu_mmu_index (CPUMBState *env, bool ifetch)
-{
-    MicroBlazeCPU *cpu = mb_env_get_cpu(env);
-
-    /* Are we in nommu mode?.  */
-    if (!(env->sregs[SR_MSR] & MSR_VM) || !cpu->cfg.use_mmu) {
-        return MMU_NOMMU_IDX;
-    }
-
-    if (env->sregs[SR_MSR] & MSR_UM) {
-        return MMU_USER_IDX;
-    }
-    return MMU_KERNEL_IDX;
-}
-
 int mb_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                             int mmu_idx);
 
@@ -383,4 +363,19 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                MemTxResult response, uintptr_t retaddr);
 #endif
 
+static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
+{
+    MicroBlazeCPU *cpu = env_archcpu(env);
+
+    /* Are we in nommu mode?.  */
+    if (!(env->sregs[SR_MSR] & MSR_VM) || !cpu->cfg.use_mmu) {
+        return MMU_NOMMU_IDX;
+    }
+
+    if (env->sregs[SR_MSR] & MSR_UM) {
+        return MMU_USER_IDX;
+    }
+    return MMU_KERNEL_IDX;
+}
+
 #endif
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 076bdb9a61..a6ea71401d 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUMBState *env)
 {
-    CPUState *cs = CPU(mb_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr, ret;
     target_siginfo_t info;
     
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index fcf86b12d5..6763421ba2 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -34,7 +34,7 @@ static unsigned int tlb_decode_size(unsigned int f)
 
 static void mmu_flush_idx(CPUMBState *env, unsigned int idx)
 {
-    CPUState *cs = CPU(mb_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     struct microblaze_mmu *mmu = &env->mmu;
     unsigned int tlb_size;
     uint32_t tlb_tag, end, t;
@@ -228,7 +228,6 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
 
 void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
 {
-    MicroBlazeCPU *cpu = mb_env_get_cpu(env);
     uint64_t tmp64;
     unsigned int i;
     qemu_log_mask(CPU_LOG_MMU,
@@ -269,7 +268,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
             /* Changes to the zone protection reg flush the QEMU TLB.
                Fortunately, these are very uncommon.  */
             if (v != env->mmu.regs[rn]) {
-                tlb_flush(CPU(cpu));
+                tlb_flush(env_cpu(env));
             }
             env->mmu.regs[rn] = v;
             break;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index e23dcfdc20..aa91d3a257 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -84,7 +84,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
 
 void helper_raise_exception(CPUMBState *env, uint32_t index)
 {
-    CPUState *cs = CPU(mb_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = index;
     cpu_loop_exit(cs);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 885fc44b51..9ce65f3bcf 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1604,7 +1604,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUMBState *env = cs->env_ptr;
-    MicroBlazeCPU *cpu = mb_env_get_cpu(env);
+    MicroBlazeCPU *cpu = env_archcpu(env);
     uint32_t pc_start;
     struct DisasContext ctx;
     struct DisasContext *dc = &ctx;
-- 
2.17.1


