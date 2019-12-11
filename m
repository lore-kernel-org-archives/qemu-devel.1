Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87524C2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459BB2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnX0fhVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459BB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5Vj-0002JK-6J
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qa-00053A-TK
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5QX-00039c-O4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:32 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5QX-000373-E5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so3439631wmb.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mgEDOR+cylQh1yQybKWlOGt38arDUN65SkkGHJWGBjo=;
 b=gnX0fhVTlppEGuJ8UhQI8Uu8MrfulnkU7Ltz7yCC2wclGyZ54T/JbqnpbkTgrg/HoP
 L9bHoavoB5+ojFXvD3sS124yyAyGfyYfjW3DAsaogCmlpNCLUWMeB4pSvzQscW/3Iaqm
 toMTtqnjNzCQcut1+JWfHAz5l6FziF69JqWXQpt3UUdvYO5Ucj0f1UhEU3pzMGPN9OK5
 5ZH6+Ejh7FctvqcdutZz4cXlUH2d/ezOantUaWzXYGzsPfKMtWJkFWn98sUw4kvGtK1H
 yzNuBtE/I8Yx8ZJXf0vmdyXuKh9+hEfxPrxbYJVSmG68SdWzMhIVFg31fpQr8oakneIo
 z6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mgEDOR+cylQh1yQybKWlOGt38arDUN65SkkGHJWGBjo=;
 b=AwDJHdacrqqw1DK9rolOhlzcEli9ifo10ti88kK5yMhm4Zq21jMCU8/3KrvgIyavlO
 mBeCHVccMjLI0OwxCjlN8nVbDx9IhHAyhkJvJf7GerBaFP41aJpQZLC0TykdRJxvK/rq
 tlTypnTXbFTToMWbJ3LElA0Kp9l8M8DAm7dxEq9V+0lnakodH9yUFc8C4WLP5B4i9MLp
 fHl4NLTdy8kC0r38p53bXIGMq3M3nEh79cBOLXMcZs7x89yUngrYy8M22s6Um76tv04Q
 cUJD3nCD6ULTrnsNDwlLESq+91u8fmoCmHfxZK7kvTHltos5Fy3RDFKp06FZH2l4TyoN
 6JQw==
X-Gm-Message-State: APjAAAVwkNNViFHDrJS9+Qx59xaC7k2cx6yvIg7s28n/Y/GwdC4eOy2s
 8ukP2pOFQ1UZfCz0Qd6SzlzGJg==
X-Google-Smtp-Source: APXvYqxPQdr4BRtr0LX0aTDaZaP0Xh/chaSRv+oZ3xh3aLUN9r9u14nuqrz4cua/eDEBNcz/G38Gcw==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr896641wmh.74.1576083928102;
 Wed, 11 Dec 2019 09:05:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v3sm2848501wml.47.2019.12.11.09.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:05:24 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 69C121FF90;
 Wed, 11 Dec 2019 17:05:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 03/20] gdbstub: move str_buf to GDBState and use GString
Date: Wed, 11 Dec 2019 17:05:03 +0000
Message-Id: <20191211170520.7747-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Rather than having a static buffer replace str_buf with a GString
which we know can grow on demand. Convert the internal functions to
take a GString instead of a char * and length.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Tested-by: Damien Hedde <damien.hedde@greensocs.com>
---
v2
  - fix conflict from status gdbserver_state
  - add put_strbuf helper
v3
  - remove double ;;
---
 gdbstub.c | 195 +++++++++++++++++++++++++-----------------------------
 1 file changed, 90 insertions(+), 105 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index edd9d8be5fe..1816e7af827 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -366,6 +366,7 @@ typedef struct GDBState {
     int process_num;
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
+    GString *str_buf;
 } GDBState;
 
 /* By default use no IRQs and no timers while single stepping so as to
@@ -380,6 +381,7 @@ static void init_gdbserver_state(void)
     g_assert(!gdbserver_state.init);
     memset(&gdbserver_state, 0, sizeof(GDBState));
     gdbserver_state.init = true;
+    gdbserver_state.str_buf = g_string_new(NULL);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -563,17 +565,15 @@ static inline int tohex(int v)
 }
 
 /* writes 2*len+1 bytes in buf */
