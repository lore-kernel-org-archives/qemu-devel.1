Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BBC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1880420640
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQuUOSgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1880420640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHV9S-0005VX-TL
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwH-0002Wu-RS
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwF-00058L-LC
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwF-00056N-Cs
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id p7so13155639wmp.4
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iek8Qe/zrNC0/kJNkNMtZvO/A84+ne8Hmh0aHdialcc=;
 b=AQuUOSgQilvgiisA56Uw+1RSoVBC2Sw2dAG35RlozMv3I1H7KT42nrVlsmTNfsYB9j
 +nsYKNZYFj+8VNTROD1mXcvrrovutt1qLbV5QWBWl6/IcDNw3QzZHbFh6m6EyJhCEpI4
 +sjQHkEQWkKNraARYgBmz5o5MDUSzBk2Kbp4RpT7Sj0JqNiAeSGL3LyBuZ9tFUcc+ij5
 Olknguw0P1ys2oNHzDKdfLMgJHVJcEImpoi7p8M7xRCzRuiw4Ov7tt0mNP9INIw+RKbe
 EHPwArHhmB0N+70N+3N6O0Di/FEzWdjFAekVZox41dePNnPIbUMbvGaO2EmUMSAAecRT
 L5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iek8Qe/zrNC0/kJNkNMtZvO/A84+ne8Hmh0aHdialcc=;
 b=cMQ2r5T2d9ykBy1DngWU5sSENm/sMoT5/0Uswo6ev4U7ecwov9h7Oxwd2UmG5nXeom
 /pTf7Tme4Glb7jaFP4DIfAnobnw/wDOPfBHzOP2VkkuaQHImuzA2LJMcxeNr+MKCku3O
 OJ/Fk+psPsK9w3DnyS4z2w2btBJPmMkw+hANEhUXV6zuNwY5DvCd2EvnmtnhCAXWs/h8
 SkxE/09xLOufWgjQdlPZe+CYDPgcVng7Jarq6/IrGGTTPt0xJSLmHt6B065bA4P4Z40K
 OJ7Ui5/JLh5oQ3ngCM/JNWEAKVTB06RT8Noso5bRqZ6jEiWRHJZDeYdvuYuYWa4e4KD1
 0g2A==
X-Gm-Message-State: APjAAAUl/pDx4jnmjmafVYsLpQQGXTQ0kp6LJbRv0ttX7ND4PlfxFEcA
 K6kkn/Kh4jqExHU8MQ2nAgQhYg==
X-Google-Smtp-Source: APXvYqz2nAMnlEWeY97HR1v74wdonmdjAzGCCw1SxzQQIB07GWNBNnbYCIkyu6qMrunSYiMXEV9wNw==
X-Received: by 2002:a05:600c:295d:: with SMTP id
 n29mr19925671wmd.36.1570462122021; 
 Mon, 07 Oct 2019 08:28:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l9sm15548131wme.45.2019.10.07.08.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 43F041FF8C;
 Mon,  7 Oct 2019 16:28:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v9 01/13] accel/tcg: introduce TBStatistics structure
Date: Mon,  7 Oct 2019 16:28:27 +0100
Message-Id: <20191007152839.30804-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

To store statistics for each TB, we created a TBStatistics structure
which is linked with the TBs. TBStatistics can stay alive after
tb_flush and be relinked to a regenerated TB. So the statistics can
be accumulated even through flushes.

The goal is to have all present and future qemu/tcg statistics and
meta-data stored in this new structure.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-2-vandersonmr2@gmail.com>
[AJB: fix git author, review comments]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
AJB
  - move tcg_collect_tb_stats inside tb-stats.c
  - add spdx header
  - drop tb from tbstats and associated functions
