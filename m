Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE82C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3759620674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eycMvEju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3759620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuAQ-00004v-7f
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRY-0000vU-5q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRW-00012A-77
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRV-0000vP-Iv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id s5so22319150wrg.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YMlB9rnlkVZWq7aBeAA4aFi+84nzrz8PdlJho1DInq4=;
 b=eycMvEjub0i5emzZ1DOfsnTttyLBPiy5DmlNj5r6vpWOvo0NWSboY1G7RzK0qCnuCx
 3zcqL0fAedsyKdgCVXm0gTjlCmuowoPOGYWpQdltcKbwULEXeYKSJBZ1yItjwX6aPhFo
 3VU1osJPm42L0U6tqTZe+cE3VtSVR+AOK/qJJ1ejWhMYuEx80P75zHcfeuK7kH/T84J+
 89rYg8GTKCP/gGJY07w4yup+r8vnnsYjc+u2n5ccc0/c3mPCiNQO5f6fdApGFChpMLWF
 XKVwXY3V+RwA7UMlDH2TjLnBUbV7vGyAk8A5O8qIyHYa6hGZjOCuXyKd+/mDdVjb+5W0
 KEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YMlB9rnlkVZWq7aBeAA4aFi+84nzrz8PdlJho1DInq4=;
 b=f3Y8BB7xUa3t62po4LVUNWK4LI4w0TcV24CVJC6e5DzT9SCIQQooEVhuLq5+27eiIJ
 VlzyWp2Q+ZPeEDsmIR5BudYv6fLeDs+Oa9deRffneVEuGHIslyhGKlx9Wm34HFUV/NXJ
 jzoboPrbasD728XJHL1Wph1YaCvkSS6sFUy/Mi+LCZkr4FwYAKiCEPkzdgyzVWJmgvtQ
 TXvO7kyBwUUWO94Z9EnpdFlkHyeHZGOKZLeVF2R7m87lzk1VnHx1ymQ5HsS6jkxzu4Wv
 Wb9t4zlficPBzicsHObkxpaE1oLkzF+tTEPFTvzomyOpfZVqxruA9M7fkrb3WqdSxUB4
 fO9Q==
X-Gm-Message-State: ANhLgQ330utMXVLuT4hsdnefH18vsCeDJTKK6C07tJffaicuwmLhMlOQ
 T1XgtLR1Dj5RkWAPVC5FZ9/nzg==
X-Google-Smtp-Source: ADFU+vt8uFGwoe5APsmUStPp4qEec6TZDxyjy4aZUvNb4VeRBhgGxxmJwRa69Nq9I4K26PCWLqrcqg==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr370285wrs.119.1584379340279; 
 Mon, 16 Mar 2020 10:22:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l26sm417018wmi.37.2020.03.16.10.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F07D21FF98;
 Mon, 16 Mar 2020 17:21:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/28] gdbstub: move mem_buf to GDBState and use GByteArray
Date: Mon, 16 Mar 2020 17:21:36 +0000
Message-Id: <20200316172155.971-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is in preparation for further re-factoring of the register API
with the rest of the code. Theoretically the read register function
could overwrite the MAX_PACKET_LENGTH buffer although currently all
registers are well within the size range.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Tested-by: Damien Hedde <damien.hedde@greensocs.com>

---
v4
  - don't set_set to len on rcmd (it's zeroed before we get here)
v3
  - fixed up email on Damien's tags
---
 gdbstub.c | 56 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index f6b42825445..db537a712cc 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -367,6 +367,7 @@ typedef struct GDBState {
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
     GString *str_buf;
+    GByteArray *mem_buf;
 } GDBState;
 
 /* By default use no IRQs and no timers while single stepping so as to
@@ -382,6 +383,7 @@ static void init_gdbserver_state(void)
     memset(&gdbserver_state, 0, sizeof(GDBState));
     gdbserver_state.init = true;
     gdbserver_state.str_buf = g_string_new(NULL);
+    gdbserver_state.mem_buf = g_byte_array_sized_new(MAX_PACKET_LENGTH);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -576,12 +578,13 @@ static void memtohex(GString *buf, const uint8_t *mem, int len)
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
@@ -1412,7 +1415,6 @@ static int cmd_parse_params(const char *data, const char *schema,
 typedef struct GdbCmdContext {
     GdbCmdVariant *params;
     int num_params;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
 } GdbCmdContext;
 
 typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
@@ -1503,6 +1505,7 @@ static void run_cmd_parser(const char *data, const GdbCmdParseEntry *cmd)
     }
 
     g_string_set_size(gdbserver_state.str_buf, 0);
+    g_byte_array_set_size(gdbserver_state.mem_buf, 0);
 
     /* In case there was an error during the command parsing we must
     * send a NULL packet to indicate the command is not supported */
