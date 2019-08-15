Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6143BC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC282084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt6yOYhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC282084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5sZ-0000IP-Cn
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5MR-0000cg-M7
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5MQ-0001ct-4r
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:31 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:43950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hy5MQ-0001cW-0s
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:30 -0400
Received: by mail-qt1-x842.google.com with SMTP id b11so896310qtp.10
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J+5X1vqIJ+CD8k9SeFSpb++0TRf0wiFY3wllBJkAPIA=;
 b=Zt6yOYhX/JUQTU0CZIygrs8nebTthCFg2PCVCrQXGP9dB4E6ewDN+MhPefNB2iczO+
 VW04FHGkHkiHh/3sZk0wFjXHjSsESmdCLRfebhyg/KoU/l7afMXX7JWZC79xk7Mun7qi
 1ZD2DS9xUh5YhSpgVFzwqj4I/4yymA0xPWrlH/rC1Vlm+2yy+kbs8B5rxcnXH5c6p//l
 2Ceiu9vHt/kTl4kjlZVv49nSuaDt88CyviXzTE7VDvhykC1bAteS1hydRDszUQu47qgB
 /pnbbt3h6Vi/vJZKRMr3PP2HTXTbGnjAI+3Kmn4v3P6Q8zRN27a3en3/JVnBw7U59n78
 0M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J+5X1vqIJ+CD8k9SeFSpb++0TRf0wiFY3wllBJkAPIA=;
 b=s3/6oqJ77OogV77TC8rPahvs6qpRBmXAfW08sTGasCiv0+j7aWunhtTqf045MgyElM
 c/b0e7hbkz46fbAcYmKmGkhrbqT2/dnwzoo2m7G5v0/+nRtmkg5T6mmcJwDKH90HNYGj
 OQUn02rOJrE+uWK8wMsGi4T9txNdRhyrQpZuJyol7cnvg5d7Lj2WVHQ/i5Tq15xVtd1c
 NXe4sOzQKQu+4HybSjxixV9wEdCt+RqY7xa0YosNUqXqSz3A5a0ckRnt/LPge42jAPnr
 PB1lNW9Btopi0v9bx5lLyNcnyAsb/rV1Ld7qeY/V2AcGk37ncOFTYY4oCzk06m7lQ4kr
 rkKw==
X-Gm-Message-State: APjAAAWFEMfw1zuBwBHDA1ypXgZQBhlqrA3RGiYn3dl1OFUFXWWXzOkk
 SMD1UQOGamJtHISQoRt5TLw+wk8K70Y=
X-Google-Smtp-Source: APXvYqww0qGRNdCUI99I5TpSjb8KaWtrtTPDaEOCm8iC+0LstSU6t/Fp7mq5P95zdAZIaBWtIt1AgQ==
X-Received: by 2002:ac8:5354:: with SMTP id d20mr1996415qto.119.1565835569197; 
 Wed, 14 Aug 2019 19:19:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:121::1])
 by smtp.googlemail.com with ESMTPSA id o5sm757943qkf.10.2019.08.14.19.19.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:19:28 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:18:49 -0300
Message-Id: <20190815021857.19526-3-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815021857.19526-1-vandersonmr2@gmail.com>
References: <20190815021857.19526-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH v5 02/10] accel: collecting TB execution count
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
enabled, then we instrument the start code of this TB
to atomically count the number of times it is executed.
We count both the number of "normal" executions and atomic
executions of a TB.

The execution count of the TB is stored in its respective
TBS.

All TBStatistics are created by default with the flags from
default_tbstats_flag.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/cpu-exec.c      |  4 ++++
 accel/tcg/tb-stats.c      |  5 +++++
 accel/tcg/tcg-runtime.c   |  7 +++++++
 accel/tcg/tcg-runtime.h   |  2 ++
 accel/tcg/translate-all.c |  7 +++++++
 accel/tcg/translator.c    |  1 +
 include/exec/gen-icount.h |  9 +++++++++
 include/exec/tb-stats.h   | 19 +++++++++++++++++++
 util/log.c                |  1 +
 9 files changed, 55 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6c85c3ee1e..e54be69499 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -252,6 +252,10 @@ void cpu_exec_step_atomic(CPUState *cpu)
 
         start_exclusive();
 
