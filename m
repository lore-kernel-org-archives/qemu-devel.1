Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFBCC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735FB20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIVes0a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735FB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM760-0006wc-NF
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:29:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ta-0003RX-A8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tY-0007pQ-Aw
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6tU-0007L5-Mo
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id a9so1997324wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8aM/3zkgxng0ie4nC212YmQwcdv5GpIX/biWiirdyy8=;
	b=JIVes0a4eaIRpR/FW3T7tTrn8D43Zz3zNpQxvvTduLo/E/oBuVY9gRFdNhTTn6AkUt
	X1R/Cnp0we9y3q1RF4H9GdrbV89LAO8m6LCqaWVy3wuWZoopgyKFZW3ZvUL/su0XO/J3
	0pHaOcUzyqP9q0P/B+L0DOaxOc8nqMJkxOt9BElm1e74Q9WHGyv8Jx6tLVZkLX+/0RuR
	CY5TFnAgO699vO1GVFQ2hvMXYDRnKnsFRd9/i/3F4O+VV48cZ1EXLRzpfDb0I2QiMLx9
	k9MWlEP0RLcb6EcFUy0juZZEEcPAzOAvdNcRGpP+TZftN/VzDZPGD1L9Ob+eLpFF6Pb0
	n9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8aM/3zkgxng0ie4nC212YmQwcdv5GpIX/biWiirdyy8=;
	b=AEkcGCSayr8UMOylLh4Y7rhD/5Oz5Ehp7mCNmU2qLtjxFrZF9w/9+okn3GcuxyRWNw
	gRLwUm7pi+Q9XuP6KNpLlUR/94JdJiPseMjxs9FQBsgu/G4IHforXVWYURQUMzJt3olu
	3qrQkmgVJFmhsOZqf2CdaXzJRht3ETs1vxiHgXxg9uDZBlU8L038XMZxjvI2WHGj7VGA
	UjvViOZDmQrromg27hPC+cgr/MoCVjN5CLPsjJaYjaDha3CCrrsQjPjtBQgtoqCiY2IB
	uExKvndUIHk+dFkqBGS/agsbpz1fCHU8/I5spCT2HOp3q3w/6S/RFvJB5Mm5nZO3lyL0
	gkww==
X-Gm-Message-State: APjAAAWPtowyVHg0vj/ed07FfaddtKg9v7agtvKaVsIuGzoxRKE8v+b/
	dyTftuWtimaip9KbhBZ5YyrJuuEA
X-Google-Smtp-Source: APXvYqx4r1R7Pr1Cre3yy7aCW+yoK1TUeJeOypws1VRJYjMukUtpzpI66oEn28XSHiuQZh1ubbUdyg==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr1733927wrp.64.1556784977985;
	Thu, 02 May 2019 01:16:17 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:17 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:33 +0300
Message-Id: <20190502081554.5521-7-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v9 06/27] gdbstub: Implement set_thread (H pkt)
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
Message-ID: <20190502081533.R-BQ91qYm0L40JDAJW5dRxcR4VtVwze5gACIuXAMxro@z>

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


