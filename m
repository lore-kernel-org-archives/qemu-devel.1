Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40753ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF60920640
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGeKDGF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF60920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVB0-00064d-OV
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwL-0002bm-LQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwI-0005Ab-Ki
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwI-0005A1-7s
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id m18so12837900wmc.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gaR/h6vIzeFfWXFxJELxenHTc8qDjXB7qS1QURQMS9g=;
 b=zGeKDGF87oX94Q4F1Nvcjm9AQBpQAyxDHor9hKtjIClfKXLZ9WQOBCPOE0v/RQW5YU
 +f9USzEqwFqQooGAgnoTpSwyGctijxQEVfDgY7MxTp6p2wA5PmxYZQA6gGDQtVPePebb
 Cp1TWPA4LjEcco+b457SpSU3m/qzpx9LejVDui5nM7ukvqW3WTLddhIy5hUMJyJ6r/VY
 3AuX1WIz7aGMkRq8MBFzFm5/7TTj0C2F61gAwc7SXd6gr4NFn1XH7AunO4l8gJTxwqIr
 Zig5vWvNpLwkw9Ar5UZh8QCEW0UsmmYgixb1tG7b80up3cvGuSdEq+vcdbeUrKCUy0uq
 2mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gaR/h6vIzeFfWXFxJELxenHTc8qDjXB7qS1QURQMS9g=;
 b=md0uSpSTJdWbuH4eYz+80cIPM5USFTnMQ2B2JB0e4UmHCO2MnSrEQHCTBhiiVKEXtI
 V+zV6jRp/MnjawFrFiCisnc625BUbVhTxAwgFm04NPRzmE3qdmB9KpqBCPg/zAI1+kSl
 QDG7f234RDmlE0hvCMdRVc+UA7uR1m60UyCKc8/5gfJ7smfmuvhCBeogPiB8A3ZJ3ABY
 KzDxQJMSF2Iq2dYHry3SuSkOKDCHN8GMs09oVEdkKhndfBJCVTETvpUf46NFGupZK5vv
 O9/eeQ7jFDsb5QTHatgv0rS/C6B6gA7KnN5kGzB5Zg63WEgKpWpdDSw4e5SmYyOr0wxQ
 KYBQ==
X-Gm-Message-State: APjAAAXOD69rBX4hzDqGxzuFEfx0jU4SRV8AUtQ+rUUqkKE+hQg8xSNN
 unef8cOWNxtf3fdhF9YYCAvAvQ==
X-Google-Smtp-Source: APXvYqwVN70WupAJluwKHY8iZvUkmZmSrxe/Hvt/mNtJi+UEE4iniz0PCu2M4AJ8nnyKjsVrBfUZCA==
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr20292409wmc.94.1570462124857; 
 Mon, 07 Oct 2019 08:28:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a3sm14933460wmj.35.2019.10.07.08.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C0A841FF92;
 Mon,  7 Oct 2019 16:28:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 05/13] accel: adding TB_JIT_TIME and full replacing
 CONFIG_PROFILER
Date: Mon,  7 Oct 2019 16:28:31 +0100
Message-Id: <20191007152839.30804-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

Replace all others CONFIG_PROFILER statistics and migrate it to
TBStatistics system. However, TCGProfiler still exists and can
be use to store global statistics and times. All TB related
statistics goes to TBStatistics.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-6-vandersonmr2@gmail.com>
[AJB: fix authorship]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/tb-stats.c      |  98 +++++++++++++++++++++---------
 accel/tcg/translate-all.c |  46 ++++++++-------
 configure                 |   3 -
 cpus.c                    |  14 ++---
 include/exec/tb-stats.h   |  15 +++++
 include/qemu/timer.h      |   5 +-
 monitor/misc.c            |  28 ++-------
 tcg/tcg.c                 | 121 ++++++++++++--------------------------
 tcg/tcg.h                 |   2 +-
 vl.c                      |   8 +--
 10 files changed, 159 insertions(+), 181 deletions(-)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 0e64c176b3..f431159fd2 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -17,11 +17,18 @@
 #include "exec/tb-stats.h"
 
 /* TBStatistic collection controls */
-enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED };
+enum TBStatsStatus {
+    TB_STATS_DISABLED = 0,
+    TB_STATS_RUNNING,
+    TB_STATS_PAUSED,
+    TB_STATS_STOPPED
+};
 
 static enum TBStatsStatus tcg_collect_tb_stats;
 static uint32_t default_tbstats_flag;
 
+uint64_t dev_time;
+
 struct jit_profile_info {
     uint64_t translations;
     uint64_t aborted;
@@ -33,6 +40,13 @@ struct jit_profile_info {
     uint64_t host;
     uint64_t guest;
     uint64_t search_data;
+
+    uint64_t interm_time;
+    uint64_t code_time;
+    uint64_t restore_count;
+    uint64_t restore_time;
+    uint64_t opt_time;
+    uint64_t la_time;
 };
 
 /* accumulate the statistics from all TBs */
@@ -54,6 +68,29 @@ static void collect_jit_profile_info(void *p, uint32_t hash, void *userp)
     jpi->host += tbs->code.out_len;
     jpi->guest += tbs->code.in_len;
     jpi->search_data += tbs->code.search_out_len;
+
+    jpi->interm_time += stat_per_translation(tbs, time.interm);
+    jpi->code_time += stat_per_translation(tbs, time.code);
+    jpi->opt_time += stat_per_translation(tbs, time.opt);
+    jpi->la_time += stat_per_translation(tbs, time.la);
+    jpi->restore_time += tbs->time.restore;
+    jpi->restore_count += tbs->time.restore_count;
+}
+
+void dump_jit_exec_time_info(uint64_t dev_time)
+{
+    static uint64_t last_cpu_exec_time;
+    uint64_t cpu_exec_time;
+    uint64_t delta;
+
+    cpu_exec_time = tcg_cpu_exec_time();
+    delta = cpu_exec_time - last_cpu_exec_time;
+
+    qemu_printf("async time  %" PRId64 " (%0.3f)\n",
+                   dev_time, dev_time / (double) NANOSECONDS_PER_SECOND);
+    qemu_printf("qemu time   %" PRId64 " (%0.3f)\n",
+                   delta, delta / (double) NANOSECONDS_PER_SECOND);
+    last_cpu_exec_time = cpu_exec_time;
 }
 
 /* dump JIT statisticis using TCGProfile and TBStats */
@@ -80,34 +117,39 @@ void dump_jit_profile_info(TCGProfile *s)
         qemu_printf("avg search data/TB  %0.1f\n",
                 jpi->search_data / (double) jpi->translations);
 
