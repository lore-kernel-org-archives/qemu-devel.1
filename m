Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276BFC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DB52075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNgfQUeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DB52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGYz-0007Js-2m
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 17:01:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG91-0001fl-HI
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8y-0004sB-Ay
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8u-0004nD-N9
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id i8so20829032oth.10
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=PYpVsDECn50S2iyRZN0fZ1fEzaZW8+7DmxjFRcVQ65o=;
	b=SNgfQUeHb6yhrsOM1h+GkXlqqOeqNSivVzYqCTW5ewigzePOuzkVVjdvjODC9RAB50
	UcQdCe5CunAL4AuQa2DPFHXqbi8qAyvM2QWxcaH/j2pbMegxyKJPd51s+WWWl0riwuXN
	39I9/VpK8fw8m6dfP0we9ArVuDsUcG1mrTNLOHr9T/cXc0naffcB003e70J035SPh8AR
	k6xMqoVzHSqe4Rff9xTHa5iTaPlr4lqmu9+cT98vRKLed5Ur+/QfWLVys9RotpOvh/bI
	3O750k5IJn/LE+u1cUr4UL15AIp8FURl2ccqp9zj7Y5HOMG98L1thM2u2J0tBUCGEoks
	L9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=PYpVsDECn50S2iyRZN0fZ1fEzaZW8+7DmxjFRcVQ65o=;
	b=J9sJypf2eCh5Ju1+xc5uNJ1sauqGFU7OZ38VxnVqNU7JALu8KGiL+1onaN8kFr+e69
	7QOGMd1YFSlguerM3+jktDrHfdCZggjm9D4xLlFZeGlXaYGl8mCC9lIXkQfAPvJWUzfG
	0S+mB7cL9sZLXY5pv2hePEt7Szqvr82EELc4Pgvba5+8kA+8hErMMBku9IJpYSu2h3o1
	6Hwo2AD8HK1y4Ofi9W28Xx7OUklY4+FWxuoWIBHNG2HsalwCtEbDqpQ7JDGn3hZOrWyd
	SOF/LEsRU34NVYiNsTaHDyLCsFbmb14cpYljsNSXCXts4wrlApv03DyzLoyFF3a4uhj4
	2jDg==
X-Gm-Message-State: APjAAAX3vU27TYmDf5e533q7zG6XM8MCynaVUDSUErFT7iudhAZnKmL+
	mKVMVvT2s3GvyR+KyEhiYd6XSjIaw96wyQ==
X-Google-Smtp-Source: APXvYqznvEFzA5gQZa/9Q11QrqcT2qA6jImT/ejQQ4ReafIQfXdFy5DqknPms/EFbsf40PA2IKOowQ==
X-Received: by 2002:a9d:4c17:: with SMTP id l23mr6516898otf.367.1559680487251; 
	Tue, 04 Jun 2019 13:34:47 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.46
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:46 -0500
Message-Id: <20190604203351.27778-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH v4 34/39] cpu: Move icount_decr to
 CPUNegativeOffsetState
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

Amusingly, we had already ignored the comment to keep this value
at the end of CPUState.  This restores the minimum negative offset
from TCG_AREG0 for code generation.

For the couple of uses within qom/cpu.c, without NEED_CPU_H, add
a pointer from the CPUState object to the IcountDecr object within
CPUNegativeOffsetState.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    |  1 +
 include/exec/cpu-defs.h   |  3 ++-
 include/exec/gen-icount.h | 16 ++++++++++------
 include/qom/cpu.h         | 40 ++++++++++++++++++---------------------
 accel/tcg/cpu-exec.c      | 23 +++++++++++-----------
 accel/tcg/tcg-all.c       |  6 ++----
 accel/tcg/translate-all.c |  8 ++++----
 cpus.c                    |  9 +++++----
 qom/cpu.c                 |  4 ++--
 9 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5ae83405c8..253dd1d9a5 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -380,6 +380,7 @@ int cpu_exec(CPUState *cpu);
 static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
 {
     cpu->parent_obj.env_ptr = &cpu->env;
+    cpu->parent_obj.icount_decr_ptr = &cpu->neg.icount_decr;
 }
 
 /**
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 921fbb4c36..c067994e5c 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -33,6 +33,7 @@
 #include "exec/hwaddr.h"
 #endif
 #include "exec/memattrs.h"
+#include "qom/cpu.h"
 
 #include "cpu-param.h"
 
@@ -232,7 +233,7 @@ typedef struct CPUTLB {
  * before CPUArchState, as a field named "neg".
  */
 typedef struct CPUNegativeOffsetState {
-    /* Empty */
+    IcountDecr icount_decr;
 } CPUNegativeOffsetState;
 
 #endif
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 9cfa6ccce5..f7669b6841 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -5,8 +5,6 @@
 
 /* Helpers for instruction counting code generation.  */
 
