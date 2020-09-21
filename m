Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E7EC43635
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D556D2193E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9lrZwYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D556D2193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPu0-00058K-Mx
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPoo-000884-Jd
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:33947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPoe-0000HI-Mv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:38 -0400
Received: by mail-pf1-x42e.google.com with SMTP id k13so9393874pfg.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MS/1tLLb4oetx2r+bYB6y25h/eLEAPaiuMEVSm1K/g8=;
 b=N9lrZwYeB6sz4Au/Wa7vLEJQxFz1Hq1+Pi54ZVyAHlu3jeas0hx5YbwCPZ2PL6y1rb
 VMVdWornGQk074pgqRI+9VZOVnn6hQ888k8jZgOinddxZKlWKCptbmoG8JmoAInB1Ick
 mvkmPJ/k2uwHS/0aOiwrXwsyGWgUHb3bUa5nbUutjgyro/vG40pjixrbCUxCeRDWPRVm
 0cH13bfulCfJelGIj+qLm8mJW1eJHfNFiZ1dWLSe8yiZgAHPBB8685KcbJYSI5dCyxji
 6bFPS0fPxWKWBQRCU29RZxBU4Q8zAK5bJM6ZJ1w4em8iV9iqlIdzIhSvGDvW+GLCM25S
 OBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MS/1tLLb4oetx2r+bYB6y25h/eLEAPaiuMEVSm1K/g8=;
 b=iZqMbBlPldPMLyoBIdTE0LMJ/53LSV2iGBYN0tyJQtNy5Eti9wS8CvD9SNBfPe2PtO
 BmpSRomxq73i+0TUAN/OYPdQzihOo3rutpC0BkqclXWoQfe8aLbY3JhvplSpcWrAiqMi
 g+GokENnHaly8NdekfFQJeVv/s9nrdRulrrV0lVI6CAxv20B59id2nUmtv+sa7e28c/a
 7o24LrC+UXn7XpwLEp22wI8Hdvf8+UxQP5DbQXmHIAq3DWFV+uctrrx+fT9IuJhzZTEm
 aZqzJC+t1vodEw+Lu/5RcVzlUemQHtDi82lbCSBKGeVRsmnImLQGKYMvbFPj049sVMDn
 RHSw==
X-Gm-Message-State: AOAM532+ZyBEuXlb7V5Nq7wlqTEiJRHSiMTC+cwrpYEyA1ndD3XQy0Hx
 BlwQsgqW9O4KjKi+/vOsChMBH/XyAZW5GA==
X-Google-Smtp-Source: ABdhPJzuCCn1Tebi3TeLwaWpeFPHDk97r1qNyyEga1I1BpJibKdhWc3pBoPNAONA22Zz5NDsUjCYdg==
X-Received: by 2002:a05:6a00:2db:b029:142:2501:34ed with SMTP id
 b27-20020a056a0002dbb0290142250134edmr772645pft.70.1600710086865; 
 Mon, 21 Sep 2020 10:41:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x4sm12585379pfm.86.2020.09.21.10.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 10:41:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/11] disas: Move host asm annotations to tb_gen_code
Date: Mon, 21 Sep 2020 10:41:11 -0700
Message-Id: <20200921174118.39352-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921174118.39352-1-richard.henderson@linaro.org>
References: <20200921174118.39352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of creating GStrings and passing them into log_disas,
just print the annotations directly in tb_gen_code.

Fix the annotations for the slow paths of the TB, after the
part implementing the final guest instruction.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/disas.h     |  2 +-
 include/exec/log.h        |  4 ++--
 accel/tcg/translate-all.c | 24 +++++++++++++++---------
 disas.c                   | 29 +++++++++--------------------
 tcg/tcg.c                 |  4 ++--
 5 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/include/disas/disas.h b/include/disas/disas.h
index 1b6e035e32..36c33f6f19 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -7,7 +7,7 @@
 #include "cpu.h"
 
 /* Disassemble this for me please... (debugging). */
-void disas(FILE *out, void *code, unsigned long size, const char *note);
+void disas(FILE *out, void *code, unsigned long size);
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
                   target_ulong size);
 
diff --git a/include/exec/log.h b/include/exec/log.h
index 3ed797c1c8..fcc7b9e00b 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -56,13 +56,13 @@ static inline void log_target_disas(CPUState *cpu, target_ulong start,
     rcu_read_unlock();
 }
 
