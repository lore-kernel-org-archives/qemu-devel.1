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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB7C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B192173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrsbVFhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B192173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1fC-0001EI-Kr
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:06:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z8-0005iJ-66
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z7-0007Ty-4O
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1Z6-0007Sr-T7
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id c77so2299959wmd.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=5vUrzsPbD2HsTVi8AVPvqq8W6f/IcWzSOuiw6zGUfXY=;
	b=DrsbVFhPhSJ2vvr3bvX2IxgGvos9E21VmEtyENu4Smf0Ve0ru5EX8VV0g2nSYaRgcm
	4LmwJOCyID+tbhmjBKfw5dJa6b3EO7gT15h/X8FE71g3I6/aLrlpp2O0fpgvRawsAJZ6
	ndlLEI8rrXcKCD0LkZzWIj+YmxnOgJUhDt/JOLZ7FQ3KxaUeBd7fOwkyQQcFkCx+NOip
	QXP4iRuenW8Pcx1h+CaR1Rauf9dMwb42iM1tXAyDwn/7TF3Luil8/Bq1FoWX6fOAB3ky
	NKHV2AUV1DYJuMfDYA4KxFS4tO1S+ZvEkVkqIWFmqPqDYjB4J50nVotPO76arUajXrD3
	27WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5vUrzsPbD2HsTVi8AVPvqq8W6f/IcWzSOuiw6zGUfXY=;
	b=XqMtJ2ulqCoOnsZ4b4ri/f5VZVdanho0KgeTudjgtsIZDbJl1yffHwemzKE9Ul3WuV
	UQEJtMm0z+2eUe1ymPn0CVbM3de6mN4bIYzOW5hUwq5MimyECQulEzrpUrJujR6jk/wL
	ygy81uMxHrwwAPBCOH5UgCGI/fl/HnNYeFzB/v1qsMODYYXsRH3tuvDrVUi/yboW2Itx
	MJJedCczdylqgv/eJBsCmRsH+5UbS45rW4pr2y6UHon178ylXFUPsp6ghnrG+KPYWPE0
	O3mZ9pROWkBk/Znwpcfbt5NtOO4Dv4eyOq0/LA7wgn5lBYKe+KisWA0lWB5R2NvsB+mM
	0kbQ==
X-Gm-Message-State: APjAAAWO8uKlcAxhZS4VkbfuP56+6BdrLc+r10XitVVzYsf/eRFkRen3
	T6tXUFAzuYs3mSLSDQjhbCybV4Ok
X-Google-Smtp-Source: APXvYqx/hb3CAJSyb7pHCyTHBmnvjhErnDlDgB+k6R0awCPOA46FeQTrlG9FBj8cQVlT4kRN7PMy8A==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr2654520wmk.114.1558432811827; 
	Tue, 21 May 2019 03:00:11 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:11 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:34 +0300
Message-Id: <20190521095948.8204-7-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v10 06/20] gdbstub: Implement set_thread (H
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
---
 gdbstub.c | 83 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index f74a30da03..129a47230f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1546,6 +1546,51 @@ static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1559,7 +1604,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
-    GDBThreadIdKind thread_kind;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -1822,35 +1866,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


