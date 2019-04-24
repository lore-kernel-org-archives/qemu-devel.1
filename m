Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F23C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAAE2175B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnq2ysX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAAE2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNH1-0003N7-Bd
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:09:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6G-0001zm-1H
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMua-0005gy-14
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuZ-0005gI-RC
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id f14so25993142wrj.5
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=oSXDiqUy2nUNipWzMgipRoZhdarhHffceRS3uDIOFXM=;
	b=Hnq2ysX9OkGIfPv5vdGzQFf+1vvj6ZfT7d4j+HkU+1KmPRzeCzlyVEpkvtwr4F6Llm
	97VSVzen3dsEUjXtx/SlBCHtR7LgMKmJ+2uLLHOQv6c728D5nELKBp3dsYqdEwCcHX8/
	UBrUuzpZ8gXSAcP3w6wLe/F21Tef3yr8AhRnyuPPgWeNUsjgSayFpreffCcJCzJzm8w1
	RohE6y6I23+XzM9FSKwO31oxnUvBpsbCVUPquXqMmNr0dhpIcABajMrvzQWswyXS6LTK
	J3UlGC7TEJHmlFbkCm9TZoTsflP4a0yrprYAHFiUgQDk3eKxzQg4a1PzQekBOGzCpZZ5
	9pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oSXDiqUy2nUNipWzMgipRoZhdarhHffceRS3uDIOFXM=;
	b=k/geDrALyfyOwzZoZKe9gDxZWbg9JmZQdDwJQXzm9avorxsCEZ2MzAhevwu2+M+haj
	cPnA0HfYjPLZ0Wzgx9Ld/QMksyacD8xn7dqMkWgqCLZRppfoEKdO/O27L1gj8apXNZIK
	Hnaoz/DAPLbQP6kNpuEpWHDPxh1NiGYUiRzJmvncyl8qjIn3ZXwPUz6v+qIl2gSMA7PQ
	ST27dOZHqDW4//JEkhXfE2XGF8+VCQjj8NJ/G8O1cr/5HA7KjtHTeGMKV/N/vu4pL+7X
	A6j6w2ElkKi2MFg6NA5Byt+ZrSaw4StJz1ubOmgH3ovhi+f+yOXm7SwPfYlllNkoFLsO
	fJDQ==
X-Gm-Message-State: APjAAAU3yor+4/9XJzVqTpzYp3vrgrJac4ZuIv5+9gMGcq4gk0bSP90e
	k0ARPPctaUh2HmieUVrJLMW5ytkA
X-Google-Smtp-Source: APXvYqwRr33y8jI/u5nV7Ist3MNCO7Fa8Kej7aVKZs+P+7J4R9jezyQPKT0wqm0ckj+E9veEUUhr1Q==
X-Received: by 2002:a5d:5383:: with SMTP id d3mr5236445wrv.105.1556131586409; 
	Wed, 24 Apr 2019 11:46:26 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:25 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:49 +0300
Message-Id: <20190424184600.8445-9-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v4 09/20] gdbstub: Implement set register (P
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
Message-ID: <20190424184549.EVHuNpt4xuOwSyHdQYTwirt3bwsoSFtM0x9x8WZ98q0@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b5d568603c..d3d688a747 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1644,6 +1644,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1887,15 +1908,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry set_reg_cmd_desc = {
+                .handler = handle_set_reg,
+                .cmd = "P",
+                .cmd_startswith = 1,
+                .schema = "L?s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &set_reg_cmd_desc, 1);
+        }
         break;
     case 'Z':
         {
-- 
2.20.1