---
 accel/tcg/Makefile.objs   |  2 +-
 accel/tcg/tb-stats.c      | 52 +++++++++++++++++++++++++++++++++
 accel/tcg/translate-all.c | 60 ++++++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h   | 15 +++-------
 include/exec/tb-context.h | 12 ++++++++
 include/exec/tb-hash.h    |  7 +++++
 include/exec/tb-stats.h   | 61 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 197 insertions(+), 12 deletions(-)
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 include/exec/tb-stats.h

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
index 0000000000..8208f4a0ad
--- /dev/null
+++ b/accel/tcg/tb-stats.c
@@ -0,0 +1,52 @@
+/*
+ * QEMU System Emulator, Code Quality Monitor System
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "disas/disas.h"
+
+#include "exec/tb-stats.h"
+
+/* TBStatistic collection controls */
+enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED };
+
+static enum TBStatsStatus tcg_collect_tb_stats;
+
+void init_tb_stats_htable_if_not(void)
+{
+    if (tb_stats_collection_enabled() && !tb_ctx.tb_stats.map) {
+        qht_init(&tb_ctx.tb_stats, tb_stats_cmp,
+                CODE_GEN_HTABLE_SIZE, QHT_MODE_AUTO_RESIZE);
+    }
+}
+
+void enable_collect_tb_stats(void)
+{
+    init_tb_stats_htable_if_not();
+    tcg_collect_tb_stats = TB_STATS_RUNNING;
+}
+
+void disable_collect_tb_stats(void)
+{
+    tcg_collect_tb_stats = TB_STATS_PAUSED;
+}
+
+void pause_collect_tb_stats(void)
+{
+    tcg_collect_tb_stats = TB_STATS_STOPPED;
+}
+
+bool tb_stats_collection_enabled(void)
+{
+    return tcg_collect_tb_stats == TB_STATS_RUNNING;
+}
+
+bool tb_stats_collection_paused(void)
+{
+    return tcg_collect_tb_stats == TB_STATS_PAUSED;
+}
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 66d4bc4341..114ebe48bf 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1118,6 +1118,23 @@ static inline void code_gen_alloc(size_t tb_size)
     }
 }
 
+/*
+ * This is the more or less the same compare as tb_cmp(), but the
+ * data persists over tb_flush. We also aggregate the various
+ * variations of cflags under one record and ignore the details of
+ * page overlap (although we can count it).
+ */
+bool tb_stats_cmp(const void *ap, const void *bp)
+{
+    const TBStatistics *a = ap;
+    const TBStatistics *b = bp;
+
+    return a->phys_pc == b->phys_pc &&
+        a->pc == b->pc &&
+        a->cs_base == b->cs_base &&
+        a->flags == b->flags;
+}
+
 static bool tb_cmp(const void *ap, const void *bp)
 {
     const TranslationBlock *a = ap;
@@ -1137,6 +1154,7 @@ static void tb_htable_init(void)
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
 
     qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
+    init_tb_stats_htable_if_not();
 }
 
 /* Must be called before using the QEMU cpus. 'tb_size' is the size
@@ -1666,6 +1684,37 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     return tb;
 }
 
+static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
+                                  target_ulong cs_base, uint32_t flags)
+{
+    TBStatistics *new_stats = g_new0(TBStatistics, 1);
+    uint32_t hash = tb_stats_hash_func(phys_pc, pc, flags);
+    void *existing_stats = NULL;
+    new_stats->phys_pc = phys_pc;
+    new_stats->pc = pc;
+    new_stats->cs_base = cs_base;
+    new_stats->flags = flags;
+
+    /*
+     * All initialisation must be complete before we insert into qht
+     * table otherwise another thread might get a partially created
+     * structure.
+     */
+    qht_insert(&tb_ctx.tb_stats, new_stats, hash, &existing_stats);
+
+    if (unlikely(existing_stats)) {
+        /*
+         * If there is already a TBStatistic for this TB from a previous flush
+         * then just make the new TB point to the older TBStatistic
+         */
+        g_free(new_stats);
+        return existing_stats;
+    } else {
+        return new_stats;
+    }
+}
+
+
 /* Called with mmap_lock held for user mode emulation.  */
 TranslationBlock *tb_gen_code(CPUState *cpu,
                               target_ulong pc, target_ulong cs_base,
@@ -1732,6 +1781,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     ti = profile_getclock();
 #endif
 
+    /*
+     * We want to fetch the stats structure before we start code
+     * generation so we can count interesting things about this
+     * generation.
+     */
+    if (tb_stats_collection_enabled()) {
+        tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
+    } else {
+        tb->tb_stats = NULL;
+    }
+
     tcg_func_start(tcg_ctx);
 
     tcg_ctx->cpu = env_cpu(env);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 49db07ba0b..73b15db7a7 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -23,21 +23,11 @@
 #include "cpu.h"
 #include "exec/tb-context.h"
 #include "sysemu/cpus.h"
+#include "exec/tb-stats.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
 #define DEBUG_DISAS
 
-/* Page tracking code uses ram addresses in system mode, and virtual
-   addresses in userspace mode.  Define tb_page_addr_t to be an appropriate
-   type.  */
-#if defined(CONFIG_USER_ONLY)
-typedef abi_ulong tb_page_addr_t;
-#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
-#else
-typedef ram_addr_t tb_page_addr_t;
-#define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
-#endif
-
 #include "qemu/log.h"
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns);
@@ -410,6 +400,9 @@ struct TranslationBlock {
     uintptr_t jmp_list_head;
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_dest[2];
+
+    /* Pointer to a struct where statistics from the TB is stored */
+    TBStatistics *tb_stats;
 };
 
 extern bool parallel_cpus;
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index feb585e0a7..3cfb62a338 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -23,6 +23,17 @@
 #include "qemu/thread.h"
 #include "qemu/qht.h"
 