-#define ENV_OFFSET   offsetof(ArchCPU, env)
-
 static TCGOp *icount_start_insn;
 
 static inline void gen_tb_start(TranslationBlock *tb)
@@ -21,7 +19,8 @@ static inline void gen_tb_start(TranslationBlock *tb)
     }
 
     tcg_gen_ld_i32(count, cpu_env,
-                   -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
+                   offsetof(ArchCPU, neg.icount_decr.u32) -
+                   offsetof(ArchCPU, env));
 
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
         imm = tcg_temp_new_i32();
@@ -39,7 +38,8 @@ static inline void gen_tb_start(TranslationBlock *tb)
 
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, cpu_env,
-                         -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
+                         offsetof(ArchCPU, neg.icount_decr.u16.low) -
+                         offsetof(ArchCPU, env));
     }
 
     tcg_temp_free_i32(count);
@@ -60,14 +60,18 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 static inline void gen_io_start(void)
 {
     TCGv_i32 tmp = tcg_const_i32(1);
-    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
+    tcg_gen_st_i32(tmp, cpu_env,
+                   offsetof(ArchCPU, parent_obj.can_do_io) -
+                   offsetof(ArchCPU, env));
     tcg_temp_free_i32(tmp);
 }
 
 static inline void gen_io_end(void)
 {
     TCGv_i32 tmp = tcg_const_i32(0);
-    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
+    tcg_gen_st_i32(tmp, cpu_env,
+                   offsetof(ArchCPU, parent_obj.can_do_io) -
+                   offsetof(ArchCPU, env));
     tcg_temp_free_i32(tmp);
 }
 
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 98e12d914c..5ee0046b62 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -232,17 +232,25 @@ typedef struct CPUClass {
     bool gdb_stop_before_watchpoint;
 } CPUClass;
 
