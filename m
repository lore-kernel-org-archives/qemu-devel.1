Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193DCC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C5F216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug6dawcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C5F216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1v3-0006zl-2w
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:22:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZS-0005zc-Eb
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZQ-0007tn-0j
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZO-0007qR-2S
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id c77so2301085wmd.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=sP4d58yWNnupURYwoPvCriT7epyMrZ73O7L1x6qXUYA=;
	b=Ug6dawcPi6G1eQP+9f/jDqCmvf3RUONL+4WvKA2JNoscgLTXQk5pIPb46Mk8n22QKA
	0qDeLEj73sCNQF36seCWg86mKvS4lpIh6rDMFXgOQ/uynKvHNQ/weF3rtSqaMiFwqwsS
	Vjkz8V/OoC3CtqoEEZ/u7qvoapreUpPKOqfVWdrp0WNrdlEsl2/Us92BNWZdQOa/7Oya
	9SG4e2cvffkwqLIPe+G2goRhvWW13+i51fxAlbqeG0iFrkQ7BxH/60qlRY1IGWfEiDlA
	mtmKyr4lbdMZzVFSwjAJlBFE0Ca6nwUcbr85FuT4YVBonPFV4YmlBZl52MsKxKk/s9ZQ
	X7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=sP4d58yWNnupURYwoPvCriT7epyMrZ73O7L1x6qXUYA=;
	b=Xz/WcrSi7QB/QOd3oA+kmLE8FXCjODHdC+iQg56jxdPn3vyi4AOTOeG6igDpOCtpG4
	N2HN7b4qjfFPFnyUWBwVItQlPKpYCeR84GiSuszj8Pv0lBR75lSFrpXiuqOHiXRafT2R
	16GKfwvkcxnVMbo2qRl+uuROQ5P79kwYNrDSxXiXPaBz/WF0PhPpVFS3R8a2OihrJC2T
	Lf8WCa54Lhk9OmXBGu5jX+p7x5NVFVCtPdxRxLmsK5UOaWi3poRwlv50lfr/rdU/KRfk
	PbbXq/WYXalhDy/+ggpmk7PHTDSmCERkJYZI3QfKG7e5lw8aJt2Rw6D9AmP8o86iR3TP
	uG+g==
X-Gm-Message-State: APjAAAWhUnybeU0mdry+2zQpriFO3PTbFwb7EtfrevK2FPWA0qXT7cuh
	LrfoxAC7LbPtEj8rzXgps2//YfcF
X-Google-Smtp-Source: APXvYqxW3A3wa6jdtX4E0XaC6pooQ4KQ4cjDZskR4lJkECP9AAx6tJo9UGVt7SAH+HIq8Vp7fXmmYg==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr2665068wml.31.1558432828557; 
	Tue, 21 May 2019 03:00:28 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:28 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:45 +0300
Message-Id: <20190521095948.8204-18-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v10 17/20] gdbstub: Implement generic set/query
 (Q/q pkt) with new infra
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generic set/query packets contains implementation for varioius
sub-commands which are required for GDB and also additional commands
which are QEMU specific.

To see which QEMU specific commands are available use the command
gdb> maintenance packet qqemu.Supported

Currently the only implemented QEMU specific command is the command
that sets the single step behavior.

gdb> maintenance packet qqemu.sstepbits
Will display the MASK bits used to control the single stepping.

gdb> maintenance packet qqemu.sstep
Will display the current value of the mask used when single stepping.

gdb> maintenance packet Qqemu.sstep:HEX_VALUE
Will change the single step mask.

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 559 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 373 insertions(+), 186 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3773b23581..57a05fd6a4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1130,14 +1130,6 @@ static GDBThreadIdKind read_thread_id(const char *buf, const char **end_buf,
     return GDB_ONE_THREAD;
 }
 
