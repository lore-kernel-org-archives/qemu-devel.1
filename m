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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFB3C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3CE20675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4LAmB+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3CE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCmE-0002oF-Pz
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:10:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdn-0004D1-NB
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdl-0002DW-PH
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdf-00023H-HS
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:51 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so9756263wmo.2
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Ncrl9VSWo6UCV0ubddeVItS24WdTGzBLmyBoaUVBSyU=;
	b=V4LAmB+BAgP9pIQRNIfBiyhZspTHT9SKxHS3/N49PXyCpAedLfOKxhFz4ldJjDrGNm
	ifeWMffHlmBLje7yLe5fslrq6HD8kXZFWtuzUZKfUNHbao9F+5Q08gSv8x/kABZOAXly
	mf3UGmrEQ9OJZnSmGfK3QQxVLwNVLgrNX3GeSf70CCS0NanH/PXwWAduExLAeKp82/K+
	g/MWg2D28+HuPTuISq0EVWJ7XrBMB0r2iOoLrGNxvOseVvk0JIW77lUPvu5PkyQ6a5Xr
	z11UMJlj5XuuGwiEwhXA17CNUxIfHiEoawL0z7Gjkh+WM3yUG4WcOn41CMJayhcR71er
	OKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Ncrl9VSWo6UCV0ubddeVItS24WdTGzBLmyBoaUVBSyU=;
	b=qEDTffFEo4NloeKhXlVW0T/ifp+xbCOlLv4VBbRfkmDTGwQwd2N5DUej2ugvWaougX
	SSdjLamSfGM/Uu+t8eM5nGfb5n14O3JI3YCCoZMT0wHNcB/q1qoY8sKPIqJ35gISPrwR
	8yxkSGbCQaNDpIqu11NFpXlZ9BQ6Tb33VgjjLhytpVtUPkcEmdZvY0wbcX4J3shP/22G
	RrHuhPf0ytW6eLFESdla6RYDLjtIDQ/q7jfGTeyMSd/RxnGkBSIaa9trf707zBKLNir2
	BukgbnVa2C9Fhae8aaaMWvIM9uw0W0r1WTcZKiDl0b66Dy6IHpCtEEMhfYpPlpauzawS
	QNJQ==
X-Gm-Message-State: APjAAAXkabVvlB2RhmHI6nVXTmz55Hj5SQ4mf9s9AWj2lvsAugOr3B+2
	oUvl3upA4rBYU7vqSB9FiUO5id8T
X-Google-Smtp-Source: APXvYqyzoyOLUc6fDb3P+5zdXj3cptf2jEGXhJFTQpWyOcacwwcEZrSDsppFyBndKcpr74F7w3vo0w==
X-Received: by 2002:a1c:63d5:: with SMTP id x204mr429725wmb.3.1558713704026;
	Fri, 24 May 2019 09:01:44 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:43 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:10 +0300
Message-Id: <20190524160118.31134-13-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v11 12/20] gdbstub: Implement write all
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


