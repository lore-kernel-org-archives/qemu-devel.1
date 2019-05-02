Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0136C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EAA20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P973YXxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EAA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM73Q-0004Ps-IY
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:26:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ta-0003Re-Bs
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tY-0007pD-Aw
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6tU-0007SR-Nw
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id k16so2002400wrn.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=C5wVxSSu9B3yjrVL1kbdSqghY5biwyr5/S2ykkoUubY=;
	b=P973YXxRkkAoD8ifvQ4auErj5Mf/eBggo1kuDyvPdSN4veKbOzGVjnH7PHerd+TyQh
	FI4faExZq2rZK/q9pJo71I7EEey4RH9ZoF+3ctmlwKC1kmv9/ozGdZ2P04D3P94FxRKw
	wJ7D3sN5tBG7USjzkrWTYk+QLXyy+DQcwlQMADcwBiZRY+0uK9kf+ZMndkS7htul423V
	lTzCTyzQXUG4RPPlH58AAiNJbV/+lPk8h4hOGrM2S+4ElCdpI8OZVGISraQBaY2zOG1z
	dMGLSn2It+DLA5NGMbSMJXVWLGV3kI20XlZ31n8B1U32kKOCab9/d+tcTHTdDE/rTW9Q
	iAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=C5wVxSSu9B3yjrVL1kbdSqghY5biwyr5/S2ykkoUubY=;
	b=uIidda+1uWx0wyD240mOAltJz/NBdmigh0IHtHZfGSrYA84QhPQNETdHSLfxUrXLRY
	h0xA2IW4gUhxJNOv84UPMd8r1rkuw/PVryVhFHrqCbZN0EEV0hiZvxM196DhZSdcEA7E
	kNGCWuccJL3IUDtVAPab1xKRCkA8h3ySyxCwy65u1NcWqSbaMwDJoFMBi25ASZ3uDLyS
	gxWzgSmpdVMzdOHGKjWBo4i1zXyQubC3rzuYO7B2ZHtaSHlGv4tEnQx+kQb2dONjfqIw
	2zMjH9qHVaPVwnpXOYb1H/jnox8kYfwducNjjkgbedsN2DZ4gMs+CtAMx7x3BTThH2RC
	lerg==
X-Gm-Message-State: APjAAAV/RJXMJrrwaVLUqn836VB15bm9PHHO3BHCYUivUncOhiW1V9vA
	+shjtPlkX6iB6GWd5f2sA1PwpLV3
X-Google-Smtp-Source: APXvYqy+YNCNJabIbOwxjy7rwjUU3L89FuOqLVyO6ASkWAHtnYT8+BNbFVdlUhiMM5Ch/3n5RZmnuQ==
X-Received: by 2002:a05:6000:10:: with SMTP id
	h16mr1355746wrx.151.1556784983117; 
	Thu, 02 May 2019 01:16:23 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:22 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:37 +0300
Message-Id: <20190502081554.5521-11-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v9 10/27] gdbstub: Implement get register (p
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
Message-ID: <20190502081537.UjpV7S8mXfLhP5-VVcZyky1nx4n0qWVU6kGaXjGXA5s@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 10e3f12a68..e9a3d0c2bc 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1655,6 +1655,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    /*
+     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
+     * This works, but can be very slow.  Anything new enough to
+     * understand XML also knows how to use this properly.
+     */
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    reg_size = gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                                 gdb_ctx->params[0].val_ull);
+    if (!reg_size) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1884,18 +1914,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'p':
-        /* Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
-           This works, but can be very slow.  Anything new enough to
-           understand XML also knows how to use this properly.  */
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        reg_size = gdb_read_register(s->g_cpu, mem_buf, addr);
-        if (reg_size) {
-            memtohex(buf, mem_buf, reg_size);
-            put_packet(s, buf);
-        } else {
-            put_packet(s, "E14");
+        {
+            static const GdbCmdParseEntry get_reg_cmd_desc = {
+                .handler = handle_get_reg,
+                .cmd = "p",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &get_reg_cmd_desc;
         }
         break;
     case 'P':
-- 
2.20.1


