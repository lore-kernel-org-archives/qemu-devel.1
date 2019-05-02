Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B931C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0227E20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIYQvcIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0227E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM70u-00016b-3B
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:24:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ta-0003Rb-B3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tY-0007pH-Av
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6tU-0007WC-NN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id y5so1399354wma.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=b1bpFqGwMibMAfq1pbDbHkF4Xk3yQKA0SG1CtWad0g4=;
	b=dIYQvcIFgvmcsw6yS0NoxDKlnxkdCaYJLAtxlrs0fnSUmECAqdGEsQVWL2LoW3nPuT
	ZE2wbNyodTgCFi+Mzqp54+YcZOEZeyJHR0De7abVtsUz0bn7X2hCyS1vsyyIz20965xZ
	82/FJV/qTaFId36/z53MsAGe4vfvXGCsU0yT0rjA7SJ0Ld4PjRnbF0TBeEprweQCKuSw
	yoD8PRRGr9qLhdrmaxHIEajVuDmZnJX4FYWvSDDGht8Jss8Fv7nGuw1Q9nHj4BIZAOBW
	k3gi8NLm4XcnbLoY+1yOM3HF6gOm2pfyXTY8gCcecyEm/GB7Xw8VfQNZf0RC162sw/Qh
	pHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=b1bpFqGwMibMAfq1pbDbHkF4Xk3yQKA0SG1CtWad0g4=;
	b=J68/XEJ4OhwBCkseJQI2odcHCdJXveJDZMNQBBQHI9kxjpmszmFQcsZg+qjx9T4nR9
	n1PZZj32iHnlOUxjWjqkFWuuV5L9+CcWntlsWVunI9O5/HhH012/miXXx04A5mo+X5oA
	J4+Z0jtCg6uyo1jmV54p5/rjEcda9Z+mhTLDiQlsnz6IPVADtPNGjXA6g3i2d/0He05f
	9zHekONUyHrd5YLorsTHFUqG/LmCiJq3Kmx4zGGctk/5NWlGGLwJCec4LWq8g4Q+m6lL
	Bpg8dHbFyzLpFtBAlT2UOju4ObK8VvpeSxjeyI++rzWE5c+5oCZ/3e/G+IyNXnwJecr1
	4KmA==
X-Gm-Message-State: APjAAAXgFB3Gw4l5zbdT9xvb7B6Yn+f8YnuT7VoGxDohzdgJ0xbAbyys
	0/1IVZ1KjnrTnWdEYWfaZppxfNGF
X-Google-Smtp-Source: APXvYqx8Dsf6BIhimBTuq6TL3aEZYgOdxV4ULDmc8y7AcPCkcF9K73gGY5FjlDCXGVY/Nop0jE1CzQ==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr1374324wma.28.1556784989304;
	Thu, 02 May 2019 01:16:29 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:28 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:41 +0300
Message-Id: <20190502081554.5521-15-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v9 14/27] gdbstub: Implement read all registers
 (g pkt) with new infra
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
Message-ID: <20190502081541.A1pmRAtYIjIatCuuEz4VnPeexh3y69fr9o6E_rn2y5w@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index adfe39b3a3..3478ac778d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1757,6 +1757,21 @@ static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    target_ulong addr, len;
+
+    cpu_synchronize_state(gdb_ctx->s->g_cpu);
+    len = 0;
+    for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
+        len += gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf + len,
+                                 addr);
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1764,7 +1779,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     CPUClass *cc;
     const char *p;
     uint32_t pid, tid;
-    int ch, reg_size, type, res;
+    int ch, type, res;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
@@ -1923,14 +1938,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'g':
-        cpu_synchronize_state(s->g_cpu);
-        len = 0;
-        for (addr = 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
-            reg_size = gdb_read_register(s->g_cpu, mem_buf + len, addr);
-            len += reg_size;
+        {
+            static const GdbCmdParseEntry read_all_regs_cmd_desc = {
+                .handler = handle_read_all_regs,
+                .cmd = "g",
+                .cmd_startswith = 1
+            };
+            cmd_parser = &read_all_regs_cmd_desc;
         }
-        memtohex(buf, mem_buf, len);
-        put_packet(s, buf);
         break;
     case 'G':
         {
-- 
2.20.1


