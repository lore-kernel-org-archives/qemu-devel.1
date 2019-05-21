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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47254C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057632173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcEbibqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057632173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50466 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1bT-0006zZ-5n
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:02:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z3-0005aY-6Z
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z2-0007KQ-4D
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1Z1-0007JN-U6
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id 15so2206319wmg.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6XN5MsYgNBFqRM18LfTzbFvP6RUmyaslbyqEQV3oSuw=;
	b=qcEbibqLgJM1XmOrSFCX2fveXbfG6og8M8RMiqCaUEtrXhcu2Jae/OniZa0w/MztGO
	8xMILjaMXmLuM/Plo3sxHAVvVOW2/Pgl+6KMir6UYXS+xCWKrEt0CTxOTCbtG//fp34r
	zjBxhIObtnqEw7JR3YaAwVg/3VfZuJKknvB7xjXmlVWesMr5VqLCCT8TWse0zWYVEOOv
	iBlzf+LeNutNeLF5E5CycM47Ur57vjKpYBU25bC1T13Wqnk66DXvpWn46/YEQBuaXHtx
	VSy99aTodNR4NvKG9A8sj4ZwkF89qIz4BRlMWvW4/WKkvV1KhWobUJ1gqgIPAAEo+rm1
	fI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6XN5MsYgNBFqRM18LfTzbFvP6RUmyaslbyqEQV3oSuw=;
	b=sJbPIFcZvM0j73rkCabtPEhdJ8ZktT6lW2BCnO8vpsJheUGxLA7b2S0QMZpdsoLB0V
	odb8e6IzgSOiXWSxFzbdSp9dNvvocAJzN/XL8JAnR0+RtgNDoZdd/Engd4z2PEvjsBSP
	uOS+qUSk/RXJT0SYkZFsTLUciG+8+ku6vtBUcT7/LQL+uLmMZMV8eBff3UFy1A4YO90o
	PvNhEg4idBsoKMSASL0Jy2Gtdf3cizJF3yORauwPFYb12b9OVYq3lyhB6I7l/2HABD+8
	U2jAYVmXBipYUhogAiXsFuusy7CWY5GgPqbE7yvX8gwINK5K9NlVBpqFyimFf1WEICiw
	1ymA==
X-Gm-Message-State: APjAAAXCVQ0XhiggDO0dVfJGGLtpR77qMzrv6QSqrwj/MUCA82Ytq8OL
	kFBIgWz04aW09nx2vvOJAfeGnCHG
X-Google-Smtp-Source: APXvYqy/oJvvQ75uTlyvMBPHImWfjkFFpWq1L+BamBfTIn36znicfw0zX3OAJWDfJUU+6bD58M7vpQ==
X-Received: by 2002:a1c:b743:: with SMTP id h64mr2905756wmf.16.1558432806673; 
	Tue, 21 May 2019 03:00:06 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:06 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:30 +0300
Message-Id: <20190521095948.8204-3-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v10 02/20] gdbstub: Implement deatch (D pkt)
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
 gdbstub.c | 93 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index e6d895177b..307366b250 100644
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
@@ -1463,6 +1458,41 @@ static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
     return -1;
 }
 
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
@@ -1477,6 +1507,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t *registers;
     target_ulong addr, len;
     GDBThreadIdKind thread_kind;
+    const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
 
@@ -1577,42 +1608,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
@@ -1985,6 +1989,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, buf);
         break;
     }
+
+    if (cmd_parser) {
+        /* helper will respond */
+        process_string_cmd(s, NULL, line_buf, cmd_parser, 1);
+    } else {
+        /* unknown command, empty respone */
+        put_packet(s, "");
+    }
+
     return RS_IDLE;
 }
 
-- 
2.21.0


