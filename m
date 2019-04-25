Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ED1C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481C82067C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj2ZYKeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481C82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJebC-0000xl-Fd
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:39:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQS-0000Yc-S6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQR-0002BB-Ty
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeQR-0002A9-O2
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id h18so10619551wml.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vbRIrSe2/0YQKchHifA9WtEnR/rS78BpaRVSv6nPF1c=;
	b=Wj2ZYKeEYhvs0AbLnRezIJjZr0ZEFn8VJ33D/V4kbcQD11GEKR7FcRxrULxFmrF+xt
	M94RT8ihBXgCCjae78FFh7TQqA7miZ7wWquUw9Vxs5MPADcwDQmM0peafGFjPgERg6CU
	/PCNPfECo9mzeLKOWGYVZ0X0DO4h3I/dey/hZzy6TuYK7B6jEB8ipJ/sNObE40T274LE
	yG45IL1NRvss4COJbJk+DNZLK9AlJ/VzwgiVoY7U4tU7Uyg6G+c45FsroXIxrKCtRn6V
	7Rc8hYe4tT6tpTS7srrTinxO1hSoTgL3s5CfQt6jlvOzXM9rvrEcunL97sYBlj+cWqBt
	aORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=vbRIrSe2/0YQKchHifA9WtEnR/rS78BpaRVSv6nPF1c=;
	b=Dr+DOl+S+JyjVZKjjzKIt3zMxLJtQt8F9wMsl3TmbaFLrjgXIw1k45XdHe9MYDyDcR
	b9Qy8MnzQbAPAhcpROxLuHSP4e/PshAtLO9XunjUKVdSdcemaetFTf//TlMwiOKJWDFe
	N9CH3vDsDAQef5YRe0PqVjHa4BzbRvWhDdENkAAlO+OWJHg9H6hOLyrt3w7UTOGW7UC9
	2vHnkdv0VBx/ue7e1SEndMXBENDiZTlF7lL3uNGDn5sRufZYGv3w5DUsBp7gHPPHRyYq
	kXvWmcxzqKANj2456ApSDO7ruaaJVLo2zrQi8dFSgSwo9tRoINJbqncZqXoKdBgYrXYl
	tn1Q==
X-Gm-Message-State: APjAAAVvVrN+FA+hBI4Hv6uuTi2jgyruCxlopZBErESHqQL9rM67obS8
	cX6Wf4IX+xFTYNci5v3xvCzjfX4r
X-Google-Smtp-Source: APXvYqwwSE4tqwjute0/qYP9NcDdKYzm40aQAAhd44fjUNtZEFUxqSi6LT3S8AejQIUGOOZhIvmpag==
X-Received: by 2002:a1c:9e96:: with SMTP id h144mr3749144wme.33.1556198908867; 
	Thu, 25 Apr 2019 06:28:28 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.28.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:28:25 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:35 +0300
Message-Id: <20190425132636.31636-21-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v6 20/21] gdbstub: Implement target halted (?
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
Message-ID: <20190425132635.a3JgWvHo9e3RJeNIZ8oi0hKPb-ZCSh6ZG0A0PFLuDig@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 779da2aa77..8838241209 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2248,13 +2248,30 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -2266,15 +2283,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