+/* Page tracking code uses ram addresses in system mode, and virtual
+   addresses in userspace mode.  Define tb_page_addr_t to be an appropriate
+   type.  */
+#if defined(CONFIG_USER_ONLY)
+typedef abi_ulong tb_page_addr_t;
+#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
+#else
+typedef ram_addr_t tb_page_addr_t;
+#define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
+#endif
+
 #define CODE_GEN_HTABLE_BITS     15
 #define CODE_GEN_HTABLE_SIZE     (1 << CODE_GEN_HTABLE_BITS)
 
@@ -35,6 +46,7 @@ struct TBContext {
 
     /* statistics */
     unsigned tb_flush_count;
+    struct qht tb_stats;
 };
 
 extern TBContext tb_ctx;
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 805235d321..dd8e8f252a 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -66,4 +66,11 @@ uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
     return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
 }
 
+static inline
+uint32_t tb_stats_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
+                            uint32_t flags)
+{
+    return qemu_xxhash5(phys_pc, pc, flags);
+}
+
 #endif
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
new file mode 100644
index 0000000000..4be6522da0
--- /dev/null
+++ b/include/exec/tb-stats.h
@@ -0,0 +1,61 @@
+/*
+ * QEMU System Emulator, Code Quality Monitor System
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef TB_STATS_H
+
+#define TB_STATS_H
+
+#include "exec/cpu-common.h"
+#include "exec/tb-context.h"
+#include "tcg.h"
+
+typedef struct TBStatistics TBStatistics;
+
+/*
+ * This struct stores statistics such as execution count of the
+ * TranslationBlocks. Each sets of TBs for a given phys_pc/pc/flags
+ * has its own TBStatistics which will persist over tb_flush.
+ *
+ * We include additional counters to track number of translations as
+ * well as variants for compile flags.
+ */
+struct TBStatistics {
+    tb_page_addr_t phys_pc;
+    target_ulong pc;
+    uint32_t     flags;
+    /* cs_base isn't included in the hash but we do check for matches */
+    target_ulong cs_base;
+};
+
+bool tb_stats_cmp(const void *ap, const void *bp);
+
+void init_tb_stats_htable_if_not(void);
+
+void enable_collect_tb_stats(void);
+void disable_collect_tb_stats(void);
+void pause_collect_tb_stats(void);
+bool tb_stats_collection_enabled(void);
+bool tb_stats_collection_paused(void);
+
+#endif
-- 
2.20.1


