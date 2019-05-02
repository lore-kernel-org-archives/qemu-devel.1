Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12816C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA34020873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+nkC1h+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA34020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6JU-0004Zt-2F
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:39:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6A3-0004sd-PC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69v-0002qp-Lx
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69k-0000iM-S2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id s15so1760191wra.12
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NvRXYl/vjqrIbJL0BHzsmEe5eGi5MjJ6JeUBkCbtEUs=;
	b=m+nkC1h+s6FPaBKoal5QRKLqgRUd99htdq6izyeYZRFIV3vZ+2k9kGRI1/K232LjKK
	G8NPmFGyD6UyZ9fugffO3qOB3/eIOlJjTD582yrnUdHDiqYkCLv0LHcOad/J9pQLIOKo
	HZa+EEG9hhg8U/9aRm4ql7kO0e8illzlmlRzkA4ZSMBIPeAoqRqkP4ATB9BMxb6dzt5V
	KgOp7SnDigvAGzO8EZ6VyelcbJYRIsg3vOLpXQSV80n4l7ys799TM3FeS+EV5hidhOyB
	5H2qfpjxwBhtlZyDHh8fzTfBlfePoHp+fOsK5jgLc7PFL3tNEDyxNX3LXDxfuJ0ooJC0
	iOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NvRXYl/vjqrIbJL0BHzsmEe5eGi5MjJ6JeUBkCbtEUs=;
	b=MB5VdFvpEinX/s1Zr/RAAW+IHCGQS2e8R5sOJDQIcEVOUn3d173Y5DU3o9qwLS0uha
	WrEJKGfzmzLqriwoQ3XO/XC/9fCD7SbP0ByApk4VOD4FTjvPpLsFPts7cn6Mm9EcpR0T
	oMBIwyW2s5OsV6ubDDgGmTJHUB6IRUX3BMaABkePFGwlPKia9GNsAXPoehtPHNyWJlz4
	96NfoYJF9zEauu7BWDD4NRew/H8VAc0x5IeE1ntrqZrxmoRvjMh/4MyxPS0OFG9RVZvY
	xH1xqaUi221Z8P0GoGfq5YgBIVW7TuuSgUr4/dRmQh0N0fzqZ9V0vsWKRgMQikgnyvE0
	Bt4Q==
X-Gm-Message-State: APjAAAU+Y2g+TMEb8selWKJ5EyxTbJzApxiwNQ6h6QW+lS1aabsjL+73
	2tTXAF3HSTOpGfLWIeEoIUIYQksD
X-Google-Smtp-Source: APXvYqxmbzEIEnzdKYa1x9bbu1xT4cH937HYxQM5cz/7LW93yRQb4i3FZAsPbjyU03HhFnM4W1Uv9g==
X-Received: by 2002:a5d:4b92:: with SMTP id b18mr1498756wrt.11.1556782048360; 
	Thu, 02 May 2019 00:27:28 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:27 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:34 +0300
Message-Id: <20190502072641.4667-21-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v8 20/27] gdbstub: Implement target halted (?
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072634.f9uptamsHbIH02C72pBprCNYKz8A1YsKYPDrYgETAks@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 2fd0d66f4d..d678191705 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2239,13 +2239,30 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "");
 }
 
+static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    char thread_id[16];
+
+    /* TODO: Make this return the correct value for user-mode.  */
+    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
+                      sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
+             GDB_SIGNAL_TRAP, thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    /*
+     * Remove all the breakpoints when this query is issued,
+     * because gdb is doing and initial connect and the state
+     * should be cleaned up.
+     */
+    gdb_breakpoint_remove_all();
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     const char *p;
     int ch;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
-    char thread_id[16];
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -2257,15 +2274,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case '?':
-        /* TODO: Make this return the correct value for user-mode.  */
-        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
-                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
-        put_packet(s, buf);
-        /* Remove all the breakpoints when this query is issued,
-         * because gdb is doing and initial connect and the state
-         * should be cleaned up.
-         */
-        gdb_breakpoint_remove_all();
+        {
+            static const GdbCmdParseEntry target_halted_cmd_desc = {
+                .handler = handle_target_halt,
+                .cmd = "?",
+                .cmd_startswith = 1
+            };
+            cmd_parser = &target_halted_cmd_desc;
+        }
         break;
     case 'c':
         {
-- 
2.20.1


