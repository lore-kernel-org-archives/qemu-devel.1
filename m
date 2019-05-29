Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D96BC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C72A21670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU1d6x5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C72A21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsMA-0004dg-65
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:46:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHs-00013J-Oe
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHr-0001Td-OC
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHr-0001KJ-Hi
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id f8so820916wrt.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zYpwIgeZFIPxtX2pfuZMsiFOK3Cy3BKlk2l3IGPOWQs=;
	b=oU1d6x5qNPlRW/5uyByXp+jFygpKPXrdw4cIhTd6YzQou9ZHhgPXmPMUgksaQjsCZN
	SSzytTsNjez3Nk1XqgsxFFzl9kqUwinoYIvuwbY1Vo+oqBvjCbDgxmoeqFrvLJ+zehf9
	pP8xDgdjFvYEGRlTC92mEPdv3RLeUoeOuzAXAW6HSZ8uq4AUMbgXwwuyhBnbVLspE5P9
	0xkCy/i+nxnOkJ30IcIKglBakFF9XnJa0EjgdKniYrdIu2ycTkIjTcWAQ+1Hg3bq0az9
	ILzNw5SGyReBRpLs9O3+mvlmEy+sLfUmY9Zg4zyvebMHwJi1fJv24Mcre/b18kTZPtjQ
	WRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zYpwIgeZFIPxtX2pfuZMsiFOK3Cy3BKlk2l3IGPOWQs=;
	b=iUOmOXPsoe0PrZE7FpEhDYGp0/R/N85hQ2GHSvXDQjw8kE/qolp1Md8eCrXIbPGm6c
	Zgz6+lnDgkopwbLrWjprkj96fS8zCGHbcVmRMV9rE4ei91w1fXAQvGhK4E/H/k8wTYo2
	GgWKP/QjlyhNRPz4wC86N1DS4yEbm4l+ozADPBf4g2tIB8D7DiZmRztjnMr/gD17xbAl
	eeEVdmWznPEcWdcrY7Sk7gHXj7GXYcitwYV7qSdLDDKczkdrwU2rTeTdonTg8GklG01Y
	NNNB8odgzQ4V45oySItiKpRenPRdj8A6DM+aMRTgQynhCELyAORStXhvL9lnGKD5xAzm
	aGcw==
X-Gm-Message-State: APjAAAXsBhwzBaTjnijG68+k1bvMdUqqjeNG8/U9DlVzSTqA33E/PHJJ
	HCryVlu9+eOlldastADVzG8U8EM7
X-Google-Smtp-Source: APXvYqzQ5HTbTOjWP9jWEJJKJubxInmKqfZHqz0NPYSSA0ns/oEe1jTz2BDDrNRkPXD/M/LHjR+nHQ==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr17123074wrv.71.1559112130464; 
	Tue, 28 May 2019 23:42:10 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.09
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:10 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:38 +0300
Message-Id: <20190529064148.19856-11-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v12 10/20] gdbstub: Implement write memory (M
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 07740ec0af..f2ea5bdd5c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1702,6 +1702,31 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1910,24 +1935,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


