Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF6C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F8F20675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPDSUDsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F8F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6v6-0004In-Uc
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:18:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6t3-000357-BH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6t1-0007GI-Ge
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6t1-0007Ea-Aj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so2031951wrs.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=o9g7yNsrGp0cm0nQks6oxRIXlO2CyhOpcYCjoRIegtQ=;
	b=TPDSUDsx1b4/+tuFMGwcj6Si+1Z6tZT+ncA3pFeq1vN/C1foc1FPpS2YqSvY5Xpwlp
	/Vj+/wcn2JjxQQJFyDWCsUky21s5Yv+d1yuCovGj8SUlZJPZyYMzDkYE16qRnkqT5v49
	fI8Y4eBMxXJtFpJuPBQhwrKeE7caF/h8sIcF34gZHb9QUUhp0HPQl4hyVdrrIkjbhhqs
	eZypk0BpoHpCanCwE2DgEuWaocZ3SbfxZ8acKAf2F/f7B41cV2gWNx5Mdio6GwZxE/MD
	OnzNytekIBC8SOasfglXVH9QUZjVLoYxeTBJYji2Kl0EIfcGccXY1MSBnr2qY95Hwmw4
	kQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=o9g7yNsrGp0cm0nQks6oxRIXlO2CyhOpcYCjoRIegtQ=;
	b=JMpcPmmG72kUlCK5xSFSoGj1XvoMFsYLPXT/srME/2kyGV/hWQFtO0U1pkD8RbS+Wk
	Hl919DJlaHXJk/9RKNsWfNIh7GDZYnSMpcH4+NrXmaDJarKgYtyy18g+j+WBSZ7HZ2w7
	V5Bk8KPuZORK0/18SCJdX3DGJU2u9XK8Dmm9+oCtx36T0Nl3Tso9YWoWpOm+4UQlYGpo
	q6m4Wh/oIJUIlCZXDrTes5qjhv6l84iJ2GjNYMeNyzFBrnoNg+eFj0v1A0q5POkiF9kG
	EO5lhypdH03jeydTPRm5jdA8mni+6OdMmDxkrVdr5VOzRl438K8MrFjyY8D5A7ff022k
	x5Qg==
X-Gm-Message-State: APjAAAWZZwVRCltBM7IX5GDkKMhGBgEMfBIveFVeOgSFo5s/GjeCeM8M
	aVxrnwQ3iQfIfp5FH04kwnfFaI7H
X-Google-Smtp-Source: APXvYqxLj4B/HnnAt92t56MYBnCCBwZTx5uItuGBIn/x8Xb/LT5W1EFFfFu/O7nJkZ8+1VV59Yynzg==
X-Received: by 2002:adf:eb03:: with SMTP id s3mr876801wrn.170.1556784968761;
	Thu, 02 May 2019 01:16:08 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:08 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:29 +0300
Message-Id: <20190502081554.5521-3-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v9 02/27] gdbstub: Implement deatch (D pkt)
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502081529._esRXb3Iz9bbVHEg_EQLcX9t4NHHSqWzwcDnnjYPplY@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 90 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index d5e0f3878a..621d689868 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1418,11 +1418,6 @@ static inline int startswith(const char *string, const char *pattern)
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
@@ -1468,6 +1463,41 @@ static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
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
@@ -1482,6 +1512,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t *registers;
     target_ulong addr, len;
     GDBThreadIdKind thread_kind;
+    const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
 
@@ -1582,42 +1613,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
@@ -1990,6 +1994,12 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


