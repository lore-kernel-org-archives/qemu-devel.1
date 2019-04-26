Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03357C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB13F206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGbEXiLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB13F206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39171 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsqz-0005Lk-Tv
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:52:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmh-0000dE-D7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsb0-0004Ob-U1
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsay-0004Lu-Ut
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id v16so47489wrp.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8aM/3zkgxng0ie4nC212YmQwcdv5GpIX/biWiirdyy8=;
	b=KGbEXiLPfQg4s5jB4sqLPP82dDGcNOvJV+RW0BP++zjdqT4OB1t3qIx6lWcP5Uis6g
	Dy9yKW8dICYrklUt41pPMTNCuU+zeMtLcCzUcz0e5rkUd4CgonUy/fW3t/zG2dQ3Cu3s
	zTJADuOocE7RC1983PVOCsnD7BuE3nMt2TCS8OgLkI+SKiSzD5nOIfEmQEYFgdQNF0Qj
	tLw5WVXA9tzD5ZAOvsqAWBIJ6DFTb7c1fplz3fVutbtSvfOxttBHxo6LBRXkEC7wSmj9
	yG2vNRJ8RJPXk3GVpe2Fg4FY9g+ZQSJusvb3xFUYES3JaptCwZ3DsTL3H+v7zqPPZGE+
	018g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8aM/3zkgxng0ie4nC212YmQwcdv5GpIX/biWiirdyy8=;
	b=TRgA7pqm2gkUN6kigsgUeggSaoOv4YovdVBb7tR7R8pbA2phrlOd3orgv4K2xZucHH
	g5Nfjzxg74ntZm4TM35yr3DnxGTH80ZjVz54eM2yp6X+x7Gpjj1zoqBu5KmrzGWD+zSM
	DTCwFSC1pCEao/7ZWaDDZb7AdNiwqU9m9eoOcHDNi9v4nRQ4+r/fL8X8JoupEbMq5zsE
	wFPetZyZKBWzKZAQbL7XJKJTPdv9quz60c4/oExbfW4R+3JWRZh4yaChkLDTs0l5l6M3
	KgUqEw63GE5FlWe6htq8fn2QJ8rwvd3ejkeWpvtd5vPrSfSwKerIChQ3cAJv7BNxEIjX
	tlOQ==
X-Gm-Message-State: APjAAAU1oq2j6dTCenWTUnJVp0PYUj+Xdc9J7SkdEsguNjP4DkAgBbag
	y5lUA59O9HfReFqmXBKlUML1wED8
X-Google-Smtp-Source: APXvYqydeYydcqyuKzHlwa6rxkw4O1ZsYKyfstn6LejLsHAd24ZnMma8MUBOSF24nbMglKH0RdXquQ==
X-Received: by 2002:a5d:6352:: with SMTP id b18mr13745445wrw.24.1556253377723; 
	Thu, 25 Apr 2019 21:36:17 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:16 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:43 +0300
Message-Id: <20190426043558.6888-7-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v7 06/21] gdbstub: Implement set_thread (H pkt)
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
Message-ID: <20190426043543.0RZpOhCyH7wZLnCtqDGuglWo4c5UUqT1al-p7Oyn4PU@z>

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


