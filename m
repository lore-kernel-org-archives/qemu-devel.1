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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADA0C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985B621773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrdPF8Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985B621773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50625 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1lK-0006Zg-O6
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:12:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZC-0005lV-4b
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZA-0007Za-7c
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZA-0007WB-1S
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id g12so17568063wro.8
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CctE0zTJnEU25JB3cn3PPMbvqOEdGic49XPgJHQGWnY=;
	b=YrdPF8PliS9s5JYhwNFYHFvT5KIgys3HchqYGIx7RLg6N26WLvQtZAGobSgfT8TeyU
	nxKkCEfpwKjAXYRS2sNF2yac3yiKHk9/djX2yYK73R+bwz3L1nXaSdndM4toOucAtwgS
	kSYVFFOWSj56bNy+jGK97ok+Dq1m9CbPLIsG6IopNTe9E+PBR0lm8RE2LYOjsrE9gdOl
	d2MXhiGGPKBy5vWU9d391D/YFSfLUevjlSSrA+cAkIHqRgMxczGf1fQnhaH0KJwTwjXG
	hs0zgtS02nw1eufo8nTsO6a09gmLcFaEMWNcHkFzA/Wt6gjuCOqbfG+KfuBiWnknhIfw
	QVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CctE0zTJnEU25JB3cn3PPMbvqOEdGic49XPgJHQGWnY=;
	b=PRjw02gZ9aasxU6VlQ48dcRhR4XnFPRUDIfDfAU3rHlaOTxE/VPgjIlrU1Zc1GpUVr
	wj+2qcbf7SNjazZGiY/Wgi7S9gMAmmVznrcfUdeA+CGWsSKyQKm03yY25EqprAjZgEwj
	MDkM7/rv8/dr/rkW3pvGqjq4zND/nfN017Qw9Lx/vrODBFZgI2IWKpLOlapckH3o0u+c
	hTjWoXyC9L0tkOwKJLIsTNWMVgTRj8omLjpnTcOG/RxlGFlnKL472QCt/sxavDBqivlT
	WWG123/eXiNXXg2QpCj/ihkl/1ttXrFQ7xbooWPIcj6Sf4kfuu7VlCxKcqHVn+Yg/XuG
	Q8wQ==
X-Gm-Message-State: APjAAAVEww2VRDxVePsKIMweUeVrprQclmPTM4wK6Cimj6y3Ww8TgCWr
	iinqZQTxq93IbWXFAg5d40HypmTI
X-Google-Smtp-Source: APXvYqzTJGEfkiXUIEEGRWsk9Cr5H9IfkL2uC3r1SnjGOji49poKC4bLGc1GIu84YrLBrDgAeaZH7A==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr10548303wrv.268.1558432814428; 
	Tue, 21 May 2019 03:00:14 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:13 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:36 +0300
Message-Id: <20190521095948.8204-9-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v10 08/20] gdbstub: Implement set register (P
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
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c59a6765cd..1c210d671a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1637,6 +1637,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    if (gdb_ctx->num_params != 2) {
+        put_packet(gdb_ctx->s, "E22");
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
@@ -1881,15 +1902,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.21.0


