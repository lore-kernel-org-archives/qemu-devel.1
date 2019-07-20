Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40700C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23FE21849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iygMkRid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23FE21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hodnR-0001Wy-NC
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmV-0006XH-HZ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmT-0006I1-HJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:23 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:37215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hodmT-0006Hj-CH
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:21 -0400
Received: by mail-qt1-x841.google.com with SMTP id y26so32959953qto.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KK8UiZXSk1KbHetSS7WAI9LM6b2boOhAzOgNHWSJLNw=;
 b=iygMkRidE9HlO9DMt6AhQQknkx8doQhUh77oLLTlunf+gQoJ6s+jPBe4PabaQJNYdW
 4RV6iXHFWQrHr8gVYEwPAbClQow7tZ+L34c0k+eF1WJyJGwYoUFBGEAw1aT38awdZ9ds
 5iCzjpFL/hQFKaqk6tbEi5MqGyC+xU3vTs0BGb2N1Cvz+QLHz/G1dQw+1fxzic9/RgeX
 9EqN7mmLMjsVdiChOE4T/aq5PdA8p2D08xjS7qLCo5d9JFuljdSGMD6eVw3M7ANsW17C
 0PjDh5PFrnR0xiH0PKFDVa5zXLrTLrzh6FE6+8DwY8mTE635tRfPXPDkVwa9nz+ffqWs
 x3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KK8UiZXSk1KbHetSS7WAI9LM6b2boOhAzOgNHWSJLNw=;
 b=piHsQGtanXjKQSyWaQD4NZSoaQ2BlaqebOdzsAn+boR9mdNfXMtjV92idOUPvpNWnA
 ETCf4DsQJnGu3WAEkrOYVoheXUdqAXZpQgpLD0q4Wc0WEc9LlK5O6fWJPSt6EhvCTQ38
 lQFnRCHR8F76OEc8OGqmQkFGPmp9PPfMALtPYwy048htLMBdoaG1dsrBm3s8lJAGcibR
 DqbEWZy6i5TUnC/AJKA7n9FUcVLfyBxZCIU0Y29mgHkSskVqYjO94YfwB6hOB0hYAGfa
 72j42HomxeppbHJBsf33Vc2YPiuN1a5TwcGyEJaScaNef2jd1dchBLPpOmZAFWe8tYCj
 zOPA==
X-Gm-Message-State: APjAAAXcHCsMiL2RHlZUMbCegXFORCaddb50QyLqT3x8FUjcVqWIuWZm
 A8jenFYAaGBosKEyrXdttZfDqKlv
X-Google-Smtp-Source: APXvYqzXY/jNl1M5TWFCsrJEBC5q8ndFNcf9ZtepJOziGom0G88SmIToZz7zkt+VCtDDAmK2YyDZNw==
X-Received: by 2002:ac8:3118:: with SMTP id g24mr39285034qtb.390.1563584600589; 
 Fri, 19 Jul 2019 18:03:20 -0700 (PDT)
Received: from vanderson-lmcad.domain.name ([177.137.96.41])
 by smtp.googlemail.com with ESMTPSA id g10sm13405115qki.37.2019.07.19.18.03.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 18:03:20 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 22:02:32 -0300
Message-Id: <20190720010235.32444-5-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720010235.32444-1-vandersonmr2@gmail.com>
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v4 4/7] accel: replacing part of
 CONFIG_PROFILER with TBStats
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

We add some of the statistics collected in the TCGProfiler
into the TBStats, having the statistics not only for the whole
emulation but for each TB. Then, we removed these stats
from TCGProfiler and reconstruct the information for the
"info jit" using the sum of all TBStats statistics.

