Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09C8C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB9221670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2NLtgtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB9221670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48308 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsPA-00079c-UW
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:49:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsI0-0001Bg-8Q
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHz-0002nF-9P
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHz-0002eT-2l
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id t5so685582wmh.3
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=sRCF1yk5BK3cTo+Mv+zzOIGiiu+VhlStwtESYiCGuI0=;
	b=Q2NLtgtbV243T4I3RiSws3kw7L4AKA8hpmhJdDT8r6IxnDY+C6zTCNTq14Rq4qyObn
	pQ43d1qYPWKlqQ+GOw6r3XOzsGoWyuw0h1hQoXNE+Hp6hWBYEzeEzbKEQ2tcrYs4jG/j
	zUwsjEf1PsV7s34bNwS7px3EqDY6JzqNseqlwFFlAjr5kZIUAwtuzHTCaQILAaSCRWXA
	kyisifk6FoAggw+3B6RGGlVoMUhZFID3nnKoWInUl23qOiN036lq5DNEyfK1E47dMI/J
	CyfxWEs2Krw2H/7WO5L0vjeT60kYe4pvyN2F/hAz+H5qLfN5ZsWjA/g5dlY0233v+T2k
	a9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=sRCF1yk5BK3cTo+Mv+zzOIGiiu+VhlStwtESYiCGuI0=;
	b=SpdOewVLxjzXRxO5Z+X2oLCzzxPDUa4WVCsacfbjgCXyPG1WGXW8NFIzWw96qD7TTP
	GI1ZL3V3c3r874vhxXOdGNnR2giC3eBkA3tfyXdsrDCE5q/3TxoLvNGIQR8GKg0LQmVM
	1KmsASnG0IZYpyObt9koVSOucy0Q9RoDFUHtjJz2dlahbJk9kcVGXYVd3yFSI4pdSDrV
	y1TNTgZpPSb/LYe3AjidXCWX4QJu1fuI5nJ5dvxc6Wrwlh8YOWXXLB3ZnFuHlTKA0jaM
	/dcY1bR7lRxI5K8lQBzS/5PHL97ax3vWj5KyQivdbZKgOjaTwrqNl0G5hSbVD0PLdVYS
	GhsA==
X-Gm-Message-State: APjAAAWi1e2osu7rajonS2G8mYZybOTmPVhVBNT1zkRSG/y0dCUrp2pA
	ZiuLIXzIzUSP7HG5R/37QR+YyNFE
X-Google-Smtp-Source: APXvYqzTzNaNkNr5phj6Qs7JHzDMWEHak1V1APAXUy6OzREOIb1Wzlz3yNaW9lZv+vZQnNCZ3QR3AQ==
X-Received: by 2002:a1c:4102:: with SMTP id o2mr5555053wma.91.1559112138047;
	Tue, 28 May 2019 23:42:18 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:17 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:46 +0300
Message-Id: <20190529064148.19856-19-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v12 18/20] gdbstub: Implement target halted (?
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

Note: The user-mode thread-id has been correctly reported since bd88c780e6

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 80fe5b2d0c..a474f2c755 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2265,13 +2265,29 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    char thread_id[16];
+
+    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
+                      sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
+             GDB_SIGNAL_TRAP, thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    /*
+     * Remove all the breakpoints when this query is issued,
+     * because gdb is doing an initial connect and the state
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
@@ -2283,15 +2299,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.21.0


