Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6037DC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288D22084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqavmJCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288D22084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ9g-00061h-RL
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:45:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzM-0004qG-1f
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIs3-0000Sg-3q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIs2-0000SF-U4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id c12so19288055wrt.8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=AtGxKwB2VPfL6jQl6Viia9yYxf81+esR3avKy4DEacA=;
	b=HqavmJCti81owpL+6bVLuBaLUcvYK7eGfyOHkdzHcyyCC6Msd4l81pOjPGfFIrK3o6
	XyaRFEftwGSuehCppj+EvZrvc8v4Z+1Y8WPxM2eYHq5GO4YFUHvnWjcb1GjnOwS+R0vG
	eYEoIA8cLM00BkK46hAwq5FsedNamBOtlspKanaYJVV8P25tA6Gzm4Os7hTzL8Fx3tXP
	Yh1rtnFiWyjs+I5uLwCpEGvj74kD+Dd7rj3QSjbk4vIgj1bZhn0pBnerokHcXkeyvgZb
	u71dg0fxHIBv+PgSFl52+wXneo+Dc+o7/zlvhIYxnLi6+LA8kRhgkUFa4x+GV51iFXNK
	QeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=AtGxKwB2VPfL6jQl6Viia9yYxf81+esR3avKy4DEacA=;
	b=tCkrY/wUTN0SKzqs57P7usx/Tw2mYYh7ktp8pJL7momp6ahiruKVD5063ga81ywIH+
	hGsH6VEVkk5Ml/WKzMFbao6oN/zsRbdCn+3/zLyXfTIRn09uNTZ9ZQJ6lssTiPSPjxii
	F7zlZAfaWQKRczccjiqsPsHbiC7EtwW70+7iQIthfSq3OiD1huQSW9FQtbXL4V2YpNvo
	D4pALrnlD6/+1FD+LxfZt60NUzfa/uFZWNbn2gex5ByXixQn+PWz4FZCuvJr4yfDpI/A
	2vqML1f4vHhx70/54kqluzfSflJh0A0i0sskH5IG9mJ7azu9Xnc0oKWojIyycXVX1hXT
	6lbQ==
X-Gm-Message-State: APjAAAX3AkdSO2e2bhhb3ivv6u01ReMGNh3as5cIxWE9HLzx9TvrumDw
	kVDioiuG9WJCNLEsnE9hbPYu7rL1
X-Google-Smtp-Source: APXvYqygjTharVhNbamXZcbVyFlw+e02db53sIaYe2MdSmOlC+qc7mj8ouOTP0UkaR03cOM6zJiuDw==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr20640431wri.220.1556116053418; 
	Wed, 24 Apr 2019 07:27:33 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:32 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:00 +0300
Message-Id: <20190424142714.28460-6-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v3 06/20] gdbstub: Implement set_thread (H pkt)
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
Message-ID: <20190424142700.IT1cE_CvSh_nnT1WYoEZU65hWWbXCg_vOPjYYsJzAUs@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 79 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index eaa42713ac..87b364b1d0 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1563,6 +1563,47 @@ static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1576,7 +1617,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
-    GDBThreadIdKind thread_kind;
 
     trace_gdbstub_io_command(line_buf);
 
@@ -1838,35 +1878,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry set_thread_cmd_desc = {
+                .handler = handle_set_thread,
+                .cmd = "H",
+                .cmd_startswith = 1,
+                .schema = "o.t0"
+            };
+            process_string_cmd(s, NULL, line_buf, &set_thread_cmd_desc, 1);
         }
         break;
     case 'T':
-- 
2.20.1


