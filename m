Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908D3C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623E4217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCQSpA63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623E4217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCge-0006A5-GZ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:04:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdf-00044E-F3
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdd-00023u-Bj
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdZ-0001zT-F9
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id u16so6658527wrn.8
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CctE0zTJnEU25JB3cn3PPMbvqOEdGic49XPgJHQGWnY=;
	b=WCQSpA636wewpDaVqr6fC68Sek+DcX+4tdbx+1F6rhf0wCXBRHljhLm6nPjFEprxlW
	ZBB1NesnDBXmvcW8LOrLROetpLD2Tc3ml38Bz+379F7ys1PzYbxJowEJV6sTCwECVojU
	cKmZzGDj+VWBK2VRbvvk2x2i4hKcHHcgcOmQLOZmb59OSRvPLVcrBasbtCsZQNDGCtlc
	Fld4GXgaax0iy03brfJlcak5TSRNWyF7uHDquREUIez6jRUeCCDW6XUfbTxfDJ5DyWbj
	pq+kWoh8MQBw4I0S20ypq5EHVUa0i29Dy/wYA3J++JyDZ1A6dbudNyXaT7zogzKrq27U
	QOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CctE0zTJnEU25JB3cn3PPMbvqOEdGic49XPgJHQGWnY=;
	b=aUkoegmUq7UOR+OEkHvcPxoUf32RXqydUM742DfMy5K5G6wEuH8nnEl7PtFLOI8ZQi
	saSmBY8ZrF/rwVkxfpB2Ci38jsaVcClAFMrBuFan35TWH234FVXYiGKC3wn0XA3IvWdU
	oUQA3ZQBbKROY+YzoI3uO1BKum1T7g3/5xcZgj9SDY+zfiIoa2hkzqghwl8TA9rFQkl9
	Vu0E/EsUyfX7Lc3fI5YWWMTyjnQOBXfpxcVVbgVqs4AsWjx2pk86Gt4TDecyV+5MxYT9
	QSpHcypLxb0sVLetF7YiMDT33DFaleSGvL6c0jhwXcTdGkzCuaEX4388of+qzFE+dVsD
	boug==
X-Gm-Message-State: APjAAAUNZVzf7wGXnXHhwmR4T5g97OcDmvyzxNlBoLhR+RKjtHjZRn9S
	lWnVuaJPdl91GxBNXv6HdlBCSoZ2
X-Google-Smtp-Source: APXvYqxVVEJT0EaZL4U1sNZEtsyrEn4n4U05CSkrZQIht6RVo7NxZrtfC1b1qk1NxLZb2bv/hZhRtQ==
X-Received: by 2002:adf:e352:: with SMTP id n18mr7841515wrj.82.1558713699713; 
	Fri, 24 May 2019 09:01:39 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:39 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:06 +0300
Message-Id: <20190524160118.31134-9-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v11 08/20] gdbstub: Implement set register (P
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


