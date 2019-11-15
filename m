Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F311C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B49C2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZbh5oMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B49C2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVfc8-0007Mr-U0
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQD-0007I7-Tr
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQ8-0002ox-9s
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:13 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVfQ7-0002nD-UV
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:08 -0500
Received: by mail-wr1-x443.google.com with SMTP id e6so11872462wrw.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xblbiO5Nw1MXVkyo/Do5/EoAGGom4HjXnFpRhvBdVco=;
 b=DZbh5oMH9/FJHyLPXM966Bk6m5fl65HOi1Bc640lVAHfwfVp8sq+x9uFHFi0GBufsm
 v460QvHTacVIxhxiOJ9uFp+tK27NCkg+sZqxws+6xKcMI6tmQFsfMWTBu2ZRP6hzkmeY
 kJfuNfLw9U/+ix3/rGvN9fbW0T1DcLZ5oeWkCmPFCu0f3pTyz0a58XvX+TKmYvYiK6PQ
 paMjYxTSsSgBj/ZHRamYggOUCl6YqnkJsfnmIrf1qFdq1pymXu6/VvJtBzLtpfFurhix
 uXBbtt2l8y2YtUq1LsscetfVZAeh0e5kqKkZHFu5G1JcUJQZuyPAtE5X37xx2bjFmins
 nN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xblbiO5Nw1MXVkyo/Do5/EoAGGom4HjXnFpRhvBdVco=;
 b=Rc69ufqQtT6LI2nB+dlfK5bPd8899lpH1w2RE8Ds/MCoLXKMtpfoKem0C7v/CbuepN
 xjymQkIE2JIGgOAyc/Ch1jfuEpxUOE7MTaD1tYve5Nk+0f72IcVQmhpNeQ3HExsabSNa
 PFTGnThs52AEJ++9iujqWLbfezah0QjzwPiyeduIfcp4SZQ2Uq5Sk2bgz1VwgyaKbM8L
 oc3oHL1Nq87KPvwT5/F/eFn77xh9z3Y+KHTlKTppE3a5mtf/XzPSiUmqFazLAjeDheLD
 HOrZqg56Eme0XL6mR6S5s1AVnxWHU2mVnWy7qyXP5I4ynMxrBLPzw/KGNAQNrIaOrici
 QSdQ==
X-Gm-Message-State: APjAAAVCbm1doQRblM4yHvhys5yMQOT5sBhqQGx3DmbIlgRJH6pLdJYM
 dINEMUXQwgQ6EqMJGbboY72bmw==
X-Google-Smtp-Source: APXvYqyODmqg3+U3YxE6eDPRvu2yr6m5eameqofnrCBQHsUE+ChWNoRbG0z5bOmAdkbnMY0Xen8PGg==
X-Received: by 2002:adf:f547:: with SMTP id j7mr8711389wrp.69.1573839006564;
 Fri, 15 Nov 2019 09:30:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a206sm11209372wmf.15.2019.11.15.09.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 09:30:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 16BD21FF90;
 Fri, 15 Nov 2019 17:30:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  03/11] gdbstub: move str_buf to GDBState and use GString
Date: Fri, 15 Nov 2019 17:29:52 +0000
Message-Id: <20191115173000.21891-4-alex.bennee@linaro.org>
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

