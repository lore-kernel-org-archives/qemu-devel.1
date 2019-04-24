Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B516C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FD8206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMZqCmMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FD8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJN8d-00040M-UO
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:01:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN69-0001zm-Fp
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuu-000647-2m
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMut-00063i-QJ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id h4so26569531wre.7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=33FIaUwsXhUgKNhssUv3dAg2ebSGWOiTF6mf5E5+6hg=;
	b=GMZqCmMQ+8BEc2zt5xKSA3NjsBzrGRZ5vx+hsAwU3bun8Mg3zJdsOKheR8EFz1rLlX
	lppm/XDl0ZGicMSZmlE5kwQSzLjgYyBZsRhtzg+cLkj7gL8QZdRhpSJlfrr/xgY0PjXG
	cqPBQeGI3M/alDMW0hu6Cr7C80CYk/NFuxQsJz5TBhbDUeVIwh/W2CFh0NbW9b3ZP2FJ
	KYUvcqG16JFgYYT9l7qtvQGYopR4lHJ6CE/ESZV1wSUyjEe9y3b3FU4SnPSE/iswePMD
	PteLHLltQjq2Be2NVUmfP6RzjTc3uDJ2k9HLFwr+YzM324UOzZgNlMth8CdcmAXW26CL
	qJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=33FIaUwsXhUgKNhssUv3dAg2ebSGWOiTF6mf5E5+6hg=;
	b=C1Uro7eZNuxEKThiyBERoeTkcnOBjUUgLaQbOV1HKNTToQu6gxJ7ann21vcRdm5xh1
	VdNXjF9bRFeWlasT/6wKEr7A2OsXQOvScm9x2GQ83oBTlRTu6BtCAXoueGes1dJ4VaBV
	VJ7hfgnb/1uYvIXcXENSxuaPpBc3058PXgxQvL7tN7n76MnRI/7rwjOH3Vm4XbpoKN49
	UfmIrRY3DPopjCTXD8+jQn8wb0n9UCoPUs1tg2IquOHV/+B7IqezrLnAc7rZ1TPyP+G1
	LDWcUJ6C6Smpso3+gJGjLRM4p1Utv9UuS8PVCA09AyiVbuR1qbUB61mRHyJ3kYSy6Bh5
	fBPg==
X-Gm-Message-State: APjAAAXwq33k6pOUYjtr2Sn84lHMKaTPi2uZpCZdrOEGUYySGHD/Q/hJ
	jMRR5OvCHmNt7ggXkFvZEXYVpEG5
X-Google-Smtp-Source: APXvYqx0P1k+lkcehRyqj5Lcccxz/gmOix3ABl8V1F125m5OmIhEApwVVM7Px8iBM1L857Gho5Umlw==
X-Received: by 2002:adf:d84f:: with SMTP id k15mr5326787wrl.301.1556131606269; 
	Wed, 24 Apr 2019 11:46:46 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:45 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:59 +0300
Message-Id: <20190424184600.8445-19-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v4 19/20] gdbstub: Implement generic set (Q
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
Message-ID: <20190424184559.XYuw7gv1cP5T8djkfBlZr-81ZU2WjYCSrJT_AE8wliM@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 213 +++++++-----------------------------------------------
 1 file changed, 25 insertions(+), 188 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8de4e09caa..61ab630d9e 100644
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
@@ -2250,18 +2242,28 @@ static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
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
 
     trace_gdbstub_io_command(line_buf);
 
@@ -2473,182 +2475,17 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry gen_set_cmd_desc = {
+                .handler = handle_gen_set,
+                .cmd = "Q",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &gen_set_cmd_desc, 1);
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