-static void memtohex(char *buf, const uint8_t *mem, int len)
+static void memtohex(GString *buf, const uint8_t *mem, int len)
 {
     int i, c;
-    char *q;
-    q = buf;
     for(i = 0; i < len; i++) {
         c = mem[i];
-        *q++ = tohex(c >> 4);
-        *q++ = tohex(c & 0xf);
+        g_string_append_c(buf, tohex(c >> 4));
+        g_string_append_c(buf, tohex(c & 0xf));
     }
-    *q = '\0';
+    g_string_append_c(buf, '\0');
 }
 
 static void hextomem(uint8_t *mem, const char *buf, int len)
@@ -667,25 +667,28 @@ static int put_packet(const char *buf)
     return put_packet_binary(buf, strlen(buf), false);
 }
 
+static void put_strbuf(void)
+{
+    put_packet(gdbserver_state.str_buf->str);
+}
+
 /* Encode data using the encoding for 'x' packets.  */
-static int memtox(char *buf, const char *mem, int len)
+static void memtox(GString *buf, const char *mem, int len)
 {
-    char *p = buf;
     char c;
 
     while (len--) {
         c = *(mem++);
         switch (c) {
         case '#': case '$': case '*': case '}':
-            *(p++) = '}';
-            *(p++) = c ^ 0x20;
+            g_string_append_c(buf, '}');
+            g_string_append_c(buf, c ^ 0x20);
             break;
         default:
-            *(p++) = c;
+            g_string_append_c(buf, c);
             break;
         }
     }
-    return p - buf;
 }
 
 static uint32_t gdb_get_cpu_pid(CPUState *cpu)
@@ -1109,16 +1112,14 @@ static void gdb_set_cpu_pc(target_ulong pc)
     cpu_set_pc(cpu, pc);
 }
 
-static char *gdb_fmt_thread_id(CPUState *cpu, char *buf, size_t buf_size)
+static void gdb_append_thread_id(CPUState *cpu, GString *buf)
 {
     if (gdbserver_state.multiprocess) {
-        snprintf(buf, buf_size, "p%02x.%02x",
-                 gdb_get_cpu_pid(cpu), cpu_gdb_index(cpu));
+        g_string_append_printf(buf, "p%02x.%02x",
+                               gdb_get_cpu_pid(cpu), cpu_gdb_index(cpu));
     } else {
-        snprintf(buf, buf_size, "%02x", cpu_gdb_index(cpu));
+        g_string_append_printf(buf, "%02x", cpu_gdb_index(cpu));
     }
-
-    return buf;
 }
 
 typedef enum GDBThreadIdKind {
@@ -1412,7 +1413,6 @@ typedef struct GdbCmdContext {
     GdbCmdVariant *params;
     int num_params;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char str_buf[MAX_PACKET_LENGTH + 1];
 } GdbCmdContext;
 
 typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
@@ -1502,6 +1502,8 @@ static void run_cmd_parser(const char *data, const GdbCmdParseEntry *cmd)
         return;
     }
 
+    g_string_set_size(gdbserver_state.str_buf, 0);
+
     /* In case there was an error during the command parsing we must
     * send a NULL packet to indicate the command is not supported */
     if (process_string_cmd(NULL, data, cmd, 1)) {
@@ -1740,8 +1742,8 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
-    put_packet(gdb_ctx->str_buf);
+    memtohex(gdbserver_state.str_buf, gdb_ctx->mem_buf, reg_size);
+    put_strbuf();
 }
 
 static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -1789,8 +1791,8 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
-    put_packet(gdb_ctx->str_buf);
+    memtohex(gdbserver_state.str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    put_strbuf();
 }
 
 static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -1827,8 +1829,8 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
                                  addr);
     }
 
