Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D53C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E741420674
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGZ+24AM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E741420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNrP-0002E1-5o
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:47:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkB-0003rO-8K
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkA-00044s-3U
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNk8-00041U-97
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id y197so6750998wmd.0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=TENOL3r5yUJno6/S+4IYhfkNIUwUbfzGmKX97CyU0qA=;
	b=pGZ+24AM1P3iAT70p5Qw3njXtzhLx9GeocyFHFSrNDOL/iucUmHoD9N0kRF8XqReFk
	ENp75n8H4EOTpVZs1GRDjL2xhJ9NG6rihIUi5I9AKX34bQoD9a3NHQvBvBIqO7+hUf4e
	aVTPVDb8IWcpjwtGw29NwUJ7uIxzoXGG0MnBQCYmgvwuG90Bx8iWZ/1UCMtWpdJTlDku
	hhLU3Wmw6SzZfRKVsucOY7/oUfaEESqdCGb9/U7nllpHx/iXY8lMfZ2v/eKMW3sPik3z
	Iw2HvTdBRdZNNS90/ZWR96P2m4j73lOmQO2LDCTKdcZjGSyriNwk9lL+BtF+H2GM10jl
	Z+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=TENOL3r5yUJno6/S+4IYhfkNIUwUbfzGmKX97CyU0qA=;
	b=Z1R7FVh0YeRX+vbcYXUSN8edUC7YFGqacBiA7VAVwjlRAcNk57egDnUmLY6U4ODYHw
	ZUBEB1u1cvQanO4gMOWQdYkbxlRGndQAwOi2QujeFm6x12ft1CzHIw9FscRKUTcROhfv
	7iWKAnFYUJ87G7z31PZH9554TXTqtVumP3Xru7GgE9seD047cSQGvBlfA3+L5xgx2soq
	PbBnYkaErTS9DmiT83xsKrNy+bHbT5pONCct316LaiOg5XbctLIIQjYQwcbjOPLDXIlP
	OmbdkG+PLTgAyy8MxbimqYxhnwrHhvIIMQalyr+scgAHvF7lC8ctxsnSMbjkIxpRV/Kr
	u7QQ==
X-Gm-Message-State: APjAAAWoauf2aIG2j3A7RK4Qn9wDRXQLcwkvixEEDoLwKHeNjLJ3pqrB
	YaWweVz2ow+3VpD04iRBrcPtA6kD
X-Google-Smtp-Source: APXvYqwhSOLP8wnZXxk8t9cU5Cwj3HIHLhbl/Sr6+fpEA2yfO116hZbIFQIATdApkpvAvvXrXtSgQg==
X-Received: by 2002:a05:600c:d4:: with SMTP id u20mr576764wmm.88.1556134782489;
	Wed, 24 Apr 2019 12:39:42 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.39.40
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:39:41 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:49 +0300
Message-Id: <20190424193859.31817-11-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v5 11/21] gdbstub: Implement write memory (M
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
Message-ID: <20190424193849.VTg1C4b7RSit04w4iM4bHRKt-tuYU-zHW2Wjt69ytZQ@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c439b8e796..4522c93fa2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1686,6 +1686,31 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1894,24 +1919,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


