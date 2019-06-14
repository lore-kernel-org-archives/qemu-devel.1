Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C189C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D5A20866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVcdPK/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D5A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnCn-00038u-Fs
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hbmf0-0003My-5e
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hbmey-0007zb-P8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:54:30 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:35369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hbmey-0007z3-KU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:54:28 -0400
Received: by mail-qk1-x742.google.com with SMTP id l128so1707387qke.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PKjJ8WywQMhni5S/aI+GnLf+YqUEj6nxfGowAtVbIiE=;
 b=GVcdPK/5lQWaW5q7epnrdARJieE/83qoLH8JFEx57x40wbEgxaq68OxUfmA20B3lRM
 /3I3AG2v611yzWO4afdpWfejoD6PU80U6V0FWh+F0rg4thOKcuZocvdne+sTP13UkDRY
 sB/hlJewVDr92CZoNDcpqq74HxWwzAayQhCDctqhB+RdRZkrSybA99m9onvk9VntUN8v
 EeZ14h9ADI09hIeEE1nA7mZNJwjUmsKvy64ZemdC66isGfIXLB+bdICpMVweiCJnKDBe
 DRYWOCk4uKU2Ea/GYGSyZQcaKF+nYrVKOeIOuDimFEOPbv5olExLYAM1l5JZyvIfYay8
 /buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PKjJ8WywQMhni5S/aI+GnLf+YqUEj6nxfGowAtVbIiE=;
 b=ShIW1RzXq3GMXY+L21pzsE3MzvLvcbg1PRTaqZ6YoZ+F148OrEzIHZl30cDfenpIEf
 sI+L38tyTr9xXWlbHXLW8nz/jazeD/pMG9Lz8x1iNWCemftNVXrCHF38fVL4LjFugxAz
 ZsBKhaGZKYo85oUeC6sbXy654gtWGxCRGG2qh8cBqsaQqrntkxbS4jQKjoqQIJVVvCtA
 A5PIAJ3F69HMcnxv0aPC878bFJBO4wLH/eBs1rhdFCsl3MylKzYA18vso1mFKL6OED27
 vGeh0KCP5jayim3g9tijB0jqrUTF+zyIFEzYaJYbwKofkMLoQgIqW7mbcLFNsXkCeLEG
 ykSw==
X-Gm-Message-State: APjAAAWw1wK2aJw7Jal3G2x2eAPZKhQqABlueCYW4eryKQPBvhUmA59w
 GVasFk7KscUn0gzQeLB9//InHcDDjpQ=
X-Google-Smtp-Source: APXvYqwvOWwlyMP9epKbsJfRS+c13T5SDM2ql2jPRaisl1pRLyV6Lb1erMdNtfx+uKVcxFeT/Zy9Ww==
X-Received: by 2002:a37:8081:: with SMTP id b123mr6667396qkd.62.1560520467753; 
 Fri, 14 Jun 2019 06:54:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:548c:f96b:4e5b:86ef:e7bc:c1a0])
 by smtp.googlemail.com with ESMTPSA id 77sm1747150qkd.59.2019.06.14.06.54.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 06:54:27 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 10:53:30 -0300
Message-Id: <20190614135332.12777-3-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190614135332.12777-1-vandersonmr2@gmail.com>
References: <20190614135332.12777-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [Qemu-Devel][PATCH 2/3] Saving counters between
 tb_flush events.
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

A new hash map was added to store the accumulated execution
frequency of the TBs even after tb_flush events. A dump
function was also added as a way to visualize these frequencies.

Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
---
 accel/tcg/translate-all.c | 59 +++++++++++++++++++++++++++++++++++++++
 accel/tcg/translate-all.h |  2 ++
 exec.c                    |  7 +++++
 include/exec/exec-all.h   |  3 ++
 include/exec/tb-context.h |  9 ++++++
 include/qom/cpu.h         |  2 ++
 6 files changed, 82 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..0bc670ffad 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1118,6 +1118,12 @@ static inline void code_gen_alloc(size_t tb_size)
     }
 }
 
