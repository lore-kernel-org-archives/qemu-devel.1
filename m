Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8171C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B097B20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGAW++dN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B097B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM763-0006yr-T4
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:29:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-0003V1-BB
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ta-0007yj-B5
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:48 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6tY-0007gt-BO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id q15so1477341wmf.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NvRXYl/vjqrIbJL0BHzsmEe5eGi5MjJ6JeUBkCbtEUs=;
	b=hGAW++dNphmEM4sCUbSRvIoH0u+r41+sd7nmMYfGM1e370ZX4TfZPly+IIi6ha6Ti9
	uHkoDIeaHGclEdiJfF+0VJp0A+YsTKvV5OT4/i2LSDcE8Ggl3n0WtyHPngBnY48L5Yxz
	H2qUyG5fl+LV01TX3CiPrZMJz/rsEEXTfaft1p7FDPEg7xAybCEpc2bvcSLZN5P0D0Wv
	kvsMYcnR+CElDBFlIXs63GO9qjWgNpkQo9zvrMpSMzuSeHTKxO/+vNqj7nGlGwwHxzGE
	JLRzv2CGg1fFiA3PqLt2hglbZePwNQNG+jwfxO+aFsqAuoS24P0fAmgjjyfskEpF5ZOg
	HaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NvRXYl/vjqrIbJL0BHzsmEe5eGi5MjJ6JeUBkCbtEUs=;
	b=thRieGEYUemvY5StpcQUcerpJ5sR7ltryyXMnzb4jx0xvhQEYzjHT2TL8wSZgWIFus
	erDmZ788MO3jPUurjoukpubZExeWvLh+5xK5FqBctx3LTcATuuBJMY9loVpE3m/eBI4A
	U47ThCRjOyxetS8jQwhnImKt7sLDLsXPI7v5iSJsEmwqycZg2p2/KoaPfEe5gr9F2St8
	ZhCA7Ez2BZPdWs9kude5YNBVbuBZkN3Pg8XDBT6bBTDxS9DQJKKFQ4ud0rTX9YYLGQyX
	SxxdjewuEE+ooddxy8q+MrK9NSyprOeeb6Du/x4ezlzGiq9Z5GSpsBwB+yEvIgBzbWj4
	unKQ==
X-Gm-Message-State: APjAAAVDcsDpEEUIhIjkAKiiQTbMrsf4UHCLPASfGCGd+n4nAPGhDMMJ
	KgqlvPDvOgsP2Aim8NIlU+QFuydD
X-Google-Smtp-Source: APXvYqzsb7UfgQXuITPyezrterGBVaGwZjxVx8+4IhCutl9KfMIE4RmBklg+eCntDHTRsuQReJszZg==
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr1309991wmf.87.1556784998784;
	Thu, 02 May 2019 01:16:38 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:38 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:47 +0300
Message-Id: <20190502081554.5521-21-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v9 20/27] gdbstub: Implement target halted (?
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
Message-ID: <20190502081547.oM4k2H4qS4NRCt_2Dg_rnDQatWL_VCBHXELZEnFqwL8@z>

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