-static int is_query_packet(const char *p, const char *query, char separator)
-{
-    unsigned int query_len = strlen(query);
-
-    return strncmp(p, query, query_len) == 0 &&
-        (p[query_len] == '\0' || p[query_len] == separator);
-}
-
 /**
  * gdb_handle_vcont - Parses and handles a vCont packet.
  * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE if there is
@@ -1904,18 +1896,368 @@ static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
-static int gdb_handle_packet(GDBState *s, const char *line_buf)
+static void handle_query_qemu_sstepbits(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+             "ENABLE=%x,NOIRQ=%x,NOTIMER=%x", SSTEP_ENABLE,
+             SSTEP_NOIRQ, SSTEP_NOTIMER);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_set_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    sstep_flags = gdb_ctx->params[0].val_ul;
+    put_packet(gdb_ctx->s, "OK");
+}
+
+static void handle_query_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "0x%x", sstep_flags);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     CPUState *cpu;
     GDBProcess *process;
+    char thread_id[16];
+
+    /*
+     * "Current thread" remains vague in the spec, so always return
+     * the first thread of the current process (gdb returns the
+     * first thread).
+     */
+    process = gdb_get_cpu_process(gdb_ctx->s, gdb_ctx->s->g_cpu);
+    cpu = get_first_cpu_in_process(gdb_ctx->s, process);
+    gdb_fmt_thread_id(gdb_ctx->s, cpu, thread_id, sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "QC%s", thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_query_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    char thread_id[16];
+
+    if (!gdb_ctx->s->query_cpu) {
+        put_packet(gdb_ctx->s, "l");
+        return;
+    }
+
+    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->query_cpu, thread_id,
+                      sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "m%s", thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    gdb_ctx->s->query_cpu =
+        gdb_next_attached_cpu(gdb_ctx->s, gdb_ctx->s->query_cpu);
+}
+
+static void handle_query_first_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    gdb_ctx->s->query_cpu = gdb_first_attached_cpu(gdb_ctx->s);
+    handle_query_threads(gdb_ctx, user_ctx);
+}
+
+static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+    int len;
+
+    if (!gdb_ctx->num_params ||
+        gdb_ctx->params[0].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
+                      gdb_ctx->params[0].thread_id.tid);
+    if (!cpu) {
+        return;
+    }
+
+    cpu_synchronize_state(cpu);
+
+    if (gdb_ctx->s->multiprocess && (gdb_ctx->s->process_num > 1)) {
+        /* Print the CPU model and name in multiprocess mode */
+        ObjectClass *oc = object_get_class(OBJECT(cpu));
+        const char *cpu_model = object_class_get_name(oc);
+        char *cpu_name = object_get_canonical_path_component(OBJECT(cpu));
+        len = snprintf((char *)gdb_ctx->mem_buf, sizeof(gdb_ctx->str_buf) / 2,
+                       "%s %s [%s]", cpu_model, cpu_name,
+                       cpu->halted ? "halted " : "running");
+        g_free(cpu_name);
+    } else {
+        /* memtohex() doubles the required space */
+        len = snprintf((char *)gdb_ctx->mem_buf, sizeof(gdb_ctx->str_buf) / 2,
+                        "CPU#%d [%s]", cpu->cpu_index,
+                        cpu->halted ? "halted " : "running");
+    }
+    trace_gdbstub_op_extra_info((char *)gdb_ctx->mem_buf);
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+#ifdef CONFIG_USER_ONLY
+static void handle_query_offsets(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    TaskState *ts;
+
+    ts = gdb_ctx->s->c_cpu->opaque;
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+             "Text=" TARGET_ABI_FMT_lx ";Data=" TARGET_ABI_FMT_lx
+             ";Bss=" TARGET_ABI_FMT_lx,
+             ts->info->code_offset,
+             ts->info->data_offset,
+             ts->info->data_offset);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+#else
+static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int len;
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    len = strlen(gdb_ctx->params[0].data);
+    if (len % 2) {
+        put_packet(gdb_ctx->s, "E01");
+        return;
+    }
+
+    len = len / 2;
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[0].data, len);
+    gdb_ctx->mem_buf[len++] = 0;
+    qemu_chr_be_write(gdb_ctx->s->mon_chr, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, "OK");
+
+}
+#endif
+
+static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
     CPUClass *cc;