-static inline void log_disas(void *code, unsigned long size, const char *note)
+static inline void log_disas(void *code, unsigned long size)
 {
     QemuLogFile *logfile;
     rcu_read_lock();
     logfile = atomic_rcu_read(&qemu_logfile);
     if (logfile) {
-        disas(logfile->fd, code, size, note);
+        disas(logfile->fd, code, size);
     }
     rcu_read_unlock();
 }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2d83013633..2874104a6a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1815,10 +1815,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         qemu_log_in_addr_range(tb->pc)) {
         FILE *logfile = qemu_log_lock();
         int code_size, data_size = 0;
-        g_autoptr(GString) note = g_string_new("[tb header & initial instruction]");
-        size_t chunk_start = 0;
+        size_t chunk_start;
         int insn = 0;
-        qemu_log("OUT: [size=%d]\n", gen_code_size);
+
         if (tcg_ctx->data_gen_ptr) {
             code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
             data_size = gen_code_size - code_size;
@@ -1827,26 +1826,33 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         }
 
         /* Dump header and the first instruction */
+        qemu_log("OUT: [size=%d]\n", gen_code_size);
+        qemu_log("  -- guest addr 0x" TARGET_FMT_lx " + tb prologue\n",
+                 tcg_ctx->gen_insn_data[insn][0]);
         chunk_start = tcg_ctx->gen_insn_end_off[insn];
-        log_disas(tb->tc.ptr, chunk_start, note->str);
+        log_disas(tb->tc.ptr, chunk_start);
 
         /*
          * Dump each instruction chunk, wrapping up empty chunks into
          * the next instruction. The whole array is offset so the
          * first entry is the beginning of the 2nd instruction.
          */
-        while (insn <= tb->icount && chunk_start < code_size) {
+        while (insn < tb->icount) {
             size_t chunk_end = tcg_ctx->gen_insn_end_off[insn];
             if (chunk_end > chunk_start) {
-                g_string_printf(note, "[guest addr: " TARGET_FMT_lx "]",
-                                tcg_ctx->gen_insn_data[insn][0]);
-                log_disas(tb->tc.ptr + chunk_start, chunk_end - chunk_start,
-                          note->str);
+                qemu_log("  -- guest addr 0x" TARGET_FMT_lx "\n",
+                         tcg_ctx->gen_insn_data[insn][0]);
+                log_disas(tb->tc.ptr + chunk_start, chunk_end - chunk_start);
                 chunk_start = chunk_end;
             }
             insn++;
         }
 
+        if (chunk_start < code_size) {
+            qemu_log("  -- tb slow paths + alignment\n");
+            log_disas(tb->tc.ptr + chunk_start, code_size - chunk_start);
+        }
+
         /* Finally dump any data we may have after the block */
         if (data_size) {
             int i;
diff --git a/disas.c b/disas.c
index c1397d3933..a4304e8137 100644
--- a/disas.c
+++ b/disas.c
@@ -262,8 +262,7 @@ static void cap_dump_insn_units(disassemble_info *info, cs_insn *insn,
     }
 }
 
-static void cap_dump_insn(disassemble_info *info, cs_insn *insn,
-                          const char *note)
+static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
 {
     fprintf_function print = info->fprintf_func;
     int i, n, split;
@@ -284,11 +283,7 @@ static void cap_dump_insn(disassemble_info *info, cs_insn *insn,
     }
 
     /* Print the actual instruction.  */
-    print(info->stream, "  %-8s %s", insn->mnemonic, insn->op_str);
-    if (note) {
-        print(info->stream, "\t\t%s", note);
-    }
-    print(info->stream, "\n");
+    print(info->stream, "  %-8s %s\n", insn->mnemonic, insn->op_str);
 
     /* Dump any remaining part of the insn on subsequent lines.  */
     for (i = split; i < n; i += split) {
@@ -320,7 +315,7 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
         size -= tsize;
 
         while (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-            cap_dump_insn(info, insn, NULL);
+            cap_dump_insn(info, insn);
         }
 
         /* If the target memory is not consumed, go back for more... */
@@ -349,8 +344,7 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
 }
 
 /* Disassemble SIZE bytes at CODE for the host.  */
-static bool cap_disas_host(disassemble_info *info, void *code, size_t size,
-                           const char *note)
+static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
 {
     csh handle;
     const uint8_t *cbuf;
@@ -366,8 +360,7 @@ static bool cap_disas_host(disassemble_info *info, void *code, size_t size,
     pc = (uintptr_t)code;
 
     while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
-        cap_dump_insn(info, insn, note);
-        note = NULL;
+        cap_dump_insn(info, insn);
     }
     if (size != 0) {
         (*info->fprintf_func)(info->stream,
@@ -411,7 +404,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
         csize += tsize;
 
         if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-            cap_dump_insn(info, insn, NULL);
+            cap_dump_insn(info, insn);
             if (--count <= 0) {
                 break;
             }
@@ -425,7 +418,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
 #endif /* !CONFIG_USER_ONLY */
 #else
 # define cap_disas_target(i, p, s)  false
-# define cap_disas_host(i, p, s, n)  false
+# define cap_disas_host(i, p, s)  false
 # define cap_disas_monitor(i, p, c)  false
 # define cap_disas_plugin(i, p, c) false
 #endif /* CONFIG_CAPSTONE */
@@ -595,7 +588,7 @@ char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
 }
 
 /* Disassemble this for me please... (debugging). */
-void disas(FILE *out, void *code, unsigned long size, const char *note)
+void disas(FILE *out, void *code, unsigned long size)
 {
     uintptr_t pc;
     int count;
@@ -673,7 +666,7 @@ void disas(FILE *out, void *code, unsigned long size, const char *note)
     print_insn = print_insn_hppa;
 #endif
 
-    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size, note)) {
+    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
         return;
     }
 
@@ -683,10 +676,6 @@ void disas(FILE *out, void *code, unsigned long size, const char *note)
     for (pc = (uintptr_t)code; size > 0; pc += count, size -= count) {
         fprintf(out, "0x%08" PRIxPTR ":  ", pc);
         count = print_insn(pc, &s.info);
-        if (note) {
-            fprintf(out, "\t\t%s", note);
-            note = NULL;
-        }
         fprintf(out, "\n");
         if (count < 0) {
             break;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 62f299e36e..9a111ce604 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1101,7 +1101,7 @@ void tcg_prologue_init(TCGContext *s)
             size_t data_size = prologue_size - code_size;
             size_t i;
 
-            log_disas(buf0, code_size, NULL);
+            log_disas(buf0, code_size);
 
             for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
                 if (sizeof(tcg_target_ulong) == 8) {
@@ -1115,7 +1115,7 @@ void tcg_prologue_init(TCGContext *s)
                 }
             }
         } else {
-            log_disas(buf0, prologue_size, NULL);
+            log_disas(buf0, prologue_size);
         }
         qemu_log("\n");
         qemu_log_flush();
-- 
2.25.1


