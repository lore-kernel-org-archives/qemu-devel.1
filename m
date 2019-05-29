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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D44C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5C1208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Qo9BHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5C1208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsUj-0003tv-3D
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:55:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHp-00010F-Br
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHo-0000q5-AN
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHo-0000dL-3y
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id r7so757221wrr.13
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Xz2AchwCFuUocRvSAx5FgReaJdMORDzlKxZ7VV9ScE8=;
	b=Q8Qo9BHDhNTZqPNeYeoa6CpmeUr9aYHvxmnaWJE/iLqUSj0k54YcSJouX3wLnYlMhk
	7iD/XGAHe2gDH4liy7u97hKeR37BYJrxv84zBzv728uArYJdY5mOhUhWH/yOWlRB8ssE
	8P9WQW0tTWXy+Y3GUxYXHzGlFOYDSyRchsdiPAOCm1G8l4IyVXJCWH4ymfCgWVPK2x7p
	e5HdnlyzdQj0UlGJyz9gVPXLIATLFAJvKA5HwDuRsT0g4b74kgkS8n8XvCcokp5kv68X
	gyC8uy1baojna7wRxlQl+/+SqjETR9ybpeYWs6D8MZ218SlnwI70blZblld1EBZqbVSk
	5FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Xz2AchwCFuUocRvSAx5FgReaJdMORDzlKxZ7VV9ScE8=;
	b=euBBf1aHtbU1j6897+QZlgdn8LTMP1bHwDcqFADU3gPmZ453rNp+FAmeJcGN9cosNf
	FInpXYw6ugNlJ6u88OTuEvJLYMyMBtaCb7CP5dAASe91NzkSSVaNzIrrXWNhQFDNptrl
	ZKBOkQZXnlqh/bVkT77PwdD/zHLCQIz7DstWbulD3o8YfuLDz36uPIlhODXMP+mhVH7e
	UjtS3fEKIDZXk0m7bpBOiSqqFUS/eJJGIlrg/cMM5IKvR6VNGOpHTf0F7GAjDv3omKuL
	i6mEyFy73IaWk6lerr8xyrtW6BL4wI20YcTDzecuAaiFbm3sZ3guTEtFZnbn/viZgB1W
	d0Yg==
X-Gm-Message-State: APjAAAXDr0/5CyMoKdpz1IQzvfLJQvi4cX49GJFaFPPgL8+1HNMhCZ5A
	TdAA0zEOPggcPRZU+RM4FyScZ3zG
X-Google-Smtp-Source: APXvYqy8WKsjHQYg9+mUOqoz94x/AcLSsWPyOPsha/nr4QqnghK/bE9I+5NbF9rWaMeSEfj/nf3s5w==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr8443845wrn.258.1559112126947; 
	Tue, 28 May 2019 23:42:06 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:06 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:34 +0300
Message-Id: <20190529064148.19856-7-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v12 06/20] gdbstub: Implement set_thread (H
 pkt) with new infra
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 83 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 5df4d58427..db213cf173 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1560,6 +1560,51 @@ static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (gdb_ctx->num_params != 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind == GDB_READ_THREAD_ERR) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (gdb_ctx->params[1].thread_id.kind != GDB_ONE_THREAD) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    }
+
+    cpu = gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[1].thread_id.pid,
+                      gdb_ctx->params[1].thread_id.tid);
+    if (!cpu) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /*
+     * Note: This command is deprecated and modern gdb's will be using the
+     *       vCont command instead.
+     */
+    switch (gdb_ctx->params[0].opcode) {
+    case 'c':
+        gdb_ctx->s->c_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    case 'g':
+        gdb_ctx->s->g_cpu = cpu;
+        put_packet(gdb_ctx->s, "OK");
+        break;
+    default:
+        put_packet(gdb_ctx->s, "E22");
+        break;
+    }
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1573,7 +1618,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
-    GDBThreadIdKind thread_kind;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -1836,35 +1880,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             put_packet(s, "E22");
         break;
     case 'H':
-        type = *p++;
-
-        thread_kind = read_thread_id(p, &p, &pid, &tid);
-        if (thread_kind == GDB_READ_THREAD_ERR) {
-            put_packet(s, "E22");
-            break;
-        }
-
-        if (thread_kind != GDB_ONE_THREAD) {
-            put_packet(s, "OK");
-            break;
-        }
-        cpu = gdb_get_cpu(s, pid, tid);
-        if (cpu == NULL) {
-            put_packet(s, "E22");
-            break;
-        }
-        switch (type) {
-        case 'c':
-            s->c_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        case 'g':
-            s->g_cpu = cpu;
-            put_packet(s, "OK");
-            break;
-        default:
-             put_packet(s, "E22");
-             break;
+        {
+            static const GdbCmdParseEntry set_thread_cmd_desc = {
+                .handler = handle_set_thread,
+                .cmd = "H",
+                .cmd_startswith = 1,
+                .schema = "o.t0"
+            };
+            cmd_parser = &set_thread_cmd_desc;
         }
         break;
     case 'T':
-- 
2.21.0