-    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
-    put_packet(gdb_ctx->str_buf);
+    memtohex(gdbserver_state.str_buf, gdb_ctx->mem_buf, len);
+    put_strbuf();
 }
 
 static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -1889,9 +1891,8 @@ static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     GDBProcess *process;
     CPUState *cpu;
-    char thread_id[16];
 
-    pstrcpy(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "E22");
+    g_string_assign(gdbserver_state.str_buf, "E22");
     if (!gdb_ctx->num_params) {
         goto cleanup;
     }
@@ -1910,11 +1911,11 @@ static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdbserver_state.g_cpu = cpu;
     gdbserver_state.c_cpu = cpu;
 
-    gdb_fmt_thread_id(cpu, thread_id, sizeof(thread_id));
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
-             GDB_SIGNAL_TRAP, thread_id);
+    g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
+    gdb_append_thread_id(cpu, gdbserver_state.str_buf);
+    g_string_append_c(gdbserver_state.str_buf, ';');
 cleanup:
-    put_packet(gdb_ctx->str_buf);
+    put_strbuf();
 }
 
 static void handle_v_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -1966,10 +1967,9 @@ static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_query_qemu_sstepbits(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
-             "ENABLE=%x,NOIRQ=%x,NOTIMER=%x", SSTEP_ENABLE,
-             SSTEP_NOIRQ, SSTEP_NOTIMER);
-    put_packet(gdb_ctx->str_buf);
+    g_string_printf(gdbserver_state.str_buf, "ENABLE=%x,NOIRQ=%x,NOTIMER=%x",
+                    SSTEP_ENABLE, SSTEP_NOIRQ, SSTEP_NOTIMER);
+    put_strbuf();
 }
 
 static void handle_set_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -1984,15 +1984,14 @@ static void handle_set_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_query_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "0x%x", sstep_flags);
-    put_packet(gdb_ctx->str_buf);
+    g_string_printf(gdbserver_state.str_buf, "0x%x", sstep_flags);
+    put_strbuf();
 }
 
 static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     CPUState *cpu;
     GDBProcess *process;
-    char thread_id[16];
 
     /*
      * "Current thread" remains vague in the spec, so always return
@@ -2001,24 +2000,21 @@ static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
      */
     process = gdb_get_cpu_process(gdbserver_state.g_cpu);
     cpu = get_first_cpu_in_process(process);
-    gdb_fmt_thread_id(cpu, thread_id, sizeof(thread_id));
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "QC%s", thread_id);
-    put_packet(gdb_ctx->str_buf);
+    g_string_assign(gdbserver_state.str_buf, "QC");
+    gdb_append_thread_id(cpu, gdbserver_state.str_buf);
+    put_strbuf();
 }
 
 static void handle_query_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    char thread_id[16];
-
     if (!gdbserver_state.query_cpu) {
         put_packet("l");
         return;
     }
 
-    gdb_fmt_thread_id(gdbserver_state.query_cpu, thread_id,
-                      sizeof(thread_id));
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "m%s", thread_id);
-    put_packet(gdb_ctx->str_buf);
+    g_string_assign(gdbserver_state.str_buf, "m");
+    gdb_append_thread_id(gdbserver_state.query_cpu, gdbserver_state.str_buf);
+    put_strbuf();
     gdbserver_state.query_cpu = gdb_next_attached_cpu(gdbserver_state.query_cpu);
 }
 
@@ -2030,8 +2026,8 @@ static void handle_query_first_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
+    g_autoptr(GString) rs = g_string_new(NULL);
     CPUState *cpu;
