Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE356C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DFE20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6DoNYR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DFE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46797 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6So-0005aW-Lu
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:49:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6AF-00053z-7N
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6A5-0002vd-P2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69w-0000g8-Gr
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id l2so1784003wrb.9
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6XppYMRruE5laPQu4tuOEJD3R2TgHj9UJ0kj9FF2Z0o=;
	b=H6DoNYR23Sg2HlFwe2cz4i6Du6c+TyDg8gjQj0G885U/uVmHGKQSOazH8lnnyKK1sH
	QwV7VYOq9UbXFTKpBbM/2UNF+NK+8lcde34XJ6hNC2rC0ybTfPrGnzJTSl4Kcin5k/jh
	lQVRuwaKtGVnzQNOp0LODgQkm1EpCvdQwaCnnwlANqO2rjYTyFinBlmz+oE37RWqy9Ei
	2hykb2nzf329Cz200tJ9SFy4yp27STdO1giye+1Wbpl1egCYV1IjKp/4uprM57m9Q4X5
	EigczdW8OwS6BjW/h3uLku0/0qqXSdgg6tLCPlhJpwfJgwCSXERKwwSI8hg5FG7hrM6l
	kw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6XppYMRruE5laPQu4tuOEJD3R2TgHj9UJ0kj9FF2Z0o=;
	b=LPL0omm2LybUVMkF9Skf/IAvzIkcOMnmevQWfDrnW68V9dXsgATJQcCSg7uxzwYhFb
	2RWo1XTKw3WiSVNsMtnlSvay7lfQMkhUEsXmvREnzlP1tEsuAUpKmocIyQq5DBGQ5Sfs
	4VF+d4cgKNDHwpEqU0drWn3pjXn3nf1rIsHK+/DOss3KMyFiaJp7QYUG53bYr4N/QcKi
	li3BS1D3eC6wdzquRuGromZq5LkQngdayP1mgOXLYjPhlX7YkhpYeIS8uWh/W7svPiHt
	IkdH49Le43Y9JQ00J0kDjvp7ht8Tv79+5INA9cFD4dZx9OKWTuGXqZeLhV+ezh4UBxxw
	HisA==
X-Gm-Message-State: APjAAAW+WJvrgZ1baFARfIbOfd0mveRvWuusQihGmZPsG5uvM4twMypu
	Xf9mFNER8PDEfgGrI1D5QiCbi7e7
X-Google-Smtp-Source: APXvYqwZVAXhrCHcHCcRODZ7PSkxAzjxLgsZYJYYdrPO34B5IlPquWxDjkho5l7MeuKuzV8nO+4OEw==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr1499057wrp.293.1556782045555; 
	Thu, 02 May 2019 00:27:25 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:24 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:32 +0300
Message-Id: <20190502072641.4667-19-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v8 18/27] gdbstub: Implement generic query (q
 pkt) with new infra
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072632.22kLWPFFTArML7aVWyRqbragesnmqmOGF0-i_kCEpiY@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 327 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index d56d0fd235..83ae8738cc 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1915,6 +1915,323 @@ static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
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
+{
+    CPUState *cpu;
+    GDBProcess *process;
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
+    CPUClass *cc;
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
+    const char *p;
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
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -2128,6 +2445,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'q':
+        {
+            static const GdbCmdParseEntry gen_query_cmd_desc = {
+                .handler = handle_gen_query,
+                .cmd = "q",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            cmd_parser = &gen_query_cmd_desc;
+        }
+        break;
     case 'Q':
         /* parse any 'q' packets here */
         if (!strcmp(p,"qemu.sstepbits")) {
-- 
2.20.1