+/*
+ * Low 16 bits: number of cycles left, used only in icount mode.
+ * High 16 bits: Set to -1 to force TCG to stop executing linked TBs
+ * for this CPU and return to its top level loop (even in non-icount mode).
+ * This allows a single read-compare-cbranch-write sequence to test
+ * for both decrementer underflow and exceptions.
+ */
+typedef union IcountDecr {
+    uint32_t u32;
+    struct {
 #ifdef HOST_WORDS_BIGENDIAN
-typedef struct icount_decr_u16 {
-    uint16_t high;
-    uint16_t low;
-} icount_decr_u16;
+        uint16_t high;
+        uint16_t low;
 #else
-typedef struct icount_decr_u16 {
-    uint16_t low;
-    uint16_t high;
-} icount_decr_u16;
+        uint16_t low;
+        uint16_t high;
 #endif
+    } u16;
+} IcountDecr;
 
 typedef struct CPUBreakpoint {
     vaddr pc;
@@ -314,11 +322,6 @@ struct qemu_work_item;
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
  * @singlestep_enabled: Flags for single-stepping.
  * @icount_extra: Instructions until next timer event.
- * @icount_decr: Low 16 bits: number of cycles left, only used in icount mode.
- * High 16 bits: Set to -1 to force TCG to stop executing linked TBs for this
- * CPU and return to its top level loop (even in non-icount mode).
- * This allows a single read-compare-cbranch-write sequence to test
- * for both decrementer underflow and exceptions.
  * @can_do_io: Nonzero if memory-mapped IO is safe. Deterministic execution
  * requires that IO only be performed on the last instruction of a TB
  * so that interrupts take effect immediately.
@@ -328,6 +331,7 @@ struct qemu_work_item;
  * @as: Pointer to the first AddressSpace, for the convenience of targets which
  *      only have a single AddressSpace
  * @env_ptr: Pointer to subclass-specific CPUArchState field.
+ * @icount_decr_ptr: Pointer to IcountDecr field within subclass.
  * @gdb_regs: Additional GDB registers.
  * @gdb_num_regs: Number of total registers accessible to GDB.
  * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
@@ -387,6 +391,7 @@ struct CPUState {
     MemoryRegion *memory;
 
     void *env_ptr; /* CPUArchState */
+    IcountDecr *icount_decr_ptr;
 
     /* Accessed in parallel; all accesses must be atomic */
     struct TranslationBlock *tb_jmp_cache[TB_JMP_CACHE_SIZE];
@@ -441,15 +446,6 @@ struct CPUState {
 
     bool ignore_memory_transaction_failures;
 
-    /* Note that this is accessed at the start of every TB via a negative
-       offset from AREG0.  Leave this field at the end so as to make the
-       (absolute value) offset as small as possible.  This reduces code
-       size, especially for hosts without large memory offsets.  */
-    union {
-        uint32_t u32;
-        icount_decr_u16 u16;
-    } icount_decr;
-
     struct hax_vcpu_state *hax_vcpu;
 
     int hvf_fd;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 45ef41ebb2..032a62672e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -54,7 +54,7 @@ typedef struct SyncClocks {
 #define MAX_DELAY_PRINT_RATE 2000000000LL
 #define MAX_NB_PRINTS 100
 
-static void align_clocks(SyncClocks *sc, const CPUState *cpu)
+static void align_clocks(SyncClocks *sc, CPUState *cpu)
 {
     int64_t cpu_icount;
 
@@ -62,7 +62,7 @@ static void align_clocks(SyncClocks *sc, const CPUState *cpu)
         return;
     }
 
-    cpu_icount = cpu->icount_extra + cpu->icount_decr.u16.low;
+    cpu_icount = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
     sc->diff_clk += cpu_icount_to_ns(sc->last_cpu_icount - cpu_icount);
     sc->last_cpu_icount = cpu_icount;
 
@@ -105,15 +105,15 @@ static void print_delay(const SyncClocks *sc)
     }
 }
 
-static void init_delay_params(SyncClocks *sc,
-                              const CPUState *cpu)
+static void init_delay_params(SyncClocks *sc, CPUState *cpu)
 {
     if (!icount_align_option) {
         return;
     }
     sc->realtime_clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
     sc->diff_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - sc->realtime_clock;
-    sc->last_cpu_icount = cpu->icount_extra + cpu->icount_decr.u16.low;
+    sc->last_cpu_icount
+        = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
     if (sc->diff_clk < max_delay) {
         max_delay = sc->diff_clk;
     }
@@ -467,7 +467,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     if (cpu->exception_index < 0) {
 #ifndef CONFIG_USER_ONLY
         if (replay_has_exception()
-               && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
+            && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0) {
             /* try to cause an exception pending in the log */
             cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()), true);
         }
@@ -525,7 +525,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * Ensure zeroing happens before reading cpu->exit_request or
      * cpu->interrupt_request (see also smp_wmb in cpu_exit())
      */
-    atomic_mb_set(&cpu->icount_decr.u16.high, 0);
+    atomic_mb_set(&cpu_neg(cpu)->icount_decr.u16.high, 0);
 
     if (unlikely(atomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
@@ -596,8 +596,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     }
 
     /* Finally, check if we need to exit to the main loop.  */
-    if (unlikely(atomic_read(&cpu->exit_request)
-        || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
+    if (unlikely(atomic_read(&cpu->exit_request))
+        || (use_icount
+            && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0)) {
         atomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
@@ -624,7 +625,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     }
 
     *last_tb = NULL;
-    insns_left = atomic_read(&cpu->icount_decr.u32);
+    insns_left = atomic_read(&cpu_neg(cpu)->icount_decr.u32);
     if (insns_left < 0) {
         /* Something asked us to stop executing chained TBs; just
          * continue round the main loop. Whatever requested the exit
@@ -643,7 +644,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     cpu_update_icount(cpu);
     /* Refill decrementer and continue execution.  */
     insns_left = MIN(0xffff, cpu->icount_budget);
-    cpu->icount_decr.u16.low = insns_left;
+    cpu_neg(cpu)->icount_decr.u16.low = insns_left;
     cpu->icount_extra = cpu->icount_budget - insns_left;
     if (!cpu->icount_extra) {
         /* Execute any remaining instructions, then let the main loop
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 3d25bdcc17..9b215dcc5a 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -28,13 +28,12 @@
 #include "sysemu/sysemu.h"
 #include "qom/object.h"
 #include "qemu-common.h"
-#include "qom/cpu.h"
+#include "cpu.h"
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
 
 unsigned long tcg_tb_size;
 
-#ifndef CONFIG_USER_ONLY
 /* mask must never be zero, except for A20 change call */
 static void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
@@ -51,7 +50,7 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     } else {
-        atomic_set(&cpu->icount_decr.u16.high, -1);
+        atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
         if (use_icount &&
             !cpu->can_do_io
             && (mask & ~old_mask) != 0) {
@@ -59,7 +58,6 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
         }
     }
 }
-#endif
 
 static int tcg_init(MachineState *ms)
 {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 52d94facf0..e24ee3a172 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -364,7 +364,7 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
         assert(use_icount);
         /* Reset the cycle counter to the start of the block
            and shift if to the number of actually executed instructions */
-        cpu->icount_decr.u16.low += num_insns - i;
+        cpu_neg(cpu)->icount_decr.u16.low += num_insns - i;
     }
     restore_state_to_opc(env, tb, data);
 
@@ -2200,7 +2200,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     if ((env->hflags & MIPS_HFLAG_BMASK) != 0
         && env->active_tc.PC != tb->pc) {
         env->active_tc.PC -= (env->hflags & MIPS_HFLAG_B16 ? 2 : 4);
-        cpu->icount_decr.u16.low++;
+        cpu_neg(cpu)->icount_decr.u16.low++;
         env->hflags &= ~MIPS_HFLAG_BMASK;
         n = 2;
     }
@@ -2208,7 +2208,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     if ((env->flags & ((DELAY_SLOT | DELAY_SLOT_CONDITIONAL))) != 0
         && env->pc != tb->pc) {
         env->pc -= 2;
-        cpu->icount_decr.u16.low++;
+        cpu_neg(cpu)->icount_decr.u16.low++;
         env->flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
         n = 2;
     }
@@ -2382,7 +2382,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(qemu_mutex_iothread_locked());
     cpu->interrupt_request |= mask;
-    atomic_set(&cpu->icount_decr.u16.high, -1);
+    atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
 }
 
 /*
diff --git a/cpus.c b/cpus.c
index ffc57119ca..111ca4ed1c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -239,7 +239,8 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
  */
 static int64_t cpu_get_icount_executed(CPUState *cpu)
 {
-    return cpu->icount_budget - (cpu->icount_decr.u16.low + cpu->icount_extra);
+    return (cpu->icount_budget -
+            (cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra));
 }
 
 /*
@@ -1389,12 +1390,12 @@ static void prepare_icount_for_run(CPUState *cpu)
          * each vCPU execution. However u16.high can be raised
          * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
          */
-        g_assert(cpu->icount_decr.u16.low == 0);
+        g_assert(cpu_neg(cpu)->icount_decr.u16.low == 0);
         g_assert(cpu->icount_extra == 0);
 
         cpu->icount_budget = tcg_get_icount_limit();
         insns_left = MIN(0xffff, cpu->icount_budget);
-        cpu->icount_decr.u16.low = insns_left;
+        cpu_neg(cpu)->icount_decr.u16.low = insns_left;
         cpu->icount_extra = cpu->icount_budget - insns_left;
 
         replay_mutex_lock();
@@ -1408,7 +1409,7 @@ static void process_icount_data(CPUState *cpu)
         cpu_update_icount(cpu);
 
         /* Reset the counters */
-        cpu->icount_decr.u16.low = 0;
+        cpu_neg(cpu)->icount_decr.u16.low = 0;
         cpu->icount_extra = 0;
         cpu->icount_budget = 0;
 
diff --git a/qom/cpu.c b/qom/cpu.c
index 3c5493c96c..6b4632abda 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -115,7 +115,7 @@ void cpu_exit(CPUState *cpu)
     atomic_set(&cpu->exit_request, 1);
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     smp_wmb();
-    atomic_set(&cpu->icount_decr.u16.high, -1);
+    atomic_set(&cpu->icount_decr_ptr->u16.high, -1);
 }
 
 int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
@@ -264,7 +264,7 @@ static void cpu_common_reset(CPUState *cpu)
     cpu->mem_io_pc = 0;
     cpu->mem_io_vaddr = 0;
     cpu->icount_extra = 0;
-    atomic_set(&cpu->icount_decr.u32, 0);
+    atomic_set(&cpu->icount_decr_ptr->u32, 0);
     cpu->can_do_io = 1;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
-- 
2.17.1


