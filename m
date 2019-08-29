Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61585C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E90E21726
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxBqCkmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E90E21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3OPL-0001jq-KM
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OK9-0004gf-Ik
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OK8-00007F-2G
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:05 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3OK7-000075-UD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:03 -0400
Received: by mail-qt1-x842.google.com with SMTP id i4so4578620qtj.8
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xXZZccE5Eb2rPf5eFiRo/1jo8tL6rXWAvLjqjdijulg=;
 b=rxBqCkmf6tuyppgy0ALszCELOQnJoF1cbbk9ODWfMWLJTLshc/GYS2CJNeoT5djYmM
 OE1v1PIT/OcMU9CKBjHN1cgkZ4g2LUr7yXQDh+ZGbKBX5uYiBCN6yOaX2m5cJpzmSDZt
 HvbdfzMsQCe+eeJTB4WqYuGSmIpD3qv0s9dDaixC8rv/KYE8wP4ojnfl1goPSqhNuLIf
 Yui9OJCeObuBp6ZC5uA24ibynYOCFPo4i8DUwJAZoaTePoeRyZqFM2uvlJXqHHqjMS1L
 32mHwU3idJSTcXGXcBe7p/Y80yDJjdRGSDKwhtzZUfmmBnzcvno6rjsAfoDr7c7VnCTC
 musQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xXZZccE5Eb2rPf5eFiRo/1jo8tL6rXWAvLjqjdijulg=;
 b=n0wO8dvHywaUeYnOBnU8ujkasdWOcPJ9eAhBBOArHAvfjlVLPcmRXywq7pVmp/mLaM
 89YfP1OdgwSo2+5tA6IfwLQB+Jp+ETW0nsnAB+o5SyOYBtyc0mxZ1ieWEl9e/Kjb5k+a
 0DfxYu4OlkOoJh5M/9NyKVdS63r5bgXpZ+vlDZ4C0k+3ZcaYy+UbmPiRxlaz9+bjaJIB
 ibuuEB0+sQx68Xxiwxy9Bv68Mhd3OaCkYbRoGxUnqsA/JdzmHk3rEdZczgapHPp98clM
 3YspL1HNMvgfBU7zrJEYbAtfzXAnnvYIJB/U/72x+ym5z6b2SKRyoW1l7tk5QiLbg/6b
 w7zw==
X-Gm-Message-State: APjAAAWxGeyoeZLg+hygLpLg5AaVy0YM/bsxhFiX7zgE4syc+ttt40PE
 uvmn6/PG/hcBVJXVTi1izyhsI0AZ6iiz0Q==
X-Google-Smtp-Source: APXvYqwmKKnJq8xy0O15y+JnYWAonKlXHzj5IxNKHzWk2wqesgi3iW9rKQhT0ktbwIl+ZqqrXqGYlw==
X-Received: by 2002:a0c:eb92:: with SMTP id x18mr7466505qvo.39.1567100103145; 
 Thu, 29 Aug 2019 10:35:03 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id j50sm1721700qtj.30.2019.08.29.10.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 10:35:02 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 14:34:28 -0300
Message-Id: <20190829173437.5926-3-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829173437.5926-1-vandersonmr2@gmail.com>
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH v8 02/11] accel: collecting TB execution count
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
index 48272c781b..9b2b7bff80 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -251,6 +251,10 @@ void cpu_exec_step_atomic(CPUState *cpu)
 
         start_exclusive();
 
+        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+            tb->tb_stats->executions.atomic++;
+        }
+
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus = false;
         in_exclusive_region = true;
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 948b107e68..1db81d83e7 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -61,3 +61,8 @@ bool tb_stats_collection_paused(void)
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
index b7bccacd3b..e72aeba682 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1785,6 +1785,13 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      */
     if (tb_stats_collection_enabled()) {
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags, tb);
+
+        if (qemu_log_in_addr_range(tb->pc)) {
+            uint32_t flag = get_default_tbstats_flag();
+            if (flag & TB_EXEC_STATS) {
+                tb->tb_stats->stats_enabled |= TB_EXEC_STATS;
+            }
+        }
     } else {
         tb->tb_stats = NULL;
     }
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 70c66c538c..ec6bd829a0 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -46,6 +46,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
+    gen_tb_exec_count(tb);
 
     /* Reset the temp count so that we can identify leaks */
     tcg_clear_temp_count();
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 822c43cfd3..be006383b9 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -32,6 +32,15 @@ static inline void gen_io_end(void)
     tcg_temp_free_i32(tmp);
 }
 
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
index 898e05a36f..c4a8715400 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -30,6 +30,9 @@
 #include "exec/tb-context.h"
 #include "tcg.h"
 
+#define tb_stats_enabled(tb, JIT_STATS) \
+    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
+
 typedef struct TBStatistics TBStatistics;
 
 /*
@@ -46,6 +49,15 @@ struct TBStatistics {
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
@@ -56,7 +68,12 @@ void init_tb_stats_htable_if_not(void);
 
 /* TBStatistic collection controls */
 enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED };
+
+#define TB_NOTHING    (1 << 0)
+#define TB_EXEC_STATS (1 << 1)
+
 extern int tcg_collect_tb_stats;
+extern uint32_t default_tbstats_flag;
 
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
@@ -64,4 +81,6 @@ void pause_collect_tb_stats(void);
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