Rather than having a static buffer replace str_buf with a GString
which we know can grow on demand. Convert the internal functions to
take a GString instead of a char * and length.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 194 ++++++++++++++++++++++++------------------------------
 1 file changed, 85 insertions(+), 109 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 2e6ff5f583c..528404c1953 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -365,6 +365,7 @@ typedef struct GDBState {
     int process_num;
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
+    GString *str_buf;
 } GDBState;
 
 /* By default use no IRQs and no timers while single stepping so as to
@@ -378,6 +379,7 @@ static GDBState *gdb_allocate_state(void)
 {
     g_assert(!gdbserver_state);
     gdbserver_state = g_new0(GDBState, 1);
+    gdbserver_state->str_buf = g_string_new(NULL);
     return gdbserver_state;
 }
 
@@ -553,17 +555,15 @@ static inline int tohex(int v)
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
@@ -657,24 +657,22 @@ static int put_packet(GDBState *s, const char *buf)
 }
 
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
 
 static uint32_t gdb_get_cpu_pid(const GDBState *s, CPUState *cpu)
@@ -1098,17 +1096,14 @@ static void gdb_set_cpu_pc(GDBState *s, target_ulong pc)
     cpu_set_pc(cpu, pc);
 }
 
-static char *gdb_fmt_thread_id(const GDBState *s, CPUState *cpu,
-                           char *buf, size_t buf_size)
+static void gdb_append_thread_id(const GDBState *s, CPUState *cpu, GString *buf)
 {
     if (s->multiprocess) {
-        snprintf(buf, buf_size, "p%02x.%02x",
-                 gdb_get_cpu_pid(s, cpu), cpu_gdb_index(cpu));
+        g_string_append_printf(buf, "p%02x.%02x",
+                               gdb_get_cpu_pid(s, cpu), cpu_gdb_index(cpu));
     } else {
-        snprintf(buf, buf_size, "%02x", cpu_gdb_index(cpu));
+        g_string_append_printf(buf, "%02x", cpu_gdb_index(cpu));
     }
-
-    return buf;
 }
 
 typedef enum GDBThreadIdKind {
@@ -1402,7 +1397,6 @@ typedef struct GdbCmdContext {
     GdbCmdVariant *params;
     int num_params;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char str_buf[MAX_PACKET_LENGTH + 1];
 } GdbCmdContext;
 
 typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
@@ -1494,6 +1488,8 @@ static void run_cmd_parser(GDBState *s, const char *data,
         return;
     }
 
+    g_string_set_size(s->str_buf, 0);
+
     /* In case there was an error during the command parsing we must
     * send a NULL packet to indicate the command is not supported */
     if (process_string_cmd(s, NULL, data, cmd, 1)) {
@@ -1742,8 +1738,8 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
-    put_packet(s, gdb_ctx->str_buf);
+    memtohex(s->str_buf, gdb_ctx->mem_buf, reg_size);
+    put_packet(s, s->str_buf->str);
 }
 
 static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -1795,8 +1791,8 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
         return;
     }
 
-    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
-    put_packet(s, gdb_ctx->str_buf);
+    memtohex(s->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    put_packet(s, s->str_buf->str);
 }
 
 static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -1835,8 +1831,8 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
                                  addr);
     }
 
-    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
-    put_packet(s, gdb_ctx->str_buf);
+    memtohex(s->str_buf, gdb_ctx->mem_buf, len);
+    put_packet(s, s->str_buf->str);
 }
 
 static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -1904,9 +1900,8 @@ static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
     GDBState *s = gdbserver_state;
     GDBProcess *process;
     CPUState *cpu;
-    char thread_id[16];
 
-    pstrcpy(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "E22");
+    g_string_assign(s->str_buf, "E22");
     if (!gdb_ctx->num_params) {
         goto cleanup;
     }
@@ -1925,11 +1920,11 @@ static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
     s->g_cpu = cpu;
     s->c_cpu = cpu;
 
-    gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id));
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
-             GDB_SIGNAL_TRAP, thread_id);
+    g_string_printf(s->str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
+    gdb_append_thread_id(s, cpu, s->str_buf);
+    g_string_append_c(s->str_buf, ';');
 cleanup:
-    put_packet(s, gdb_ctx->str_buf);
+    put_packet(s, s->str_buf->str);
 }
 
 static void handle_v_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -1986,11 +1981,9 @@ static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
 static void handle_query_qemu_sstepbits(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     GDBState *s = gdbserver_state;
-
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
-             "ENABLE=%x,NOIRQ=%x,NOTIMER=%x", SSTEP_ENABLE,
-             SSTEP_NOIRQ, SSTEP_NOTIMER);
-    put_packet(s, gdb_ctx->str_buf);
+    g_string_printf(s->str_buf, "ENABLE=%x,NOIRQ=%x,NOTIMER=%x",
+                    SSTEP_ENABLE, SSTEP_NOIRQ, SSTEP_NOTIMER);
+    put_packet(s, s->str_buf->str);
 }
 
 static void handle_set_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2008,9 +2001,8 @@ static void handle_set_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
 static void handle_query_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     GDBState *s = gdbserver_state;
