Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D51EC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBB420675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQMqi7vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBB420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCjQ-0008TV-Rt
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:07:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdZ-00040r-GH
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdX-0001yW-GI
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdT-0001tF-3J
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id r7so10530157wrr.13
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6XN5MsYgNBFqRM18LfTzbFvP6RUmyaslbyqEQV3oSuw=;
	b=UQMqi7vrI/R0wgvqQVhuWgEdg4gPlcSVMLMD9JBI+hR/Cg0nFz8oewYT58B2oK8+qd
	pJFTDjeve8OtDWwUAlF2xWNhLk/l0S1jmZ+DAM9TZkJjBreyiy3ilWEvDID0bz0/cSU2
	z9PHgXj9MSVr8zYY0eGrwW/0viY7+U+ZzThpGJ4uk2eDRUeK6mYZP9f64HsFWb/yLMNZ
	RMzg21KNCYRZnSAzeHU0AdJaR1tSbS76ojs4Otr01TIt8L77fTYLJG4c7zKP0kapkT+h
	DlyuLmpkeeEDz34GlF/wRwTF+fxan7olXO65pyLCeoQ4/E4ZasHmkhmMqAe/FMjhMhzy
	5T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6XN5MsYgNBFqRM18LfTzbFvP6RUmyaslbyqEQV3oSuw=;
	b=FhP0GMNYlVW8zFFGyUZ+1Kxe+dtrYjHqwy50I3QevGHG6/myvwjaUrodaeSIvqQecp
	+0lGsISkKJBcb1LANAs4uxltMXszFayLHolCOVl71lErFPJF7clGDtgg/in3lcII2Wzh
	kDI/TSg3vR4dt41jpiDBIz6+tfA6WSn1zOJthoYMkleaTy9f7VHNG9Q/SWZ9jATRKnsF
	x65SfQOmbsQDeTyWLyB6M0tAsfPtmrtRzjf5ht95RBV/ilQmP7DeWLHRz5/CWDc/oTgY
	Ry744vXUkoanUfa+mrZwkYbUtZUhRlWy4cEHrUE+CIKsGmCvecrKtzC5UwfNOjlC9RM3
	p8Ug==
X-Gm-Message-State: APjAAAWt2SdcNMpMKDYLNNrtWFhBtQ2/YnEFb8d1HdEcYwB4zBM5wgTu
	ea0RYiIpHDI9CamDsrBx6R6mai1U
X-Google-Smtp-Source: APXvYqwBrnJ24odEsQt9aaPDKeEbqRd5DPZ83OXo7k8oT/MkLqOSzy/zzrKuFwZF3CDhPVt5PxEEcQ==
X-Received: by 2002:adf:f988:: with SMTP id f8mr3234559wrr.254.1558713691221; 
	Fri, 24 May 2019 09:01:31 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:30 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:00 +0300
Message-Id: <20190524160118.31134-3-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v11 02/20] gdbstub: Implement deatch (D pkt)
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


