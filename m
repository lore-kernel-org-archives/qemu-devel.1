Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7565FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B5620675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzskXrAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B5620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57033 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCoq-0005ZF-Ct
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:13:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdn-0004D4-Ns
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdl-0002DV-Om
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdf-00021R-GJ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so5684988wma.4
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+MQZmZOjKDB4jASk4WwHNgmMdTwnSXOjIf4N4zQ8Ens=;
	b=CzskXrAASAUX7agFsSxUUDvXRg7DbwWQ7Q4xKdSRn5Csxb0c5D3F/AmnEMzgAWcIwI
	a4R3qDf+NHJe7SlzpCH9QngnmtOj53lrv/hz8ViKBrdi73P7SFbWQrXFMh9kqCORU2G3
	8XqlvacXcphWDJqrvAAn9kvqY06AxTSJC5bTqDYpge4SyNi6OXeCbXG6QsYNuoEkpe+a
	kWinScwPeehd5AwigAbYJTOnuOUGwkcsqyFlkwoeL8cUHqmmeY9JciKcdKqxIzKhPEmJ
	HhS4/aqM4FLL1ZutKxbSdMuT68pdm0AqYqa+QH9tMuVW9OdSq35go5bDL5XTKOCzha1f
	a29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+MQZmZOjKDB4jASk4WwHNgmMdTwnSXOjIf4N4zQ8Ens=;
	b=IGZ59rOBILfot18n6dyjtMbFIsWbL4WMjsjmm+HWL8l7TlbnOOUMm7e1H9bagnXtcg
	GycMfBdzcXDPdnoV+v53i7mamwu+TuPhAhy7jWwdlzwd+WcZry4rQ9PBfPAT2tR4D9/7
	iXeyWTX/bhod5V8CYgOLZzsuMHqzBA8PrWCaP6S2DE1SNmpPqAkXiEvqu+KgQQCq5IT2
	wT2r/uOswGGirPPyy4pkzRVfSalsQRXGL7hvzyoi+CWoB7GCM8Jg0bDogvbLe/YjSMZh
	Q82aohID6uK+xMA6Z3ZhjDTzqM49UqUUQQz6J00rhNYfE3yLVAuzlBG56vP0G/j88vYy
	eadg==
X-Gm-Message-State: APjAAAVnQKN3zlCEmrofj6FGbAfH9K/BNe5eNdtEDWo3/qKuUUM/yznB
	CQGUn6DsMqTmr8bwU6LP+gxk9dXt
X-Google-Smtp-Source: APXvYqzGZrhqWHtmkneDDEAoRiMUjuLVKvyJe3hZfgceC9s7E+KgAFRfAROT47fEsuRvu8QaZAYMGA==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr434194wmj.34.1558713701982;
	Fri, 24 May 2019 09:01:41 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.40
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:41 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:08 +0300
Message-Id: <20190524160118.31134-11-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v11 10/20] gdbstub: Implement write memory (M
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


