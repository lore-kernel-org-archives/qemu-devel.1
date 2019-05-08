Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A8C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B111920C01
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoFVzg79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B111920C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56835 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAbE-0002QW-MZ
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:38:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7P-0007sm-TC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7M-0007ih-VL
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:30 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7K-0007Ru-Sv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id v80so9493430pfa.3
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=SaDigTDS9fIyB6rL+bfWX54Q/iaaD71vm+s0VzJukzw=;
	b=CoFVzg793NHJKmIEo+weZ6lEnxIfAyToDaSa4Q0zZiiKJuI5Y85JIK5uJ67cyoNHb1
	HV8N/o9fbhdcK/erYHFqGLO551GP8kbVKNagJb7jsiMikOlQEIGCX9knpGzisg//rRXp
	6lctrSWu6WM29wS9v3K0DsXPGpztkshyzpSEbqtAKaHV2U+pOdmdaHh7KvdGEM1MDNNb
	veGlibpLBzzt54Z1NgLIZc901f6Ad3C03GgTqCWzk5d/+1/oCmOQGFuJ6IjHjJLII8ow
	GtJVoQ5IF26Y5QhYw8ISg2Fa1xBL1pi8nDyNHWfRl4nWj0v6oTWUowreuhp4EF6LMXBO
	UjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=SaDigTDS9fIyB6rL+bfWX54Q/iaaD71vm+s0VzJukzw=;
	b=L2NTB3O1kj+rnbvBdLgSjp8rGvEg9HTuY7rJB+QQ3kpmtAHHUNqI45kH9Ax6QJM+nJ
	fuSTknkrlO+C1U4i6PoNWtLgxfc92zk8LOYMjpXqHZpWYkDNDgP/v358tyR7J2fvkzLX
	PYWjsDcway/FTccRrVrwEEdfaLGwrzFgAtdGH2M66frMk98njIgHQY2m9KHo1x8lFjyL
	qBFe7/8ndu9FKsb3VIL3tQcbIddg0wvYIdhLVUdaXZLhOptG+BALc0WyfLtTOGlj24tP
	YdorSyeFWhGjlHul2okG+kEU9bSsBpZgrA9M3CsDppben9FbG2rscrGmZm8HqIsjNtS+
	JNRA==
X-Gm-Message-State: APjAAAV2j+Vak9Mh9MTpskseOQ0aUd3qbqQjKk1eDMwkW9G2Ee48XP5P
	c+Nig8wi3GAi9TTdfWNJFw5KCFWUh58=
X-Google-Smtp-Source: APXvYqzwX6C2WuwLMYZ5e8khWyvZdKGZpeIkXgUIPCe0lkzuX1iUv9TcNmNg3dqsD4dTnLzqIHaHVg==
X-Received: by 2002:a63:d252:: with SMTP id t18mr43484422pgi.131.1557274041942;
	Tue, 07 May 2019 17:07:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:32 -0700
Message-Id: <20190508000641.19090-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 30/39] target/xtensa: Use env_cpu,
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

Move cpu_get_tb_cpu_state below the include of "exec/cpu-all.h"
so that the definition of env_cpu is available.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h          | 17 ++++++-----------
 hw/xtensa/pic_cpu.c          |  2 +-
 linux-user/xtensa/cpu_loop.c |  2 +-
 target/xtensa/dbg_helper.c   |  4 ++--
 target/xtensa/exc_helper.c   |  9 ++++-----
 target/xtensa/helper.c       |  2 +-
 target/xtensa/mmu_helper.c   | 11 ++++-------
 target/xtensa/xtensa-semi.c  |  2 +-
 8 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index a20541b5d6..86c88eae40 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -529,11 +529,6 @@ struct XtensaCPU {
     CPUXtensaState env;
 };
 
-static inline XtensaCPU *xtensa_env_get_cpu(const CPUXtensaState *env)
-{
-    return container_of(env, XtensaCPU, env);
-}
-
 #define ENV_OFFSET offsetof(XtensaCPU, env)
 
 
@@ -711,10 +706,15 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
 #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
 #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
 
+typedef CPUXtensaState CPUArchState;
+typedef XtensaCPU ArchCPU;
+
+#include "exec/cpu-all.h"
+
 static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
         target_ulong *cs_base, uint32_t *flags)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     *pc = env->pc;
     *cs_base = 0;
@@ -784,9 +784,4 @@ static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, target_ulong *pc,
     }
 }
 
