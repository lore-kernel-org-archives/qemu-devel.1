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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D1DC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A080A21726
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKocd4H2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A080A21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NmJ-00028O-G5
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Nb9-0006XL-Nb
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Nb5-0006Q8-Vz
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:35 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:37981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3Nb5-0006P6-Pp
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:31 -0400
Received: by mail-qk1-x744.google.com with SMTP id u190so3561982qkh.5
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gldjjNeOXXLP+VPk84ZaCQqNJXol7qudw4JE7i3j1aU=;
 b=IKocd4H2EJSbqlWsRnpPLI5Akly6A9K4i3pjsThzrKKpYVDbLYFBueCJ7ujacziqLt
 VW1rmqgLEiGXfkEJXqSiQmXuDcz/IQi7Uzlz686ZioOVP38ITPYDU1Or9AyBWExQYqEF
 S5lo/9OZujzPHgKzs3MzGsGahG1IhgbJwz4WOfOGN/GDmId+kzKoxdP/f1llisD5+HTB
 Vq/iPeqlU+b9QueZ6Xi6H47fElT26Yzqb1TL6kAEFFMwLKrk+zY/ms4g5jQx6kvqhgKE
 RykRVgSA+jYU2+IuzE17UO4T+nLXEm6j+LH7XY0GnlU6J42kvFQiuoh0MipKMqOnU7rp
 ajxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gldjjNeOXXLP+VPk84ZaCQqNJXol7qudw4JE7i3j1aU=;
 b=Nk101FcXd9P5lpLbBMTUehc7OAHFRGQnvrh6vzZiXZsJ2nS7U+sdtj94TxKnQRJCGj
 iz3MelzFtrm9LKDQODMzFEDcPEsq4fshY9vH55eoxfWCp6lhtEOTvSh4l+A+VRFNr0YI
 Xo8cYL6nzjsWNl5TzC3if4DjSvPKsDGk1gRH3Vx1XRZHv4Axtrwrbh1MHULFS4ZbpM8a
 FQaBElx54qT/RAI1qp71RiucOX1liiM4N20dgoTReZlirzZ479wHOjvjB+vCvEcEOWEp
 GR4Q+hO8HU7xgFCVRPqtnWAHhxZHZf3i+/KHvkAAOuOyApzgNQTpYH1S5xYqKYe9J360
 RaNw==
X-Gm-Message-State: APjAAAXVX/hVr1wquZfSqvEVGMlOvvLje+frSjmH89ULArVskeJbKj1q
 Usw+JJDqJu+ToXbPWfjtzdTx0V8WnGhFVA==
X-Google-Smtp-Source: APXvYqyMn2VuBcWXEX2KIqhLf+cMGdVscyf4nlFQ/3DragFBBrAIzHyPlN0tYpwlUp8+quWAQ/5OaA==
X-Received: by 2002:a05:620a:691:: with SMTP id
 f17mr10639334qkh.470.1567097309679; 
 Thu, 29 Aug 2019 09:48:29 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id g25sm1441024qkk.87.2019.08.29.09.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 09:48:29 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 13:47:52 -0300
Message-Id: <20190829164754.3906-9-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829164754.3906-1-vandersonmr2@gmail.com>
References: <20190829164754.3906-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: [Qemu-devel] [PATCH v7 08/10] Adding info [tb-list|tb|coverset]
 commands to HMP.
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These commands allow the exploration of TBs
generated by the TCG. Understand which one
hotter, with more guest/host instructions...
and examine their guest, host and IR code.

The goal of this command is to allow the dynamic exploration
of TCG behavior and code quality. Therefore, for now, a
corresponding QMP command is not worthwhile.

Example of output:

TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
	| exec:4828932/0 guest inst cov:16.38%
	| trans:1 ints: g:3 op:82 op_opt:34 spills:3
	| h/g (host bytes / guest insts): 90.666664
	| time to gen at 2.4GHz => code:3150.83(ns) IR:712.08(ns)
	| targets: 0x0000000000034d5e (id:11), 0x0000000000034d0d (id:2)

TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
	| exec:4825842/0 guest inst cov:21.82%
	| trans:1 ints: g:4 op:80 op_opt:38 spills:2
	| h/g (host bytes / guest insts): 84.000000
	| time to gen at 2.4GHz => code:3362.92(ns) IR:793.75(ns)
	| targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)

TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
	| exec:6956495/0  guest inst cov:21.82%
	| trans:2 ints: g:2 op:40 op_opt:19 spills:1
	| h/g (host bytes / guest insts): 84.000000
	| time to gen at 2.4GHz => code:3130.83(ns) IR:722.50(ns)
	| targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)

----------------
IN:
0x00034d0d:  89 de                    movl     %ebx, %esi
0x00034d0f:  26 8b 0e                 movl     %es:(%esi), %ecx
0x00034d12:  26 f6 46 08 80           testb    $0x80, %es:8(%esi)
0x00034d17:  75 3b                    jne      0x34d54

------------------------------

TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
	| exec:5202686/0 guest inst cov:11.28%
	| trans:1 ints: g:3 op:82 op_opt:34 spills:3
	| h/g (host bytes / guest insts): 90.666664
	| time to gen at 2.4GHz => code:2793.75(ns) IR:614.58(ns)
	| targets: 0x0000000000034d5e (id:3), 0x0000000000034d0d (id:2)

TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
	| exec:5199468/0 guest inst cov:15.03%
	| trans:1 ints: g:4 op:80 op_opt:38 spills:2
	| h/g (host bytes / guest insts): 84.000000
	| time to gen at 2.4GHz => code:2958.75(ns) IR:719.58(ns)
	| targets: 0x0000000000034d19 (id:4), 0x0000000000034d54 (id:1)

------------------------------
2 TBs to reach 25% of guest inst exec coverage
Total of guest insts exec: 138346727

------------------------------

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/tb-stats.c         | 421 ++++++++++++++++++++++++++++++++++-
 accel/tcg/translate-all.c    |   2 +-
 disas.c                      |  31 ++-
 hmp-commands-info.hx         |  24 ++
 include/exec/tb-stats.h      |  45 +++-
 include/qemu/log-for-trace.h |   4 +
 include/qemu/log.h           |   2 +
 monitor/misc.c               |  74 ++++++
 util/log.c                   |  52 ++++-
 9 files changed, 634 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 9959477fbb..d588c551c9 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -34,9 +34,35 @@
 
 /* only accessed in safe work */
 static GList *last_search;
-
+int id = 1; /* display_id increment counter */
 uint64_t dev_time;
 
+static TBStatistics *get_tbstats_by_id(int id)
+{
+    GList *iter;
+
+    for (iter = last_search; iter; iter = g_list_next(iter)) {
+        TBStatistics *tbs = iter->data;
+        if (tbs && tbs->display_id == id) {
+            return tbs;
+            break;
+        }
+    }
+    return NULL;
+}
+
+static TBStatistics *get_tbstats_by_addr(target_ulong pc)
+{
+    GList *iter;
+    for (iter = last_search; iter; iter = g_list_next(iter)) {
+        TBStatistics *tbs = iter->data;
+        if (tbs && tbs->pc == pc) {
+            return tbs;
+        }
+    }
+    return NULL;
+}
+
 struct jit_profile_info {
     uint64_t translations;
     uint64_t aborted;
@@ -175,6 +201,7 @@ static void clean_tbstats(void)
     qht_destroy(&tb_ctx.tb_stats);
 }
 
+
 void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
 {
     struct TbstatsCommand *cmdinfo = icmd.host_ptr;
@@ -261,6 +288,398 @@ void init_tb_stats_htable_if_not(void)
     }
 }
 