-    int len;
 
     if (!gdb_ctx->num_params ||
         gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
@@ -2051,20 +2047,17 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
         /* Print the CPU model and name in multiprocess mode */
         ObjectClass *oc = object_get_class(OBJECT(cpu));
         const char *cpu_model = object_class_get_name(oc);
-        char *cpu_name = object_get_canonical_path_component(OBJECT(cpu));
-        len = snprintf((char *)gdb_ctx->mem_buf, sizeof(gdb_ctx->str_buf) / 2,
-                       "%s %s [%s]", cpu_model, cpu_name,
-                       cpu->halted ? "halted " : "running");
-        g_free(cpu_name);
+        g_autofree char *cpu_name;
+        cpu_name  = object_get_canonical_path_component(OBJECT(cpu));
+        g_string_printf(rs, "%s %s [%s]", cpu_model, cpu_name,
+                        cpu->halted ? "halted " : "running");
     } else {
-        /* memtohex() doubles the required space */
-        len = snprintf((char *)gdb_ctx->mem_buf, sizeof(gdb_ctx->str_buf) / 2,
-                        "CPU#%d [%s]", cpu->cpu_index,
+        g_string_printf(rs, "CPU#%d [%s]", cpu->cpu_index,
                         cpu->halted ? "halted " : "running");
     }
-    trace_gdbstub_op_extra_info((char *)gdb_ctx->mem_buf);
-    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
-    put_packet(gdb_ctx->str_buf);
+    trace_gdbstub_op_extra_info(rs->str);
+    memtohex(gdbserver_state.str_buf, (uint8_t *)rs->str, rs->len);
+    put_strbuf();
 }
 
 #ifdef CONFIG_USER_ONLY
@@ -2073,13 +2066,14 @@ static void handle_query_offsets(GdbCmdContext *gdb_ctx, void *user_ctx)
     TaskState *ts;
 
     ts = gdbserver_state.c_cpu->opaque;
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
-             "Text=" TARGET_ABI_FMT_lx ";Data=" TARGET_ABI_FMT_lx
-             ";Bss=" TARGET_ABI_FMT_lx,
-             ts->info->code_offset,
-             ts->info->data_offset,
-             ts->info->data_offset);
-    put_packet(gdb_ctx->str_buf);
+    g_string_printf(gdbserver_state.str_buf,
+                    "Text=" TARGET_ABI_FMT_lx
+                    ";Data=" TARGET_ABI_FMT_lx
+                    ";Bss=" TARGET_ABI_FMT_lx,
+                    ts->info->code_offset,
+                    ts->info->data_offset,
+                    ts->info->data_offset);
+    put_strbuf();
 }
 #else
 static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2110,12 +2104,10 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     CPUClass *cc;
 
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "PacketSize=%x",
-             MAX_PACKET_LENGTH);
+    g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
     cc = CPU_GET_CLASS(first_cpu);
     if (cc->gdb_core_xml_file) {
-        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
-                ";qXfer:features:read+");
+        g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
 
     if (gdb_ctx->num_params &&
@@ -2123,8 +2115,8 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
         gdbserver_state.multiprocess = true;
     }
 
-    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";multiprocess+");
-    put_packet(gdb_ctx->str_buf);
+    g_string_append(gdbserver_state.str_buf, ";multiprocess+");
+    put_strbuf();
 }
 
 static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2168,14 +2160,15 @@ static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     if (len < total_len - addr) {
-        gdb_ctx->str_buf[0] = 'm';
-        len = memtox(gdb_ctx->str_buf + 1, xml + addr, len);
+        g_string_assign(gdbserver_state.str_buf, "m");
+        memtox(gdbserver_state.str_buf, xml + addr, len);
     } else {
-        gdb_ctx->str_buf[0] = 'l';
-        len = memtox(gdb_ctx->str_buf + 1, xml + addr, total_len - addr);
+        g_string_assign(gdbserver_state.str_buf, "l");
+        memtox(gdbserver_state.str_buf, xml + addr, total_len - addr);
     }
 
-    put_packet_binary(gdb_ctx->str_buf, len + 1, true);
+    put_packet_binary(gdbserver_state.str_buf->str,
+                      gdbserver_state.str_buf->len, true);
 }
 
 static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2185,19 +2178,19 @@ static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "sstepbits;sstep");
