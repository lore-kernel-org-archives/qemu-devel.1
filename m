Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3038CC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 05:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024C02089F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 05:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyFi7l09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024C02089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfHyD-0001g2-AU
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 01:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35106)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfHxD-0000ej-2g
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfHxB-0003tk-Pd
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:47 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hfHxB-0003sT-KD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:45 -0400
Received: by mail-qt1-x841.google.com with SMTP id i34so13250574qta.6
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 22:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BpTIchYsllR1Ah9JBFFUjXd10Do0JEFP6oFAE0/v72Q=;
 b=CyFi7l09n92itBblOOW3IjYwKnPliTj7euOFeCnmARL9SIfMwSFInIm1zS5dHF1Qow
 dwr1z0j62KNeNhqw7OULDDjICQDZ6z3L0e/T1q0AFWxi6HdVB3pqocmcwzLCx1G7ADkI
 zIui6cQqOMzJnrhNlyWP+P1vN3P8i+Dro+MrLPTywxe20eRuia0vjHyikKVbl8x/3Ph+
 yg6lAX1F1hhMn5hIoROcDMa/gqW8dt6YWh9kLvpvAIeTdwwRybf/9UHIR6w/IdQxoLiB
 6bOmw4X1mZL3RrVuQO1Ja/gfgrgMMnjKAfk69slH/zhj0JSMNKNDu3FBd2Nr4LYdlwH/
 E8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BpTIchYsllR1Ah9JBFFUjXd10Do0JEFP6oFAE0/v72Q=;
 b=mVO7FiJlKxWv2rQAVRCm2ftYKEs9mvZ5p2fNY6JQyj7WGnzVXtRS6oecteH7HwUzS6
 X9Rs7tH4V0btUpitkGykakMF2glLn+sDsGAjYT2qQi4KjVI3TydoFpITxQR+u/PIgAHr
 feNxnZ9FrxdA7Sz6aHr1vwr0LYHihabrkc8mABGFIsFEY2Z9vvRJesSZVo6K1WZqMm5I
 r8YlEnf/6gqjOX4FUJfSabq24nZgkugw/oJgZs5FxW0MIXQaxeVCXWbzeNdMEcWVe6uF
 2KGiwYa7sXPDHRxxRvGEC7JGiA/Evl+Ka73NVVxu3V5Www90tqoQnDE/2sQWI3NRfVE/
 /pAw==
X-Gm-Message-State: APjAAAXqFqxCDrfpq52rlui4+LtA8dx0zZP/Wn1IQoxcw1cOasecZuLr
 Gd8OKWXNr1YLhZ6X3NWvOjeYkpKB
X-Google-Smtp-Source: APXvYqzszH1VV7JZ4BaH6rJnwlWHtAEpFz7gnTBvW1GNCtNoRdp/lPe4SsAolKcsQejEdLOQrKoLGA==
X-Received: by 2002:a0c:92ab:: with SMTP id b40mr54771803qvb.129.1561355744121; 
 Sun, 23 Jun 2019 22:55:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:548d:5237:c368:80a0:cb96:64bf])
 by smtp.googlemail.com with ESMTPSA id t80sm5154440qka.87.2019.06.23.22.55.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 23 Jun 2019 22:55:43 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 02:54:39 -0300
Message-Id: <20190624055442.2973-2-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624055442.2973-1-vandersonmr2@gmail.com>
References: <20190624055442.2973-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v2 1/4] add and link a statistic struct to TBs
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
link it to each TB while they are created.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/translate-all.c | 40 +++++++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h   | 21 ++++++++++++++++++++
 include/exec/tb-context.h |  1 +
 include/qemu/log.h        |  1 +
 4 files changed, 63 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..f7e99f90e0 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1118,6 +1118,18 @@ static inline void code_gen_alloc(size_t tb_size)
     }
 }
 
+static gint statistics_cmp(gconstpointer p1, gconstpointer p2) 
+{
+    const TBStatistics *a = (TBStatistics *) p1;
+    const TBStatistics *b = (TBStatistics *) p2;
+
+    return (a->pc == b->pc && 
+		   a->cs_base == b->cs_base &&
+		   a->flags == b->flags && 
+	       a->page_addr[0] == b->page_addr[0] &&
+    	   a->page_addr[1] == b->page_addr[1]) ? 0 : 1; 
+}
+
 static bool tb_cmp(const void *ap, const void *bp)
 {
     const TranslationBlock *a = ap;
@@ -1586,6 +1598,29 @@ static inline void tb_page_add(PageDesc *p, TranslationBlock *tb,
 #endif
 }
 
+static void tb_insert_statistics_structure(TranslationBlock *tb) {
+    TBStatistics *new_stats = g_new0(TBStatistics, 1);
+    new_stats->pc = tb->pc;
+    new_stats->cs_base = tb->cs_base;
+    new_stats->flags = tb->flags;
+    new_stats->page_addr[0] = tb->page_addr[0];
+    new_stats->page_addr[1] = tb->page_addr[1];
+
+	GList *lookup_result = g_list_find_custom(tb_ctx.tb_statistics, new_stats, statistics_cmp);
+
+	if (lookup_result) {
+		/* If there is already a TBStatistic for this TB from a previous flush
+		* then just make the new TB point to the older TBStatistic
+		*/
+		free(new_stats);
+    	tb->tb_stats = lookup_result->data;
+	} else {
+		/* If not, then points to the new tb_statistics and add it to the hash */
+		tb->tb_stats = new_stats;
+    	tb_ctx.tb_statistics = g_list_prepend(tb_ctx.tb_statistics, new_stats);
+	}
+}
+
 /* add a new TB and link it to the physical page tables. phys_page2 is
  * (-1) to indicate that only one page contains the TB.
  *
@@ -1636,6 +1671,11 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
         void *existing_tb = NULL;
         uint32_t h;
 
+        if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
+        	/* create and link to its TB a structure to store statistics */
+        	tb_insert_statistics_structure(tb);
+		}
+
         /* add in the hash table */
         h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
                          tb->trace_vcpu_dstate);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 16034ee651..359100ef3b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -324,6 +324,24 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 #define CODE_GEN_AVG_BLOCK_SIZE 150
 #endif
 
+typedef struct TBStatistics TBStatistics;                                                                                                               
+
+/* 
+ * This struct stores statistics such as execution count of the TranslationBlocks.
+ * Each TB has its own TBStatistics. TBStatistics is suppose to live even after 
+ * flushes.
+ */
+struct TBStatistics {                                                                                                                                   
+    target_ulong pc;                                                                                                                                    
+    target_ulong cs_base;                                                                                                                               
+    uint32_t flags;                                                                                                                                     
+    tb_page_addr_t page_addr[2];                                                                                                                        
+
+    // total number of times that the related TB have being executed                                                                                    
+    uint32_t exec_count;                                                                                                                                
+    uint32_t exec_count_overflows;                                                                                                                      
+};  
+
 /*
  * Translation Cache-related fields of a TB.
  * This struct exists just for convenience; we keep track of TB's in a binary
@@ -403,6 +421,9 @@ struct TranslationBlock {
     uintptr_t jmp_list_head;
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_dest[2];
+
+    // Pointer to a struct where statistics from the TB is stored
+    TBStatistics *tb_stats;
 };
 
 extern bool parallel_cpus;
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index feb585e0a7..a78ce92e60 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -35,6 +35,7 @@ struct TBContext {
 
     /* statistics */
     unsigned tb_flush_count;
+    GList *tb_statistics;
 };
 
 extern TBContext tb_ctx;
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