The goal is to have one unique and better way of collecting
emulation statistics. Moreover, checking dynamiclly if the
profiling is enabled showed to have an insignificant impact
on the performance:
https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality#Overheads.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/Makefile.objs   |   2 +-
 accel/tcg/tb-stats.c      | 107 ++++++++++++++++++++++++++++++++++++++
 accel/tcg/translate-all.c |  10 ++--
 include/exec/tb-stats.h   |   9 ++++
 tcg/tcg.c                 |  93 ++++-----------------------------
 tcg/tcg.h                 |  10 ----
 6 files changed, 131 insertions(+), 100 deletions(-)
 create mode 100644 accel/tcg/tb-stats.c

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index d381a02f34..49ffe81b5d 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -2,7 +2,7 @@ obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
-obj-y += translator.o
+obj-y += translator.o tb-stats.o
 
 obj-$(CONFIG_USER_ONLY) += user-exec.o
 obj-$(call lnot,$(CONFIG_SOFTMMU)) += user-exec-stub.o
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
new file mode 100644
index 0000000000..44497d4f9b
--- /dev/null
+++ b/accel/tcg/tb-stats.c
@@ -0,0 +1,107 @@
+#include "qemu/osdep.h"
+
+#include "disas/disas.h"
+#include "exec/exec-all.h"
+#include "tcg.h"
+
+#include "qemu/qemu-print.h"
+
+struct jit_profile_info {
+    uint64_t translations;
+    uint64_t aborted;
+    uint64_t ops;
+    unsigned ops_max;
+    uint64_t del_ops;
+    uint64_t temps;
+    unsigned temps_max;
+    uint64_t host;
+    uint64_t guest;
+    uint64_t host_ins;
+    uint64_t search_data;
+};
+
+/* accumulate the statistics from all TBs */
+static void collect_jit_profile_info(void *p, uint32_t hash, void *userp)
+{
+    struct jit_profile_info *jpi = userp;
+    TBStatistics *tbs = p;
+
+    jpi->translations += tbs->translations.total;
+    jpi->ops += tbs->code.num_tcg_ops;
+    if (tbs->translations.total && tbs->code.num_tcg_ops / tbs->translations.total
+            > jpi->ops_max) {
+        jpi->ops_max = tbs->code.num_tcg_ops / tbs->translations.total;
+    }
+    jpi->del_ops += tbs->code.deleted_ops;
+    jpi->temps += tbs->code.temps;
+    if (tbs->translations.total && tbs->code.temps / tbs->translations.total >
+            jpi->temps_max) {
+        jpi->temps_max = tbs->code.temps / tbs->translations.total;
+    }
+    jpi->host += tbs->code.out_len;
+    jpi->guest += tbs->code.in_len;
+    jpi->host_ins += tbs->code.num_host_inst;
+    jpi->search_data += tbs->code.search_out_len;
+}
+
+/* dump JIT statisticis using TCGProfile and TBStats */
+void dump_jit_profile_info(TCGProfile *s)
+{
+    if (!tb_stats_collection_enabled()) {
+        return;
+    }
+
+    struct jit_profile_info *jpi = g_new0(struct jit_profile_info, 1);
+
+    qht_iter(&tb_ctx.tb_stats, collect_jit_profile_info, jpi);
+
+    if (jpi->translations) {
+        qemu_printf("translated TBs      %" PRId64 "\n", jpi->translations);
+        qemu_printf("avg ops/TB          %0.1f max=%d\n",
+                jpi->ops / (double) jpi->translations, jpi->ops_max);
+        qemu_printf("deleted ops/TB      %0.2f\n",
+                jpi->del_ops / (double) jpi->translations);
+        qemu_printf("avg temps/TB        %0.2f max=%d\n",
+                jpi->temps / (double) jpi->translations, jpi->temps_max);
+        qemu_printf("avg host code/TB    %0.1f\n",
+                jpi->host / (double) jpi->translations);
+        qemu_printf("avg host ins/TB     %0.1f\n",
+                jpi->host_ins / (double) jpi->translations);
+        qemu_printf("avg search data/TB  %0.1f\n",
+                jpi->search_data / (double) jpi->translations);
+
+        if (s) {
+            int64_t tot = s->interm_time + s->code_time;
+            qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4 GHz)\n",
+                            tot, tot / 2.4e9);
+            qemu_printf("cycles/op           %0.1f\n",
+                        jpi->ops ? (double)tot / jpi->ops : 0);
+            qemu_printf("cycles/in byte      %0.1f\n",
+                        jpi->guest ? (double)tot / jpi->guest : 0);
+            qemu_printf("cycles/out byte     %0.1f\n",
+                        jpi->host ? (double)tot / jpi->host : 0);
+            qemu_printf("cycles/out inst     %0.1f\n",
+                        jpi->host_ins ? (double)tot / jpi->host_ins : 0);
+            qemu_printf("cycles/search byte     %0.1f\n",
+                        jpi->search_data ? (double)tot / jpi->search_data : 0);
+            if (tot == 0) {
+                tot = 1;
+            }
+            qemu_printf("  gen_interm time   %0.1f%%\n",
+                        (double)s->interm_time / tot * 100.0);
+            qemu_printf("  gen_code time     %0.1f%%\n",
+                        (double)s->code_time / tot * 100.0);
+            qemu_printf("optim./code time    %0.1f%%\n",
+                        (double)s->opt_time / (s->code_time ? s->code_time : 1)
+                        * 100.0);
+            qemu_printf("liveness/code time  %0.1f%%\n",
+                    (double)s->la_time / (s->code_time ? s->code_time : 1) * 100.0);
+            qemu_printf("cpu_restore count   %" PRId64 "\n",
+                    s->restore_count);
+            qemu_printf("  avg cycles        %0.1f\n",
+                    s->restore_count ? (double)s->restore_time / s->restore_count : 0);
+        }
+    }
+}
+
+
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3a47ac6f2c..bbdb0f23a4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1773,8 +1773,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
  tb_overflow:
 
 #ifdef CONFIG_PROFILER