+        uint64_t tot = jpi->interm_time + jpi->code_time;
+
+        qemu_printf("JIT cycles          %" PRId64 " (%0.3fs at 2.4 GHz)\n",
+                tot, tot / 2.4e9);
+        qemu_printf("  cycles/op           %0.1f\n",
+                jpi->ops ? (double)tot / jpi->ops : 0);
+        qemu_printf("  cycles/in byte      %0.1f\n",
+                jpi->guest ? (double)tot / jpi->guest : 0);
+        qemu_printf("  cycles/out byte     %0.1f\n",
+                jpi->host ? (double)tot / jpi->host : 0);
+        qemu_printf("  cycles/search byte  %0.1f\n",
+                jpi->search_data ? (double)tot / jpi->search_data : 0);
+        if (tot == 0) {
+            tot = 1;
+        }
+
+        qemu_printf("  gen_interm time     %0.1f%%\n",
+                (double)jpi->interm_time / tot * 100.0);
+        qemu_printf("  gen_code time       %0.1f%%\n",
+                (double)jpi->code_time / tot * 100.0);
+
+        qemu_printf("    optim./code time    %0.1f%%\n",
+                (double)jpi->opt_time / (jpi->code_time ? jpi->code_time : 1) * 100.0);
+        qemu_printf("    liveness/code time  %0.1f%%\n",
+                (double)jpi->la_time / (jpi->code_time ? jpi->code_time : 1) * 100.0);
+
+        qemu_printf("cpu_restore count   %" PRId64 "\n", jpi->restore_count);
+        qemu_printf("  avg cycles        %0.1f\n",
+                jpi->restore_count ? (double)jpi->restore_time / jpi->restore_count : 0);
+
         if (s) {
-            int64_t tot = s->interm_time + s->code_time;
-            qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4 GHz)\n",
-                            tot, tot / 2.4e9);
-            qemu_printf("cycles/op           %0.1f\n",
-                        jpi->ops ? (double)tot / jpi->ops : 0);
-            qemu_printf("cycles/in byte      %0.1f\n",
-                        jpi->guest ? (double)tot / jpi->guest : 0);
-            qemu_printf("cycles/out byte     %0.1f\n",
-                        jpi->host ? (double)tot / jpi->host : 0);
-            qemu_printf("cycles/search byte     %0.1f\n",
-                        jpi->search_data ? (double)tot / jpi->search_data : 0);
-            if (tot == 0) {
-                tot = 1;
-            }
-            qemu_printf("  gen_interm time   %0.1f%%\n",
-                        (double)s->interm_time / tot * 100.0);
-            qemu_printf("  gen_code time     %0.1f%%\n",
-                        (double)s->code_time / tot * 100.0);
-            qemu_printf("optim./code time    %0.1f%%\n",
-                        (double)s->opt_time / (s->code_time ? s->code_time : 1)
-                        * 100.0);
-            qemu_printf("liveness/code time  %0.1f%%\n",
-                    (double)s->la_time / (s->code_time ? s->code_time : 1) * 100.0);
-            qemu_printf("cpu_restore count   %" PRId64 "\n",
-                    s->restore_count);
-            qemu_printf("  avg cycles        %0.1f\n",
-                    s->restore_count ? (double)s->restore_time / s->restore_count : 0);
+            qemu_printf("cpu exec time  %" PRId64 " (%0.3fs)\n",
+                s->cpu_exec_time, s->cpu_exec_time / (double) NANOSECONDS_PER_SECOND);
         }
     }
     g_free(jpi);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 84f759a829..396e63c3e7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -337,10 +337,11 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     CPUArchState *env = cpu->env_ptr;
     uint8_t *p = tb->tc.ptr + tb->tc.size;
     int i, j, num_insns = tb->icount;
-#ifdef CONFIG_PROFILER
-    TCGProfile *prof = &tcg_ctx->prof;
-    int64_t ti = profile_getclock();
-#endif
+    uint64_t ti = 0;
+
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        ti = profile_getclock();
+    }
 
     searched_pc -= GETPC_ADJ;
 
@@ -370,11 +371,11 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     }
     restore_state_to_opc(env, tb, data);
 
-#ifdef CONFIG_PROFILER
-    atomic_set(&prof->restore_time,
-                prof->restore_time + profile_getclock() - ti);
-    atomic_set(&prof->restore_count, prof->restore_count + 1);
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        atomic_add(&tb->tb_stats->time.restore, profile_getclock() - ti);
+        atomic_inc(&tb->tb_stats->time.restore_count);
+    }
+
     return 0;
 }
 
@@ -1731,9 +1732,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size, max_insns;
     TCGProfile *prof = &tcg_ctx->prof;
-#ifdef CONFIG_PROFILER
-    int64_t ti;
-#endif
+    uint64_t ti = 0;
+
     assert_memory_lock();
 
     phys_pc = get_page_addr_code(env, pc);
@@ -1779,9 +1779,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tb_cflags = cflags;
  tb_overflow:
 
