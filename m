Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EDCC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B326E20640
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrM7tQa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B326E20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHV5f-0001dC-8p
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwI-0002X4-1k
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwG-00058q-2u
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwF-00057f-Rk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id y19so15859060wrd.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZX61NvfE8BqogvWy9OM6m8VYaWtIBDMGNRtv9Ph9gpM=;
 b=rrM7tQa0mFN3QELZQjQIJXyvQi9A3nSFZmwCOVV4sas5/kauY9RdwG6BN4zPPY9P0O
 N2JYAHZOJJPJIdtWIHEKf5hFmDmiqPSFHiwZCVx1Zr+hSHFKLrdSE1m7RgzWuvCtdvo8
 J9is4NSMGayOInsWMuSZoaEaZuKW8PaFjt/qaKPsXJClxYXWpzWtWeB5d7KbXGAchtNr
 9/T/kFkZNqUdEifaC1Algu4wmukZ8Raz/8IcbZByIAm2C/Oh/oK1cp4ttRiVuw81LeJz
 KJ5Q0vpoFDGufr6TcCaY9efUUkduh8PZsgo7+m4HMNbGaGK6jZlvnKvHI8+mGfNG2PvR
 nBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZX61NvfE8BqogvWy9OM6m8VYaWtIBDMGNRtv9Ph9gpM=;
 b=elaRpRp7Z1aMCf07f2INbl8BL1nu8f8ETWJ0hW0/G+vyHLy1/jWZpfwF80lKPsW46n
 7V5ccKBsT7MLxZ9wCoJL352Ynyy7RLL1wPGDrLHgs5SKsXPp4OKn8XwyPHbjsp/uOxrE
 vHHaGqQeefcv+pARHcsWEYMikZwMmOV77kC8R6/hWUgb3tHq9lNlkV5crscGbEevNr9a
 DV9yuEb+VgNMQzVed/J6HTM9dxhF5A9/shes5sr9dql5gzhr6wef8zhYGr7Zikz8eFnS
 K8AcYXcLukIMORT2budiFFHy+xJcW+pYUOi9pROMbkq2AiA1/eQAz9NZh4YZ8e/7qiqr
 Ntvw==
X-Gm-Message-State: APjAAAWUoArulBqdxOM98MqDSEAcIJwvuG3VvDc9M1xsg5SCbL3uWKya
 t+knRoxeJRdroOn95uRudclMTA==
X-Google-Smtp-Source: APXvYqxfrpdAh6cQL9BfqbMRdP/legsmBckQ4HAaZWiH6uHQpcaCn8nsPqS9aFoN+4t7ILBxF0hecw==
X-Received: by 2002:a5d:664b:: with SMTP id f11mr23865013wrw.285.1570462122573; 
 Mon, 07 Oct 2019 08:28:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a10sm16739122wrm.52.2019.10.07.08.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7F6ED1FF90;
 Mon,  7 Oct 2019 16:28:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v9 03/13] accel: collecting JIT statistics
Date: Mon,  7 Oct 2019 16:28:29 +0100
Message-Id: <20191007152839.30804-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

If a TB has a TBS (TBStatistics) with the TB_JIT_STATS enabled then we
collect statistics of its translation processes and code translation.

To help with collection we include the TCGProfile structure
unconditionally. It will have further alterations in future commits.

Collecting the number of host instructions seems to be not simple as
it would imply in having to modify several target source files. So,
for now, we are only collecting the size of the host gen code.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-4-vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
AJB:
  - replace tb tracking with proper array.
  - stash tcg counts in tcg_ctx.prof until we can update later
  - update jit stats under a lock instead of lots of atomics
  - don't re-count nb_ops
---
 accel/tcg/translate-all.c | 35 ++++++++++++++++++++++++++++++++++-
 accel/tcg/translator.c    |  3 +++
 include/exec/tb-stats.h   | 23 +++++++++++++++++++++++
 tcg/tcg.c                 |  9 +++++++--
 tcg/tcg.h                 | 23 +++++++++++++++++++++--
 5 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b7dd1a78e5..6fa9850a3a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1690,10 +1690,13 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
     TBStatistics *new_stats = g_new0(TBStatistics, 1);
     uint32_t hash = tb_stats_hash_func(phys_pc, pc, flags);
     void *existing_stats = NULL;
+
     new_stats->phys_pc = phys_pc;
     new_stats->pc = pc;
     new_stats->cs_base = cs_base;
     new_stats->flags = flags;
+    new_stats->tbs = g_ptr_array_sized_new(4);
+    qemu_mutex_init(&new_stats->jit_stats_lock);
 
     /*
      * All initialisation must be complete before we insert into qht
@@ -1707,6 +1710,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
          * If there is already a TBStatistic for this TB from a previous flush
          * then just make the new TB point to the older TBStatistic
          */
+        g_ptr_array_free(new_stats->tbs, true);
         g_free(new_stats);
         return existing_stats;
     } else {
@@ -1726,8 +1730,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     target_ulong virt_page2;
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
-#ifdef CONFIG_PROFILER
     TCGProfile *prof = &tcg_ctx->prof;
+#ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
     assert_memory_lock();
@@ -1795,6 +1799,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         if (flag & TB_EXEC_STATS) {
             tb->tb_stats->stats_enabled |= TB_EXEC_STATS;
         }
+
+        if (flag & TB_JIT_STATS) {
+            tb->tb_stats->stats_enabled |= TB_JIT_STATS;
+        }
     } else {
         tb->tb_stats = NULL;
     }