-    /* includes aborted translations because of exceptions */
-    atomic_set(&prof->tb_count1, prof->tb_count1 + 1);
     ti = profile_getclock();
 #endif
 
@@ -1822,7 +1820,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 
 #ifdef CONFIG_PROFILER
-    atomic_set(&prof->tb_count, prof->tb_count + 1);
     atomic_set(&prof->interm_time, prof->interm_time + profile_getclock() - ti);
     ti = profile_getclock();
 #endif
@@ -1869,12 +1866,13 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
 #ifdef CONFIG_PROFILER
     atomic_set(&prof->code_time, prof->code_time + profile_getclock() - ti);
-    atomic_set(&prof->code_in_len, prof->code_in_len + tb->size);
-    atomic_set(&prof->code_out_len, prof->code_out_len + gen_code_size);
-    atomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
     if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        atomic_add(&tb->tb_stats->code.in_len, tb->size);
+        atomic_add(&tb->tb_stats->code.out_len, gen_code_size);
+        atomic_add(&tb->tb_stats->code.search_out_len, search_size);
+
         size_t code_size = gen_code_size;
         if (tcg_ctx->data_gen_ptr) {
             code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 6584b78c4a..7d775f2c0d 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -40,6 +40,13 @@ struct TBStatistics {
         unsigned num_tcg_ops;
         unsigned num_tcg_ops_opt;
         unsigned spills;
+
+        /* CONFIG_PROFILE */
+        unsigned temps;
+        unsigned deleted_ops;
+        unsigned in_len;
+        unsigned out_len;
+        unsigned search_out_len;
     } code;
 
     struct {
@@ -51,4 +58,6 @@ struct TBStatistics {
 
 bool tb_stats_cmp(const void *ap, const void *bp);
 
+void dump_jit_profile_info(TCGProfile *s);
+
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 446e3d1708..46b31a2f68 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2295,9 +2295,9 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
     s->nb_ops--;
 
-#ifdef CONFIG_PROFILER
-    atomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
-#endif
+    if (tb_stats_enabled(s->current_tb, TB_JIT_STATS)) {
+        atomic_inc(&s->current_tb->tb_stats->code.deleted_ops);
+    }
 }
 
 static TCGOp *tcg_op_alloc(TCGOpcode opc)
@@ -3914,16 +3914,6 @@ void tcg_profile_snapshot(TCGProfile *prof, bool counters, bool table)
 
         if (counters) {
             PROF_ADD(prof, orig, cpu_exec_time);
-            PROF_ADD(prof, orig, tb_count1);
-            PROF_ADD(prof, orig, tb_count);
-            PROF_ADD(prof, orig, op_count);
-            PROF_MAX(prof, orig, op_count_max);
-            PROF_ADD(prof, orig, temp_count);
-            PROF_MAX(prof, orig, temp_count_max);
-            PROF_ADD(prof, orig, del_op_count);
-            PROF_ADD(prof, orig, code_in_len);
-            PROF_ADD(prof, orig, code_out_len);
-            PROF_ADD(prof, orig, search_out_len);
             PROF_ADD(prof, orig, interm_time);
             PROF_ADD(prof, orig, code_time);
             PROF_ADD(prof, orig, la_time);
@@ -4003,26 +3993,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     TCGOp *op;
 
     s->current_tb = tb;
-
-#ifdef CONFIG_PROFILER
-    {
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
         int n = 0;
 
         QTAILQ_FOREACH(op, &s->ops, link) {
             n++;
         }
-        atomic_set(&prof->op_count, prof->op_count + n);
-        if (n > prof->op_count_max) {
-            atomic_set(&prof->op_count_max, n);
-        }
+        atomic_add(&tb->tb_stats->code.num_tcg_ops, n);
 
         n = s->nb_temps;
-        atomic_set(&prof->temp_count, prof->temp_count + n);
-        if (n > prof->temp_count_max) {
-            atomic_set(&prof->temp_count_max, n);
-        }
+        atomic_add(&tb->tb_stats->code.temps, n);
     }
-#endif
 
 #ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
@@ -4229,70 +4210,16 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     return tcg_current_code_size(s);
 }
 
-#ifdef CONFIG_PROFILER
 void tcg_dump_info(void)
 {
+    TCGProfile *s = NULL;
+#ifdef CONFIG_PROFILER
     TCGProfile prof = {};
-    const TCGProfile *s;
-    int64_t tb_count;
-    int64_t tb_div_count;
-    int64_t tot;
-
     tcg_profile_snapshot_counters(&prof);
     s = &prof;
-    tb_count = s->tb_count;
-    tb_div_count = tb_count ? tb_count : 1;
-    tot = s->interm_time + s->code_time;
-
-    qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4 GHz)\n",
-                tot, tot / 2.4e9);
-    qemu_printf("translated TBs      %" PRId64 " (aborted=%" PRId64
-                " %0.1f%%)\n",
-                tb_count, s->tb_count1 - tb_count,
-                (double)(s->tb_count1 - s->tb_count)
-                / (s->tb_count1 ? s->tb_count1 : 1) * 100.0);
-    qemu_printf("avg ops/TB          %0.1f max=%d\n",
-                (double)s->op_count / tb_div_count, s->op_count_max);
-    qemu_printf("deleted ops/TB      %0.2f\n",
-                (double)s->del_op_count / tb_div_count);
-    qemu_printf("avg temps/TB        %0.2f max=%d\n",
-                (double)s->temp_count / tb_div_count, s->temp_count_max);
-    qemu_printf("avg host code/TB    %0.1f\n",
-                (double)s->code_out_len / tb_div_count);
-    qemu_printf("avg search data/TB  %0.1f\n",
-                (double)s->search_out_len / tb_div_count);
-    
-    qemu_printf("cycles/op           %0.1f\n",
-                s->op_count ? (double)tot / s->op_count : 0);
-    qemu_printf("cycles/in byte      %0.1f\n",
-                s->code_in_len ? (double)tot / s->code_in_len : 0);
-    qemu_printf("cycles/out byte     %0.1f\n",
-                s->code_out_len ? (double)tot / s->code_out_len : 0);
-    qemu_printf("cycles/search byte     %0.1f\n",
-                s->search_out_len ? (double)tot / s->search_out_len : 0);
-    if (tot == 0) {
-        tot = 1;
-    }
-    qemu_printf("  gen_interm time   %0.1f%%\n",
-                (double)s->interm_time / tot * 100.0);
-    qemu_printf("  gen_code time     %0.1f%%\n",
-                (double)s->code_time / tot * 100.0);
-    qemu_printf("optim./code time    %0.1f%%\n",
-                (double)s->opt_time / (s->code_time ? s->code_time : 1)
-                * 100.0);
-    qemu_printf("liveness/code time  %0.1f%%\n",
-                (double)s->la_time / (s->code_time ? s->code_time : 1) * 100.0);
-    qemu_printf("cpu_restore count   %" PRId64 "\n",
-                s->restore_count);
-    qemu_printf("  avg cycles        %0.1f\n",
-                s->restore_count ? (double)s->restore_time / s->restore_count : 0);
-}
-#else
-void tcg_dump_info(void)
-{
-    qemu_printf("[TCG profiler not compiled]\n");
-}
 #endif
+    dump_jit_profile_info(s);
+}
 
 #ifdef ELF_HOST_MACHINE
 /* In order to use this feature, the backend needs to do three things:
diff --git a/tcg/tcg.h b/tcg/tcg.h
index bf6f3bcba3..026a066b9a 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -644,16 +644,6 @@ QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
 
 typedef struct TCGProfile {
     int64_t cpu_exec_time;
-    int64_t tb_count1;
-    int64_t tb_count;
-    int64_t op_count; /* total insn count */
-    int op_count_max; /* max insn per TB */
-    int temp_count_max;
-    int64_t temp_count;
-    int64_t del_op_count;
-    int64_t code_in_len;
-    int64_t code_out_len;
-    int64_t search_out_len;
     int64_t interm_time;
     int64_t code_time;
     int64_t la_time;
-- 
2.22.0