+        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+            tb->tb_stats->executions.atomic++;
+        }
+
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus = false;
         in_exclusive_region = true;
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 02844717cb..3489133e9e 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -37,3 +37,8 @@ bool tb_stats_collection_paused(void)
 {
     return tcg_collect_tb_stats == TB_STATS_PAUSED;
 }
+
+uint32_t get_default_tbstats_flag(void)
+{
+    return default_tbstats_flag;
+}
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 8a1e408e31..6f4aafba11 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+void HELPER(inc_exec_freq)(void *ptr)
+{
+    TBStatistics *stats = (TBStatistics *) ptr;
+    g_assert(stats);
+    atomic_inc(&stats->executions.normal);
+}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 4fa61b49b4..bf0b75dbe8 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
+DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
+
 #ifdef CONFIG_SOFTMMU
 
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b7bccacd3b..df08d183df 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1785,6 +1785,13 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      */
     if (tb_stats_collection_enabled()) {
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags, tb);
+        uint32_t flag = get_default_tbstats_flag();
+
+        if (qemu_log_in_addr_range(tb->pc)) {
+            if (flag & TB_EXEC_STATS) {
+                tb->tb_stats->stats_enabled |= TB_EXEC_STATS;
+            }
+        }
     } else {
         tb->tb_stats = NULL;
     }
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a348a3..396a11e828 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -46,6 +46,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
+    gen_tb_exec_count(tb);
 
     /* Reset the temp count so that we can identify leaks */
     tcg_clear_temp_count();
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index f7669b6841..b3efe41894 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -7,6 +7,15 @@
 
 static TCGOp *icount_start_insn;
 
+static inline void gen_tb_exec_count(TranslationBlock *tb)
+{
+    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+        TCGv_ptr ptr = tcg_const_ptr(tb->tb_stats);
+        gen_helper_inc_exec_freq(ptr);
+        tcg_temp_free_ptr(ptr);
+    }
+}
+
 static inline void gen_tb_start(TranslationBlock *tb)
 {
     TCGv_i32 count, imm;
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index cc8f8a6ce6..0265050b79 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -6,6 +6,9 @@
 #include "exec/tb-context.h"
 #include "tcg.h"
 
+#define tb_stats_enabled(tb, JIT_STATS) \
+    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
+
 typedef struct TBStatistics TBStatistics;
 
 /*
@@ -22,6 +25,15 @@ struct TBStatistics {
     uint32_t     flags;
     /* cs_base isn't included in the hash but we do check for matches */
     target_ulong cs_base;
+
+    uint32_t stats_enabled;
+
+    /* Execution stats */
+    struct {
+        unsigned long normal;
+        unsigned long atomic;
+    } executions;
+
     /* current TB linked to this TBStatistics */
     TranslationBlock *tb;
 };
@@ -32,7 +44,12 @@ void init_tb_stats_htable_if_not(void);
 
 /* TBStatistic collection controls */
 enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED };
+
+#define TB_NOTHING    0
+#define TB_EXEC_STATS 1
+
 extern int tcg_collect_tb_stats;
+extern uint32_t default_tbstats_flag;
 
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
@@ -40,4 +57,6 @@ void pause_collect_tb_stats(void);
 bool tb_stats_collection_enabled(void);
 bool tb_stats_collection_paused(void);
 
+uint32_t get_default_tbstats_flag(void);
+
 #endif
diff --git a/util/log.c b/util/log.c
index 393a17115b..29021a4584 100644
--- a/util/log.c
+++ b/util/log.c
@@ -32,6 +32,7 @@ static int log_append = 0;
 static GArray *debug_regions;
 
 int tcg_collect_tb_stats;
+uint32_t default_tbstats_flag;
 
 /* Return the number of characters emitted.  */
 int qemu_log(const char *fmt, ...)
-- 
2.22.0


