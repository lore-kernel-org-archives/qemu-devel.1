Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9C1C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94CD207FA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovpSp5Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94CD207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSim4-000588-Ht
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iSikD-0003MP-Tn
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iSikC-0006oo-17
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:41 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iSikB-0006oB-PC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:39 -0500
Received: by mail-pl1-x641.google.com with SMTP id s10so1592272plp.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lIi54vr/HziQ7SiW+njRL+MHz75T7cGRSD/KXgMu79Q=;
 b=ovpSp5Pkv1JqUJsIzwnUIWpIQePLGWfHqdt9lzF630v/aGpHrwQAvBPk/mGvJtaPvq
 gcsVzhDQ1JGqTzW8ZQll4rpU5iGwlxroWXA7Pu0Ft+TZOc3kb1kyi4c3kUO8vCqyQi8Y
 B4lXXtT+4ta4tPrgN8d4n678qJQ0/lPY03V1xdM84caKD54zEIxnnXkfE0uDKRQJUG2P
 PSWiNVLFLg2xP4MZITpPY/IiK6z7UNnC8fcEV2lzwEi5SFWARj/ImGJYZgFF377VJK7c
 pVSddCyrxf0cCNTaDTChjxGUA2rwoBHS1Db+4MyB5cUAG1/4Tiz6j8dL3rfpaeYRP1bY
 pSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lIi54vr/HziQ7SiW+njRL+MHz75T7cGRSD/KXgMu79Q=;
 b=DwzArokrygbWnMIT7MoGqCEh4xYlRh7BmJ2J4qoIBXIP3LHlzAhbN+jkqExhbJ1AcT
 sQ1jjHuQCy6qssCWcD/iqKiSVdvTdGPH8Cpf0ar9kTmj3mOQwWoqmVoOajEL8P+G09c9
 hXJ4y2WkdcCRgJMTLmlcdMVqmBDIbtsPbCvdnh9fJA0J6Skc98j8xLq5PG77QSqgGkxE
 VJIrYe7RHhtFSfYOSuGUG2QP1RcggTvZzgpoApiibW3zTeeJ5ScG1oGFREhpO06neHpT
 nNrNPzZxJzici9nHtA62VvdAcSrzzgdgT01oBnCtSCcfDhwuqaEC0BzPxIQaV2koi6DX
 Fr9g==
X-Gm-Message-State: APjAAAUtk4RKBJQqX2XaRSZlebOWHaEWDyWYImjXF9U6nDj0kVH0p+CG
 OqGK+LhBbj1iZXClvPfoC3r1pOAi5XQ=
X-Google-Smtp-Source: APXvYqysgQpkl4jydo5FFHCLaQB6BzgnQTxVQVyUgSPzh6XulkvhaUlfKimjyV9VmFhWtnKVvJ1MWw==
X-Received: by 2002:a17:90a:2ec3:: with SMTP id
 h3mr5535811pjs.131.1573136798387; 
 Thu, 07 Nov 2019 06:26:38 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id f8sm3375502pgd.64.2019.11.07.06.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 06:26:37 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] qemu_log_lock/unlock now preserves the qemu_logfile
 handle.
Date: Thu,  7 Nov 2019 09:26:12 -0500
Message-Id: <20191107142613.2379-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107142613.2379-1-robert.foley@linaro.org>
References: <20191107142613.2379-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_log_lock() now returns a handle and qemu_log_unlock() receives a
handle to unlock.  This allows for changing the handle during logging
and ensures the lock() and unlock() are for the same file.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/qemu/log.h            | 14 +++++++-------
 accel/tcg/cpu-exec.c          |  4 ++--
 accel/tcg/translate-all.c     |  4 ++--
 accel/tcg/translator.c        |  4 ++--
 exec.c                        |  4 ++--
 hw/net/can/can_sja1000.c      |  4 ++--
 net/can/can_socketcan.c       |  5 ++---
 target/cris/translate.c       |  4 ++--
 target/i386/translate.c       |  5 +++--
 target/lm32/translate.c       |  4 ++--
 target/microblaze/translate.c |  4 ++--
 target/nios2/translate.c      |  4 ++--
 target/tilegx/translate.c     |  7 ++++---
 target/unicore32/translate.c  |  4 ++--
 tcg/tcg.c                     | 16 ++++++++--------
 15 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index 975de18e23..3d0f47a479 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -71,25 +71,25 @@ static inline bool qemu_log_separate(void)
  * qemu_loglevel is never set when qemu_logfile is unset.
  */
 
