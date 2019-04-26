Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C0C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6075206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8jtLmGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6075206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsoJ-00025E-T9
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:50:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmS-0000dE-Ss
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsbW-00051t-5E
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsbV-00050J-VC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id y5so1352434wma.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NvRXYl/vjqrIbJL0BHzsmEe5eGi5MjJ6JeUBkCbtEUs=;
	b=o8jtLmGMTg/j6FrH5qMGrYRokarNWfduHVYdcA4l3xtFrJBSYzcinmoONSD8seG9QB
	wuXP+t/2XlqehNvAYQouCzK4pzKeKriAVJ1y/zkVbCy20DQFmu2W81ZOxPcKcfqQ4nvp
	5fokp5lUhWW51b21kUDLpdFh6aKM1/yYMPGxTuMZmAIIOzQO7E0GaosfQHcoB8laTKwO
	sfJ7StEZxVMPZNLBpbT5bqLltehh0cOy/Q64kWxwNQjgHI53xHcNaH+38W7AqGKIlgKQ
	IjdYboGyD8uYDBGJwLKrZl84x267f5EwjiERroq5m0tqyZa61AxSpvtsAHdq7IxTZDUo
	ngaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NvRXYl/vjqrIbJL0BHzsmEe5eGi5MjJ6JeUBkCbtEUs=;
	b=q+Gr+gAOgLcv04i27QOs8yn8XQ7JvXWTAe7Y1xSh1HTbOqYkBnBAMrKDYKTfy7MKL4
	BwCaEJmy1PXu6RJSluZftV6Z2cpIcuFDk7eTUMSjLjtBDAzAS3HbcJ4NaJoJuD3Wx80g
	kor8h98Hyhx2KABLywv+rEzgToPYQeM2xrrZ02VLJwJMTCkn4f+88lxfbSuyPoDZs7vi
	wRFjXt4aXTSl47HRudRxyfot/wf7mn0BIGYQMPxZ0NGmO34MCORgCtWlp1EsSJxoY075
	yT/7At01eNcF7m57ZlXzngpwGSD3IS1LATCI+wJ0xfcpXXq2GqkE0rPDo9eDA9Vokd+i
	CCAg==
X-Gm-Message-State: APjAAAUSMKIvhdagi/Otal9VfA+R3NtgbizDXC0h1Z/IdTpVnhJxafOI
	Vc5dsITO3FSLBe5u+TTwWg2/FTZq
X-Google-Smtp-Source: APXvYqz0YHwHacXZGEZGCrgf/kWATQGqcMYEDMdTRX8XT/4inL2vVcroUITGoNCf3bA1lcuLqizuNg==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr6298258wmc.117.1556253412396; 
	Thu, 25 Apr 2019 21:36:52 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:51 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:57 +0300
Message-Id: <20190426043558.6888-21-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v7 20/21] gdbstub: Implement target halted (?
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426043557.U84YhsN52APRoqWu-7NJ4Fix6GRvtRyhCSwLAOBzwhs@z>

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