+static bool statistics_cmp(const void* ap, const void *bp) {
+    const TBStatistics *a = ap;
+    const TBStatistics *b = bp;
+    return a->pc == b->pc && a->cs_base == b->cs_base && a->flags == b->flags;
+}
+
 static bool tb_cmp(const void *ap, const void *bp)
 {
     const TranslationBlock *a = ap;
@@ -1137,6 +1143,7 @@ static void tb_htable_init(void)
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
 
     qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
+    qht_init(&tb_ctx.tb_statistics, statistics_cmp, CODE_GEN_HTABLE_SIZE, QHT_MODE_AUTO_RESIZE);
 }
 
 /* Must be called before using the QEMU cpus. 'tb_size' is the size
@@ -1228,6 +1235,53 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
     return false;
 }
 
+static void do_tb_dump_exec_freq(void *p, uint32_t hash, void *userp)
+{
+#if TARGET_LONG_SIZE == 8
+    TBStatistics *tbs = p;
+    printf("%016lx\t%lu\n", tbs->pc, tbs->total_exec_freq);
+#elif TARGET_LONG_SIZE == 4
+    TBStatistics *tbs = p;
+    printf("%016x\t%lu\n", tbs->pc, tbs->total_exec_freq);
+#endif
+}
+
+void tb_dump_all_exec_freq(void)
+{
+    tb_read_exec_freq();
+    qht_iter(&tb_ctx.tb_statistics, do_tb_dump_exec_freq, NULL);
+}
+
+static void do_tb_read_exec_freq(void *p, uint32_t hash, void *userp)
+{
+    TranslationBlock *tb = p;
+    TBStatistics tbscmp;
+    tbscmp.pc = tb->pc;
+    tbscmp.cs_base = tb->cs_base;
+    tbscmp.flags = tb->flags;
+
+    TBStatistics *tbs = qht_lookup(userp, &tbscmp, hash);
+
+    uint64_t exec_freq = tb_get_and_reset_exec_freq((TranslationBlock*) p);
+
+    if (tbs) {
+        tbs->total_exec_freq += exec_freq;
+    } else {
+        void *existing;
+        tbs = malloc(sizeof(TBStatistics));
+        tbs->total_exec_freq = exec_freq;
+        tbs->pc = tb->pc;
+        tbs->cs_base = tb->cs_base;
+        tbs->flags = tb->flags;
+        qht_insert(userp, tbs, hash, &existing);
+    }
+}
+
+void tb_read_exec_freq(void)
+{
+    qht_iter(&tb_ctx.htable, do_tb_read_exec_freq, &tb_ctx.tb_statistics);
+}
+
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
@@ -1252,6 +1306,10 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
         cpu_tb_jmp_cache_clear(cpu);
     }
 
+    if (enable_freq_count) {
+        tb_read_exec_freq();
+    }
+
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
 
@@ -1723,6 +1781,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->flags = flags;
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
+    tb->exec_freq = 0;
     tcg_ctx->tb_cflags = cflags;
  tb_overflow:
 
diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 64f5fd9a05..e13088c36d 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -32,6 +32,8 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access);
 void tb_check_watchpoint(CPUState *cpu);
 
+extern bool enable_freq_count;
+
 #ifdef CONFIG_USER_ONLY
 int page_unprotect(target_ulong address, uintptr_t pc);
 #endif
diff --git a/exec.c b/exec.c
index e7622d1956..9b64a012ee 100644
--- a/exec.c
+++ b/exec.c
@@ -1013,6 +1013,13 @@ const char *parse_cpu_option(const char *cpu_option)
     return cpu_type;
 }
 
+uint64_t tb_get_and_reset_exec_freq(TranslationBlock *tb)
+{
+    uint64_t exec_freq = atomic_load_acquire(&tb->exec_freq);
+    atomic_store_release(&tb->exec_freq, 0);
+    return exec_freq;
+}
+
 #if defined(CONFIG_USER_ONLY)
 void tb_invalidate_phys_addr(target_ulong addr)
 {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a80407622e..5d3d829d18 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -513,4 +513,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
 /* vl.c */
 extern int singlestep;
 
+void tb_read_exec_freq(void);
+void tb_dump_all_exec_freq(void);
+
 #endif
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index feb585e0a7..ba518d47a0 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -28,6 +28,14 @@
 
 typedef struct TranslationBlock TranslationBlock;
 typedef struct TBContext TBContext;
+typedef struct TBStatistics TBStatistics;
+
+struct TBStatistics {
+    target_ulong pc;
+    target_ulong cs_base;
+    uint32_t flags;
+    uint64_t total_exec_freq;
+};
 
 struct TBContext {
 
@@ -35,6 +43,7 @@ struct TBContext {
 
     /* statistics */
     unsigned tb_flush_count;
+    struct qht tb_statistics;
 };
 
 extern TBContext tb_ctx;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5ee0046b62..593c1f1137 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -474,6 +474,8 @@ static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
     }
 }
 
+uint64_t tb_get_and_reset_exec_freq(struct TranslationBlock*);
+
 /**
  * qemu_tcg_mttcg_enabled:
  * Check whether we are running MultiThread TCG or not.
-- 
2.22.0


