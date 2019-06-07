Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575DDC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B31E20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBfYhjEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B31E20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCGK-000294-8S
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB54-0008Il-7P
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB52-0005wa-Rc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:50984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB52-0005vD-L5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id c66so1283302wmf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eS4ups5iSOxsrkjwkIPBvVdVBQzJoB39R+u5rhoVXoE=;
 b=NBfYhjEeUJfiDur2FFm6EDzUu5k9zDTNrQJ6FpxY6Nd/rI4pv+zbhCJCLBX8hF2wCe
 39IKy50tnzNg7Hs5yDM6BiWRYcFNqSd86jxZTRDnH70G9HismS/7ZJQxImnnhHolAnJP
 JC3kiUMJXQojcQlXYMnv6qOd58ekELKshmQjuvPmLLlesO3ugG3jw5FkHJ/o+YbuvhbK
 2379wgUdSw1PXnlhbiw+hreF1z+bTcu3xrfhDx76xObY4sBZe/3rDgBg1zIjFIdAHUHu
 pRD5uRnO7Cg1vPwL7L8GzPFaEcbwPo7FQiQBeJP0jiDo4iYQdXvCBygyFgUJXT+j4zC1
 whlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eS4ups5iSOxsrkjwkIPBvVdVBQzJoB39R+u5rhoVXoE=;
 b=HIj+TwG/KKmOEkltH9A5ShxTAjyhsy5bYfy7ZHtPMpFXl7rokMMQnAr9I0PmEa819S
 MNdj9GSABXuu9b6KJyXWaYfWIT+y1Et89t1eEtCdKglmc1IuYKfReXPN0o+Gad9M5ZYN
 AvybXW6ayjLAJkJNo/IEkZoOhfzpFavcMap4ZehXOcBrFbT+GWxj3oZtqqQl4vRwDTxH
 CYrSHryUI82/VeVXk+arTPUU8eHKDC3vh00Bpd16yt/sqrZujRo3ObhYLIp0NpSj5vub
 ZZkKCIHx5BQ+JISOIm/F8Rc4rwxUgiRYqcWfRHqi3jtiSTsSeu4d8XaiqW7SXQkVCTke
 YYQg==
X-Gm-Message-State: APjAAAXfF/NikmNn/2aBJKdDeipP6p4h7mvR98BPFadAZJWm7UjUH2zr
 xsqf3fXZXGbQQ2RGfZT70S2NuA==
X-Google-Smtp-Source: APXvYqzkprCY3rOjUeG0tJce/61GGW2ku4O6XhzSiS5Obu+MRl8STiv213P5hWJu5Kb9dApjEUzhhw==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr2900174wml.126.1559899355465; 
 Fri, 07 Jun 2019 02:22:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w185sm1405942wma.39.2019.06.07.02.22.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BA75C1FFBA;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:33 +0100
Message-Id: <20190607090552.12434-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 34/52] gdbstub: Implement deatch (D pkt) with
 new infra
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
Message-Id: <20190529064148.19856-3-arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index 09fe5a4b99..120e52f5d2 100644
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
2.20.1


