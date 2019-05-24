Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB985C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C0320675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgh72pA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C0320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCrM-0007vG-N6
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:15:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCds-0004I1-1C
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdq-0002Hu-2d
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdp-0002DJ-RA
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so5685756wma.4
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+NF9Yo7d6jp3qeQ6UNfGvcDfxpGOYkZyN8rNP8o5Qo8=;
	b=Dgh72pA7oISYq7pA8dc4iwSQaKR1MkJiMuAOvEuDiFl12N70c8FVzOe/uowyB+k8H1
	a/3OvDHFxMjMmdR5GTK3Tz/YQPsZEv4Q6RGsqZXlmJWPMivZdH6/usqIcDi1/ioTI/A+
	hOkkHD1ByDpQ2n6TKTKUkDXBCanENaYzzq0v26zhR3xGKwYhOp0A8XHUke7P2+VyFIXN
	+VusM7iE3i6rT3olxG+B64oFuuHoYalPKYVqKZFukIdVrqG6uCL5G2cQfNG2uCrmk2aV
	tDS+mwMRRmM1Y2MyiUbdBY7egxSmoeuLAaZ5grMmdaw2iaiT6bGkAzY0Zhm0IT3ZBpbi
	Dd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+NF9Yo7d6jp3qeQ6UNfGvcDfxpGOYkZyN8rNP8o5Qo8=;
	b=kRhd0aeDMB7EPuH3h7euLcpdgjraAcnHrNFJIjb6eA+038JOSGgpC3NPZecNe9DBqv
	stCGLXI3qKIegQ+oe0lDfffOqaW3PCe0RVAqCfqmy1NNpMOmBSxBfZm+HP3zyMXn1WSe
	ntOERnRbanmxvDY5IRWyDBhXtDb9X0WjEy2itWH5O82a9UBCZRWl5fIuhALuxES7k6Qw
	DL6mHo56C8nDTeu/P7EaxBHgNomZZG2AE+OiUP7htDox6f1VjWtKr/LRWDWQNMApg9oA
	XRbKqb4qBwD2qnlATLCuwRIyG94WSBCApo0YsejflPmNfSuExOEVOgWMkZRjX3x1+CHz
	ICNA==
X-Gm-Message-State: APjAAAUVgk75qjfTHkQjOVJBxucZ43QE7BDgC0jwU6BQCCYKfeEfLjNX
	9J8D74FkIOhIWDw6A5dcsKhpqd9B
X-Google-Smtp-Source: APXvYqwcPlCCPZvVEPQpIo4dPs+YYXfSp7eORfiWC8pjxZKbXNW0Ke3HjqlFn5ArJ4lchXqCPafDCA==
X-Received: by 2002:a1c:c016:: with SMTP id q22mr15816329wmf.6.1558713713214; 
	Fri, 24 May 2019 09:01:53 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:52 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:16 +0300
Message-Id: <20190524160118.31134-19-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v11 18/20] gdbstub: Implement target halted (?
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
index 57a05fd6a4..097b7d1231 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2251,13 +2251,29 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -2269,15 +2285,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