-
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "0x%x", sstep_flags);
-    put_packet(s, gdb_ctx->str_buf);
+    g_string_printf(s->str_buf, "0x%x", sstep_flags);
+    put_packet(s, s->str_buf->str);
 }
 
 static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2018,7 +2010,6 @@ static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
     GDBState *s = gdbserver_state;
     CPUState *cpu;
     GDBProcess *process;
-    char thread_id[16];
 
     /*
      * "Current thread" remains vague in the spec, so always return
@@ -2027,27 +2018,24 @@ static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
      */
     process = gdb_get_cpu_process(s, s->g_cpu);
     cpu = get_first_cpu_in_process(s, process);
-    gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id));
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "QC%s", thread_id);
-    put_packet(s, gdb_ctx->str_buf);
+    g_string_assign(s->str_buf, "QC");
+    gdb_append_thread_id(s, cpu, s->str_buf);
+    put_packet(s, s->str_buf->str);
 }
 
 static void handle_query_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     GDBState *s = gdbserver_state;
-    char thread_id[16];
 
     if (!s->query_cpu) {
         put_packet(s, "l");
         return;
     }
 
-    gdb_fmt_thread_id(s, s->query_cpu, thread_id,
-                      sizeof(thread_id));
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "m%s", thread_id);
-    put_packet(s, gdb_ctx->str_buf);
-    s->query_cpu =
-        gdb_next_attached_cpu(s, s->query_cpu);
+    g_string_assign(s->str_buf, "m");
+    gdb_append_thread_id(s, s->query_cpu, s->str_buf);
+    put_packet(s, s->str_buf->str);
+    s->query_cpu = gdb_next_attached_cpu(s, s->query_cpu);
 }
 
 static void handle_query_first_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2060,8 +2048,8 @@ static void handle_query_first_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
 static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     GDBState *s = gdbserver_state;
+    g_autoptr(GString) rs = g_string_new(NULL);
     CPUState *cpu;
-    int len;
 
     if (!gdb_ctx->num_params ||
         gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
@@ -2081,20 +2069,17 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
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
-    put_packet(s, gdb_ctx->str_buf);
+    trace_gdbstub_op_extra_info(rs->str);
+    memtohex(s->str_buf, (uint8_t *)rs->str, rs->len);
+    put_packet(s, s->str_buf->str);
 }
 
 #ifdef CONFIG_USER_ONLY
@@ -2104,13 +2089,14 @@ static void handle_query_offsets(GdbCmdContext *gdb_ctx, void *user_ctx)
     TaskState *ts;
 
     ts = s->c_cpu->opaque;
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
-             "Text=" TARGET_ABI_FMT_lx ";Data=" TARGET_ABI_FMT_lx
-             ";Bss=" TARGET_ABI_FMT_lx,
-             ts->info->code_offset,
-             ts->info->data_offset,
-             ts->info->data_offset);
-    put_packet(s, gdb_ctx->str_buf);
+    g_string_printf(s->str_buf,
+                    "Text=" TARGET_ABI_FMT_lx
+                    ";Data=" TARGET_ABI_FMT_lx
+                    ";Bss=" TARGET_ABI_FMT_lx,
+                    ts->info->code_offset,
+                    ts->info->data_offset,
+                    ts->info->data_offset);
+    put_packet(s, s->str_buf->str);
 }
 #else
 static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2143,12 +2129,10 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
     GDBState *s = gdbserver_state;
     CPUClass *cc;
 
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "PacketSize=%x",
-             MAX_PACKET_LENGTH);
+    g_string_printf(s->str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
     cc = CPU_GET_CLASS(first_cpu);
     if (cc->gdb_core_xml_file) {
-        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
-                ";qXfer:features:read+");
+        g_string_append(s->str_buf, ";qXfer:features:read+");
     }
 
     if (gdb_ctx->num_params &&
@@ -2156,8 +2140,8 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
         s->multiprocess = true;
     }
 
