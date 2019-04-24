Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA3C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1B421901
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7PZHCfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1B421901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ47-0000X6-BB
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:40:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzJ-0004qG-St
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsT-0000zp-96
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsP-0000oX-HX
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id h4so25452121wre.7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=g0cYfZYZPafiRCWlvwBqevxyijfckEKNWxR0Y2mkHTM=;
	b=l7PZHCfDSegZSZlTNS8Kbzq6mBubbx9DUvSAp95GYMWQi7/Qjr1XsHdqjdQMsxEWbP
	fcez3mXH0YwoWNpeqf57UdLh1wEaw9r+BUpY1PUtz/3Xy9XS1Ddo+rEnhuxDZuJ+Pre1
	VWfoWRcNWZ3DwGy94Ju/AQyvU7WpwdCTslnx0mzZ1XD1k9P81ZpSO6U2iU0QRd5uOxbj
	oR0cR0zQP646029rnzKHb1gv4SJ2uaeV9nCSEE2qHzNFSQ7M0M9v+q/jTfOx7aH0rDul
	9Vioh3RpUz+n4+0hMO+LT6LyZAf+AuMhycd5brRBNj93gVXsuIheeR1r3pMJdm47EgNW
	UbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=g0cYfZYZPafiRCWlvwBqevxyijfckEKNWxR0Y2mkHTM=;
	b=VNYuzR4BmAOojKjf6EMGW6xJ3/JEDem7ah2KcHfpN0FxeXG5CWlmTixn3BQkSHLdom
	nckh8rzCEJeix0XAez5C506tmnoCu2w9elTrS4cx+scAQ6c+xrPVsN3QhdXCFVYbmDbQ
	qyfUjZ3Tp5h8HbdnmiJlsSB9zKIDrtMlD618kwujUGg55RJTTrcLCHZaV9iPdzJUGWwm
	DmgQLZ/0NDIXnw09BLsNezMm8degnuBaeEHloZtr5a8s+DMZGGOMndouXTClRzM7aTGb
	U09bMUNRNS+AlOqfbEsLrEx61703DI4t6ku9QYj5n+owGlV9lzdvXNniG7dHhA/oFPgX
	pIdA==
X-Gm-Message-State: APjAAAWu36WfMrQWcxGoxXVMp3Vx30Xii9CX/gx6Fnw9pc+4qh6hdtb1
	WAQqdy3H/wQ2s47Ej2eSl8IRW88h
X-Google-Smtp-Source: APXvYqw9YQ6TIb3u97vjpG7bCQVvjfPMxAyGscpk6LHQ7ctoK6AQX14vCOSbpejfmeYfrdht/nioIw==
X-Received: by 2002:a05:6000:12c7:: with SMTP id
	l7mr20537210wrx.4.1556116072309; 
	Wed, 24 Apr 2019 07:27:52 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:50 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:07 +0300
Message-Id: <20190424142714.28460-13-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v3 13/20] gdbstub: Implement write all
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424142707.UAlpkb5c5BSWjHulcbvZeXRjzNfmOWlyuRIGYidrnCs@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index deeb78c341..0523deaef2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1750,6 +1750,29 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1761,7 +1784,6 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
-    uint8_t *registers;
     target_ulong addr, len;
 
     trace_gdbstub_io_command(line_buf);
@@ -1926,16 +1948,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry write_all_regs_cmd_desc = {
+                .handler = handle_write_all_regs,
+                .cmd = "G",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &write_all_regs_cmd_desc, 1);
         }
-        put_packet(s, "OK");
         break;
     case 'm':
         {
-- 
2.20.1


