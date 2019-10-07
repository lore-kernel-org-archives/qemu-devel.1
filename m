Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE67C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7833720640
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4sJ4dW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7833720640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHV4R-0000aS-Qs
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwG-0002Uu-8Q
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwE-00055l-JQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwE-000545-AI
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:42 -0400
Received: by mail-wm1-x341.google.com with SMTP id v17so12818975wml.4
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jiinz3d2F99RIXRll0ualSf17q0g/ADEbP78O4FLO4Y=;
 b=R4sJ4dW2NklQ96IyVjLN9AfmmJgowWqJSewdwHBwxGD/rxO6l+LWGQnlgCyIXy/oaV
 hMyq3hr7K/IsEhBDzTcETIY3+kgxsF3iNOVQfcs0/uLRHcG4mhm6d9CajM/C8lUt6o/r
 IUfsF/r5/ylJC4z6/SzpjI6KJFH3Sl6/dPK0DK68BhHTS5h90kMPS3l/5PrXcN71HlbA
 8T8STcIHG9Q54TBmpj8XwvubhnbNh4f5AUucVhLTSxAxmGRqCTOImpSLRTVBvMNuBpwf
 sIQfCwmFhs8xEAfqpus9z3YKggJtbJnN6KPV3rYTyE5ZoqgxjXyD5Jqj3RGbSpJhRCEa
 +uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jiinz3d2F99RIXRll0ualSf17q0g/ADEbP78O4FLO4Y=;
 b=pEDvSbi9aHS3AFnMbrLKlbT9WC1Ybdcv8FBcmHZgIzAcDrXWQJWgPXAC9q8tYXD3Hm
 2fUxy6ypKj1xOcxEnQ+swrCtfh42qNnivIr5sVhLUrJHbGwaU7ARoH4RW62DXcZ+bz2o
 tfVsGJzWKzxCviQoM96cJDsQBYv1O3ROfgn7WdCEHxQNnoMcB5HjDbl9FO6f19H5YIIY
 NcK6uVi9T8EVNfjyWrHFjbUSzLv4Yzl3hsexvTqWN9DdjrD5IC8+0RMbk5CGDx2Ifekm
 sswuvTaTy3xNkeJoWs4v8CKjfNMx4TEjsnNUSL2GAXsgdS5mrBN+0y53LBekzboVL9eW
 TDdQ==
X-Gm-Message-State: APjAAAVNDwv2QHraCPlRCgvVFYw0wzxOUPxxzRxej29DPSRRRypWPL+O
 /JuGSI8/cm/j7ZC7KDc9wW1/Ow==
X-Google-Smtp-Source: APXvYqzPPyMmjzt5/eqF/cED2fPcnLnUFJvdQz1LVYQVPsLU7TcwFOgifi2youNgr8vWXCZ1BfEh1Q==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr20574835wmj.21.1570462121096; 
 Mon, 07 Oct 2019 08:28:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x2sm19782660wrn.81.2019.10.07.08.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 62A111FF8F;
 Mon,  7 Oct 2019 16:28:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v9 02/13] accel: collecting TB execution count
Date: Mon,  7 Oct 2019 16:28:28 +0100
Message-Id: <20191007152839.30804-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Message-Id: <20190829173437.5926-3-vandersonmr2@gmail.com>
[AJB: Fix author]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
AJB:
  - move default_tbstats_flag to tb-stats
  - hoist dfilter check
---
 accel/tcg/cpu-exec.c      |  4 ++++
 accel/tcg/tb-stats.c      |  6 ++++++
 accel/tcg/tcg-runtime.c   |  7 +++++++
 accel/tcg/tcg-runtime.h   |  2 ++
 accel/tcg/translate-all.c | 11 +++++++++--
 accel/tcg/translator.c    |  1 +
 include/exec/gen-icount.h |  9 +++++++++
 include/exec/tb-stats.h   | 18 ++++++++++++++++++
 8 files changed, 56 insertions(+), 2 deletions(-)

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
index 8208f4a0ad..ee0506bff1 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -16,6 +16,7 @@
 enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED };
 
 static enum TBStatsStatus tcg_collect_tb_stats;
+static uint32_t default_tbstats_flag;
 
 void init_tb_stats_htable_if_not(void)
 {
@@ -50,3 +51,8 @@ bool tb_stats_collection_paused(void)
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
index 114ebe48bf..b7dd1a78e5 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1784,10 +1784,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     /*
      * We want to fetch the stats structure before we start code
      * generation so we can count interesting things about this
-     * generation.
+     * generation. If dfilter is in effect we will only collect stats
+     * for the specified range.
      */
-    if (tb_stats_collection_enabled()) {
+    if (tb_stats_collection_enabled() &&
+        qemu_log_in_addr_range(tb->pc)) {
+        uint32_t flag = get_default_tbstats_flag();
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
+
+        if (flag & TB_EXEC_STATS) {
+            tb->tb_stats->stats_enabled |= TB_EXEC_STATS;
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
index 4be6522da0..51aecf65e2 100644
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
@@ -46,16 +49,31 @@ struct TBStatistics {
     uint32_t     flags;
     /* cs_base isn't included in the hash but we do check for matches */
     target_ulong cs_base;
+
+    /* which stats are enabled for this TBStats */
+    uint32_t stats_enabled;
+
+    /* Execution stats */
+    struct {
+        unsigned long normal;
+        unsigned long atomic;
+    } executions;
+
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
 
 void init_tb_stats_htable_if_not(void);
 
+#define TB_NOTHING    (1 << 0)
+#define TB_EXEC_STATS (1 << 1)
+
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
 void pause_collect_tb_stats(void);
 bool tb_stats_collection_enabled(void);
 bool tb_stats_collection_paused(void);
 
+uint32_t get_default_tbstats_flag(void);
+
 #endif
-- 
2.20.1