-    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";multiprocess+");
-    put_packet(s, gdb_ctx->str_buf);
+    g_string_append(s->str_buf, ";multiprocess+");
+    put_packet(s, s->str_buf->str);
 }
 
 static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2202,14 +2186,14 @@ static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     if (len < total_len - addr) {
-        gdb_ctx->str_buf[0] = 'm';
-        len = memtox(gdb_ctx->str_buf + 1, xml + addr, len);
+        g_string_assign(s->str_buf, "m");
+        memtox(s->str_buf, xml + addr, len);
     } else {
-        gdb_ctx->str_buf[0] = 'l';
-        len = memtox(gdb_ctx->str_buf + 1, xml + addr, total_len - addr);
+        g_string_assign(s->str_buf, "l");
+        memtox(s->str_buf, xml + addr, total_len - addr);
     }
 
-    put_packet_binary(s, gdb_ctx->str_buf, len + 1, true);
+    put_packet_binary(s, s->str_buf->str, s->str_buf->len, true);
 }
 
 static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2221,11 +2205,11 @@ static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     GDBState *s = gdbserver_state;
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "sstepbits;sstep");
+    g_string_printf(s->str_buf, "sstepbits;sstep");
 #ifndef CONFIG_USER_ONLY
-    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";PhyMemMode");
+    g_string_append(s->str_buf, ";PhyMemMode");
 #endif
-    put_packet(s, gdb_ctx->str_buf);
+    put_packet(s, s->str_buf->str);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -2233,8 +2217,8 @@ static void handle_query_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx,
                                            void *user_ctx)
 {
     GDBState *s = gdbserver_state;
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "%d", phy_memory_mode);
-    put_packet(s, gdb_ctx->str_buf);
+    g_string_printf(s->str_buf, "%d", phy_memory_mode);
+    put_packet(s, s->str_buf->str);
 }
 
 static void handle_set_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
@@ -2405,13 +2389,10 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
 static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     GDBState *s = gdbserver_state;
-    char thread_id[16];
-
-    gdb_fmt_thread_id(s, s->c_cpu, thread_id,
-                      sizeof(thread_id));
-    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
-             GDB_SIGNAL_TRAP, thread_id);
-    put_packet(s, gdb_ctx->str_buf);
+    g_string_printf(s->str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
+    gdb_append_thread_id(s, s->c_cpu, s->str_buf);
+    g_string_append_c(s->str_buf, ';');
+    put_packet(s, s->str_buf->str);
     /*
      * Remove all the breakpoints when this query is issued,
      * because gdb is doing an initial connect and the state
@@ -2675,8 +2656,8 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
 {
     GDBState *s = gdbserver_state;
     CPUState *cpu = s->c_cpu;
-    char buf[256];
-    char thread_id[16];
+    g_autoptr(GString) buf = g_string_new(NULL);
+    g_autoptr(GString) tid = g_string_new(NULL);
     const char *type;
     int ret;
 
@@ -2694,7 +2675,7 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
         return;
     }
 
-    gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id));
+    gdb_append_thread_id(s, cpu, tid);
 
     switch (state) {
     case RUN_STATE_DEBUG:
@@ -2712,10 +2693,9 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
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
@@ -2756,10 +2736,10 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
         break;
     }
     gdb_set_stop_cpu(cpu);
-    snprintf(buf, sizeof(buf), "T%02xthread:%s;", ret, thread_id);
+    g_string_printf(buf, "T%02xthread:%s;", ret, tid->str);
 
 send_packet:
-    put_packet(s, buf);
+    put_packet(s, buf->str);
 
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
@@ -3248,13 +3228,9 @@ static void gdb_chr_event(void *opaque, int event)
 
 static void gdb_monitor_output(GDBState *s, const char *msg, int len)
 {
-    char buf[MAX_PACKET_LENGTH];
-
-    buf[0] = 'O';
-    if (len > (MAX_PACKET_LENGTH/2) - 1)
-        len = (MAX_PACKET_LENGTH/2) - 1;
-    memtohex(buf + 1, (uint8_t *)msg, len);
-    put_packet(s, buf);
+    g_autoptr(GString) buf = g_string_new("O");
+    memtohex(buf, (uint8_t *)msg, len);
+    put_packet(s, buf->str);
 }
 
 static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
-- 
2.20.1


