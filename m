Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56646C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E4B2183E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD12ZYLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E4B2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNlw-0005DV-8e
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:41:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk5-0003l2-UX
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk1-0003uO-5s
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNjp-0003fZ-0e
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id 4so6107302wmf.1
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0qJN6185ODZeDOdkkrEIq0s8E30UIRJZdf625wY6AUY=;
	b=ZD12ZYLP2H8UkUEkbWvZhzrdiK5Mpf9PiAgHMJSkJhstV+2UgIgfgklobb9SwohsMh
	0H1WGtkm7yJ5DqC42jR+RGRWD9+DbuePD+TsmWGXFwzfYCC9BM1GvH8UNwCVcDOXcuj7
	1XNZaXfAIYeOH9ocmMqvK26pQ5E0Rz5gnOh1rsIQIwRAAgDDn8WJSezRoVBmWcSZavj9
	XbT5c9+2u0iRCmGqTJf9SwtBYzgt2Kza8P5l7qHccQzXIseHGrDv4Zq8JNB0xGWnXUX4
	9M99fBa/RV4jdStrPRvbGXTL/bhH3FQV2nOuZ4MfXF4UDPgbEif6kkDiyJXGCSF3d7a+
	eWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0qJN6185ODZeDOdkkrEIq0s8E30UIRJZdf625wY6AUY=;
	b=kFQLNEQWWJX1tEU0caKwB6KJSpdCP4dNwJdEwFFNFtCs8CDGuZO7xEXbHVlveF2vyU
	7XRcH++Fi8t5befVVxDZ1Equdu0KPE10OO81GcfWHit1ZiDcRa+vc77q8FW3yCvQrlWe
	XWyPhKM95EnuNRNe1aLM6qeO5q+tsnn2pCw2ctXGThN/3ycp7H/YRdjYXC85YdDFlaau
	rm42IJbRecDzMd6otwTQA4UhXyQvT9Sp1ONGRaCOFd/rRwYFmEUge05O/NAGnZVEPQ9g
	+14KX3W9taCdWdKUAKZqoNAZq++9ym6HrFQ6Ki+XNNkG207ggUE+sQwHI4PrSiEASLtN
	/jPw==
X-Gm-Message-State: APjAAAV2g68EmvmdtyZENS/omSbogcGORYqI2kxqTxgyt3UlEKTUIPpx
	Im0brAr+P7FguSn/J/XxWN00xFiZ
X-Google-Smtp-Source: APXvYqxdvsRPsoNPchc8ImncImt1Ob2CeA2Z7UQZu8pckopqH1eK76fmLs6GcbmZP5prd3EMXgNQ/g==
X-Received: by 2002:a1c:f901:: with SMTP id x1mr560445wmh.136.1556134758100;
	Wed, 24 Apr 2019 12:39:18 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:16 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:40 +0300
Message-Id: <20190424193859.31817-2-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v5 02/21] gdbstub: Implement deatch (D pkt)
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424193840.aOMW-WFJuJ90Uue3TLAiJ1CiioFIq75e1TkvrM-I_J0@z>

Signed-otff-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 89 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3308279fa8..fdad1ac466 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1420,10 +1420,6 @@ static inline int startswith(const char *string, const char *pattern)
   return !strncmp(string, pattern, strlen(pattern));
 }
 
-__attribute__((unused)) static int process_string_cmd(
-        GDBState *s, void *user_ctx, const char *data,
-        const GdbCmdParseEntry *cmds, int num_cmds);
-
 static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
                               const GdbCmdParseEntry *cmds, int num_cmds)
 {
@@ -1468,6 +1464,41 @@ static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
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
@@ -1482,6 +1513,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t *registers;
     target_ulong addr, len;
     GDBThreadIdKind thread_kind;
+    const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
 
@@ -1582,42 +1614,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
@@ -1990,6 +1995,12 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, buf);
         break;
     }
+
+    if (cmd_parser &&
+        process_string_cmd(s, NULL, line_buf, cmd_parser, 1)) {
+        put_packet(s, "");
+    }
+
     return RS_IDLE;
 }
 
-- 
2.20.1


