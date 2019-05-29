Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A94C07542
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D808E216FD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbuIiXq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D808E216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsP6-00074Q-34
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:49:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHm-0000y2-MJ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHl-0000FV-H7
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHl-00005B-BE
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id v22so691296wml.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2qe4jUb7Wrs/Gksk3zL4XfYnM/CEolczq1katmanDvA=;
	b=IbuIiXq2eGf7/gxLLkUDe10z821pzSAcDu1CEZMfWjjLQE4SFkxOqxI9+037vcCPvH
	1cb6T/nmMimbcgUfiOaUaP9vpylZPxormXi5eNJp00Acr16Zmgc9xZaLto3U2zFkcwKW
	E1XQjuRpJSown8lo7pu9CBH/XjpWX6FCnTR+jrqWwdH40002kbsN+B4vmQm2F0sqRBES
	aspne1YVDqZpqh0ZAdXRzf8b5jDUOwg0fwKgN1/B03RCJzeazt5nPntjPmVrPrdVukoT
	8Cu/T36+hoXN5g/ABxHIi+yGm05ep9WhXIImmC3N1PZZQnGWV5n+GMg6Qivi9ZHUGls1
	oDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2qe4jUb7Wrs/Gksk3zL4XfYnM/CEolczq1katmanDvA=;
	b=ZL2n5yv5lexvRCYyvD09yGuwrfL+CBRy18FBwISZ5EnEiyvoWbIUiGKCqioamqVfPS
	zqyFIMY1JowZjCcRqA7hLG/YGW1ZFZ0aARkBk3bALACRwkI4oqW5aw4qBj/EcDDgCzQD
	ZYDkjf5VM6G61qUh9+PgylcNS0jJ6/PEZc52k7mhUTVzH8kvmghmZIIoEUj25jiBbrI+
	oO1XwkC4RgsRg6Lf+u1hJRtkYdc6fQSb+1aVkqeCMgmKqgz9d0I4w/P7q05qfl3Vh6/u
	qYkyogsMLKFmnWGiWDSnpK1PoenPqE3kkrqWbEmGEC4gSTtb750XAFiUBo3Ywvab/sxS
	2NsQ==
X-Gm-Message-State: APjAAAVk3ISD/ZkgvF0aopZVgMf2L2d8Ok5Bq9IX5JORasfq4tjMN1IT
	6zeYjlaXAOPcnnk2JfF1+ANpedKs
X-Google-Smtp-Source: APXvYqyh3wiRwJ0kmjhLQ13B3rQHLIvHA1TII+rNXSTV8+b7SGRmqO8AJLgPLxcYF6krchdDjW2GYA==
X-Received: by 2002:a1c:411:: with SMTP id 17mr5161634wme.74.1559112123367;
	Tue, 28 May 2019 23:42:03 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:02 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:30 +0300
Message-Id: <20190529064148.19856-3-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v12 02/20] gdbstub: Implement deatch (D pkt)
 with new infra
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

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 101 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index e6d895177b..1db322c15a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1413,11 +1413,6 @@ static inline int startswith(const char *string, const char *pattern)
   return !strncmp(string, pattern, strlen(pattern));
 }
 
-static int process_string_cmd(
-        GDBState *s, void *user_ctx, const char *data,
-        const GdbCmdParseEntry *cmds, int num_cmds)
-        __attribute__((unused));
-
 static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
                               const GdbCmdParseEntry *cmds, int num_cmds)
 {
@@ -1463,6 +1458,55 @@ static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
     return -1;
 }
 
+static void run_cmd_parser(GDBState *s, const char *data,
+                           const GdbCmdParseEntry *cmd)
+{
+    if (!data) {
+        return;
+    }
+
+    /* In case there was an error during the command parsing we must
+    * send a NULL packet to indicate the command is not supported */
+    if (process_string_cmd(s, NULL, data, cmd, 1)) {
+        put_packet(s, "");
+    }
+}
+
+static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    GDBProcess *process;
+    GDBState *s = gdb_ctx->s;
+    uint32_t pid = 1;
+
+    if (s->multiprocess) {
+        if (!gdb_ctx->num_params) {
+            put_packet(s, "E22");
+            return;
+        }
+
+        pid = gdb_ctx->params[0].val_ul;
+    }
+
+    process = gdb_get_process(s, pid);
+    gdb_process_breakpoint_remove_all(s, process);
+    process->attached = false;
+
+    if (pid == gdb_get_cpu_pid(s, s->c_cpu)) {
+        s->c_cpu = gdb_first_attached_cpu(s);
+    }
+
+    if (pid == gdb_get_cpu_pid(s, s->g_cpu)) {
+        s->g_cpu = gdb_first_attached_cpu(s);
+    }
+
+    if (!s->c_cpu) {
+        /* No more process attached */
+        gdb_syscall_mode = GDB_SYS_DISABLED;
+        gdb_continue(s);
+    }
+    put_packet(s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1477,6 +1521,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t *registers;
     target_ulong addr, len;
     GDBThreadIdKind thread_kind;
+    const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
 
@@ -1577,42 +1622,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         error_report("QEMU: Terminated via GDBstub");
         exit(0);
     case 'D':
-        /* Detach packet */
-        pid = 1;
-
-        if (s->multiprocess) {
-            unsigned long lpid;
-            if (*p != ';') {
-                put_packet(s, "E22");
-                break;
-            }
-
-            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
-                put_packet(s, "E22");
-                break;
-            }
-
-            pid = lpid;
-        }
-
-        process = gdb_get_process(s, pid);
-        gdb_process_breakpoint_remove_all(s, process);
-        process->attached = false;
-
-        if (pid == gdb_get_cpu_pid(s, s->c_cpu)) {
-            s->c_cpu = gdb_first_attached_cpu(s);
-        }
-
-        if (pid == gdb_get_cpu_pid(s, s->g_cpu)) {
-            s->g_cpu = gdb_first_attached_cpu(s);
-        }
-
-        if (s->c_cpu == NULL) {
-            /* No more process attached */
-            gdb_syscall_mode = GDB_SYS_DISABLED;
-            gdb_continue(s);
+        {
+            static const GdbCmdParseEntry detach_cmd_desc = {
+                .handler = handle_detach,
+                .cmd = "D",
+                .cmd_startswith = 1,
+                .schema = "?.l0"
+            };
+            cmd_parser = &detach_cmd_desc;
         }
-        put_packet(s, "OK");
         break;
     case 's':
         if (*p != '\0') {
@@ -1985,6 +2003,9 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, buf);
         break;
     }
+
+    run_cmd_parser(s, line_buf, cmd_parser);
+
     return RS_IDLE;
 }
 
-- 
2.21.0