-#ifdef CONFIG_PROFILER
-    ti = profile_getclock();
-#endif
 
     /*
      * We want to fetch the stats structure before we start code
@@ -1801,6 +1798,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         if (flag & TB_JIT_STATS) {
             tb->tb_stats->stats_enabled |= TB_JIT_STATS;
         }
+
+        if (flag & TB_JIT_TIME) {
+            tb->tb_stats->stats_enabled |= TB_JIT_TIME;
+            ti = profile_getclock();
+        }
     } else {
         tb->tb_stats = NULL;
     }
@@ -1826,10 +1828,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         tcg_ctx->tb_jmp_target_addr = tb->jmp_target_arg;
     }
 
-#ifdef CONFIG_PROFILER
-    atomic_set(&prof->interm_time, prof->interm_time + profile_getclock() - ti);
-    ti = profile_getclock();
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        atomic_add(&tb->tb_stats->time.interm, profile_getclock() - ti);
+        ti = profile_getclock();
+    }
 
     gen_code_size = tcg_gen_code(tcg_ctx, tb);
     if (unlikely(gen_code_size < 0)) {
@@ -1871,9 +1873,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
     tb->tc.size = gen_code_size;
 
-#ifdef CONFIG_PROFILER
-    atomic_set(&prof->code_time, prof->code_time + profile_getclock() - ti);
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        atomic_add(&tb->tb_stats->time.code, profile_getclock() - ti);
+    }
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
diff --git a/configure b/configure
index 8f8446f52b..eedeb9016e 100755
--- a/configure
+++ b/configure
@@ -6566,9 +6566,6 @@ fi
 if test "$static" = "yes" ; then
   echo "CONFIG_STATIC=y" >> $config_host_mak
 fi
-if test "$profiler" = "yes" ; then
-  echo "CONFIG_PROFILER=y" >> $config_host_mak
-fi
 if test "$want_tools" = "yes" ; then
   echo "CONFIG_TOOLS=y" >> $config_host_mak
 fi
diff --git a/cpus.c b/cpus.c
index d2c61ff155..3c4bce0e56 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1442,21 +1442,17 @@ static void process_icount_data(CPUState *cpu)
 static int tcg_cpu_exec(CPUState *cpu)
 {
     int ret;
-#ifdef CONFIG_PROFILER
-    int64_t ti;
-#endif
+    uint64_t ti;
 
     assert(tcg_enabled());
-#ifdef CONFIG_PROFILER
     ti = profile_getclock();
-#endif
+
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
-#ifdef CONFIG_PROFILER
-    atomic_set(&tcg_ctx->prof.cpu_exec_time,
-               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
-#endif
+
+    atomic_add(&tcg_ctx->prof.cpu_exec_time, profile_getclock() - ti);
+
     return ret;
 }
 
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index c779d6a183..a142972960 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -90,10 +90,24 @@ struct TBStatistics {
      * this TBStats structure. Has to be reset on a tb_flush.
      */
     GPtrArray *tbs;
+
+    /* end of jit_stats_lock */
+
+    /* These are accessed with atomic operations */
+    struct {
+        int64_t restore;
+        uint64_t restore_count;
+        int64_t interm;
+        int64_t code;
+        int64_t opt;
+        int64_t la;
+    } time;
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
 
+void dump_jit_exec_time_info(uint64_t dev_time);
+
 void init_tb_stats_htable_if_not(void);
 
 void dump_jit_profile_info(TCGProfile *s);
@@ -101,6 +115,7 @@ void dump_jit_profile_info(TCGProfile *s);
 #define TB_NOTHING    (1 << 0)
 #define TB_EXEC_STATS (1 << 1)
 #define TB_JIT_STATS  (1 << 2)
+#define TB_JIT_TIME   (1 << 3)
 
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 85bc6eb00b..641ca3ddd0 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -1006,13 +1006,10 @@ static inline int64_t cpu_get_host_ticks(void)
 }
 #endif
 
-#ifdef CONFIG_PROFILER
 static inline int64_t profile_getclock(void)
 {
     return get_clock();
 }
 
-extern int64_t dev_time;
-#endif
-
+extern uint64_t dev_time;
 #endif
diff --git a/monitor/misc.c b/monitor/misc.c
index aef16f6cfb..ac4ff58d96 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -472,6 +472,11 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
 
 static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 {
+    if (!tb_stats_collection_enabled()) {
+        error_report("TB information not being recorded.");
+        return;
+    }
+
     dump_opcount_info();
 }
 #endif
@@ -1082,32 +1087,11 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
     mtree_info(flatview, dispatch_tree, owner);
 }
 
