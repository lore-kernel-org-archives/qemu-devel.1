Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192BBC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CE32084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVb2lgdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CE32084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJEz-0001v1-05
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:51:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzN-0004qG-6D
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIrv-0000M7-2X
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIru-0000Kf-SI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so25449651wre.7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0t4FX1TNQUnOr4CGuttVo9IjP/yTIVHUDB0xpm/aIaA=;
	b=ZVb2lgdvFITrBoKCE6wX/q2XJr0an8YLKBRRaRcRb/NzNv7QmstG3StgSxceAGewsY
	nt+Yt5/ohPV7T5QKfXen0gzO88s+7oe/UPen7X5WR+tLzt5jwwmPzLLNqGs5qyD6Igco
	2KE9QB9964qB0IL5LswSYPovBC6ttfeX5htk0sVEUEsw5TZCd0ldsrKNZNSIjqK+Fj7f
	woEjy4t0WE+NNW3xJsaFX2lqELZtFnVhh0FhZO9F3agMDNnJXORJ2O4i02Ram3t7p1U7
	h4I5zecuNrYDBBbKh7oY/lRE1VXTxPimKeFua1y0gXsg7ahk2OAjSngJ8UmW8rBzuxR3
	aa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0t4FX1TNQUnOr4CGuttVo9IjP/yTIVHUDB0xpm/aIaA=;
	b=C89YkJmEZyex68Fi73X9Sa5Q9eJb/hZ49MObWswmZiT4Nrcgh2HclPmRa1QXLXWMe5
	VDQsYf6RLe3XhDR7XmOAxj+PUvEwTNN65w4b3Eyug1UWXYOL23dRtLeg5pFnlojjE8/O
	cIpleQVvg9ClTq1xUc4c9qGZSTiEgyr0SeWuDbrnqsv0TzQX5wW+91/3OFbknlDcsmD6
	kX/pku0iGhC30ERAhsNf2tS3LA+ipI1TYunDFNAUR11gLYwbfExEo5i8R0dtW3YZ5RKn
	jGduzfx1nIm+1InMR3zEZ+WtzwhDyzW5U9l3TfoPrn+z5KBdmDZBbarQVlyeLV/dWOka
	BoYA==
X-Gm-Message-State: APjAAAVaY/BxqRunb8VtQRZvLH1kAfaN2F9UH8+opaywCCkNqseWQcUH
	ggJMV00jzrr3SMY9DfZT/c6Sdbys
X-Google-Smtp-Source: APXvYqwgkG992Dfz6kXdUusTwSwFMEgxI7Ei+MzY+RARabCboaTmuesi+VvUe7qN7iNlkLqT3fSekg==
X-Received: by 2002:adf:ef07:: with SMTP id e7mr6906035wro.256.1556116045168; 
	Wed, 24 Apr 2019 07:27:25 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:24 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:26:56 +0300
Message-Id: <20190424142714.28460-2-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v3 02/20] gdbstub: Implement deatch (D pkt)
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
Message-ID: <20190424142656.nHS7jjpa5GmrRoU1i3cko0S14OO6WKV-AZCAsZJX3ds@z>

From: Jon Doron <arilou@gmail.com>

Signed-otff-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 82 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b5bd01b913..34e6722a8c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1435,10 +1435,6 @@ static inline int startswith(const char *string, const char *pattern)
   return !strncmp(string, pattern, strlen(pattern));
 }
 
-__attribute__((unused)) static int process_string_cmd(
-        GDBState *s, void *user_ctx, const char *data,
-        GdbCmdParseEntry *cmds, int num_cmds);
-
 static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
                               GdbCmdParseEntry *cmds, int num_cmds)
 {
@@ -1483,6 +1479,41 @@ static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
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
@@ -1597,42 +1628,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry deatch_cmd_desc = {
+                .handler = handle_detach,
+                .cmd = "D",
+                .cmd_startswith = 1,
+                .schema = "?.l0"
+            };
+            process_string_cmd(s, NULL, line_buf, &deatch_cmd_desc, 1);
         }
-        put_packet(s, "OK");
         break;
     case 's':
         if (*p != '\0') {
-- 
2.20.1


