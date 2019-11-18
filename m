Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5514F22310
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYt2XMi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5514F22310
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWoPW-00028J-TF
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iWoNF-00009M-0U
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iWoNB-0005mT-2v
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:52 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iWoNA-0005m5-QL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:49 -0500
Received: by mail-pg1-x543.google.com with SMTP id 15so10224440pgh.5
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 13:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SzYBwosOH0RhXIU2AZPKvHTHuDB70z5449ITz+BvFqY=;
 b=TYt2XMi39KGb9A/5y0IUf+0NOS3PcVzcI4LafzRJc+SRKDh9yJxVYbPBBk0B07xhzy
 dNoAZ0bU/D16OZe8ajRIpB9aRMkxgyiq9DeE4Jaj3nhP2XXMznvfb0yPiEWkUX1ec3Up
 U1had5lYWIT1uIUrnq9IOPQIFI9LBRAir6QvOyz4eGUHuu2rYpwCxV7AwgMDgv/T9wHv
 cntPHC3mNnOLGl/RHiamodpdskqdL5PF/dD2bVevZpDSddW+90RIzu56nUpNDsmF3yfR
 7TWYmXfLiWcafi6Fu0sj9xTQh3QkxUcgThsiAISWyukgcH69xztUH5AIKbDwsTBi+C9K
 L4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SzYBwosOH0RhXIU2AZPKvHTHuDB70z5449ITz+BvFqY=;
 b=ds8q6HLxwQu+acIB+/O0/C6WXymbVbXpDH9wFiWAsw6KqRYzWmABhI+Uqafm4bYeR/
 Urd/nhzrCL9iRFW/qxdB9xtJiUQOcMA8keXNYUz5sWT9o8fTICG3GAN7EWFhKR3+J0at
 w1glfc8v1NRSahTxpMiRGzUm7MoqjkDpVweH9ZYTbb8seBQF1umeqfU8N96YN4T0lOjJ
 BjZ8kNqN/E4mQoks8Hvurcd2vnl0219rjMNrU8CXJ22HtUJcoIqmnh4oMv20zTZl47oh
 ui2EyAGvv4F4oT001Wrtm60ZPaM9PZOPrZeCUkg9X4PfZOGXclcZzWwM/XHcQwevY6CD
 qlYg==
X-Gm-Message-State: APjAAAWbe9CSJh5z6DX5J4AuxZAR7q2me9O4LguKLc1wJ8V30AxbmfSR
 0F5zTb3LfPyv6r2n/h7lg97hhWH39wk=
X-Google-Smtp-Source: APXvYqx/N4gJKzxkpwDxV3dqjyt6+727cKOOJtqLaeInRJH9YOEeMDVpX25Jnkp0LZoOCpzwP8drGg==
X-Received: by 2002:a63:3741:: with SMTP id g1mr1491684pgn.434.1574111747293; 
 Mon, 18 Nov 2019 13:15:47 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id v15sm22301728pfe.44.2019.11.18.13.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 13:15:46 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/6] qemu_log_lock/unlock now preserves the qemu_logfile
 handle.
Date: Mon, 18 Nov 2019 16:15:26 -0500
Message-Id: <20191118211528.3221-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118211528.3221-1-robert.foley@linaro.org>
References: <20191118211528.3221-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_log_lock() now returns a handle and qemu_log_unlock() receives a
handle to unlock.  This allows for changing the handle during logging
and ensures the lock() and unlock() are for the same file.

Also in target/tilegx/translate.c removed the qemu_log_lock()/unlock()
calls (and the log("\n")), since the translator can longjmp out of the
loop if it attempts to translate an instruction in an inaccessible page.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
    - Changes to one use case to remove use of qemu_log_lock()/unlock().
      Only change was target/tilegx/translate.c
---
v1
    - Moved this up in the patch sequence to be
      before adding RCU for qemu_logfile.
---
 include/qemu/log.h            |  9 ++++++---
 target/tilegx/translate.c     |  6 ------
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
 target/unicore32/translate.c  |  4 ++--
 tcg/tcg.c                     | 16 ++++++++--------
 15 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index a91105b2ad..a7c5b01571 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -53,14 +53,17 @@ static inline bool qemu_log_separate(void)
  * qemu_loglevel is never set when qemu_logfile is unset.
  */
 
-static inline void qemu_log_lock(void)
+static inline FILE *qemu_log_lock(void)
 {
     qemu_flockfile(qemu_logfile);
+    return logfile->fd;
 }
 
-static inline void qemu_log_unlock(void)
+static inline void qemu_log_unlock(FILE *fd)
 {
-    qemu_funlockfile(qemu_logfile);
+    if (fd) {
+        qemu_funlockfile(fd);
+    }
 }
 
 /* Logging functions: */
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index 68dd4aa2d8..abce7e1c75 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2388,7 +2388,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     dc->zero = NULL;
 
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
-        qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
     }
     gen_tb_start(tb);
@@ -2417,11 +2416,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     gen_tb_end(tb, num_insns);
     tb->size = dc->pc - pc_start;
     tb->icount = num_insns;
-
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
 }
 
 void restore_state_to_opc(CPUTLGState *env, TranslationBlock *tb,
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
index bdc7d5326a..525115b041 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1765,10 +1765,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
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
index 5475d49ed1..0511266d85 100644
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
 
@@ -4041,11 +4041,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
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
 
@@ -4086,11 +4086,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
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
@@ -4107,11 +4107,11 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
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


