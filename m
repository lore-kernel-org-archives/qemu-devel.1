Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B59BC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E01206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9wP01wZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E01206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVfYX-0006mp-Ki
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQC-0007H1-U8
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQ9-0002rw-Pf
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:12 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVfQ9-0002qA-H0
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:09 -0500
Received: by mail-wr1-x443.google.com with SMTP id r10so11851587wrx.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=foxVFkukIuN7paaMzE4/YUfiP7VYKyDwOA+0UfKOdTQ=;
 b=x9wP01wZiLln14PjSlCZCsRs1iCDrYkLwswudyWg92IAQZy1pUcLcBpID8iz0fFKWn
 VkBM0R87iYcOvJPa/cdMzOtLL0U1X93y0izcWBM5HVlJcjU7saoP1qOcMn1OOAylVNtF
 1CwfET+UwsStcq9lClVYnORLWqOtTbQZdfVMiNYpH+SyHijmIGd865Nv0worcuQ5JlqT
 Qi0NmDcTkOKn7m66VKUbX1JQ75393NHP6eq9WTe52j2FamTRf1059od3zobTqU5x4Wsh
 MLiX18Y2UrNSCeibFe/YRve2ZVBjFtwUnjGdObnzIkPYpLapg2hNXlADvGsMW7LtqUgE
 hGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=foxVFkukIuN7paaMzE4/YUfiP7VYKyDwOA+0UfKOdTQ=;
 b=e7la2l/+87rbgxSGzgBGBRHjY6oiHKJyJIxVrI1KJOpnr581CsEwk6r4MCmMCYz5XS
 XB1ClkHbDL75QjWssU8hEG0/1BEo/ddaVvJAUHJAcv0EXvpl4gZeao2031f6AeAvLzHE
 8gY0BdLBZ+H5Y5w9XxfRoupWdAaUeiAWZOKgnQfGltxU8TeBZ4NruhCNHoM22AOZ1O54
 PN8P2E3tI2wRcqnf7vqlEQ280LI+X9b28+E+YaUlqFezaujlfFtJcYZMz1oue3fDkjXR
 OCc05Ax1i8yzizb8D5msIFPx0fzZWooGN3bZ5Qeg4lvifyY+ZqIAsUakLPsbCDYVDSEy
 +4oA==
X-Gm-Message-State: APjAAAX8gLRoSAPpti4jIhcPMkx5ungbmdFcSsCORI9H6W0fIdw6L7MD
 x3qXNvFpWMz7jbaZEmeRnWpePA==
X-Google-Smtp-Source: APXvYqzsnsa8vDb5WbJzAbgZ2igLdu4XQ5yzzKUce5bqnkLOuyhCDJNHZsMVvjANMLhEjgddjYpy1w==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr16530080wrv.104.1573839008333; 
 Fri, 15 Nov 2019 09:30:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j14sm11766564wrp.16.2019.11.15.09.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 09:30:05 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B49A1FF91;
 Fri, 15 Nov 2019 17:30:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 04/11] gdbstub: move mem_buf to GDBState and use GByteArray
Date: Fri, 15 Nov 2019 17:29:53 +0000
Message-Id: <20191115173000.21891-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191115173000.21891-1-alex.bennee@linaro.org>
References: <20191115173000.21891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is in preparation for further re-factoring of the register API
with the rest of the code. Theoretically the read register function
could overwrite the MAX_PACKET_LENGTH buffer although currently all
registers are well within the size range.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 52 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 528404c1953..4c3e211890f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -366,6 +366,7 @@ typedef struct GDBState {
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
     GString *str_buf;
+    GByteArray *mem_buf;
 } GDBState;
 
 /* By default use no IRQs and no timers while single stepping so as to
@@ -380,6 +381,7 @@ static GDBState *gdb_allocate_state(void)
     g_assert(!gdbserver_state);
     gdbserver_state = g_new0(GDBState, 1);
     gdbserver_state->str_buf = g_string_new(NULL);
+    gdbserver_state->mem_buf = g_byte_array_sized_new(MAX_PACKET_LENGTH);
     return gdbserver_state;
 }
 
@@ -566,12 +568,13 @@ static void memtohex(GString *buf, const uint8_t *mem, int len)
     g_string_append_c(buf, '\0');
 }
 
-static void hextomem(uint8_t *mem, const char *buf, int len)
+static void hextomem(GByteArray *mem, const char *buf, int len)
 {
     int i;
 
     for(i = 0; i < len; i++) {
-        mem[i] = (fromhex(buf[0]) << 4) | fromhex(buf[1]);
+        guint8 byte = fromhex(buf[0]) << 4 | fromhex(buf[1]);
+        g_byte_array_append(mem, &byte, 1);
         buf += 2;
     }
 }
@@ -1396,7 +1399,6 @@ static int cmd_parse_params(const char *data, const char *schema,
 typedef struct GdbCmdContext {
     GdbCmdVariant *params;
     int num_params;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
 } GdbCmdContext;
 
 typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
@@ -1489,6 +1491,7 @@ static void run_cmd_parser(GDBState *s, const char *data,
     }
 
     g_string_set_size(s->str_buf, 0);
+    g_byte_array_set_size(s->mem_buf, 0);
 
     /* In case there was an error during the command parsing we must
     * send a NULL packet to indicate the command is not supported */
