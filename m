Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE6C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0872067C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO7HYjY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0872067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57347 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJebq-0001PV-81
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:40:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeP9-0007qT-PK
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeP8-0000E7-Qz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeP8-0000DM-Hr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id a9so12753737wrp.6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0qJN6185ODZeDOdkkrEIq0s8E30UIRJZdf625wY6AUY=;
	b=fO7HYjY82UVmKOil/lWyIAlhCNBZ29MfJra14Ipq9RbgmAi+s9XQuoQKrLw8s52vlm
	g5vKQtgPFTGSfmgtP/AgspuKwDMRDgrNn3SzNRM2qxs7I3yvehQQDzoDpVH9RzzO6I+Y
	6B7/4+oduqxBn6Dy1NvyKd6SG/VEoMMygo0/zOeTkAM+3SAhQyrCowcHMFjwJi0/ITPl
	idR6kc6gZ6z09SJFfRMxGGRwOMT5S2BUIMuBKgrMWyS91IlG89KxRY7xaAq1bRfhUgVU
	L/hD+6M+Js6ettErgbHEA9Y/SmEOvoUrrbH8qJVy06Be4RznrxzoIpNLt5zEgMfzT67/
	FfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0qJN6185ODZeDOdkkrEIq0s8E30UIRJZdf625wY6AUY=;
	b=pglC5YAJHFYcEICasNeZmt72zdcaqUH635xcs+RdHIfwjSzKMJnD9nmLc4sqAb+ja9
	55eRHkLp5x9d6BgS8ZHJw/lx2IkX2UPTPCTU1qdOefr1rU2b2v4UbeXCCRFyn/lMIOb7
	M9WxpNK/D1u7+EYl8ZKPnegAHM3OcVUZ5unAwRDZJ/GeqFdAZR98oMdohNcEprJSnbZt
	Pp0fIhOqgBr0UPqAa/GGgjg5qkLzwwOGrbVHmskyw14VtUIQh1R2Vb7CwMmCySeZZV+s
	2jiI2daHkOO0iUZAJKi4CbK7uE21qFWwmjwDZZ1EKCkJkPx00CvdSJmnf/uARiHv0zU3
	QAJg==
X-Gm-Message-State: APjAAAX2Xgoy15ixEe5tNMJLqMlNpFY6f7UQTvci3Hwu3E/mESHhkCRa
	a0FkLtXxgj0ClfqqPZbkjgjcnRFk
X-Google-Smtp-Source: APXvYqyl15FW02wG7SgyWX/z7F+38nWONHWZHQtwUEidoyZ2CnXy/ob9vs88ZCbgD4GMZaabGi30VA==
X-Received: by 2002:a5d:4707:: with SMTP id y7mr9646983wrq.185.1556198828097; 
	Thu, 25 Apr 2019 06:27:08 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:03 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:17 +0300
Message-Id: <20190425132636.31636-3-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v6 02/21] gdbstub: Implement deatch (D pkt)
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
Message-ID: <20190425132617.gz0ejfJ4SQT75zTx_2Aoo2ZgYQcNT8jIGXUG2xmVwtM@z>

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


