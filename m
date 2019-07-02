Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22294C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4138218B6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGmP6FaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4138218B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiPyO-00011j-6E
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 17:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPuL-0007Vx-56
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPuE-0002yc-40
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:01:44 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:42087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hiPuD-0002Wr-PO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:01:37 -0400
Received: by mail-qk1-x741.google.com with SMTP id b18so15572009qkc.9
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LjINaP8tzwGdbq8Iwzbck262QU0WP1SzxhlO19ZPZdA=;
 b=jGmP6FaAswmNwEKtbEJ2l2lgOd5+Up6YoTWj8hfLNDrifB1jbXc/5wRERk6VGw8f16
 VlnANTRCAA1gTYTpyNnkLl8OPrxQ+bH/cDQ4IMf9IAcMnCyIj8TnQeN336MjeJBm3D2D
 cny0lCL541jrW3RhmJOwJMFtZV/x7CKraK8ivSB3W23R9lAlfGB8oMdZa3Q3nKIlbU6c
 RxdCFYwfaULH5KlEPHgolraoljSZ7utsonUQ5YHE3o62C/WoXa4IlTB2lZreFfCedMwd
 JtjTPfacX9gOJa2De3t5npSDyba3i8K8oednk03bWDAOXJ9TP7PKMD8xpKPNPEarzYd2
 XLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LjINaP8tzwGdbq8Iwzbck262QU0WP1SzxhlO19ZPZdA=;
 b=eCi8LC4qAlTAD3iUOfT9Msq00EOjMTdcpWqNQhZ6wKb3EBZDwi2IMG+vr1c34h2AVx
 cLvWkRpxhVawRHWykhFV5xG5XeU2FS3t68U/BgQr4fPx01WiXy21ziYUnv0+QR5TFPna
 7V7AomTAaEQrMs1WCVB40+kjK0RaP1hbJxYHakQDjyJOXN+s0a8aAcFsbakPOs5tzKiG
 BfySDW1Hp7y4uCH0CwqAj30+/J6IXtmZjUDzvRfAeliNu7m9G9haZaC0P4bcfrv2vOlj
 B36/5CkDekC9zwNPIwq7MV2CvqIzGaX8y/puZelSctaK80M2Iv8s0beIN5O4kC+SIKBF
 723A==
X-Gm-Message-State: APjAAAUnhztuqxi6y0Zrqrq8OKHGQn3Hd1pU0M9azMEzniAaQs30JFLw
 lvktfn1UigisybD/UNH7r3R5WRld
X-Google-Smtp-Source: APXvYqxMO/YvffrrrbHoS2xNdQ900oSWvX/c357KjpOyL1HqulUP9eRvu38EzTO/UC/NPT+k3Rcgew==
X-Received: by 2002:a37:b8c:: with SMTP id 134mr23998838qkl.160.1562101247922; 
 Tue, 02 Jul 2019 14:00:47 -0700 (PDT)
Received: from vanderson-lmcad.HotSpot300 ([189.61.239.22])
 by smtp.googlemail.com with ESMTPSA id
 s127sm6770979qkd.107.2019.07.02.14.00.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 14:00:47 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:00:12 -0300
Message-Id: <20190702210017.4275-1-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v3 1/6] accel/tcg: adding structure to store TB
 statistics
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

We want to store statistics for each TB even after flushes.
We do not want to modify or grow the TB struct.
So we create a new struct to contain this statistics and
we link one of it to each TB as they are generated.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/translate-all.c | 60 +++++++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h   | 46 ++++++++++++++++++++++++++++++
 include/exec/tb-context.h |  1 +
 include/exec/tb-hash.h    |  7 +++++
 include/qemu/log.h        |  1 +
 5 files changed, 115 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..d05803a142 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1132,11 +1132,31 @@ static bool tb_cmp(const void *ap, const void *bp)
         a->page_addr[1] == b->page_addr[1];
 }
 
+/*
+ * This is the more or less the same compare, but the data persists
+ * over tb_flush. We also aggregate the various variations of cflags
+ * under one record and ignore the details of page overlap (although
+ * we can count it).
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
 static void tb_htable_init(void)
 {
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
 
     qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
+    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
+        qht_init(&tb_ctx.tb_stats, tb_stats_cmp, CODE_GEN_HTABLE_SIZE, mode);
+    }
 }
 
 /* Must be called before using the QEMU cpus. 'tb_size' is the size
@@ -1586,6 +1606,31 @@ static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
 #endif
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
 /* add a new TB and link it to the physical page tables. phys_page2 is
  * (-1) to indicate that only one page contains the TB.
  *
@@ -1732,6 +1777,21 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     ti = profile_getclock();
 #endif
 
+    /*
+     * We want to fetch the stats structure before we start code
+     * generation so we can count interesting things about this
+     * generation.
+     *
+     * XXX: using loglevel is fugly - we should have a general flag
+     */
+    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS) && qemu_log_in_addr_range(tb->pc)) {
+        tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
+        /* XXX: should we lock and update in bulk? */
+        atomic_inc(&tb->tb_stats->translations.total);
+    } else {
+        tb->tb_stats = NULL;
+    }
+
     tcg_func_start(tcg_ctx);
 
     tcg_ctx->cpu = env_cpu(env);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 16034ee651..a4bcd9b6df 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -324,6 +324,49 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 #define CODE_GEN_AVG_BLOCK_SIZE 150
 #endif
 
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
+
+    /* Translation stats */
+    struct {
+        unsigned long total;
+        unsigned long uncached;
+        unsigned long spanning;
+        /* XXX: count invalidation? */
+    } translations;
+
+    /* Execution stats */
+    struct {
+        unsigned long total;
+        unsigned long atomic;
+    } executions;
+
+    struct {
+        unsigned num_guest_inst;
+        unsigned num_host_inst;
+        unsigned num_tcg_inst;
+    } code;
+
+    /* HMP information - used for referring to previous search */
+    int display_id;
+};
+
+bool tb_stats_cmp(const void *ap, const void *bp);
+
 /*
  * Translation Cache-related fields of a TB.
  * This struct exists just for convenience; we keep track of TB's in a binary
@@ -403,6 +446,9 @@ struct TranslationBlock {
     uintptr_t jmp_list_head;
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_dest[2];
+
+    /* Pointer to a struct where statistics from the TB is stored */
+    TBStatistics *tb_stats;
 };
 
 extern bool parallel_cpus;
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index feb585e0a7..a4decb5d1f 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -35,6 +35,7 @@ struct TBContext {
 
     /* statistics */
     unsigned tb_flush_count;
+    struct qht tb_stats;
 };
 
 extern TBContext tb_ctx;
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 4f3a37d927..54c477fe79 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -64,4 +64,11 @@ uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
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
diff --git a/include/qemu/log.h b/include/qemu/log.h
index b097a6cae1..2fca65dd01 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
 /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 #define CPU_LOG_TB_FPU     (1 << 17)
+#define CPU_LOG_HOT_TBS    (1 << 18)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
-- 
2.22.0


