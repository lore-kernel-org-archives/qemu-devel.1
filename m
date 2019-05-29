Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6410C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02A721670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozt1N/AS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02A721670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsP5-00074u-Tg
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:49:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHu-00015D-Ka
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHt-0001qd-GW
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHt-0001h3-9b
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id 15so680867wmg.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=fmBgz+KC4/5bEya28Z0ZS6wch0W9g6YQKvTnKrR7Gq0=;
	b=ozt1N/ASHQlONUmPN1vjIH4Rk4z0A3QWI55MvOpOzFYoSFUBkgsAOZJRxhqMrm4BRM
	miosJMHcnrLnd6XlMdPeWpbZ8Rjr+xMAok2owOTdthjmj93plPWpRsWsFjFLequPnSRi
	bIGYpwaas/hYs+LbSH7uR7dryX7F2wN84SRzQv1vD55fVTTRP/eBOQligk647Sgl94Un
	qc73SnllnY9lLxm7Gsh/ImpZ4kvYqUx7psw82XfHKTjZmV18yTacfV3nXczWlKUYeAol
	Ekqz6PNJTQcQU18QIsL3vro/6gePqwVOIJ00cEULvq+3Hfx/aqmImiKWk5wzKnir88BQ
	J05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fmBgz+KC4/5bEya28Z0ZS6wch0W9g6YQKvTnKrR7Gq0=;
	b=UzIls8XFG5jFJifuBpeRAT4joNFixQqUThWi7FfdvxFRQ6FtzyLKq5IXJCIAHr0jjB
	fKzmxUH46UJM+gOVKVQVKJDvPHbfKI9OGpb0siLE9vXtB5nbLMrqZpbYNEf+wEfNwdpw
	zGY/BMCScBnTJumKGSlbNCIpt5UIFnhWPy6XP6w1+HVfrPj386WK2bmtMVPBQOh2gLkQ
	6aGMG+2fN9tQcEjlJFUM3cL7J43JSRGWVO5c0TBO8yC3SuGkTrZ6mJmDhirDGB1JP8bk
	Za7wVbqQ4llBQMHvUDjpAEo+Pkvaqhq/Y0hZ8QHlNvdZvTGBFKVfQmZ4hfraR82SDYT0
	QoSg==
X-Gm-Message-State: APjAAAXTh/T7rlXmeffxPlmJoZWeyY5bocEbE8cPfzbO18UZf5549noO
	vdfp9Efm5T55TNiz8F3iWk5Hn154
X-Google-Smtp-Source: APXvYqxHHLKIMEIcVJ9XxYtnAgv7UrEs0QFWWK836Rz3od+KhQVxsB3Lflcd1hbBq7QwDLqOAUootQ==
X-Received: by 2002:a7b:c939:: with SMTP id h25mr5769956wml.7.1559112132287;
	Tue, 28 May 2019 23:42:12 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:11 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:40 +0300
Message-Id: <20190529064148.19856-13-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v12 12/20] gdbstub: Implement write all
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3d8c2f8f42..a487e549d1 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1751,6 +1751,29 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1762,7 +1785,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    uint8_t *registers;
     target_ulong addr, len;
     const GdbCmdParseEntry *cmd_parser = NULL;
 
@@ -1928,16 +1950,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


