Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A77C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F07214AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQG8rNwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F07214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39190 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJstJ-0007XO-1w
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:55:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsme-0000dE-B3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsb9-0004Z9-Fi
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsb9-0004YQ-9b
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id r6so2467610wrm.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7xWdg5J6VC6HFdEkoiuvTsAB/KgJAJp/2excD9374G8=;
	b=kQG8rNwvX5+JSjdSd7ULxS5P7o8KX15sYOC37obpqWq8Eo17WNd7qZT6PQTJIIcLCi
	YDFb64zcNqlB8FsBfVNA2k/CLOTTu+wEs5+b8qdYL/nnf9VjvAcWz9CkV+plImk59BPt
	T6zn4Be4KMAzQrLRveyqxaxqcStg9JDzUyMcyAdhIec8EC0lrCZaSGTYaED4F87QSqr+
	TqiJovdJZpwlqY5KcHuXOQM4wt4P4j0KXeURwDVqDM3VrBQEcqBWSfIyHQJrDSB2C5gh
	+AOSBdz+cCmgo1xiPCYe10Mw1qqPIA+0c83JzcN1inrUBXx80SiZ5Atw/kbkrO2SG5uf
	tvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7xWdg5J6VC6HFdEkoiuvTsAB/KgJAJp/2excD9374G8=;
	b=Qw2swhT6fOfvPT2yQAPVq74VnkmQJunRO6V7o4/x1cT4pXZsqigQu8N0ho6pGZNIr0
	IRyc+DZIr/JKQgt0GvFoY4xg0co1ONOL8nnoEwB2IyVaQeGLEvV/86FOqrMtJL0dwQeC
	3wNE8sXrGu1e/c0TI5Qh4ACDUnfFQZtdjKbkuluSEcGisJ/8w72EZe3ye7lK6xDYJoq6
	kp4CdZw5Vi+26FCb0LNCDDaDVL+x2QI9RZno4CmSuSIgVeiSR87hlyE5SZisCyBbvY36
	xPNvwVG6JrojTR5theedxVPp7V8y5iEyhDR6oSoZc03zvsIO8Km0f9xkZ6kHBssevcQi
	F/jA==
X-Gm-Message-State: APjAAAWscQGelzJJ92eIoZ1XsE0lJxc09t/sdQ9r/CaFeYKMCtfoS6xM
	KsHdusDAEY2peAiKlFycY7d1uC8H
X-Google-Smtp-Source: APXvYqyFGUmKiTaEjpdDocJzPC/cygweHiSyXbDHhGf2fqS/TiEbK4E7l/NLcU1kZ+VTXfzXMmjevQ==
X-Received: by 2002:a5d:5382:: with SMTP id d2mr17099333wrv.78.1556253389471; 
	Thu, 25 Apr 2019 21:36:29 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:27 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:48 +0300
Message-Id: <20190426043558.6888-12-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v7 11/21] gdbstub: Implement write memory (M
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426043548.jaaRqybCY-pn5ajKVlkQmlcW5zHZphDws7DxdfGKIl8@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index e9a3d0c2bc..8dc2e1d507 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1685,6 +1685,31 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* hextomem() reads 2*len bytes */
+    if (gdb_ctx->params[1].val_ull > strlen(gdb_ctx->params[2].data) / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
+             gdb_ctx->params[1].val_ull);
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, true)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1893,24 +1918,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'M':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (*p == ':')
-            p++;
-
-        /* hextomem() reads 2*len bytes */
-        if (len > strlen(p) / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-        hextomem(mem_buf, p, len);
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len,
-                                   true) != 0) {
-            put_packet(s, "E14");
-        } else {
-            put_packet(s, "OK");
+        {
+            static const GdbCmdParseEntry write_mem_cmd_desc = {
+                .handler = handle_write_mem,
+                .cmd = "M",
+                .cmd_startswith = 1,
+                .schema = "L,L:s0"
+            };
+            cmd_parser = &write_mem_cmd_desc;
         }
         break;
     case 'p':
-- 
2.20.1


