Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6567FC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4B82077C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhfCzwsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4B82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46531 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNza-000891-Ba
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:55:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkX-0004BL-3H
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkW-0004Sf-4P
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:40:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNkV-0004SQ-Uh
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:40:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so4176870wrs.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vbRIrSe2/0YQKchHifA9WtEnR/rS78BpaRVSv6nPF1c=;
	b=EhfCzwsiHbgEXsdH7sh+2VwUex2Ki9uy1apXkhbgC8D9lEgW4a44pHJ1n8FyjP7gEu
	2IiBIYz5/1kTm+gq9C172GxmgfQcSQBt6qAo8CIXuDgC6hPc018ysk57H0ykNsLgT7C4
	NKf3KHz5xoWVQfSywR82MXNQegqNZbynQHrXgUyLIH0wWv93RyZOXSQbbfhwiENQ+zqx
	+VBiLDnDoQ/7kXdIAx+CTqx4M951hC6vAggGiRqHVXa6ZFjs4D0E/BAnkRwzu0q2BolR
	3wvAUpaP8Qtat1cMut5i+dN/YMlpdy2Q8plW5NQftSd3hHgK0c7iIiEbHAfS/N51Oab9
	ujWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=vbRIrSe2/0YQKchHifA9WtEnR/rS78BpaRVSv6nPF1c=;
	b=EPQRL2nOdxam7u5khut7IaBb1s8Zt/gvH+WuAaiSXK8Jxmkymeshfnacu3BrLupRmH
	NaOgXUax2PB1Za01Lh9bP1whg885zqRllB42utE67QxRVF9bvlH/KlLZWnDefYVJsmwI
	k05PULr0OT59VAYNx0Be0nM6vH0+HSUfKFHcj7sn5wy5uE4emhJkZw9aWDZRieUTMjCy
	4lAamULCC7klJ5CeAiluPFFFyOrphd5oixnuIU+8NfGDbdxnLsT6GAFxqNuoWIF7FVqi
	ZofNsPvrehzoxNKOCmG4sPjxt2GUjHcnoqHL1ePgX4Mst/lVtWA+IGpB1tkpTa5jcjVC
	03OQ==
X-Gm-Message-State: APjAAAVqdvvzNE+cZJ+JZdumrJWtsqAc362gTwhivrPmr1Qlb8PwCrkp
	kzIB0VZvcEtfuql8xtD0debWPLFH
X-Google-Smtp-Source: APXvYqxuRhrkpFds2JNzoDF+Go+EBq+kUJb/iRWk8utl+zarpqhf0zGV0qm4JHn/j0o9ChDrNp+6oA==
X-Received: by 2002:adf:ee8b:: with SMTP id b11mr12106162wro.123.1556134804852;
	Wed, 24 Apr 2019 12:40:04 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.40.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:40:03 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:58 +0300
Message-Id: <20190424193859.31817-20-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v5 20/21] gdbstub Implement target halted (?
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
Message-ID: <20190424193858.2x2kU6ktcjyn4VPrwX5HnIEcLwhg1UkA6NejI8Lucxs@z>

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


