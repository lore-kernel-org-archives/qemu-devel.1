Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF702C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43E22175B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERL1fQ/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43E22175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45899 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNGz-0003NR-S0
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:09:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6K-0002Db-Ic
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuM-0005Q2-M6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:15 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuM-0005O9-Fd
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id h4so26567572wre.7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=UknJZKnJVERT3JA2rb2yBuVPhKJqbGKHtbXr3Dgn3pU=;
	b=ERL1fQ/NKJ+o+BYRChZgQbgez7ZNuBV7gOV+HbvM9CcUpCAgtlu/OT+T4C749zuW9v
	k59K+xveHzjolGFBJauYA7XwTjNpR7heUypzkWQr4CfmfUKHDeLVSKhOr47fg6Y/pkUu
	wi4UDVM2gIY7W2B9rAYs1TaVm/sYua8huwt73a4LuWD2aFKYuvXP0YuB3Fy+us6aEGfS
	AVOCx/dSTMQ1DlZgqtTZzzB9k1/GABga0MkgjjWsl/tRGTBXigKOFEh2hA4DDNPepKpU
	XG1BtYysdb6s/lG3s4bQr0sGllKDwFyAs24Wa+ozB5Q9nRehte7NN4d77j8gkuo/lgll
	BZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=UknJZKnJVERT3JA2rb2yBuVPhKJqbGKHtbXr3Dgn3pU=;
	b=CSGyR9LsoIxZSPglfi+lPUMti765hYsb+yd3WzNsibUfyRWJMOcJJR90a1vbdm/QuN
	ZpLyAEXoh91K+6xNKAfFY10EvlM1+37AlAO2SDXzLaGskVWqTXjmAfHJsF1xEybv4ucN
	nb8eJikLnSO1643eC9dCLvrmCHFjbuanEuqmo1SRF6x614SL3NUNnXH66cOwKa95bNok
	GNgWXlL2RuJhyprVPY1oPYttQxf7GkFyqreyCUNnBHU7oPRf6EFcQwobD7NR1GZOZi8S
	/mYA02eDXEOmkSuvNKFPBrzj0clnK7jaGz4NTJcsVIwyCebfab66xaG15vuHz61LpgXx
	9oxQ==
X-Gm-Message-State: APjAAAWgrXm2t1eGTYz+WDp04mq/H0T6np4QQEqLlwAD5iEf3fcLSNoC
	jTyiUTt+MChlL0elPwquDQzHhwk2
X-Google-Smtp-Source: APXvYqyPy6aMxqbpPzuicEhNKouTs/u+LTds1anWuLMd5b4EFFBhRp7A98DPUpO21kcF1g+KXp758w==
X-Received: by 2002:adf:e703:: with SMTP id c3mr21179511wrm.98.1556131572844; 
	Wed, 24 Apr 2019 11:46:12 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:10 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:42 +0300
Message-Id: <20190424184600.8445-2-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PATCH v4 02/20] gdbstub: Implement deatch (D pkt)
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
Message-ID: <20190424184542.C_rtPeFY20-HUHSX7jaruEoy4cTLmv1rskriaxyCJ0A@z>

Signed-otff-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 82 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 64680722fc..952a6d92ef 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1429,10 +1429,6 @@ static inline int startswith(const char *string, const char *pattern)
   return !strncmp(string, pattern, strlen(pattern));
 }
 
-__attribute__((unused)) static int process_string_cmd(
-        GDBState *s, void *user_ctx, const char *data,
-        GdbCmdParseEntry *cmds, int num_cmds);
-
 static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
                               GdbCmdParseEntry *cmds, int num_cmds)
 {
@@ -1477,6 +1473,41 @@ static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
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
@@ -1591,42 +1622,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