-typedef CPUXtensaState CPUArchState;
-typedef XtensaCPU ArchCPU;
-
-#include "exec/cpu-all.h"
-
 #endif
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index a8939f5e58..df3acbb541 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -33,7 +33,7 @@
 
 void check_interrupts(CPUXtensaState *env)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int minlevel = xtensa_get_cintlevel(env);
     uint32_t int_set_enabled = env->sregs[INTSET] & env->sregs[INTENABLE];
     int level;
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index bee78edb8a..64831c9199 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -123,7 +123,7 @@ static void xtensa_underflow12(CPUXtensaState *env)
 
 void cpu_loop(CPUXtensaState *env)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_siginfo_t info;
     abi_ulong ret;
     int trapnr;
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index cd8fbd653a..be1f81107b 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -71,7 +71,7 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
 static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
         uint32_t dbreakc)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
     uint32_t mask = dbreakc | ~DBREAKC_MASK;
 
@@ -118,7 +118,7 @@ void HELPER(wsr_dbreakc)(CPUXtensaState *env, uint32_t i, uint32_t v)
             set_dbreak(env, i, env->sregs[DBREAKA + i], v);
         } else {
             if (env->cpu_watchpoint[i]) {
-                CPUState *cs = CPU(xtensa_env_get_cpu(env));
+                CPUState *cs = env_cpu(env);
 
                 cpu_watchpoint_remove_by_ref(cs, env->cpu_watchpoint[i]);
                 env->cpu_watchpoint[i] = NULL;
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 4a1f7aef5d..601341d13a 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -34,7 +34,7 @@
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     if (excp == EXCP_YIELD) {
@@ -100,7 +100,7 @@ void HELPER(debug_exception)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
 
 void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
 {
-    CPUState *cpu;
+    CPUState *cpu = env_cpu(env);
 
     env->pc = pc;
     env->sregs[PS] = (env->sregs[PS] & ~PS_INTLEVEL) |
@@ -111,11 +111,10 @@ void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
     qemu_mutex_unlock_iothread();
 
     if (env->pending_irq_level) {
-        cpu_loop_exit(CPU(xtensa_env_get_cpu(env)));
+        cpu_loop_exit(cpu);
         return;
     }
 
-    cpu = CPU(xtensa_env_get_cpu(env));
     cpu->halted = 1;
     HELPER(exception)(env, EXCP_HLT);
 }
@@ -165,7 +164,7 @@ static void handle_interrupt(CPUXtensaState *env)
         (env->config->level_mask[level] &
          env->sregs[INTSET] &
          env->sregs[INTENABLE])) {
-        CPUState *cs = CPU(xtensa_env_get_cpu(env));
+        CPUState *cs = env_cpu(env);
 
         if (level > 1) {
             env->sregs[EPC1 + level - 1] = env->pc;
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5f37f378a3..7e5c10e098 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -316,7 +316,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 
 void xtensa_runstall(CPUXtensaState *env, bool runstall)
 {
-    CPUState *cpu = CPU(xtensa_env_get_cpu(env));
+    CPUState *cpu = env_cpu(env);
 
     env->runstall = runstall;
     cpu->halted = runstall;
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 79a10da231..2603f43807 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -46,12 +46,10 @@ void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
 
 void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
 {
-    XtensaCPU *cpu = xtensa_env_get_cpu(env);
-
     v = (v & 0xffffff00) | 0x1;
     if (v != env->sregs[RASID]) {
         env->sregs[RASID] = v;
-        tlb_flush(CPU(cpu));
+        tlb_flush(env_cpu(env));
     }
 }
 
@@ -250,7 +248,7 @@ void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
         uint32_t wi;
         xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
         if (entry->variable && entry->asid) {
-            tlb_flush_page(CPU(xtensa_env_get_cpu(env)), entry->vaddr);
+            tlb_flush_page(env_cpu(env), entry->vaddr);
             entry->asid = 0;
         }
     }
@@ -296,8 +294,7 @@ void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
 void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
                           unsigned wi, unsigned ei, uint32_t vpn, uint32_t pte)
 {
-    XtensaCPU *cpu = xtensa_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
     xtensa_tlb_entry *entry = xtensa_tlb_get_entry(env, dtlb, wi, ei);
 
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
@@ -652,7 +649,7 @@ static int get_physical_addr_mmu(CPUXtensaState *env, bool update_tlb,
 
 static bool get_pte(CPUXtensaState *env, uint32_t vaddr, uint32_t *pte)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t paddr;
     uint32_t page_size;
     unsigned access;
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 5f5ce4f344..bb29adc921 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -197,7 +197,7 @@ void xtensa_sim_open_console(Chardev *chr)
 
 void HELPER(simcall)(CPUXtensaState *env)
 {
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     uint32_t *regs = env->regs;
 
     switch (regs[2]) {
-- 
2.17.1


