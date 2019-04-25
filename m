Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB34C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D8F206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKld0IuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D8F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58050 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJf08-0006mf-8M
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:05:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQF-0000Mx-DH
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQD-00020e-TZ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeQD-0001zu-N0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id 26so3498241wmj.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0Iz5SrYAXu7VpCoWsP3e/cvDID9SYRQ00R50I33AURg=;
	b=tKld0IuLm8DI3f7gUS4HBkoZnHruU/xXlnJeInytgY95OB0TuoMfQ1QjpOeD55B2eZ
	Z3D8/taq37PSWHsEvf6zSEsSoaB1Btzr37fhL3mUC6zU1piH4gupsy8CInWYIiZmcXNu
	fhmHzzrw85bfhSqJPAnL8kfyR+qFQwXQr2n8BujFaOp6YwscogE1NjhFIU6dZxgk39yv
	Bc1g1p3GuAhlFxN/Vd0xtQi/QLSv2sO1I7SFNhzWMwDHUHfoHwIYy/J4bQkDbMjVtp7q
	Cpm0ptbGaIcZkbncaPKY17CpIpH6AFlHA1QcyLxOHu2RJl40lVBbEQO295/RUEIL+jqH
	XvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0Iz5SrYAXu7VpCoWsP3e/cvDID9SYRQ00R50I33AURg=;
	b=EOpf+pMxnrs11LY3R3ZHiPSZ8kUYYpL0MUHrj3L68oo4uWCV2wuvCRWYYoz8QgqmFl
	HNTmWvyFqVf+ljBbJbX59CHG4uk8QlxK6mhaLm1fv7ERbhmDPjCTyh8VGuiCs1nN+pRF
	zKCbURdgQ7El7WHdwogPHIXbcmLvYr+eKLdbC7BJQ0HjezfaPl8Du3stoVx1XDhfyVdv
	7DRms8i54M6wZjk2j6Ts2bJVk47oQlBYNj0yV6t7KIUZwL1XSrFHyqASz2aqlhZWHkRi
	xSuY1ta7Kj7CkfFI59YdVIGJoGhgGgz699cLv3cb5xg7rLADEJ63SsSCOnFgfo7QO9HY
	J5HQ==
X-Gm-Message-State: APjAAAWK33bYwj/J/i5taABPC1/okhpTRrdUgZK5kljX53x1zIg7NaYN
	t5xApJOj0cfbBRmKds4WHxaZnN5Q
X-Google-Smtp-Source: APXvYqxIa7LWxca8uO1Rb2/PpQL4lvQ/UYGVLVckTNmNfG+xLGhikGjJ2CNbJ9BH/41ZYDA+nGs1QQ==
X-Received: by 2002:a1c:9e96:: with SMTP id h144mr3748274wme.33.1556198895179; 
	Thu, 25 Apr 2019 06:28:15 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.28.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:28:12 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:33 +0300
Message-Id: <20190425132636.31636-19-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v6 18/21] gdbstub: Implement generic query (q
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132633.tX5oo3kFWifMeK96Ko_HwLNQkEJwleHZYUqyja_Idhk@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 335 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 335 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 7bc00d7f77..a2db1ec661 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1916,6 +1916,331 @@ static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
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
+        .cmd_full_match = 1
+    },
+    {
+        .handler = handle_query_qemu_sstep,
+        .cmd = "qemu.sstep",
+        .cmd_full_match = 1,
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
+        .cmd_full_match = 1
+    },
+    {
+        .handler = handle_query_threads,
+        .cmd = "sThreadInfo",
+        .cmd_full_match = 1
+    },
+    {
+        .handler = handle_query_first_threads,
+        .cmd = "fThreadInfo",
+        .cmd_full_match = 1
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
+        .cmd_full_match = 1
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
+        .cmd_full_match = 1,
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
+        .cmd_full_match = 1
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
@@ -2129,6 +2454,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


