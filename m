Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBEC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D449218B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp/YOry8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D449218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNoY-0007rs-Ii
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:44:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk8-0003mC-0V
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk5-00040B-VU
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNk3-0003nl-Um
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id w15so6717710wmc.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=M4+5FDQ/6x+srBv3D1SqFY72lf8MIyrhQkAf/Mt9fsY=;
	b=lp/YOry8IelCb8ayXGeGqkcVtW6YC38sQ/GJfWbtopjkhweq07/zH1v7AdQuuo6be+
	9PP7N6GjHbASYXrKy1HnlzJPlxYLb9dC3IRCjqrsUS9Wlps1zxT4V6Pb3HF+S88MUmY4
	VvQWFjr1kIJT524pvQdCQkKlOAGXXo6NKd+n+0NMi9+NOiLOR0JsAM1cm1yEfsUkB87z
	f8T223K3ZdRlS/wHgPltkiPyHR9qPyMHgTLqVbEVYVXnXLtFSOCUQyTvh9n4LFaxTl9c
	0hHhJ8CCg2bVpPjwdPRlWJaVNGvOkNBMDwWpxUvACLk3LG662ORXOCLu2oKZ4DO8d7hD
	BBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=M4+5FDQ/6x+srBv3D1SqFY72lf8MIyrhQkAf/Mt9fsY=;
	b=qW/qZ2DfLxvMY6RSF6PFz1N9Z+dM85fJ0JCXb3Y+byJY6pJdpLMU9a8LDoCzG3k3Zl
	O13KQM0cIxTnS0NzxajcZtGj1xM8iHEEty5nFUuxJH6LDkC1zkVWvgM7VM3SWIBFRTm3
	+plLFytZ0vG+KDhtXZUkIBeo897NdXMpt1a4iP0LZY9Al4Ucl49WXRKskm0HqBULXGTT
	Yn6dHFIDkNrWPndD0L5rMObJv3kK60UXKnKiYxLeuciDSVgI5xz2f1M8rFTZ7hzHYqI2
	0A9qLicIuWik5GV/M9OBogALLxChdBe8zYHpZc8CSl+JaHLyhZaLMeqs1YN0ruXvV/uO
	NLQg==
X-Gm-Message-State: APjAAAVzPFVC2mtCxF/fsIwN4UkkT2kdjcKY/hShptpfeZWEr+i7rQCK
	ITlzyNNtUE9aY7Mn6qp51qpyShcz
X-Google-Smtp-Source: APXvYqxnytOJ7Sflr52ccI1+IgZI7dX7buPMNIU20zyM8sW92oY3GctDm+63HGO1DfxsrZNpRbwRow==
X-Received: by 2002:a1c:cbc5:: with SMTP id b188mr549562wmg.87.1556134768042; 
	Wed, 24 Apr 2019 12:39:28 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:26 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:44 +0300
Message-Id: <20190424193859.31817-6-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v5 06/21] gdbstub: Implement set_thread (H pkt)
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
Message-ID: <20190424193844.i2lNI2OPkix17229hvg5QZDR4w4daIveqDicurtftmc@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 79 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8e922a2df4..83757def9b 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1548,6 +1548,47 @@ static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    CPUState *cpu;
+
+    if (gdb_ctx->num_params < 2) {
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
@@ -1561,7 +1602,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
-    GDBThreadIdKind thread_kind;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -1824,35 +1864,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.20.1


