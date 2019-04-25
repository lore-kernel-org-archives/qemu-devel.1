Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290A5C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0AD206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFlTWUuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0AD206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57563 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJemT-00037f-3m
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:51:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePT-00088Q-2q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePQ-0000gM-H0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePQ-0000em-9F
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id o25so9273200wmf.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=M4+5FDQ/6x+srBv3D1SqFY72lf8MIyrhQkAf/Mt9fsY=;
	b=YFlTWUuyu/OX566JRAFqJQFm5V15zL6nrPJDKBZORXWzQXazBB+CN2VTbg7K9dWJJF
	uFxxoZx4nxtQ+DT/4ptmyxAjSrgb6jjc9DlZXJ71RPVG0I9ZMz0UW8RDeHb5bBtbdNX8
	piMEI4QMZqx/I4fYTiKYoF1Lr+8HTpZG3LzIRrmq//5oKXi1B720i09Gob0VhOi7etsV
	B9PWKcXIR8auuNxpOHkaoCqkkFT48EtMfD+ySdB1nA5Cp6DabTlpgGW1KxXehBPXDst9
	6OCdDoymWA4T5hXY670bAUnEoEkGWyqNA+HDpBGHi0fBhrAKOftJ8hlL45+i1x0kn1Sf
	6paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=M4+5FDQ/6x+srBv3D1SqFY72lf8MIyrhQkAf/Mt9fsY=;
	b=gaxIh8SanQmjdfrgdUn0wM/lpxIunZOImfsXF6nduFvhEL09N37n0Gdg2cLwHn+SPB
	c+rSV6d+yllWjJD9rbaag05noMqedZJVSDrFAONyp/OM0Qph1ijNZ4EYG1luVtcI7akE
	SkOHQTOM+LfPHsFyKCOJ3b6p0LvUXaf/MgDUrmJZaiwTHHfMIIK21sRgSsNyVgjRaKbS
	E3urM90vCcTrgrtpEir3xuzALdcO2KZWAq/1kTQuLBNFLlJxMjeZGPnOpEC9n3l6KX5/
	UDob9LuTVIHPOqAWo95cnZBlTga/NqmEPUIlW/07PQ4K+8CCRomTozASZ2o/5pe5r9b/
	cWHw==
X-Gm-Message-State: APjAAAWBQPC/etCk3KaLD2DXoOZRe6dqgRLQmDXPsBaYvrdEsj/fPP5H
	6fuHVQ0JXmnaqX8uHQnB2IlirIFN
X-Google-Smtp-Source: APXvYqwXCz5UYcNYedt8ck9JvvKBK7XWl5TAOw0Ed3+VTZWsbeudX7XjHV/+5yxfZJSVPvsGmEWscA==
X-Received: by 2002:a1c:9e96:: with SMTP id h144mr3745198wme.33.1556198845910; 
	Thu, 25 Apr 2019 06:27:25 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:24 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:21 +0300
Message-Id: <20190425132636.31636-7-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v6 06/21] gdbstub: Implement set_thread (H pkt)
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
Message-ID: <20190425132621.mq95Qfs4IKoCcFMiDSeKFeKzrv8aEvWgLeOanRKB9a4@z>

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