@@ -1710,8 +1713,8 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     reg_size = strlen(gdb_ctx->params[1].data) / 2;
-    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
-    gdb_write_register(s->g_cpu, gdb_ctx->mem_buf,
+    hextomem(s->mem_buf, gdb_ctx->params[1].data, reg_size);
+    gdb_write_register(s->g_cpu, s->mem_buf->data,
                        gdb_ctx->params[0].val_ull);
     put_packet(s, "OK");
 }
@@ -1731,14 +1734,16 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    reg_size = gdb_read_register(s->g_cpu, gdb_ctx->mem_buf,
+    reg_size = gdb_read_register(s->g_cpu, s->mem_buf->data,
                                  gdb_ctx->params[0].val_ull);
     if (!reg_size) {
         put_packet(s, "E14");
         return;
+    } else {
+        g_byte_array_set_size(s->mem_buf, reg_size);
     }
 
-    memtohex(s->str_buf, gdb_ctx->mem_buf, reg_size);
+    memtohex(s->str_buf, s->mem_buf->data, reg_size);
     put_packet(s, s->str_buf->str);
 }
 
@@ -1757,11 +1762,11 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
+    hextomem(s->mem_buf, gdb_ctx->params[2].data,
              gdb_ctx->params[1].val_ull);
     if (target_memory_rw_debug(s->g_cpu, gdb_ctx->params[0].val_ull,
-                               gdb_ctx->mem_buf,
-                               gdb_ctx->params[1].val_ull, true)) {
+                               s->mem_buf->data,
+                               s->mem_buf->len, true)) {
         put_packet(s, "E14");
         return;
     }
@@ -1784,14 +1789,16 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
+    g_byte_array_set_size(s->mem_buf, gdb_ctx->params[1].val_ull);
+
     if (target_memory_rw_debug(s->g_cpu, gdb_ctx->params[0].val_ull,
-                               gdb_ctx->mem_buf,
-                               gdb_ctx->params[1].val_ull, false)) {
+                               s->mem_buf->data,
+                               s->mem_buf->len, false)) {
         put_packet(s, "E14");
         return;
     }
 
-    memtohex(s->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    memtohex(s->str_buf, s->mem_buf->data, s->mem_buf->len);
     put_packet(s, s->str_buf->str);
 }
 
@@ -1807,9 +1814,9 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     cpu_synchronize_state(s->g_cpu);
-    registers = gdb_ctx->mem_buf;
     len = strlen(gdb_ctx->params[0].data) / 2;
-    hextomem(registers, gdb_ctx->params[0].data, len);
+    hextomem(s->mem_buf, gdb_ctx->params[0].data, len);
+    registers = s->mem_buf->data;
     for (addr = 0; addr < s->g_cpu->gdb_num_g_regs && len > 0;
          addr++) {
         reg_size = gdb_write_register(s->g_cpu, registers, addr);
@@ -1827,11 +1834,13 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     cpu_synchronize_state(s->g_cpu);
     len = 0;
     for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
-        len += gdb_read_register(s->g_cpu, gdb_ctx->mem_buf + len,
+        len += gdb_read_register(s->g_cpu, s->mem_buf->data + len,
                                  addr);
     }
+    /* FIXME: This is after the fact sizing */
+    g_byte_array_set_size(s->mem_buf, len);
 
-    memtohex(s->str_buf, gdb_ctx->mem_buf, len);
+    memtohex(s->str_buf, s->mem_buf->data, len);
     put_packet(s, s->str_buf->str);
 }
 
@@ -2102,6 +2111,7 @@ static void handle_query_offsets(GdbCmdContext *gdb_ctx, void *user_ctx)
 static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     GDBState *s = gdbserver_state;
+    const guint8 zero = 0;
     int len;
 
     if (!gdb_ctx->num_params) {
@@ -2116,11 +2126,11 @@ static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     len = len / 2;
-    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[0].data, len);
-    gdb_ctx->mem_buf[len++] = 0;
-    qemu_chr_be_write(s->mon_chr, gdb_ctx->mem_buf, len);
+    g_byte_array_set_size(s->mem_buf, len);
+    hextomem(s->mem_buf, gdb_ctx->params[0].data, len);
+    g_byte_array_append(s->mem_buf, &zero, 1);
+    qemu_chr_be_write(s->mon_chr, s->mem_buf->data, s->mem_buf->len);
     put_packet(s, "OK");
-
 }
 #endif
 
-- 
2.20.1