+static void collect_tb_stats(void *p, uint32_t hash, void *userp)
+{
+    last_search = g_list_prepend(last_search, p);
+}
+
+static void dump_tb_targets(TBStatistics *tbs)
+{
+    if (tbs && tbs->tb) {
+        TBStatistics *valid_target_tbstats[2] = {NULL, NULL};
+
+        /*
+         * Check and ensure that targets' tbstats have a valid display_id and
+         * are in last_search list
+         */
+        for (int jmp_id = 0; jmp_id < 2; jmp_id++) {
+            qemu_spin_lock(&tbs->tb->jmp_lock);
+            TranslationBlock *tb_dst =
+                (TranslationBlock *) (atomic_read(&tbs->tb->jmp_dest[jmp_id]) & ~1);
+            qemu_spin_unlock(&tbs->tb->jmp_lock);
+
+            if (tb_dst) {
+                target_ulong pc = tb_dst ? tb_dst->pc : 0;
+
+                /* Check if tb_dst is on the last_search list */
+                TBStatistics *tbstats_pc = get_tbstats_by_addr(pc);
+
+                /* if not in the last_search list, then insert it */
+                if (!tbstats_pc) {
+                    last_search = g_list_append(last_search, tb_dst->tb_stats);
+                }
+
+                /* if the tb_stats does not have a valid display_id, then set one. */
+                if (tb_dst->tb_stats && tb_dst->tb_stats->display_id == 0) {
+                    tb_dst->tb_stats->display_id = id++;
+                    valid_target_tbstats[jmp_id] = tb_dst->tb_stats;
+                }
+            }
+        }
+
+        if (valid_target_tbstats[0] && !valid_target_tbstats[1]) {
+            qemu_log("\t| targets: 0x"TARGET_FMT_lx" (id:%d)\n",
+                    valid_target_tbstats[0]->pc, valid_target_tbstats[0]->display_id);
+        } else if (!valid_target_tbstats[0] && valid_target_tbstats[1]) {
+            qemu_log("\t| targets: 0x"TARGET_FMT_lx" (id:%d)\n",
+                    valid_target_tbstats[1]->pc, valid_target_tbstats[1]->display_id);
+        } else if (valid_target_tbstats[0] && valid_target_tbstats[1]) {
+            qemu_log("\t| targets: 0x"TARGET_FMT_lx" (id:%d), "
+                     "0x"TARGET_FMT_lx" (id:%d)\n",
+                    valid_target_tbstats[0]->pc, valid_target_tbstats[0]->display_id,
+                    valid_target_tbstats[1]->pc, valid_target_tbstats[1]->display_id);
+        } else {
+            qemu_log("\t| targets: no direct target\n");
+        }
+    }
+}
+
+static void dump_tb_header(TBStatistics *tbs)
+{
+    unsigned g = stat_per_translation(tbs, code.num_guest_inst);
+    unsigned ops = stat_per_translation(tbs, code.num_tcg_ops);
+    unsigned ops_opt = stat_per_translation(tbs, code.num_tcg_ops_opt);
+    unsigned spills = stat_per_translation(tbs, code.spills);
+    unsigned h = stat_per_translation(tbs, code.out_len);
+
+    float guest_host_prop = g ? ((float) h / g) : 0;
+
+    qemu_log("TB id:%d | phys:0x"TB_PAGE_ADDR_FMT" virt:0x"TARGET_FMT_lx
+             " flags:%#08x\n", tbs->display_id, tbs->phys_pc, tbs->pc, tbs->flags);
+
+    if (tbs_stats_enabled(tbs, TB_EXEC_STATS)) {
+        qemu_log("\t| exec:%lu/%lu guest inst cov:%.2f%%\n", tbs->executions.normal,
+                tbs->executions.atomic, tbs->executions.coverage / 100.0f);
+    }
+
+    if (tbs_stats_enabled(tbs, TB_JIT_STATS)) {
+        qemu_log("\t| trans:%lu ints: g:%u op:%u op_opt:%u spills:%d"
+             "\n\t| h/g (host bytes / guest insts): %f\n",
+             tbs->translations.total, g, ops, ops_opt, spills, guest_host_prop);
+    }
+
+    if (tbs_stats_enabled(tbs, TB_JIT_TIME)) {
+        qemu_log("\t| time to gen at 2.4GHz => code:%0.2lf(ns) IR:%0.2lf(ns)\n",
+             tbs->time.code / 2.4, tbs->time.interm / 2.4);
+    }
+
+    dump_tb_targets(tbs);
+    qemu_log("\n");
+}
+
+static gint
+inverse_sort_tbs(gconstpointer p1, gconstpointer p2, gpointer psort_by)
+{
+    const TBStatistics *tbs1 = (TBStatistics *) p1;
+    const TBStatistics *tbs2 = (TBStatistics *) p2;
+    int sort_by = *((int *) psort_by);
+    unsigned long c1 = 0;
+    unsigned long c2 = 0;
+
+    if (likely(sort_by == SORT_BY_SPILLS)) {
+        c1 = stat_per_translation(tbs1, code.spills);
+        c2 = stat_per_translation(tbs2, code.spills);
+    } else if (likely(sort_by == SORT_BY_HOTNESS)) {
+        c1 = stat_per_translation(tbs1, executions.normal);
+        c2 = stat_per_translation(tbs2, executions.normal);
+    } else if (likely(sort_by == SORT_BY_HG)) {
+        if (tbs1->code.num_guest_inst == 0) {
+            return -1;
+        }
+        if (tbs2->code.num_guest_inst == 0) {
+            return 1;
+        }
+
+        float a =
+            (float) stat_per_translation(tbs1, code.out_len) / tbs1->code.num_guest_inst;
+        float b =
+            (float) stat_per_translation(tbs2, code.out_len) / tbs2->code.num_guest_inst;
+        c1 = a <= b ? 0 : 1;
+        c2 = a <= b ? 1 : 0;
+    }
+
+    return c1 < c2 ? 1 : c1 == c2 ? 0 : -1;
+}
+
+static void dump_last_search_headers(int count)
+{
+    if (!last_search) {
+        qemu_log("No data collected yet\n");
+        return;
+    }
+
+    GList *l = last_search;
+    while (l != NULL && count--) {
+        TBStatistics *tbs = (TBStatistics *) l->data;
+        GList *next = l->next;
+        dump_tb_header(tbs);
+        l = next;
+    }
+}
+
+static uint64_t calculate_last_search_coverages(void)
+{
+    uint64_t total_exec_count = 0;
+    GList *i;
+
+    /* Compute total execution count for all tbs */
+    for (i = last_search; i; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        total_exec_count +=
+            (tbs->executions.atomic + tbs->executions.normal) * tbs->code.num_guest_inst;
+    }
+
+    for (i = last_search; i; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        uint64_t tb_total_execs =
+            (tbs->executions.atomic + tbs->executions.normal) * tbs->code.num_guest_inst;
+        tbs->executions.coverage = (10000 * tb_total_execs) / (total_exec_count + 1);
+    }
+
+    return total_exec_count;
+}
+
+static void do_dump_coverset_info(int percentage)
+{
+    mmap_lock();
+    uint16_t total_coverage = 0;
+    unsigned coverset_size = 0;
+    percentage *= 100;
+    id = 1;
+    GList *i;
+
+    g_list_free(last_search);
+    last_search = NULL;
+
+    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
+
+    int sort_by = SORT_BY_HOTNESS;
+    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs, &sort_by);
+
+    if (!last_search) {
+        qemu_log("No data collected yet\n");
+        return;
+    }
+
+    uint64_t total_exec_count = calculate_last_search_coverages();
+
+    /* Iterate and tbs display_id until reach the coverage percentage count */
+    for (i = last_search; i && total_coverage < percentage; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        tbs->display_id = id++;
+        coverset_size++;
+        total_coverage += tbs->executions.coverage;
+    }
+
+    /* free the unused bits */
+    if (i) {
+        if (i->next) {
+            i->next->prev = NULL;
+        }
+        g_list_free(i->next);
+        i->next = NULL;
+    }
+
+    dump_last_search_headers(coverset_size);
+    mmap_unlock();
+
+    qemu_log("------------------------------\n");
+    qemu_log("%u TBs to reach %d%% of guest inst exec coverage\n",
+                coverset_size, percentage / 100);
+    qemu_log("Total of guest insts exec: %lu", total_exec_count);
+    qemu_log("\n------------------------------\n");
+}
+
+static void do_dump_tbs_info(int total, int sort_by)
+{
+    id = 1;
+    GList *i;
+    int count = total;
+
+    g_list_free(last_search);
+    last_search = NULL;
+
+    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
+
+    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs, &sort_by);
+
+    if (!last_search) {
+        qemu_printf("No data collected yet!\n");
+        return;
+    }
+
+    calculate_last_search_coverages();
+
+    for (i = last_search; i && count--; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        tbs->display_id = id++;
+    }
+
+    /* free the unused bits */
+    if (i) {
+        if (i->next) {
+            i->next->prev = NULL;
+        }
+        g_list_free(i->next);
+        i->next = NULL;
+    }
+
+    dump_last_search_headers(total);
+}
+
+static void
+do_dump_coverset_info_safe(CPUState *cpu, run_on_cpu_data percentage)
+{
+    qemu_log_to_monitor(true);
+    do_dump_coverset_info(percentage.host_int);
+    qemu_log_to_monitor(false);
+}
+
+struct tbs_dump_info {
+    int count;
+    int sort_by;
+};
+
+static void do_dump_tbs_info_safe(CPUState *cpu, run_on_cpu_data tbdi)
+{
+    struct tbs_dump_info *info = tbdi.host_ptr;
+    qemu_log_to_monitor(true);
+    do_dump_tbs_info(info->count, info->sort_by);
+    qemu_log_to_monitor(false);
+    g_free(info);
+}
+
+/*
+ * When we dump_tbs_info on a live system via the HMP we want to
+ * ensure the system is quiessent before we start outputting stuff.
+ * Otherwise we could pollute the output with other logging output.
+ */
+void dump_coverset_info(int percentage, bool use_monitor)
+{
+    if (use_monitor) {
+        async_safe_run_on_cpu(first_cpu, do_dump_coverset_info_safe,
+                              RUN_ON_CPU_HOST_INT(percentage));
+    } else {
+        do_dump_coverset_info(percentage);
+    }
+}
+
+void dump_tbs_info(int count, int sort_by, bool use_monitor)
+{
+    if (use_monitor) {
+        struct tbs_dump_info *tbdi = g_new(struct tbs_dump_info, 1);
+        tbdi->count = count;
+        tbdi->sort_by = sort_by;
+        async_safe_run_on_cpu(first_cpu, do_dump_tbs_info_safe,
+                              RUN_ON_CPU_HOST_PTR(tbdi));
+    } else {
+        do_dump_tbs_info(count, sort_by);
+    }
+}
+
+static GString *get_code_string(TBStatistics *tbs, int log_flags)
+{
+    int old_log_flags = qemu_loglevel;
+
+    CPUState *cpu = first_cpu;
+    uint32_t cflags = curr_cflags() | CF_NOCACHE;
+    TranslationBlock *tb = NULL;
+
+    GString *code_s = g_string_new(NULL);
+    qemu_log_to_string(true, code_s);
+
+    qemu_set_log(log_flags);
+
+    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+        mmap_lock();
+        tb = tb_gen_code(cpu, tbs->pc, tbs->cs_base, tbs->flags, cflags);
+        tb_phys_invalidate(tb, -1);
+        mmap_unlock();
+    } else {
+        /*
+         * The mmap_lock is dropped by tb_gen_code if it runs out of
+         * memory.
+         */
+        fprintf(stderr, "%s: dbg failed!\n", __func__);
+        qemu_log("\ncould not gen code for this TB\n");
+        assert_no_pages_locked();
+    }
+
+    qemu_set_log(old_log_flags);
+    qemu_log_to_string(false, NULL);
+
+    if (tb) {
+        tcg_tb_remove(tb);
+    }
+
+    return code_s;
+}
+
+static void do_tb_dump_with_statistics(TBStatistics *tbs, int log_flags)
+{
+    qemu_log("\n------------------------------\n\n");
+    dump_tb_header(tbs);
+
+    GString *code_s = get_code_string(tbs, log_flags);
+    qemu_log("%s", code_s->str);
+    g_string_free(code_s, true);
+    qemu_log("------------------------------\n");
+}
+
+struct tb_dump_info {
+    int id;
+    int log_flags;
+    bool use_monitor;
+};
+
+static void do_dump_tb_info_safe(CPUState *cpu, run_on_cpu_data info)
+{
+    struct tb_dump_info *tbdi = (struct tb_dump_info *) info.host_ptr;
+
+    if (!last_search) {
+        qemu_log("no search on record\n");
+        return;
+    }
+
+    qemu_log_to_monitor(tbdi->use_monitor);
+
+    TBStatistics *tbs = get_tbstats_by_id(tbdi->id);
+    if (tbs) {
+        do_tb_dump_with_statistics(tbs, tbdi->log_flags);
+    } else {
+        qemu_log("no TB statitics found with id %d\n", tbdi->id);
+    }
+
+    qemu_log_to_monitor(false);
+
+    g_free(tbdi);
+}
+
+void dump_tb_info(int id, int log_mask, bool use_monitor)
+{
+    struct tb_dump_info *tbdi = g_new(struct tb_dump_info, 1);
+
+    tbdi->id = id;
+    tbdi->log_flags = log_mask;
+    tbdi->use_monitor = use_monitor;
+
+    async_safe_run_on_cpu(first_cpu, do_dump_tb_info_safe,
+                          RUN_ON_CPU_HOST_PTR(tbdi));
+
+    /* tbdi free'd by do_dump_tb_info_safe */
+}
+
+
 void enable_collect_tb_stats(void)
 {
     init_tb_stats_htable_if_not();
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a2e65bb85c..fa163440dc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1778,7 +1778,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      * generation so we can count interesting things about this
      * generation.
      */
-    if (tb_stats_collection_enabled()) {
+    if (tb_stats_collection_enabled() && !(tb->cflags & CF_NOCACHE)) {
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags, tb);
         uint32_t flag = get_default_tbstats_flag();
 
diff --git a/disas.c b/disas.c
index 3e2bfa572b..d5292d4246 100644
--- a/disas.c
+++ b/disas.c
@@ -8,6 +8,8 @@
 #include "disas/disas.h"
 #include "disas/capstone.h"
 
+#include "qemu/log-for-trace.h"
+
 typedef struct CPUDebug {
     struct disassemble_info info;
     CPUState *cpu;
@@ -420,6 +422,22 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
 # define cap_disas_monitor(i, p, c)  false
 #endif /* CONFIG_CAPSTONE */
 
+static int fprintf_log(struct _IO_FILE *a, const char *b, ...)
+{
+    va_list ap;
+    va_start(ap, b);
+
+    if (!to_string) {
+        vfprintf(a, b, ap);
+    } else {
+        qemu_vlog(b, ap);
+    }
+
+    va_end(ap);
+
+    return 1;
+}
+
 /* Disassemble this for me please... (debugging).  */
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
                   target_ulong size)
@@ -429,7 +447,7 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     int count;
     CPUDebug s;
 
-    INIT_DISASSEMBLE_INFO(s.info, out, fprintf);
+    INIT_DISASSEMBLE_INFO(s.info, out, fprintf_log);
 
     s.cpu = cpu;
     s.info.read_memory_func = target_read_memory;
@@ -460,11 +478,12 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     }
 
     for (pc = code; size > 0; pc += count, size -= count) {
-	fprintf(out, "0x" TARGET_FMT_lx ":  ", pc);
-	count = s.info.print_insn(pc, &s.info);
-	fprintf(out, "\n");
-	if (count < 0)
-	    break;
+        fprintf_log(out, "0x" TARGET_FMT_lx ":  ", pc);
+        count = s.info.print_insn(pc, &s.info);
+        fprintf_log(out, "\n");
+        if (count < 0) {
+            break;
+        }
         if (size < count) {
             fprintf(out,
                     "Disassembler disagrees with translator over instruction "
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c59444c461..f415479011 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -289,6 +289,30 @@ ETEXI
         .help       = "show dynamic compiler info",
         .cmd        = hmp_info_jit,
     },
+    {
+        .name       = "tb-list",
+        .args_type  = "number:i?,sortedby:s?",
+        .params     = "[number sortedby]",
+        .help       = "show a [number] translated blocks sorted by [sortedby]"
+                      "sortedby opts: hotness hg spills",
+        .cmd        = hmp_info_tblist,
+    },
+    {
+        .name       = "tb",
+        .args_type  = "id:i,flags:s?",
+        .params     = "id [flag1,flag2,...]",
+        .help       = "show information about one translated block by id."
+                      "dump flags can be used to set dump code level: out_asm in_asm op",
+        .cmd        = hmp_info_tb,
+    },
+    {
+        .name       = "coverset",
+        .args_type  = "coverage:i?",
+        .params     = "[coverage]",
+        .help       = "show hottest translated blocks neccesary to cover"
+                      "[coverage]% of the execution count",
+        .cmd        = hmp_info_coverset,
+    },
 #endif
 
 STEXI
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 65063c52d7..51d73e1c5f 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -35,8 +35,11 @@
 enum SortBy { SORT_BY_HOTNESS, SORT_BY_HG /* Host/Guest */, SORT_BY_SPILLS };
 enum TbstatsCmd { START, PAUSE, STOP, FILTER };
 
+#define tbs_stats_enabled(tbs, JIT_STATS) \
+    (tbs && (tbs->stats_enabled & JIT_STATS))
+
 #define tb_stats_enabled(tb, JIT_STATS) \
-    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
+    (tb && tb->tb_stats && tbs_stats_enabled(tb->tb_stats, JIT_STATS))
 
 #define stat_per_translation(stat, name) \
     (stat->translations.total ? stat->name / stat->translations.total : 0)
@@ -64,6 +67,8 @@ struct TBStatistics {
     struct {
         unsigned long normal;
         unsigned long atomic;
+        /* filled only when dumping x% cover set */
+        uint16_t coverage;
     } executions;
 
     struct {
@@ -82,7 +87,6 @@ struct TBStatistics {
 
     struct {
         unsigned long total;
-        unsigned long uncached;
         unsigned long spanning;
     } translations;
 
@@ -95,6 +99,9 @@ struct TBStatistics {
         int64_t la;
     } time;
 
+    /* HMP information - used for referring to previous search */
+    int display_id;
+
     /* current TB linked to this TBStatistics */
     TranslationBlock *tb;
 };
@@ -115,6 +122,40 @@ struct TbstatsCommand {
 
 void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
 
+/**
+ * dump_coverset_info: report the hottest blocks to cover n% of execution
+ *
+ * @percentage: cover set percentage
+ * @use_monitor: redirect output to monitor
+ *
+ * Report the hottest blocks to either the log or monitor
+ */
+void dump_coverset_info(int percentage, bool use_monitor);
+
+
+/**
+ * dump_tbs_info: report the hottest blocks
+ *
+ * @count: the limit of hotblocks
+ * @sort_by: property in which the dump will be sorted
+ * @use_monitor: redirect output to monitor
+ *
+ * Report the hottest blocks to either the log or monitor
+ */
+void dump_tbs_info(int count, int sort_by, bool use_monitor);
+
+/**
+ * dump_tb_info: dump information about one TB
+ *
+ * @id: the display id of the block (from previous search)
+ * @mask: the temporary logging mask
+ * @Use_monitor: redirect output to monitor
+ *
+ * Re-run a translation of a block at addr for the purposes of debug output
+ */
+void dump_tb_info(int id, int log_mask, bool use_monitor);
+
+
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index 2f0a5b080e..3de88484cb 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -20,6 +20,9 @@
 
 /* Private global variable, don't use */
 extern int qemu_loglevel;
+extern bool to_string;
+
+extern int32_t max_num_hot_tbs_to_dump;
 
 #define LOG_TRACE          (1 << 15)
 
@@ -31,5 +34,6 @@ static inline bool qemu_loglevel_mask(int mask)
 
 /* main logging function */
 int GCC_FMT_ATTR(1, 2) qemu_log(const char *fmt, ...);
+int qemu_vlog(const char *fmt, va_list va);
 
 #endif
diff --git a/include/qemu/log.h b/include/qemu/log.h
index a8d1997cde..804cf90f0f 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -114,6 +114,8 @@ typedef struct QEMULogItem {
 extern const QEMULogItem qemu_log_items[];
 
 void qemu_set_log(int log_flags);
+void qemu_log_to_monitor(bool enable);
+void qemu_log_to_string(bool enable, GString *s);
 void qemu_log_needs_buffers(void);
 void qemu_set_log_filename(const char *filename, Error **errp);
 void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
diff --git a/monitor/misc.c b/monitor/misc.c
index 218263d29a..b99c018124 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -504,6 +504,80 @@ static void hmp_tbstats(Monitor *mon, const QDict *qdict)
 
 }
 
+static void hmp_info_tblist(Monitor *mon, const QDict *qdict)
+{
+    int number_int;
+    const char *sortedby_str = NULL;
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+    if (!tb_ctx.tb_stats.map) {
+        error_report("no TB information recorded");
+        return;
+    }
+
+    number_int = qdict_get_try_int(qdict, "number", 10);
+    sortedby_str = qdict_get_try_str(qdict, "sortedby");
+
+    int sortedby = SORT_BY_HOTNESS;
+    if (sortedby_str == NULL || strcmp(sortedby_str, "hotness") == 0) {
+        sortedby = SORT_BY_HOTNESS;
+    } else if (strcmp(sortedby_str, "hg") == 0) {
+        sortedby = SORT_BY_HG;
+    } else if (strcmp(sortedby_str, "spills") == 0) {
+        sortedby = SORT_BY_SPILLS;
+    } else {
+        error_report("valid sort options are: hotness hg spills");
+        return;
+    }
+
+    dump_tbs_info(number_int, sortedby, true);
+}
+
+static void hmp_info_tb(Monitor *mon, const QDict *qdict)
+{
+    const int id = qdict_get_int(qdict, "id");
+    const char *flags = qdict_get_try_str(qdict, "flags");
+    int mask;
+
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+
+    mask = flags ? qemu_str_to_log_mask(flags) : CPU_LOG_TB_IN_ASM;
+
+    if (!mask) {
+        error_report("Unable to parse log flags, see 'help log'");
+        return;
+    }
+
+    dump_tb_info(id, mask, true);
+}
+
+static void hmp_info_coverset(Monitor *mon, const QDict *qdict)
+{
+    int coverage;
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+    if (!tb_stats_collection_enabled()) {
+        error_report("TB information not being recorded");
+        return;
+    }
+
+    coverage = qdict_get_try_int(qdict, "coverage", 90);
+
+    if (coverage < 0 || coverage > 100) {
+        error_report("Coverset percentage should be between 0 and 100");
+        return;
+    }
+
+    dump_coverset_info(coverage, true);
+}
+
 static void hmp_info_jit(Monitor *mon, const QDict *qdict)
 {
     if (!tcg_enabled()) {
diff --git a/util/log.c b/util/log.c
index c3805b331b..698b48d083 100644
--- a/util/log.c
+++ b/util/log.c
@@ -33,28 +33,58 @@ int qemu_loglevel;
 static int log_append = 0;
 static GArray *debug_regions;
 int32_t max_num_hot_tbs_to_dump;
+static bool to_monitor;
+bool to_string;
 
 int tcg_collect_tb_stats;
 uint32_t default_tbstats_flag;
 
-/* Return the number of characters emitted.  */
-int qemu_log(const char *fmt, ...)
+GString *string;
+
+int qemu_vlog(const char *fmt, va_list va)
 {
     int ret = 0;
-    if (qemu_logfile) {
-        va_list ap;
-        va_start(ap, fmt);
-        ret = vfprintf(qemu_logfile, fmt, ap);
-        va_end(ap);
-
-        /* Don't pass back error results.  */
-        if (ret < 0) {
-            ret = 0;
+    if (to_string) {
+        if (string) {
+            g_string_append_vprintf(string, fmt, va);
         }
+    } else if (to_monitor) {
+        ret = qemu_vprintf(fmt, va);
+    } else if (qemu_logfile) {
+        ret = vfprintf(qemu_logfile, fmt, va);
+    }
+
+    /* Don't pass back error results.  */
+    if (ret < 0) {
+        ret = 0;
     }
     return ret;
 }
 
+/* Return the number of characters emitted.  */
+int qemu_log(const char *fmt, ...)
+{
+    int ret = 0;
+    va_list ap;
+    va_start(ap, fmt);
+
+    ret = qemu_vlog(fmt, ap);
+
+    va_end(ap);
+    return ret;
+}
+
+void qemu_log_to_monitor(bool enable)
+{
+    to_monitor = enable;
+}
+
+void qemu_log_to_string(bool enable, GString *s)
+{
+    to_string = enable;
+    string = s;
+}
+
 static bool log_uses_own_buffers;
 
 /* enable or disable low levels log */
-- 
2.22.0


