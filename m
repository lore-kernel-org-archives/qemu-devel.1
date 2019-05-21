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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323CC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D6F21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAOW+6JW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D6F21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1qn-0004Bx-84
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:18:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZG-0005ow-4M
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZE-0007eu-4w
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZC-0007bi-N8
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id w8so17870703wrl.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/sbmzo79XaCZQwqH+f+jq/WsDe+pAivhYNl3QyPcKVE=;
	b=iAOW+6JWvQXcMi5oKvyrtBFcxzfEydkHs1kcbT6j00DBTq5Haf964UqHc9DN/Oq1ua
	nu02FSI/bcgRr3Aw7HRHB2ABPhxuxNbkbEtmG3331icx5Ncf4m7suaTgBQglTmXdYoX5
	S31JemcIANlZd7GDBbUw+PAK3Tr1qP3WpXnE0bh8/7QenwcxeMFuHB3yKt9MLKAlT+yn
	XGq+cCPxpYcxB6c3cwao+duBaf8AXDDi51tyIVsveOwR9YmAtSqE17P2BDmuhJuzkrgK
	iDpLM/dGj27H7PiXMfOxm3DBLVRUfCfHS6PExBDAENPbPgNQzbu6ceAeOynNY8a/mrdJ
	gl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/sbmzo79XaCZQwqH+f+jq/WsDe+pAivhYNl3QyPcKVE=;
	b=OpTX+9pMwHp5ALb+T84an+rug6Qg7L2lRzjUSdYSUl45fZrPfGiTpGe3VYfDkUN/oK
	8hYltSo6zLO4lRydcXi2EvVze8Guy9pTYGSKtw46lFXCqFB3tqmR52MC14E77hsWxGx5
	f/6JEMqmGViQopH1h46d6vfuKUbYKuoFUVLOrtgbc805i9szJIK3IsNRrBNmaLL5OwSs
	oN+1GVeYtI+TcltQxlCfqmFjLZpFhbSDdDfBThTepswb4X89sNpt26n6UYkp3m7xSpv3
	+7rpvBOmBMJ4keIHtsq5rTeh6TnmAKThTei4M/sY1G6qWuo+grRCZadcXrkyE63j2lFi
	XZfw==
X-Gm-Message-State: APjAAAVdumLT5PPLABD5Gr4XjffXmPjNAx4y89TgA7nMhkfosXXj98PL
	hRSBbjFCtWxp1cg6bhkmGRbcOiRr
X-Google-Smtp-Source: APXvYqz5TNxuJHN7hmHj5TZcG4aAuagh2rAcFi+QvVnVbqgLNtxrT947khhe5cEqds+/OthVdO4ZcA==
X-Received: by 2002:adf:e649:: with SMTP id b9mr3926104wrn.195.1558432817704; 
	Tue, 21 May 2019 03:00:17 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:17 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:38 +0300
Message-Id: <20190521095948.8204-11-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v10 10/20] gdbstub: Implement write memory (M
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
 gdbstub.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3284b3e01d..c798d93e22 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1688,6 +1688,31 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params != 3) {
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
@@ -1896,24 +1921,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.21.0