+
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "PacketSize=%x",
+             MAX_PACKET_LENGTH);
+    cc = CPU_GET_CLASS(first_cpu);
+    if (cc->gdb_core_xml_file) {
+        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+                ";qXfer:features:read+");
+    }
+
+    if (gdb_ctx->num_params &&
+        strstr(gdb_ctx->params[0].data, "multiprocess+")) {
+        gdb_ctx->s->multiprocess = true;
+    }
+
+    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";multiprocess+");
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    GDBProcess *process;
+    CPUClass *cc;
+    unsigned long len, total_len, addr;
+    const char *xml;
     const char *p;
-    uint32_t pid, tid;
-    int ch, type;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    process = gdb_get_cpu_process(gdb_ctx->s, gdb_ctx->s->g_cpu);
+    cc = CPU_GET_CLASS(gdb_ctx->s->g_cpu);
+    if (!cc->gdb_core_xml_file) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    gdb_has_xml = true;
+    p = gdb_ctx->params[0].data;
+    xml = get_feature_xml(gdb_ctx->s, p, &p, process);
+    if (!xml) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    addr = gdb_ctx->params[1].val_ul;
+    len = gdb_ctx->params[2].val_ul;
+    total_len = strlen(xml);
+    if (addr > total_len) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    if (len > (MAX_PACKET_LENGTH - 5) / 2) {
+        len = (MAX_PACKET_LENGTH - 5) / 2;
+    }
+
+    if (len < total_len - addr) {
+        gdb_ctx->str_buf[0] = 'm';
+        len = memtox(gdb_ctx->str_buf + 1, xml + addr, len);
+    } else {
+        gdb_ctx->str_buf[0] = 'l';
+        len = memtox(gdb_ctx->str_buf + 1, xml + addr, total_len - addr);
+    }
+
+    put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
+}
+
+static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    put_packet(gdb_ctx->s, GDB_ATTACHED);
+}
+
+static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    put_packet(gdb_ctx->s, "sstepbits;sstep");
+}
+
+static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
+    /* Order is important if has same prefix */
+    {
+        .handler = handle_query_qemu_sstepbits,
+        .cmd = "qemu.sstepbits",
+    },
+    {
+        .handler = handle_query_qemu_sstep,
+        .cmd = "qemu.sstep",
+    },
+    {
+        .handler = handle_set_qemu_sstep,
+        .cmd = "qemu.sstep=",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+};
+
+static GdbCmdParseEntry gdb_gen_query_table[] = {
+    {
+        .handler = handle_query_curr_tid,
+        .cmd = "C",
+    },
+    {
+        .handler = handle_query_threads,
+        .cmd = "sThreadInfo",
+    },
+    {
+        .handler = handle_query_first_threads,
+        .cmd = "fThreadInfo",
+    },
+    {
+        .handler = handle_query_thread_extra,
+        .cmd = "ThreadExtraInfo,",
+        .cmd_startswith = 1,
+        .schema = "t0"
+    },
+#ifdef CONFIG_USER_ONLY
+    {
+        .handler = handle_query_offsets,
+        .cmd = "Offsets",
+    },
+#else
+    {
+        .handler = handle_query_rcmd,
+        .cmd = "Rcmd,",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+#endif
+    {
+        .handler = handle_query_supported,
+        .cmd = "Supported:",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    {
+        .handler = handle_query_supported,
+        .cmd = "Supported",
+        .schema = "s0"
+    },
+    {
+        .handler = handle_query_xfer_features,
+        .cmd = "Xfer:features:read:",
+        .cmd_startswith = 1,
+        .schema = "s:l,l0"
+    },
+    {
+        .handler = handle_query_attached,
+        .cmd = "Attached:",
+        .cmd_startswith = 1
+    },
+    {
+        .handler = handle_query_attached,
+        .cmd = "Attached",
+    },
+    {
+        .handler = handle_query_qemu_supported,
+        .cmd = "qemu.Supported",
+    },
+};
+
+static GdbCmdParseEntry gdb_gen_set_table[] = {
+    /* Order is important if has same prefix */
+    {
+        .handler = handle_set_qemu_sstep,
+        .cmd = "qemu.sstep:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+};
+
+static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (!process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                            gdb_gen_query_set_common_table,
+                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+        return;
+    }
+
+    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                           gdb_gen_query_table,
+                           ARRAY_SIZE(gdb_gen_query_table))) {
+        put_packet(gdb_ctx->s, "");
+    }
+}
+
+static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (!process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                            gdb_gen_query_set_common_table,
+                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+        return;
+    }
+
+    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                           gdb_gen_set_table,
+                           ARRAY_SIZE(gdb_gen_set_table))) {
+        put_packet(gdb_ctx->s, "");
+    }
+}
+
+static int gdb_handle_packet(GDBState *s, const char *line_buf)
+{
+    const char *p;
+    int ch;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    target_ulong addr, len;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -2117,183 +2459,28 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'q':
-    case 'Q':
-        /* parse any 'q' packets here */
-        if (!strcmp(p,"qemu.sstepbits")) {
-            /* Query Breakpoint bit definitions */
-            snprintf(buf, sizeof(buf), "ENABLE=%x,NOIRQ=%x,NOTIMER=%x",
-                     SSTEP_ENABLE,
-                     SSTEP_NOIRQ,
-                     SSTEP_NOTIMER);
-            put_packet(s, buf);
-            break;
-        } else if (is_query_packet(p, "qemu.sstep", '=')) {
-            /* Display or change the sstep_flags */
-            p += 10;
-            if (*p != '=') {
-                /* Display current setting */
-                snprintf(buf, sizeof(buf), "0x%x", sstep_flags);
-                put_packet(s, buf);
-                break;
-            }
-            p++;
-            type = strtoul(p, (char **)&p, 16);
-            sstep_flags = type;
-            put_packet(s, "OK");
-            break;
-        } else if (strcmp(p,"C") == 0) {
-            /*
-             * "Current thread" remains vague in the spec, so always return
-             * the first thread of the current process (gdb returns the
-             * first thread).
-             */
-            cpu = get_first_cpu_in_process(s, gdb_get_cpu_process(s, s->g_cpu));
-            snprintf(buf, sizeof(buf), "QC%s",
-                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id)));
-            put_packet(s, buf);
-            break;
-        } else if (strcmp(p,"fThreadInfo") == 0) {
-            s->query_cpu = gdb_first_attached_cpu(s);
-            goto report_cpuinfo;
-        } else if (strcmp(p,"sThreadInfo") == 0) {
-        report_cpuinfo:
-            if (s->query_cpu) {
-                snprintf(buf, sizeof(buf), "m%s",
-                         gdb_fmt_thread_id(s, s->query_cpu,
-                                       thread_id, sizeof(thread_id)));
-                put_packet(s, buf);
-                s->query_cpu = gdb_next_attached_cpu(s, s->query_cpu);
-            } else
-                put_packet(s, "l");
-            break;
-        } else if (strncmp(p,"ThreadExtraInfo,", 16) == 0) {
-            if (read_thread_id(p + 16, &p, &pid, &tid) == GDB_READ_THREAD_ERR) {
-                put_packet(s, "E22");
-                break;
-            }
-            cpu = gdb_get_cpu(s, pid, tid);
-            if (cpu != NULL) {
-                cpu_synchronize_state(cpu);
-
-                if (s->multiprocess && (s->process_num > 1)) {
-                    /* Print the CPU model and name in multiprocess mode */
-                    ObjectClass *oc = object_get_class(OBJECT(cpu));
-                    const char *cpu_model = object_class_get_name(oc);
-                    char *cpu_name =
-                        object_get_canonical_path_component(OBJECT(cpu));
-                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
-                                   "%s %s [%s]", cpu_model, cpu_name,
-                                   cpu->halted ? "halted " : "running");
-                    g_free(cpu_name);
-                } else {
-                    /* memtohex() doubles the required space */
-                    len = snprintf((char *)mem_buf, sizeof(buf) / 2,
-                                   "CPU#%d [%s]", cpu->cpu_index,
-                                   cpu->halted ? "halted " : "running");
-                }
-                trace_gdbstub_op_extra_info((char *)mem_buf);
-                memtohex(buf, mem_buf, len);
-                put_packet(s, buf);
-            }
-            break;
-        }
-#ifdef CONFIG_USER_ONLY
-        else if (strcmp(p, "Offsets") == 0) {
-            TaskState *ts = s->c_cpu->opaque;
-
-            snprintf(buf, sizeof(buf),
-                     "Text=" TARGET_ABI_FMT_lx ";Data=" TARGET_ABI_FMT_lx
-                     ";Bss=" TARGET_ABI_FMT_lx,
-                     ts->info->code_offset,
-                     ts->info->data_offset,
-                     ts->info->data_offset);
-            put_packet(s, buf);
-            break;
-        }
-#else /* !CONFIG_USER_ONLY */
-        else if (strncmp(p, "Rcmd,", 5) == 0) {
-            int len = strlen(p + 5);
-
-            if ((len % 2) != 0) {
-                put_packet(s, "E01");
-                break;
-            }
-            len = len / 2;
-            hextomem(mem_buf, p + 5, len);
-            mem_buf[len++] = 0;
-            qemu_chr_be_write(s->mon_chr, mem_buf, len);
-            put_packet(s, "OK");
-            break;
-        }
-#endif /* !CONFIG_USER_ONLY */
-        if (is_query_packet(p, "Supported", ':')) {
-            snprintf(buf, sizeof(buf), "PacketSize=%x", MAX_PACKET_LENGTH);
-            cc = CPU_GET_CLASS(first_cpu);
-            if (cc->gdb_core_xml_file != NULL) {
-                pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
-            }
-
-            if (strstr(p, "multiprocess+")) {
-                s->multiprocess = true;
-            }
-            pstrcat(buf, sizeof(buf), ";multiprocess+");
-
-            put_packet(s, buf);
-            break;
-        }
-        if (strncmp(p, "Xfer:features:read:", 19) == 0) {
-            const char *xml;
-            target_ulong total_len;
-
-            process = gdb_get_cpu_process(s, s->g_cpu);
-            cc = CPU_GET_CLASS(s->g_cpu);
-            if (cc->gdb_core_xml_file == NULL) {
-                goto unknown_command;
-            }
-
-            gdb_has_xml = true;
-            p += 19;
-            xml = get_feature_xml(s, p, &p, process);
-            if (!xml) {
-                snprintf(buf, sizeof(buf), "E00");
-                put_packet(s, buf);
-                break;
-            }
-
-            if (*p == ':')
-                p++;
-            addr = strtoul(p, (char **)&p, 16);
-            if (*p == ',')
-                p++;
-            len = strtoul(p, (char **)&p, 16);
-
-            total_len = strlen(xml);
-            if (addr > total_len) {
-                snprintf(buf, sizeof(buf), "E00");
-                put_packet(s, buf);
-                break;
-            }
-            if (len > (MAX_PACKET_LENGTH - 5) / 2)
-                len = (MAX_PACKET_LENGTH - 5) / 2;
-            if (len < total_len - addr) {
-                buf[0] = 'm';
-                len = memtox(buf + 1, xml + addr, len);
-            } else {
-                buf[0] = 'l';
-                len = memtox(buf + 1, xml + addr, total_len - addr);
-            }
-            put_packet_binary(s, buf, len + 1, true);
-            break;
+        {
+            static const GdbCmdParseEntry gen_query_cmd_desc = {
+                .handler = handle_gen_query,
+                .cmd = "q",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            cmd_parser = &gen_query_cmd_desc;
         }
-        if (is_query_packet(p, "Attached", ':')) {
-            put_packet(s, GDB_ATTACHED);
-            break;
+        break;
+    case 'Q':
+        {
+            static const GdbCmdParseEntry gen_set_cmd_desc = {
+                .handler = handle_gen_set,
+                .cmd = "Q",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            cmd_parser = &gen_set_cmd_desc;
         }
-        /* Unrecognised 'q' command.  */
-        goto unknown_command;
-
+        break;
     default:
-    unknown_command:
         /* put empty packet */
         buf[0] = '\0';
         put_packet(s, buf);
-- 
2.21.0