@@ -1930,6 +1938,31 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if ((pc & TARGET_PAGE_MASK) != virt_page2) {
         phys_page2 = get_page_addr_code(env, virt_page2);
     }
+
+    /*
+     * Collect JIT stats when enabled. We batch them all up here to
+     * avoid spamming the cache with atomic accesses
+     */
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        TBStatistics *ts = tb->tb_stats;
+        qemu_mutex_lock(&ts->jit_stats_lock);
+
+        ts->code.num_guest_inst += prof->translation.nb_guest_insns;
+        ts->code.num_tcg_ops += prof->translation.nb_ops_pre_opt;
+        ts->code.num_tcg_ops_opt += tcg_ctx->nb_ops;
+        ts->code.spills += prof->translation.nb_spills;
+        ts->code.out_len += tb->tc.size;
+
+        ts->translations.total++;
+        if (phys_page2 != -1) {
+            ts->translations.spanning++;
+        }
+
+        g_ptr_array_add(ts->tbs, tb);
+
+        qemu_mutex_unlock(&ts->jit_stats_lock);
+    }
+
     /*
      * No explicit memory barrier is required -- tb_link_page() makes the
      * TB visible in a consistent state.
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ec6bd829a0..114e76db27 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -116,6 +116,9 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     db->tb->size = db->pc_next - db->pc_first;
     db->tb->icount = db->num_insns;
 
+    /* Save number of guest instructions for TB_JIT_STATS */
+    tcg_ctx->prof.translation.nb_guest_insns = db->num_insns;
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 51aecf65e2..566ae0d2be 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -59,6 +59,28 @@ struct TBStatistics {
         unsigned long atomic;
     } executions;
 
+    /* JIT Stats - protected by lock */
+    QemuMutex jit_stats_lock;
+
+    struct {
+        unsigned num_guest_inst;
+        unsigned num_tcg_ops;
+        unsigned num_tcg_ops_opt;
+        unsigned spills;
+        unsigned out_len;
+    } code;
+
+    struct {
+        unsigned long total;
+        unsigned long uncached;
+        unsigned long spanning;
+    } translations;
+
+    /*
+     * All persistent (cached) TranslationBlocks using
+     * this TBStats structure. Has to be reset on a tb_flush.
+     */
+    GPtrArray *tbs;
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
@@ -67,6 +89,7 @@ void init_tb_stats_htable_if_not(void);
 
 #define TB_NOTHING    (1 << 0)
 #define TB_EXEC_STATS (1 << 1)
+#define TB_JIT_STATS  (1 << 2)
 
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 16b2d0e0ec..fa2fef9f1a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1117,6 +1117,7 @@ void tcg_func_start(TCGContext *s)
     s->nb_labels = 0;
     s->current_frame_offset = s->frame_start;
 
+    s->prof.translation.nb_spills = 0;
 #ifdef CONFIG_DEBUG_TCG
     s->goto_tb_issue_mask = 0;
 #endif
@@ -3125,6 +3126,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
         case TEMP_VAL_REG:
             tcg_out_st(s, ts->type, ts->reg,
                        ts->mem_base->reg, ts->mem_offset);
+            s->prof.translation.nb_spills++;
             break;
 
         case TEMP_VAL_MEM:
@@ -3990,12 +3992,12 @@ int64_t tcg_cpu_exec_time(void)
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 {
-#ifdef CONFIG_PROFILER
     TCGProfile *prof = &s->prof;
-#endif
     int i, num_insns;
     TCGOp *op;
 
+    s->current_tb = tb;
+
 #ifdef CONFIG_PROFILER
     {
         int n = 0;
@@ -4027,6 +4029,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 
+    /* save pre-optimisation op count */
+    prof->translation.nb_ops_pre_opt = s->nb_ops;
+
 #ifdef CONFIG_DEBUG_TCG
     /* Ensure all labels referenced have been emitted.  */
     {
diff --git a/tcg/tcg.h b/tcg/tcg.h
index a37181c899..31571289cf 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -555,7 +555,26 @@ typedef struct TCGOp {
 /* Make sure operands fit in the bitfields above.  */
 QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
 
+/*
+ * The TCGProfile structure holds data for analysing the quality of
+ * the code generation. The data is split between stuff that is valid
+ * for the lifetime of a single translation and things that are valid
+ * for the lifetime of the translator. As the former is reset for each
+ * new translation so it should be copied elsewhere if you want to
+ * keep it.
+ *
+ * The structure is safe to access within the context of translation
+ * but accessing the data from elsewhere should be done with safe
+ * work.
+ */
 typedef struct TCGProfile {
+
+    struct {
+        int nb_guest_insns;
+        int nb_spills;
+        int nb_ops_pre_opt;
+    } translation;
+
     int64_t cpu_exec_time;
     int64_t tb_count1;
     int64_t tb_count;
@@ -600,9 +619,7 @@ struct TCGContext {
 
     tcg_insn_unit *code_ptr;
 
-#ifdef CONFIG_PROFILER
     TCGProfile prof;
-#endif
 
 #ifdef CONFIG_DEBUG_TCG
     int temps_in_use;
@@ -651,6 +668,8 @@ struct TCGContext {
 
     uint16_t gen_insn_end_off[TCG_MAX_INSNS];
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
+
+    TranslationBlock *current_tb;
 };
 
 extern TCGContext tcg_init_ctx;
-- 
2.20.1


