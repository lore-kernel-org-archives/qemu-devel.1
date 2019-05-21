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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B7C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D157D21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAdcx/YJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D157D21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50814 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1sO-0004wa-4q
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:20:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZI-0005rH-3I
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZG-0007hb-8p
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZG-0007fk-1n
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id b18so17800935wrq.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=sD4J8yU9W5U39LJ4w5k/hf8/NJnFz6Gfac7J3rxMuig=;
	b=bAdcx/YJVrypi2sR+8j1xWJ3InRqGaCTji8rUpw2s+JmMXjVXW2/JtWpEraOFYyqa/
	55+7T9hHrC8OW0dvzHC8YJAoIaqc2xUwHubSc5i3oF9YLk7Qw35DoA1msfhtuby7eBmH
	HCIR9eWQeW4jYN/R0y2FTB15a4xJRrv5YYGhaEghbMGBJvecXep9zeAbz/cKWEINSqwA
	P8FA84G96zBGwzAu2fawrk0sTR9mxGuoVl4VR731yh4TXf3fr65opM5ql4vz5+U2hiTG
	j12a4Md39MCo+y7MIN+vjIeRfM1X1nkKShfGdSsYhEEa1QeUjxCiXx/fMrdNbgd9zEWE
	2vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=sD4J8yU9W5U39LJ4w5k/hf8/NJnFz6Gfac7J3rxMuig=;
	b=KWrMIMuavgMMoeM+GHUD0dh1l0QGaj+O9n0JWTPfVeaqka+1LCY5WjGaVsxwI29/pI
	2D8ZKH/TSo5865KjGUBTrUC2LWoI4Q5DG6nDyH9AmtQZ8y0f/BXzUIdPp7LBFOreRFwr
	+v7s9fZCW6P6khFzql8RodWYj5g/XuoNu59xn+8hWP+4Gk/dBBR0SNS7uJGKaS7LZfvC
	6oU+38gxx2PprqntJlYMA7fN5JCm+PnzIgmZSHRdnx8MVbMUr/o1AEY/64ywJEPwtkdp
	RV6/ami0DqDYLQs4L3/mmHeBKySmuoLt1Caif6aEYrjGg22lThKnJlfTAKU/RlcWuePq
	vReA==
X-Gm-Message-State: APjAAAU9LAZSp6xjH1g7cMNJzDCD/s4L5KGGjAo3jHw4wqGff0DDIwSr
	wrlW3eXl6QqQndUqQz2o0XYQ95Ef
X-Google-Smtp-Source: APXvYqzTBBLIyhoB/ytdSAeTmHfinVpg1GSRHgC7AXgSvEPo07+T6gX65MgMCQulhGbv/T60ul75mw==
X-Received: by 2002:adf:de82:: with SMTP id w2mr5057287wrl.53.1558432820391;
	Tue, 21 May 2019 03:00:20 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:40 +0300
Message-Id: <20190521095948.8204-13-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v10 12/20] gdbstub: Implement write all
 registers (G pkt) with new infra
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
 gdbstub.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c957b0d8a7..1afad31b49 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1737,6 +1737,29 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    target_ulong addr, len;
+    uint8_t *registers;
+    int reg_size;
+
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    registers = gdb_ctx->mem_buf;
+    len = strlen(gdb_ctx->params[0].data) / 2;
+    hextomem(registers, gdb_ctx->params[0].data, len);
+    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs && len > 0;
+         addr++) {
+        reg_size = gdb_write_register(gdb_ctx->s->g_cpu, registers, addr);
+        len -= reg_size;
+        registers += reg_size;
+    }
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1748,7 +1771,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    uint8_t *registers;
     target_ulong addr, len;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
@@ -1914,16 +1936,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, buf);
         break;
     case 'G':
-        cpu_synchronize_state(s->g_cpu);
-        registers = mem_buf;
-        len = strlen(p) / 2;
-        hextomem((uint8_t *)registers, p, len);
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs && len > 0; addr++) {
-            reg_size = gdb_write_register(s->g_cpu, registers, addr);
-            len -= reg_size;
-            registers += reg_size;
+        {
+            static const GdbCmdParseEntry write_all_regs_cmd_desc = {
+                .handler = handle_write_all_regs,
+                .cmd = "G",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            cmd_parser = &write_all_regs_cmd_desc;
         }
-        put_packet(s, "OK");
         break;
     case 'm':
         {
-- 
2.21.0


