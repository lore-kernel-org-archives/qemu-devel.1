Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C773FC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6B9206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTXWvvOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6B9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJf1V-0007qk-PH
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:06:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQL-0000S3-V7
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQK-00025l-JD
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeQK-00025L-9n
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id v14so10625084wmf.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8oEFDKxbCtKm7exNUDzwxsBAyq4ksqjhK1GGeb9omBg=;
	b=gTXWvvOA+n4EG0gVKSJSJQ9QRLs8a0EnN4LQdNUBX+o9l2HyHWTaTwKkBQftQBfau0
	OK16Lq0bsrRRQu7i6kD+B2Nd+bDJaEjfOF4J4y2oFHOnG+eT5ybF2J3ic4twgBNOwIt3
	r0+sHisuQennV9BfUBp/Hid0JTwTZ/FsuA9mdGhYvIfs3ChqV4kmeENC0lqb3mE8tLEP
	A0V/a/e9XbG+dL8xBSLkLK9e5je3p4LYcUWux7gZY8uzTpxcsNvT8VAcJl9n4CyzBZ7N
	m4OVJgFw2jB01h0l47IJ9jd3Izo5rr7hJda3RrIpwV2RoDfPRRXijxmmcn0x+NcYGYPc
	YG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8oEFDKxbCtKm7exNUDzwxsBAyq4ksqjhK1GGeb9omBg=;
	b=fJzAJX/82GzcWp7H834Vtc8y7aQD/SWhn8GEM8K8Hb/ncC8UziV/VD1tmmoxltsQYe
	W65u18AvjvuJsy+4k1E+aPdTRI8HuIirl7IRGA7GRe7cNweUnojPo3h4BAWIS/wFKHFS
	ZicKKT0HOIrj+TpoCYIXs1Bf+FZT/Zo6JNslADPF8Y0r6ERCfVJ7hnWOTKiKROSqS+UN
	yLGR6mcssoX6TBFwJEMapRJhVFJZtIyeuxVEbiQGPfwmV6A3kgDrljVbidhvyF1op33N
	DJPv+M43lj2WDbCLQO6+2ictOVLaHJVaDUhEGdb+encAKSi3lQiexMBm0ys8ye3MgU8o
	1hCw==
X-Gm-Message-State: APjAAAUjJUBoB51kfjtcrTJ4mlWPPbUw9hPX7wnN8nFL+tSJc3hQrvOS
	FC+JqKS5JVlCiMXUVwO1HjaIsPXp
X-Google-Smtp-Source: APXvYqzcgY5c2K7LbtNyKqfcYc+CfTcE4wTuhHdMZvU4ykO3ZIV0oRG3ucu9QpkjOBcnJStGpGDBWA==
X-Received: by 2002:a1c:c7c9:: with SMTP id x192mr3614546wmf.151.1556198901545;
	Thu, 25 Apr 2019 06:28:21 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.28.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:28:18 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:34 +0300
Message-Id: <20190425132636.31636-20-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v6 19/21] gdbstub: Implement generic set (Q
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
Message-ID: <20190425132634.bdf75GtaVnmf3f7JflHeH4-y-GJ_pKvcaN1uaKa6RQY@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 213 +++++++-----------------------------------------------
 1 file changed, 25 insertions(+), 188 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a2db1ec661..779da2aa77 100644
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
@@ -2241,18 +2233,28 @@ static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
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
+    put_packet(gdb_ctx->s, "");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
-    CPUState *cpu;
-    GDBProcess *process;
-    CPUClass *cc;
     const char *p;
-    uint32_t pid, tid;
-    int ch, type;
+    int ch;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    target_ulong addr, len;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -2465,182 +2467,17 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'Q':
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
-        }
-        if (is_query_packet(p, "Attached", ':')) {
-            put_packet(s, GDB_ATTACHED);
-            break;
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
2.20.1