-#ifdef CONFIG_PROFILER
-
-int64_t dev_time;
-
 static void hmp_info_profile(Monitor *mon, const QDict *qdict)
 {
-    static int64_t last_cpu_exec_time;
-    int64_t cpu_exec_time;
-    int64_t delta;
-
-    cpu_exec_time = tcg_cpu_exec_time();
-    delta = cpu_exec_time - last_cpu_exec_time;
-
-    monitor_printf(mon, "async time  %" PRId64 " (%0.3f)\n",
-                   dev_time, dev_time / (double)NANOSECONDS_PER_SECOND);
-    monitor_printf(mon, "qemu time   %" PRId64 " (%0.3f)\n",
-                   delta, delta / (double)NANOSECONDS_PER_SECOND);
-    last_cpu_exec_time = cpu_exec_time;
+    dump_jit_exec_time_info(dev_time);
     dev_time = 0;
 }
-#else
-static void hmp_info_profile(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "Internal profiler not compiled\n");
-}
-#endif
 
 /* Capture support */
 static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9c199c8a40..e1438fa0d9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3881,82 +3881,34 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
     }
 }
 
-#ifdef CONFIG_PROFILER
-
 /* avoid copy/paste errors */
 #define PROF_ADD(to, from, field)                       \
     do {                                                \
         (to)->field += atomic_read(&((from)->field));   \
     } while (0)
 
-#define PROF_MAX(to, from, field)                                       \
-    do {                                                                \
-        typeof((from)->field) val__ = atomic_read(&((from)->field));    \
-        if (val__ > (to)->field) {                                      \
-            (to)->field = val__;                                        \
-        }                                                               \
-    } while (0)
-
-/* Pass in a zero'ed @prof */
-static inline
-void tcg_profile_snapshot(TCGProfile *prof, bool counters, bool table)
+static void collect_tcg_profiler(TCGProfile *prof)
 {
+    int i;
     unsigned int n_ctxs = atomic_read(&n_tcg_ctxs);
-    unsigned int i;
 
     for (i = 0; i < n_ctxs; i++) {
         TCGContext *s = atomic_read(&tcg_ctxs[i]);
         const TCGProfile *orig = &s->prof;
 
-        if (counters) {
-            PROF_ADD(prof, orig, cpu_exec_time);
-            PROF_ADD(prof, orig, interm_time);
-            PROF_ADD(prof, orig, code_time);
-            PROF_ADD(prof, orig, la_time);
-            PROF_ADD(prof, orig, opt_time);
-            PROF_ADD(prof, orig, restore_count);
-            PROF_ADD(prof, orig, restore_time);
-        }
-        if (table) {
-            int i;
+        PROF_ADD(prof, orig, cpu_exec_time);
 
-            for (i = 0; i < NB_OPS; i++) {
-                PROF_ADD(prof, orig, table_op_count[i]);
-            }
+        for (i = 0; i < NB_OPS; i++) {
+            PROF_ADD(prof, orig, table_op_count[i]);
         }
     }
 }
 
-#undef PROF_ADD
-#undef PROF_MAX
-
-static void tcg_profile_snapshot_counters(TCGProfile *prof)
-{
-    tcg_profile_snapshot(prof, true, false);
-}
-
-static void tcg_profile_snapshot_table(TCGProfile *prof)
-{
-    tcg_profile_snapshot(prof, false, true);
-}
-
-void tcg_dump_op_count(void)
-{
-    TCGProfile prof = {};
-    int i;
-
-    tcg_profile_snapshot_table(&prof);
-    for (i = 0; i < NB_OPS; i++) {
-        qemu_printf("%s %" PRId64 "\n", tcg_op_defs[i].name,
-                    prof.table_op_count[i]);
-    }
-}
-
-int64_t tcg_cpu_exec_time(void)
+uint64_t tcg_cpu_exec_time(void)
 {
     unsigned int n_ctxs = atomic_read(&n_tcg_ctxs);
     unsigned int i;
-    int64_t ret = 0;
+    uint64_t ret = 0;
 
     for (i = 0; i < n_ctxs; i++) {
         const TCGContext *s = atomic_read(&tcg_ctxs[i]);
@@ -3966,19 +3918,6 @@ int64_t tcg_cpu_exec_time(void)
     }
     return ret;
 }
-#else
-void tcg_dump_op_count(void)
-{
-    qemu_printf("[TCG profiler not compiled]\n");
-}
-
-int64_t tcg_cpu_exec_time(void)
-{
-    error_report("%s: TCG profiler not compiled", __func__);
-    exit(EXIT_FAILURE);
-}
-#endif
-
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 {
@@ -4020,18 +3959,18 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 
-#ifdef CONFIG_PROFILER
-    atomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        atomic_add(&tb->tb_stats->time.opt, -profile_getclock());
+    }
 
 #ifdef USE_TCG_OPTIMIZATIONS
     tcg_optimize(s);
 #endif
 
-#ifdef CONFIG_PROFILER
-    atomic_set(&prof->opt_time, prof->opt_time + profile_getclock());
-    atomic_set(&prof->la_time, prof->la_time - profile_getclock());
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        atomic_add(&tb->tb_stats->time.opt, profile_getclock());
+        atomic_add(&tb->tb_stats->time.la,  -profile_getclock());
+    }
 
     reachable_code_pass(s);
     liveness_pass_1(s);
