Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37610C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55302465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7TmYNKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55302465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiH3W-0006SZ-WB
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1V-0004eJ-V0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1T-0007VF-DJ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiH1S-0007Qn-ST
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:47 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so8999928wmb.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RRppQbj+sXywUjOQA2w87Jf3PtvabL0PQyQmHfRcQXo=;
 b=q7TmYNKWU5PtbBxYlqGHX6d0UF1Sh7xr+8MrmolwyK49r9W619SkSTzjX7n7pza6Qn
 rc6dlJRvCwuv7vZZKgoQjqwdk9GDmcCDGMyqMaPUlXHMjIHD1eO6xCeZ/5GzVnWqBWFR
 R67PHSNxpCl538ZmulzmByvFlfEArdGpp1Kv0F+k3AYeXKGBaBp54Z7gtliSW9kodAfW
 Xhi3iYVX2bJJDQ9S6BmfDyC87Y+T7AL2yIFdGIZ3c6TjAz4EAaJ0X30RNFtuok7EaIS1
 IDK28rwAlmGhVhbac7W20dKldP5bll3A1ivN3LVQRWAyPoV2Yk9BpqRXiCNPkRj/9/DD
 LjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RRppQbj+sXywUjOQA2w87Jf3PtvabL0PQyQmHfRcQXo=;
 b=tioB8MUbcpD+Dd0nYCqa85faHbvoLHpKgS2hxZc6799C1Fuq1A545kbACUjMGEjUYB
 Y658zcNYiIbCRS99gI/zccsyvzR8udOydJq6obOK5oNZBx1PRvtaGc5k9q3ksLX5H0km
 x42p1A75fy7Mb30QJ30Mn62nKdbHmHXqw4/yMu3KDFzxwW38XN2J0TXqOUdOevYyk/8r
 j8DQQ6QSLowWnR7JLGprZxF+r3QfVHaIfo9G+uzInD9YLFaWnJyCzF/bPmb9CKie2XGE
 SyOel7z126Pi10UnePgcOTHdDNaLcukqsRBNoYnjHBkJeLxZoHpzYlFTZgcO3aEUx38x
 FhEw==
X-Gm-Message-State: APjAAAUaTBiglyE4tpj4a9cnJBuTDiO15fLxSOb+Dp3VkyTivMRwOVxZ
 It4lTtOulbdaScqx6nnY23+LrA==
X-Google-Smtp-Source: APXvYqxcj6F8n7bdIfN6gUK+BGICtvt74k7ruuQbt83/rQtZY5QtDAT3V62xP1bPpGMRoJXAUDZDKg==
X-Received: by 2002:a1c:20d3:: with SMTP id
 g202mr16307905wmg.169.1576843485550; 
 Fri, 20 Dec 2019 04:04:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f127sm8140798wma.4.2019.12.20.04.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:04:41 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 28A871FF90;
 Fri, 20 Dec 2019 12:04:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 03/21] gdbstub: move str_buf to GDBState and use GString
Date: Fri, 20 Dec 2019 12:04:20 +0000
Message-Id: <20191220120438.16114-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 Richard Henderson <richard.henderson@linaro.org>, alan.hayward@arm.com,
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
index 85ef7d37e08..80d99c209ff 100644
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
@@ -3196,13 +3185,9 @@ static void gdb_chr_event(void *opaque, int event)
 
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


