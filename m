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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90106C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 05:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F7D2083D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 05:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqN/g5VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F7D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfHzy-0003Rh-JG
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 01:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35129)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfHxG-0000gN-5h
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfHxF-0003xE-5n
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:50 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hfHxF-0003x4-1q
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:49 -0400
Received: by mail-qk1-x741.google.com with SMTP id a27so8864418qkk.5
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 22:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lj7QrdjZw8J8skBaTRgg83iCd0ZIi47fBBWlzMh6hoo=;
 b=HqN/g5VSc1Qut9rTZaKZ+q3YOe26cRbwvPHu3+rl6oOrZv92USCePDZQ33IanSpbm0
 LLC78mrUF+97lVX4VyPwSmIT1BaLhMpyd0W0Q1+8hmL7YSHVIxZj+82jJLWHVF1HNOtZ
 3h0epNWnyHQpKLt8YHH7h70Hn2/goliAFUA6wwjzl9hGwps2e3Jk4ZZNCJ6vTvI+UPFP
 u+p0rYroo0RiamxMqVxbCjk4kfd5vxwLNFRhUnOhEtvfyZAOf+/zyJdsQfbYquAltCqI
 3DlqMAK+GhcohkHDCOa5wARkF4GPnw5DyS8r6W4utIPVMfo8F1lzabfKaoqz6EY+13t/
 T+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lj7QrdjZw8J8skBaTRgg83iCd0ZIi47fBBWlzMh6hoo=;
 b=TyKVSp7ZfgEVCnHTaM4ru1AODoJT8RGGZ6xxs2osgV56/f5ekohQ6cC6JZy2TyMpqA
 fVCenDBAuOG9oEj8I2S9M35eT8NcdfJDtYbZa5XGEhabtzqwdHL+ggIPC+z/fyEzhuWT
 M1OgR57fcpD48+XEKrW6lRvgPwyPOe241FgVu9CRrplZudSQ8nug3YFdCxXht4WnQC4n
 mf692aqVSa3CWB+hEWKT88ZVuHR0kvixb7dultlrZc8h1rPF4qxibD16Vj/UzFgZrRvy
 VZLEffUTgsQLOhaRSrFblTOkf9qa6q3mVX73OWNEgJHsYQnsFRO+vIrX0y6x32mSCeAl
 Lr+Q==
X-Gm-Message-State: APjAAAUKML/Zjiahk3TgUFq9px7KX2OCAaekRIdRPx+4GmwQ4vKFTHfm
 1+8S3u0DS56vcHTE1QXF7+ol3wfE
X-Google-Smtp-Source: APXvYqz8upaVh3h091fMXQLCDpAyOnTByG05zGw31YLfNriAKNZPj7QeiQD7QxjIL6qSD4tmcBloeA==
X-Received: by 2002:a05:620a:15a5:: with SMTP id
 f5mr81491822qkk.45.1561355748199; 
 Sun, 23 Jun 2019 22:55:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:548d:5237:c368:80a0:cb96:64bf])
 by smtp.googlemail.com with ESMTPSA id t80sm5154440qka.87.2019.06.23.22.55.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 23 Jun 2019 22:55:47 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 02:54:41 -0300
Message-Id: <20190624055442.2973-4-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624055442.2973-1-vandersonmr2@gmail.com>
References: <20190624055442.2973-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v2 3/4] Introduce dump of hot TBs
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

Adding a function to dump the Nth hottest TBs.
The block PC, execution count and ops is dump to the log.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/translate-all.c | 45 +++++++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h   |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f7e99f90e0..c3d9ecb2c4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1240,6 +1240,27 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
     return false;
 }
 
+static void tb_dump_statistics(TBStatistics *tbs)
+{
+    uint32_t cflags = curr_cflags() | CF_NOCACHE;
+    int old_log_flags = qemu_loglevel;
+
+    qemu_set_log(CPU_LOG_TB_OP_OPT);
+
+    qemu_log("\n------------------------------\n");
+    qemu_log("Translation Block PC: \t0x"TARGET_FMT_lx "\n", tbs->pc);
+    qemu_log("Execution Count: \t%lu\n\n", (uint64_t) (tbs->exec_count + tbs->exec_count_overflows*0xFFFFFFFF));
+
+    mmap_lock();
+    TranslationBlock *tb = tb_gen_code(current_cpu, tbs->pc, tbs->cs_base, tbs->flags, cflags);
+    tb_phys_invalidate(tb, -1);
+    mmap_unlock();
+
+    qemu_set_log(old_log_flags);
+
+    tcg_tb_remove(tb);
+}
+
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
@@ -1276,6 +1297,30 @@ done:
     mmap_unlock();
 }
 
+static gint inverse_sort_tbs(gconstpointer p1, gconstpointer p2) 
+{
+    const TBStatistics *tbs1 = (TBStatistics *) p1;
+    const TBStatistics *tbs2 = (TBStatistics *) p2;
+    uint64_t p1_count = (uint64_t) (tbs1->exec_count + tbs1->exec_count_overflows*0xFFFFFFFF);
+    uint64_t p2_count = (uint64_t) (tbs2->exec_count + tbs2->exec_count_overflows*0xFFFFFFFF);
+
+    return p1_count < p2_count ? 1 : p1_count == p2_count ? 0 : -1;
+}
+
+void tb_dump_exec_freq(uint32_t max_tbs_to_print)
+{
+    tb_ctx.tb_statistics = g_list_sort(tb_ctx.tb_statistics, inverse_sort_tbs);
+
+    uint32_t tbs_printed = 0;
+    for (GList *i = tb_ctx.tb_statistics; i != NULL; i = i->next) {
+        tbs_printed++;
+	    tb_dump_statistics((TBStatistics *) i->data);
+        if (max_tbs_to_print != 0 && tbs_printed >= max_tbs_to_print) {
+            break;
+        }
+    }
+}
+
 void tb_flush(CPUState *cpu)
 {
     if (tcg_enabled()) {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 359100ef3b..0547db0271 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -533,4 +533,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
 /* vl.c */
 extern int singlestep;
 
+void tb_dump_exec_freq(uint32_t);
+
 #endif
-- 
2.22.0