@@ -4054,9 +3993,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         }
     }
 
-#ifdef CONFIG_PROFILER
-    atomic_set(&prof->la_time, prof->la_time + profile_getclock());
-#endif
+    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
+        atomic_add(&tb->tb_stats->time.la, profile_getclock());
+    }
 
 #ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
@@ -4081,14 +4020,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     s->pool_labels = NULL;
 #endif
 
+    if (!tb_stats_collection_enabled()) {
+        QTAILQ_FOREACH(op, &s->ops, link) {
+            TCGOpcode opc = op->opc;
+            atomic_add(&s->prof.table_op_count[opc], 1);
+        }
+    }
+
     num_insns = -1;
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
 
-#ifdef CONFIG_PROFILER
-        atomic_set(&prof->table_op_count[opc], prof->table_op_count[opc] + 1);
-#endif
-
         switch (opc) {
         case INDEX_op_mov_i32:
         case INDEX_op_mov_i64:
@@ -4181,14 +4123,23 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     return tcg_current_code_size(s);
 }
 
+void tcg_dump_op_count(void)
+{
+    TCGProfile prof = {};
+    int i;
+
+    collect_tcg_profiler(&prof);
+    for (i = 0; i < NB_OPS; i++) {
+        qemu_printf("%s %" PRId64 "\n", tcg_op_defs[i].name, prof.table_op_count[i]);
+    }
+}
+
 void tcg_dump_info(void)
 {
     TCGProfile *s = NULL;
-#ifdef CONFIG_PROFILER
     TCGProfile prof = {};
-    tcg_profile_snapshot_counters(&prof);
     s = &prof;
-#endif
+    collect_tcg_profiler(s);
     dump_jit_profile_info(s);
 }
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5296f7c075..6dcbbf79e7 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -948,7 +948,7 @@ int tcg_check_temp_count(void);
 #define tcg_check_temp_count() 0
 #endif
 
-int64_t tcg_cpu_exec_time(void);
+uint64_t tcg_cpu_exec_time(void);
 void tcg_dump_info(void);
 void tcg_dump_op_count(void);
 
diff --git a/vl.c b/vl.c
index 002bf4919e..f91bc6fb4c 100644
--- a/vl.c
+++ b/vl.c
@@ -1796,17 +1796,11 @@ static bool main_loop_should_exit(void)
 
 static void main_loop(void)
 {
-#ifdef CONFIG_PROFILER
-    int64_t ti;
-#endif
+    uint64_t ti;
     while (!main_loop_should_exit()) {
-#ifdef CONFIG_PROFILER
         ti = profile_getclock();
-#endif
         main_loop_wait(false);
-#ifdef CONFIG_PROFILER
         dev_time += profile_getclock() - ti;
-#endif
     }
 }
 
-- 
2.20.1