-static inline void qemu_log_lock(void)
+static inline FILE *qemu_log_lock(void)
 {
     QemuLogFile *logfile;
     rcu_read_lock();
     logfile = atomic_rcu_read(&qemu_logfile);
     if (logfile) {
         qemu_flockfile(logfile->fd);
+        return logfile->fd;
     }
     rcu_read_unlock();
+    return NULL;
 }
 
-static inline void qemu_log_unlock(void)
+static inline void qemu_log_unlock(FILE *fd)
 {
-    QemuLogFile *logfile;
-    logfile = atomic_rcu_read(&qemu_logfile);
-    if (logfile) {
-        qemu_funlockfile(logfile->fd);
+    if (fd) {
+        qemu_funlockfile(fd);
+        rcu_read_unlock();
     }
-    rcu_read_unlock();
 }
 
 /* Logging functions: */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c01f59c743..62068d10c3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -156,7 +156,7 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
 #if defined(DEBUG_DISAS)
     if (qemu_loglevel_mask(CPU_LOG_TB_CPU)
         && qemu_log_in_addr_range(itb->pc)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         int flags = 0;
         if (qemu_loglevel_mask(CPU_LOG_TB_FPU)) {
             flags |= CPU_DUMP_FPU;
@@ -165,7 +165,7 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
         flags |= CPU_DUMP_CCOP;
 #endif
         log_cpu_state(cpu, flags);
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif /* DEBUG_DISAS */
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9f48da9472..bb325a2bc4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1804,7 +1804,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("OUT: [size=%d]\n", gen_code_size);
         if (tcg_ctx->data_gen_ptr) {
             size_t code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
@@ -1829,7 +1829,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         }
         qemu_log("\n");
         qemu_log_flush();
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index f977682be7..603d17ff83 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -138,11 +138,11 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("----------------\n");
         ops->disas_log(db, cpu);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 }
diff --git a/exec.c b/exec.c
index ffdb518535..c994a00f10 100644
--- a/exec.c
+++ b/exec.c
@@ -1223,13 +1223,13 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
     fprintf(stderr, "\n");
     cpu_dump_state(cpu, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
     if (qemu_log_separate()) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("qemu: fatal: ");
         qemu_log_vprintf(fmt, ap2);
         qemu_log("\n");
         log_cpu_state(cpu, CPU_DUMP_FPU | CPU_DUMP_CCOP);
         qemu_log_flush();
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
         qemu_log_close();
     }
     va_end(ap2);
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 1f81341554..39c78faf9b 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -247,8 +247,8 @@ int can_sja_accept_filter(CanSJA1000State *s,
 static void can_display_msg(const char *prefix, const qemu_can_frame *msg)
 {
     int i;
+    FILE *logfile = qemu_log_lock();
 
-    qemu_log_lock();
     qemu_log("%s%03X [%01d] %s %s",
              prefix,
              msg->can_id & QEMU_CAN_EFF_MASK,
@@ -261,7 +261,7 @@ static void can_display_msg(const char *prefix, const qemu_can_frame *msg)
     }
     qemu_log("\n");
     qemu_log_flush();
-    qemu_log_unlock();
+    qemu_log_unlock(logfile);
 }
 
 static void buff2frame_pel(const uint8_t *buff, qemu_can_frame *frame)
diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 8a6ffad40c..29bfacd4f8 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -76,8 +76,7 @@ QEMU_BUILD_BUG_ON(offsetof(qemu_can_frame, data)
 static void can_host_socketcan_display_msg(struct qemu_can_frame *msg)
 {
     int i;
-
-    qemu_log_lock();
+    FILE *logfile = qemu_log_lock();
     qemu_log("[cansocketcan]: %03X [%01d] %s %s",
              msg->can_id & QEMU_CAN_EFF_MASK,
              msg->can_dlc,
@@ -89,7 +88,7 @@ static void can_host_socketcan_display_msg(struct qemu_can_frame *msg)
     }
     qemu_log("\n");
     qemu_log_flush();
-    qemu_log_unlock();
+    qemu_log_unlock(logfile);
 }
 
 static void can_host_socketcan_read(void *opaque)
diff --git a/target/cris/translate.c b/target/cris/translate.c
index e752bd0609..cb57516a44 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3273,11 +3273,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 #if !DISAS_CRIS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("--------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
         log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 #endif
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 77e932d827..7c99ef1385 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2502,14 +2502,15 @@ static void gen_unknown_opcode(CPUX86State *env, DisasContext *s)
     gen_illegal_opcode(s);
 
     if (qemu_loglevel_mask(LOG_UNIMP)) {
+        FILE *logfile = qemu_log_lock();
         target_ulong pc = s->pc_start, end = s->pc;
-        qemu_log_lock();
+
         qemu_log("ILLOPC: " TARGET_FMT_lx ":", pc);
         for (; pc < end; ++pc) {
             qemu_log(" %02x", cpu_ldub_code(env, pc));
         }
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 }
 
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 778cae1e81..73db9654d6 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1137,10 +1137,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("\n");
         log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 761f535357..cc1ad15656 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1766,10 +1766,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 #if !SIM_COMPAT
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("--------------\n");
         log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 #endif
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e17656e66f..82107bf270 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -892,11 +892,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(tb->pc)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(tb->pc));
         log_target_disas(cs, tb->pc, dc->pc - tb->pc);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 }
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index 68dd4aa2d8..fd406f4f71 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2377,6 +2377,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     uint64_t pc_start = tb->pc;
     uint64_t page_start = pc_start & TARGET_PAGE_MASK;
     int num_insns = 0;
+    FILE *logfile = NULL;
 
     dc->pc = pc_start;
     dc->mmuidx = 0;
@@ -2388,7 +2389,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     dc->zero = NULL;
 
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
-        qemu_log_lock();
+        logfile = qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
     }
     gen_tb_start(tb);
@@ -2418,9 +2419,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     tb->size = dc->pc - pc_start;
     tb->icount = num_insns;
 
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
+    if (logfile) {
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 }
 
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 0e01f35856..0f6891b8aa 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1994,12 +1994,12 @@ done_generating:
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
         log_target_disas(cs, pc_start, dc->pc - pc_start);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
     tb->size = dc->pc - pc_start;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 220eaac7c7..4f616ba38b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1085,7 +1085,7 @@ void tcg_prologue_init(TCGContext *s)
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM)) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("PROLOGUE: [size=%zu]\n", prologue_size);
         if (s->data_gen_ptr) {
             size_t code_size = s->data_gen_ptr - buf0;
@@ -1110,7 +1110,7 @@ void tcg_prologue_init(TCGContext *s)
         }
         qemu_log("\n");
         qemu_log_flush();
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 
@@ -4049,11 +4049,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
                  && qemu_log_in_addr_range(tb->pc))) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("OP:\n");
         tcg_dump_ops(s, false);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 
@@ -4094,11 +4094,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef DEBUG_DISAS
         if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_IND)
                      && qemu_log_in_addr_range(tb->pc))) {
-            qemu_log_lock();
+            FILE *logfile = qemu_log_lock();
             qemu_log("OP before indirect lowering:\n");
             tcg_dump_ops(s, false);
             qemu_log("\n");
-            qemu_log_unlock();
+            qemu_log_unlock(logfile);
         }
 #endif
         /* Replace indirect temps with direct temps.  */
@@ -4115,11 +4115,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
                  && qemu_log_in_addr_range(tb->pc))) {
-        qemu_log_lock();
+        FILE *logfile = qemu_log_lock();
         qemu_log("OP after optimization and liveness analysis:\n");
         tcg_dump_ops(s, true);
         qemu_log("\n");
-        qemu_log_unlock();
+        qemu_log_unlock(logfile);
     }
 #endif
 
-- 
2.17.1