+    g_string_printf(gdbserver_state.str_buf, "sstepbits;sstep");
 #ifndef CONFIG_USER_ONLY
-    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";PhyMemMode");
+    g_string_append(gdbserver_state.str_buf, ";PhyMemMode");
 #endif
-    put_packet(gdb_ctx->str_buf);
+    put_strbuf();
 }
 
 #ifndef CONFIG_USER_ONLY
 static void handle_query_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx,
                                            void *user_ctx)
 {
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "%d", phy_memory_mode);
-    put_packet(gdb_ctx->str_buf);
+    g_string_printf(gdbserver_state.str_buf, "%d", phy_memory_mode);
+    put_strbuf();
 }
 
 static void handle_set_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2362,13 +2355,10 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    char thread_id[16];
-
-    gdb_fmt_thread_id(gdbserver_state.c_cpu, thread_id,
-                      sizeof(thread_id));
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
-             GDB_SIGNAL_TRAP, thread_id);
-    put_packet(gdb_ctx->str_buf);
+    g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
+    gdb_append_thread_id(gdbserver_state.c_cpu, gdbserver_state.str_buf);
+    g_string_append_c(gdbserver_state.str_buf, ';');
+    put_strbuf();
     /*
      * Remove all the breakpoints when this query is issued,
      * because gdb is doing an initial connect and the state
@@ -2631,8 +2621,8 @@ void gdb_set_stop_cpu(CPUState *cpu)
 static void gdb_vm_state_change(void *opaque, int running, RunState state)
 {
     CPUState *cpu = gdbserver_state.c_cpu;
-    char buf[256];
-    char thread_id[16];
+    g_autoptr(GString) buf = g_string_new(NULL);
+    g_autoptr(GString) tid = g_string_new(NULL);
     const char *type;
     int ret;
 
@@ -2650,7 +2640,7 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
         return;
     }
 
-    gdb_fmt_thread_id(cpu, thread_id, sizeof(thread_id));
+    gdb_append_thread_id(cpu, tid);
 
     switch (state) {
     case RUN_STATE_DEBUG:
@@ -2668,10 +2658,9 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
             }
             trace_gdbstub_hit_watchpoint(type, cpu_gdb_index(cpu),
                     (target_ulong)cpu->watchpoint_hit->vaddr);
-            snprintf(buf, sizeof(buf),
-                     "T%02xthread:%s;%swatch:" TARGET_FMT_lx ";",
-                     GDB_SIGNAL_TRAP, thread_id, type,
-                     (target_ulong)cpu->watchpoint_hit->vaddr);
+            g_string_printf(buf, "T%02xthread:%s;%swatch:" TARGET_FMT_lx ";",
+                            GDB_SIGNAL_TRAP, tid->str, type,
+                            (target_ulong)cpu->watchpoint_hit->vaddr);
             cpu->watchpoint_hit = NULL;
             goto send_packet;
         } else {
@@ -2712,10 +2701,10 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
         break;
     }
     gdb_set_stop_cpu(cpu);
-    snprintf(buf, sizeof(buf), "T%02xthread:%s;", ret, thread_id);
+    g_string_printf(buf, "T%02xthread:%s;", ret, tid->str);
 
 send_packet:
-    put_packet(buf);
+    put_packet(buf->str);
 
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
@@ -3195,13 +3184,9 @@ static void gdb_chr_event(void *opaque, int event)
 
 static void gdb_monitor_output(const char *msg, int len)
 {
-    char buf[MAX_PACKET_LENGTH];
-
-    buf[0] = 'O';
-    if (len > (MAX_PACKET_LENGTH/2) - 1)
-        len = (MAX_PACKET_LENGTH/2) - 1;
-    memtohex(buf + 1, (uint8_t *)msg, len);
-    put_packet(buf);
+    g_autoptr(GString) buf = g_string_new("O");
+    memtohex(buf, (uint8_t *)msg, len);
+    put_packet(buf->str);
 }
 
 static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
-- 
2.20.1