@@ -1715,8 +1718,8 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     reg_size = strlen(gdb_ctx->params[1].data) / 2;
-    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
-    gdb_write_register(gdbserver_state.g_cpu, gdb_ctx->mem_buf,
+    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[1].data, reg_size);
+    gdb_write_register(gdbserver_state.g_cpu, gdbserver_state.mem_buf->data,
                        gdb_ctx->params[0].val_ull);
     put_packet("OK");
 }
@@ -1735,14 +1738,17 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    reg_size = gdb_read_register(gdbserver_state.g_cpu, gdb_ctx->mem_buf,
+    reg_size = gdb_read_register(gdbserver_state.g_cpu,
+                                 gdbserver_state.mem_buf->data,
                                  gdb_ctx->params[0].val_ull);
     if (!reg_size) {
         put_packet("E14");
         return;
+    } else {
+        g_byte_array_set_size(gdbserver_state.mem_buf, reg_size);
     }
 
-    memtohex(gdbserver_state.str_buf, gdb_ctx->mem_buf, reg_size);
+    memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, reg_size);
     put_strbuf();
 }
 
@@ -1759,11 +1765,11 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
+    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[2].data,
              gdb_ctx->params[1].val_ull);
     if (target_memory_rw_debug(gdbserver_state.g_cpu, gdb_ctx->params[0].val_ull,
-                               gdb_ctx->mem_buf,
-                               gdb_ctx->params[1].val_ull, true)) {
+                               gdbserver_state.mem_buf->data,
+                               gdbserver_state.mem_buf->len, true)) {
         put_packet("E14");
         return;
     }
@@ -1784,14 +1790,17 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
+    g_byte_array_set_size(gdbserver_state.mem_buf, gdb_ctx->params[1].val_ull);
+
     if (target_memory_rw_debug(gdbserver_state.g_cpu, gdb_ctx->params[0].val_ull,
-                               gdb_ctx->mem_buf,
-                               gdb_ctx->params[1].val_ull, false)) {
+                               gdbserver_state.mem_buf->data,
+                               gdbserver_state.mem_buf->len, false)) {
         put_packet("E14");
         return;
     }
 
-    memtohex(gdbserver_state.str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data,
+             gdbserver_state.mem_buf->len);
     put_strbuf();
 }
 
@@ -1806,9 +1815,9 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     cpu_synchronize_state(gdbserver_state.g_cpu);
-    registers = gdb_ctx->mem_buf;
     len = strlen(gdb_ctx->params[0].data) / 2;
-    hextomem(registers, gdb_ctx->params[0].data, len);
+    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[0].data, len);
+    registers = gdbserver_state.mem_buf->data;
     for (addr = 0; addr < gdbserver_state.g_cpu->gdb_num_g_regs && len > 0;
          addr++) {
         reg_size = gdb_write_register(gdbserver_state.g_cpu, registers, addr);
@@ -1825,11 +1834,14 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     cpu_synchronize_state(gdbserver_state.g_cpu);
     len = 0;
     for (addr = 0; addr < gdbserver_state.g_cpu->gdb_num_g_regs; addr++) {
-        len += gdb_read_register(gdbserver_state.g_cpu, gdb_ctx->mem_buf + len,
+        len += gdb_read_register(gdbserver_state.g_cpu,
+                                 gdbserver_state.mem_buf->data + len,
                                  addr);
     }
+    /* FIXME: This is after the fact sizing */
+    g_byte_array_set_size(gdbserver_state.mem_buf, len);
 
-    memtohex(gdbserver_state.str_buf, gdb_ctx->mem_buf, len);
+    memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, len);
     put_strbuf();
 }
 
@@ -2078,6 +2090,7 @@ static void handle_query_offsets(GdbCmdContext *gdb_ctx, void *user_ctx)
 #else
 static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    const guint8 zero = 0;
     int len;
 
     if (!gdb_ctx->num_params) {
@@ -2091,12 +2104,13 @@ static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
+    g_assert(gdbserver_state.mem_buf->len == 0);
     len = len / 2;
-    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[0].data, len);
-    gdb_ctx->mem_buf[len++] = 0;
-    qemu_chr_be_write(gdbserver_state.mon_chr, gdb_ctx->mem_buf, len);
+    hextomem(gdbserver_state.mem_buf, gdb_ctx->params[0].data, len);
+    g_byte_array_append(gdbserver_state.mem_buf, &zero, 1);
+    qemu_chr_be_write(gdbserver_state.mon_chr, gdbserver_state.mem_buf->data,
+                      gdbserver_state.mem_buf->len);
     put_packet("OK");
-
 }
 #endif
 
-- 
2.20.1


