Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB145C282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40C72084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig3S8TS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40C72084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42771 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ9H-0005e6-64
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:45:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzK-0004gC-IR
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsL-0000pB-UZ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsK-0000hq-1b
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id c5so16586391wrs.11
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1Xzew2DYAuR34ykBKdLIT8kezrjugasfzVHtbe9dKFY=;
	b=Ig3S8TS/r2gQE/ij6CXDSEFrHEvk4cYRRnO4ajnpNN1rqbluromBKiF9F3YgzWnVAp
	FfmH+x7bzop3kXiHVi4dhnnY5AFc49lKCLvdQM42k1JvDQ46VPQztMAJ7IPT8FF64CnS
	zGAerJ1ioL+lKvZmcL1pbWwEFp05qnon4z0OXlhloFU+gZBDl1A1rxO831MdqktqUZ2E
	/1P6BB2ixT63xo/G9PyhSa91P5xWxHJaKVO6O5fuSyDd2z5fJ+wdC6J8OPuXtbnPYkZ7
	gQWdQVFEo6VtGP4bZMw5mgDo+HJtdop1i4q0fqhI4Lby/L87NsckASTFrnhi+bUMvMwB
	Ox2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=1Xzew2DYAuR34ykBKdLIT8kezrjugasfzVHtbe9dKFY=;
	b=SPC9TXogk48vCoddPj1RgI80g54XZ1u9HQCFjmDxo0U0z4o/EXZyniR9axXMIJE7T9
	ZaVTikOYwlyR1yFTItnDoCk88fQLlF4xQ3mUYC5sFXxSmO2t9wVrVqDa6lvjM5X08eIA
	FHCfGnjbdPzrjz3J8hUagscTbOpOqx7xBikhhXfmX6rb+8WdKhXWGidXdpJHY5Hiw/WA
	aQIj95AG2IaC77CJ9g/BZs4sbB62iu1w2pm+CzBG1YO+q/GG7DBIcMOCRE/mw0Q8UzL9
	0/ggEBkSW+apsxU1AXwEY5eJenpQPq8B1sI78bU0bi+GSMNskWLsT/b83639eGkJlkwG
	EmlQ==
X-Gm-Message-State: APjAAAWVCsFGRmliXGjuqmt5ZgeO4XWoi6pYYMkF1COGl9+flnhP8dX/
	3G6GBwiFnAqdaSt30OZnsKUX5BQl
X-Google-Smtp-Source: APXvYqzqHXDfpBgBsOVwu2JdQG+LMWilc8RcKZx4tLDd3VoPj+4aLM0oJA3W5yXogSHhdAGvwUXrOA==
X-Received: by 2002:a05:6000:ca:: with SMTP id
	q10mr1116883wrx.148.1556116065248; 
	Wed, 24 Apr 2019 07:27:45 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:44 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:05 +0300
Message-Id: <20190424142714.28460-11-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3 11/20] gdbstub: Implement write memory (M
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424142705.1Qtf3Vs4VyoQbMlrsU-__9Rd19NgxV649bGhtPhlPy4@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index ca91cb6740..a58450ffab 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1701,6 +1701,31 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1908,24 +1933,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry write_mem_cmd_desc = {
+                .handler = handle_write_mem,
+                .cmd = "M",
+                .cmd_startswith = 1,
+                .schema = "L,L:s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &write_mem_cmd_desc, 1);
         }
         break;
     case 'p':
-- 
2.20.1


