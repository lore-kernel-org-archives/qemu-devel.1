Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852DEC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E2D2388B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXl4JIWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E2D2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmSV-0003J8-LD
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOf-0007yD-6W
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:09 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOW-0004Ks-7i
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:07 -0400
Received: by mail-pg1-x52d.google.com with SMTP id k133so7810101pgc.7
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CzXADkkcwqXZtobMqRgIZ6k008MJ95TKA8X3VHJ5T3U=;
 b=pXl4JIWdqO+G90JBZGgr51GEsVfBjrIMi/z5bvv4pJ3x8rj6ugGUqnB8/XzawS8NZO
 r2blOOhMXYLS5FQWjq72k4BCeuhhx9lUL53QWgo598aqBunR6tva+JB356DfpiNlqIIA
 3I0eztV0m9frnssLO1z711MDVMSE0S+IW44Ie/7DviAQTFOEPPnspIiIi0Ergw85DYlv
 d+gkNE4asJfM6mRqcd9c+OoeWLGOvfgU0gsQTKtPBGPOSeSBIGQ2/mONxR1jM4yEBU0N
 1473eWmHm7I5h+CX3QbgRRIydi8cijLly8RQF6U3LuL1nFanDMzJb/1Qi2yZeZD9TiMw
 xzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CzXADkkcwqXZtobMqRgIZ6k008MJ95TKA8X3VHJ5T3U=;
 b=bnEBF9vyJY+YUvrqHGWKDynntwzsGiQ6gjmCRIG8j0jABUMPpKg6egHSo6TzJ8igoE
 R9Ww2VS+CLNkIr8p8qvGbEJluzH8x1jY39cCSIaTWjyv6bkeQhOa5XIIt2Tl36CmKxaZ
 9TzR80jyvbderjJQ7MFyfqCC7RrOTya3tErfOwbbh1EQjAdIO6ziQ15UOCnmU2YY+0WB
 lDku0HHHQ7T7Z5XxWkdAPcxWe1r41BMDc3QoaPTG7Q3ky1vmt++kUmSCgdbPfHnNf+WE
 WFFC0a3TLO/MHdqMr3BLnJcq7qDd10bkHA7223r4dEvSI/DbkuBFYnocdTDpV/ZR8e1S
 AgWQ==
X-Gm-Message-State: AOAM533IBPjqY5bLsmKM6NcV/WEFPJXD6I5Qvr3zCUG6UbcKbLWiqWMv
 RUu0ez+YpsgfK7JzSb/ph3+cIOttClXHAw==
X-Google-Smtp-Source: ABdhPJxeOt/K4mKPisiJoAFF2GJFHZCvC457NNe/ITK8x5enway30MPhzQSnODDNeMiVlwQuqrbI6Q==
X-Received: by 2002:a17:902:b186:b029:d1:cc21:9a7d with SMTP id
 s6-20020a170902b186b02900d1cc219a7dmr5637042plr.8.1600796870648; 
 Tue, 22 Sep 2020 10:47:50 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:47:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] disas: Move host asm annotations to tb_gen_code
Date: Tue, 22 Sep 2020 10:47:34 -0700
Message-Id: <20200922174741.475876-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of creating GStrings and passing them into log_disas,
just print the annotations directly in tb_gen_code.

Fix the annotations for the slow paths of the TB, after the
part implementing the final guest instruction.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


