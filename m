Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F83C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CE4218FD
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGb+VjBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CE4218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ1H-0006Tf-K4
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:37:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzG-0004qG-Pv
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsb-00018N-CD
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsb-00014h-4P
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so7882430wrp.6
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/c5IWlozLF/xgWcLfKZ3+ImQLkPy2X3T9RDaN/kMFqI=;
	b=sGb+VjBwbXmkke3gYgbOg3Or6g/IdAj/eykBR8j6254JqPMPsxFGSIgl63RHD36Y3b
	EVTSrua/Por9EfxDzJZ4LFQsTcfo7T+hOZsdt9onu58Yq+eQC/YvNGQOwhs9YW+uf+rT
	njKkmaCuI4eaJuP54OwlE90WKpEAyTMRqdvzu06yeARrXuxgLn+AY7ipp2fS9hh5Tbkv
	+NnoTYr0r/qGrOBE5qopvlFlBQkMAg8fpjj/qj1LjCS58Eepx0y2IEOCGcqUQD9B3Z6k
	+0SgLPkTTamqYUVT6QAlI6xs/DwfwW1EcgCRoAj0qEMF1SMeaqTQscb2rqsfPQbK7Vzo
	PqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/c5IWlozLF/xgWcLfKZ3+ImQLkPy2X3T9RDaN/kMFqI=;
	b=MZGaCksCyTjYkKTaMP/A8Odf9WEsdErfVvGY6pGLXJ0xW6ebtNctpYcMDqm1V60qTS
	LQ/Tw2IwbteFsN4Bds+QjTaCK4uDYzkbkPXDA8iog2DfRgzefnIS/Fky3C+ANOWSQG1t
	8puVg8TL9PmdKjA6Y5zXbrb1FKPCF3mjdOTQloUWOeSlBp5RWqh2L8BjuxDNO2WR0hm3
	p2KP2Bilu6QiS3PHWUhkkVpc4O/zsFgn0uI7tjGDH7li2pdYgS72zirKNv+BKoIFKsh/
	AMT9bfKawRfaSG6/2FmeSEOnWHOzK8jJYjaFLVNXpoQqmMN+u3ZZhLVKU49MbpKf+AWq
	Ircw==
X-Gm-Message-State: APjAAAVhvBEU2fOOkkU/FoSOUhfROg98oAmDmLrLJX4kK2WuHK9WYCdR
	y8L3uPWWV+UET8DW/34kMI/wdyCW
X-Google-Smtp-Source: APXvYqwTQoyOUaYQ+vhsNwfE/I+uw1G54QSq3QwrKeB98GHEH8tflklssRhD/gV1USCIh8eBQL4t3w==
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr6545572wrt.41.1556116084248;
	Wed, 24 Apr 2019 07:28:04 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.28.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:28:03 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:11 +0300
Message-Id: <20190424142714.28460-17-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v3 17/20] gdbstub: Implement v commands with
 new infra
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
Message-ID: <20190424142711.6w_UcV3MgTmVbcmWF97x00TInCOmaD_XbqFpGO3Kq0Y@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 170 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 110 insertions(+), 60 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 273216beb6..2dc088180d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1831,6 +1831,106 @@ static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_v_cont_query(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    put_packet(gdb_ctx->s, "vCont;c;C;s;S");
+}
+
+static void handle_v_cont(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    res = gdb_handle_vcont(gdb_ctx->s, gdb_ctx->params[0].data);
+    if ((res == -EINVAL) || (res == -ERANGE)) {
+        put_packet(gdb_ctx->s, "E22");
+    } else if (res) {
+        put_packet(gdb_ctx->s, "\0");
+    }
+}
+
+static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    GDBProcess *process;
+    CPUState *cpu;
+    char thread_id[16];
+
+    strcpy(gdb_ctx->str_buf, "E22");
+    if (!gdb_ctx->num_params) {
+        goto cleanup;
+    }
+
+    process = gdb_get_process(gdb_ctx->s, gdb_ctx->params[0].val_ul);
+    if (!process) {
+        goto cleanup;
+    }
+
+    cpu = get_first_cpu_in_process(gdb_ctx->s, process);
+    if (!cpu) {
+        goto cleanup;
+    }
+
+    process->attached = true;
+    gdb_ctx->s->g_cpu = cpu;
+    gdb_ctx->s->c_cpu = cpu;
+
+    gdb_fmt_thread_id(gdb_ctx->s, cpu, thread_id, sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
+             GDB_SIGNAL_TRAP, thread_id);
+cleanup:
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
+static void handle_v_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    /* Kill the target */
+    put_packet(gdb_ctx->s, "OK");
+    error_report("QEMU: Terminated via GDBstub");
+    exit(0);
+}
+
+static GdbCmdParseEntry gdb_v_commands_table[] = {
+    /* Order is important if has same prefix */
+    {
+        .handler = handle_v_cont_query,
+        .cmd = "Cont?",
+        .cmd_startswith = 1
+    },
+    {
+        .handler = handle_v_cont,
+        .cmd = "Cont",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    {
+        .handler = handle_v_attach,
+        .cmd = "Attach;",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+    {
+        .handler = handle_v_kill,
+        .cmd = "Kill;",
+        .cmd_startswith = 1
+    },
+};
+
+static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
+                           gdb_v_commands_table,
+                           ARRAY_SIZE(gdb_v_commands_table))) {
+        put_packet(gdb_ctx->s, "");
+    }
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1838,7 +1938,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, type, res;
+    int ch, type;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1886,66 +1986,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'v':
-        if (strncmp(p, "Cont", 4) == 0) {
-            p += 4;
-            if (*p == '?') {
-                put_packet(s, "vCont;c;C;s;S");
-                break;
-            }
-
-            res = gdb_handle_vcont(s, p);
-
-            if (res) {
-                if ((res == -EINVAL) || (res == -ERANGE)) {
-                    put_packet(s, "E22");
-                    break;
-                }
-                goto unknown_command;
-            }
-            break;
-        } else if (strncmp(p, "Attach;", 7) == 0) {
-            unsigned long pid;
-
-            p += 7;
-
-            if (qemu_strtoul(p, &p, 16, &pid)) {
-                put_packet(s, "E22");
-                break;
-            }
-
-            process = gdb_get_process(s, pid);
-
-            if (process == NULL) {
-                put_packet(s, "E22");
-                break;
-            }
-
-            cpu = get_first_cpu_in_process(s, process);
-
-            if (cpu == NULL) {
-                /* Refuse to attach an empty process */
-                put_packet(s, "E22");
-                break;
-            }
-
-            process->attached = true;
-
-            s->g_cpu = cpu;
-            s->c_cpu = cpu;
-
-            snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
-                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id)));
-
-            put_packet(s, buf);
-            break;
-        } else if (strncmp(p, "Kill;", 5) == 0) {
-            /* Kill the target */
-            put_packet(s, "OK");
-            error_report("QEMU: Terminated via GDBstub");
-            exit(0);
-        } else {
-            goto unknown_command;
+        {
+            static GdbCmdParseEntry v_cmd_desc = {
+                .handler = handle_v_commands,
+                .cmd = "v",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &v_cmd_desc, 1);
         }
+        break;
     case 'k':
         /* Kill the target */
         error_report("QEMU: Terminated via GDBstub");
-- 
2.20.1


