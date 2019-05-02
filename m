Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8440BC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DAD2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ/edaK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DAD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46622 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6Gr-0002BX-E2
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:36:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69W-0004PM-PI
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69S-0002Ti-Ij
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69Q-0000C6-5i
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id j13so1289062wmh.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8aM/3zkgxng0ie4nC212YmQwcdv5GpIX/biWiirdyy8=;
	b=eQ/edaK1etb9t/aFDrrIZckCBOywZy31sFgLmv4Q351QKNCJ4hIWoWzbf+/HPxeOxL
	hiR44+etH4JhjOvmI88tZWDk+wXP75FRPe23VeDlD9BOmWs16y1W2wB0vy7ZnQ0eJbit
	59ciKL6+UI0h20xvmpL/5ximxbQ6AFARnMQRIqKcPlgAbc8nj8DAsNduzN9dG+O5mweJ
	z5NOfZNOR2NqmyzSqY/CAui3drYMsFW3qY1UVDampPl1ILHOrsy9krYadsK/r5Kbh/DQ
	B1lL42zZXEIPRwjhrn2GQ+p7BfdDFOqjnOiXMKk9AAZW5+zmwb9vcNNWx4Gx0OE2nF/1
	sd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8aM/3zkgxng0ie4nC212YmQwcdv5GpIX/biWiirdyy8=;
	b=P/9UQEZw+VFPyuqX/NGqMvn1/o21RTvf2x4hK4G9ikWP/gsOmc1nltv98amNb/Z9On
	q0wzPky3Z5D6+fn0+z2aQdraHVlGmbJvj5++38Pp1ifusMQkHm2+Q2s253/0c+u5l093
	E4M/CNQ3ma1N7link6Z4LIfRo7Y659mPPcNBeej/o2UB4qmo0Ke7yo5yOfnt/l9rQRQg
	OOf1/BEGvHaPOkSFRkQj1aos/9EYCyAdf90XJA8AvWa88Ud6BZz+0+pAOkfEovJZU8EO
	KFqEhEXSXES7UzST3WaiWJcJ7gfuNp5i1kwia4J3WSvY26LJriu/6s9eDldm2jmh2MMy
	ugOw==
X-Gm-Message-State: APjAAAXw6KS3m4ZItG80vHL+o81DubrJDYQx6LscQQ/vx/s/uBlWvi1e
	zLqfiPGvjnLoRF53eocrjspW70I8
X-Google-Smtp-Source: APXvYqzNs6/IRnoBRkViOSvynCggb4hjPDXfR5TkNPIRgJx1BTQ3XSHdP04A+Pc8p0/II8g7EBCKng==
X-Received: by 2002:a1c:b705:: with SMTP id h5mr1212346wmf.75.1556782024491;
	Thu, 02 May 2019 00:27:04 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:03 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:20 +0300
Message-Id: <20190502072641.4667-7-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v8 06/27] gdbstub: Implement set_thread (H pkt)
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072620.NYALR60UhEdh7bVEe2CyHgYOpzEQPu4Hmr6I_CC54Ew@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 79 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 469aaeb875..21cdaf4678 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1547,6 +1547,47 @@ static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1560,7 +1601,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     char thread_id[16];
     uint8_t *registers;
     target_ulong addr, len;
-    GDBThreadIdKind thread_kind;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -1823,35 +1863,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


