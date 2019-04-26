Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A04C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E665A206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwg1RQYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E665A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsta-0007xC-44
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:55:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmf-0000dE-E5
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsb3-0004Rr-Fl
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsb3-0004Q5-9U
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so2438658wre.7
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6OoH0VZvs5cN/77prjtAmvXUSegJODVLc//0yGYVjjY=;
	b=uwg1RQYsgwBPEOxFTvFOaDqh6ZEi2lTBJyr+fRp43kx+QeD/E0S9N4UfiFgLfrL9ty
	vSLK160mzxUZE6ULWZfQi1sHyAjFGRWkhYQDPKGk+mF3MiirK3XqbVCTSIsUoGOaCISW
	QixASgsdtwMG0jaIp7ZYtfvwSDvL8JuiCD6gcE8//S3tXhziW2KKzY+Wylsv/UK8kFl/
	BdqLYgNlXqnRebdxU4oxO6RuJNNWESfPsBoI73GbhrOB4jelr5nMeOYgab5l9ce5+dcK
	spajNVfD5cgR/P9HoKY+cYr+BABTYK5avc9x+4q82M8l5ndjzZAHBjq/QxtqMi1W2z+N
	frZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6OoH0VZvs5cN/77prjtAmvXUSegJODVLc//0yGYVjjY=;
	b=PqE9AMNPiAkpUtyJuBnEmjuTBTF6WqGTSHvxKC/Djkb4gjvvvXjpudt0NQIqrYmsDZ
	iFmPxGee4WXgHz0fwFgqfMe/5xc7NJtq83m2BXmUcJ1Jr2ymDwmTEOlUTtStASgfSkho
	Tj/vlElM+LRATJn34aKJ6nPGmSD1AQAZ9jYwtFavI2UFfFsf23y5ck5r4XTgV9HZjARG
	VbA3C5cZ+D1bJW814Pcj99KI2tE8cd7Zk+TBYSanJHlRSSxEUThoOrvZejfzvU09BXxT
	egi2VwPKzBbB+otD8ELZBkUqKYdLsIOM3H6gLjVYcxFkxAjuWb2gF4WJiwM0GrYITqyR
	eFSg==
X-Gm-Message-State: APjAAAV7WNUKxXpOkxzTzid9N6m5ffdI4pZHxNAX/K7YGNkpUJCRSaeT
	7OdjOZkaq4lyJRDLWZNoxl7ztV0z
X-Google-Smtp-Source: APXvYqyDOwg9VcXu3GWfwvVg4nX+8CwandTAo9p4prMmapUow+j7CPrCT/E5eDL5+I4Q47WPX17Nfg==
X-Received: by 2002:adf:ec4e:: with SMTP id w14mr5479137wrn.53.1556253383464; 
	Thu, 25 Apr 2019 21:36:23 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:22 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:46 +0300
Message-Id: <20190426043558.6888-10-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v7 09/21] gdbstub: Implement set register (P
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
Message-ID: <20190426043546.rodz4IjGHxRL9xulp8-GPnKS5CkefDLUE9oHzxPk-LU@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b42425b24c..10e3f12a68 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1634,6 +1634,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    reg_size = strlen(gdb_ctx->params[1].data) / 2;
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
+    gdb_write_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                       gdb_ctx->params[0].val_ull);
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1878,15 +1899,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'P':
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == '=')
-            p++;
-        reg_size = strlen(p) / 2;
-        hextomem(mem_buf, p, reg_size);
-        gdb_write_register(s->g_cpu, mem_buf, addr);
-        put_packet(s, "OK");
+        {
+            static const GdbCmdParseEntry set_reg_cmd_desc = {
+                .handler = handle_set_reg,
+                .cmd = "P",
+                .cmd_startswith = 1,
+                .schema = "L?s0"
+            };
+            cmd_parser = &set_reg_cmd_desc;
+        }
         break;
     case 'Z':
         {
-- 
2.20.1


