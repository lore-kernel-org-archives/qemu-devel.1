Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E5C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A9B206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlZ4n1Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A9B206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39100 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsnx-0001j6-Br
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:49:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmG-0000dG-DU
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsbQ-0004w9-HL
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsbQ-0004tm-AY
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id c12so2426329wrt.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kKebEya2GiWvJfCSlb0vx4oLqKZ12SF6Am+XqCA7M8o=;
	b=JlZ4n1WpFODLSq81e4QfOT9kqk5GGHSTvRCYDIIP9SNXVESXET8lU6++oPTq+YbpmG
	Di43CkmW6KORChFLgZ2DWRs9sCwhGbgsS8A7Qres+3YvLoVlV1y7bAAxOxA4INzM1zhC
	GRmpBXHZvq3P5esqDiR7VtX9P6oeAdW63L7OOyQta78Ufk8euitH0yyoFFqOqTBva1vz
	OfgwQkJmvu7mh9ttNb/BBXQeo0q/xbb5SCdj0jhC3+jkTHPnR62/kUL+i+yAd+sOA67a
	JUmqw0wJolj/YHMtZchlkMmqd/RTtVH8LbCcbNsYWDPIg01qyMGe4+JvBlfkxYRAHmtG
	x7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kKebEya2GiWvJfCSlb0vx4oLqKZ12SF6Am+XqCA7M8o=;
	b=SIFYnPewSq3WVHsNHfpiQR9mu9yzBDd4Cpczi0Q38vPJT/xMAY6Mhj48sG81aK2HEb
	TtzVZsx/2G7QC0nzrAPY7iZqTChCSWafh3QjRkxqKLbMWVNwO9RHw5f5obia1aIXXsZ5
	hWRCKSKujCs0oO/iE8KGqk5IV0+R7sBxFfakkx4LjyRpsb/o09TAin7BqD2mKJt9tLzu
	aTNgR2oyQ+qutpk1uRMu5mT596+prWyilyWxivrAz/Q1XECyOwEjT+7cZ0CKdIxaukCh
	VApRoyrsvTUvkWHxdd4u9irqqV1PdVp8vIS+eQ0b8lMYe5Zs7NhZQ423HmX/WoJ2VrC1
	vjBg==
X-Gm-Message-State: APjAAAX+6lSMrVPA/ZvMrkdCwj+zK9yeYXff43hjz49xHiaxpfbl4gCS
	NL4pXlWdsXtE8TR3rKtVsjDoZSW+
X-Google-Smtp-Source: APXvYqxkav1dQsrKH3H1MdJIaTMXAuvYUrLscxe80SRO+xPUgHT/1mgxxrcPIwvn6R5ymRw/mqpNgA==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr8689045wrp.202.1556253406489; 
	Thu, 25 Apr 2019 21:36:46 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:45 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:54 +0300
Message-Id: <20190426043558.6888-18-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v7 17/21] gdbstub: Implement v commands with
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426043554.zYXjyHpGkazhJvavWmhJO_AT9zyPjIB7SDLSoDNcQCk@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 170 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 110 insertions(+), 60 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 9b0556f8be..d56d0fd235 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1815,6 +1815,106 @@ static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1822,7 +1922,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, type, res;
+    int ch, type;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1871,66 +1971,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static const GdbCmdParseEntry v_cmd_desc = {
+                .handler = handle_v_commands,
+                .cmd = "v",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            cmd_parser = &v_cmd_desc;
         }
+        break;
     case 'k':
         /* Kill the target */
         error_report("QEMU: Terminated via GDBstub");
-- 
2.20.1


