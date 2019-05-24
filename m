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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4ECC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7343C2070D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pE5rdpaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7343C2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57117 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCuc-00021I-I9
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:19:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdt-0004JJ-Vc
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdr-0002Kb-VW
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:02:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdp-00027f-Ry
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id e15so10568925wrs.4
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ni+e0LhW6YWUs24EBh3Q0RNwpZ46aTDH74CutNl7AtE=;
	b=pE5rdpaKqOR5Acs7ZSgEkGFaq2pAHBT/ugrZ47t+/7ac0dBOTEL8mNRbL4mr1qYOj9
	TRbKAW8Sp1nyBCOvvnxnfPswK1Y/u1je+dL0KYzADbPGJBW7zpBJMA7K45FpeUQ//q1m
	Vs3E6faxdfIt37F7vEcK3l+Hkg6nZCHZ+8KVXSYu2QKq1SUGqSA+/klN2sm0lhqMMh6c
	dBhWVpwj+ZhD2wttecgmOIPOiUG5klrGnyXz9GmnIezMKpfnaEbZ46Rnl8pLG9OV3fOg
	+nWeKzX2OE+i/W623TED8JfauRLPQxK7Htmthbmj09tymkPuGFtnJtetjKIIXXI1uQzg
	5hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ni+e0LhW6YWUs24EBh3Q0RNwpZ46aTDH74CutNl7AtE=;
	b=Nd5Gwh2oCOOxfZ1F653hlILC/30KOMI5+uChe6r6OJoPseBC3ijaGoU7UVgmSY1J5k
	H2SrvaSBGlywsf0yTUxzmKDDrENbkZkhggIKEZxPzOfkJ1gXfHCNs7VrtpaGlVX5+NBq
	yDKpUa/PyAD/tSKrdnjlUrsIgs895sSwEL68GX5yV+AzbxHIyKZ2hCDpupYER7P3v/tG
	/s1L/Zm/lRUxsMCTy9qC49uF3LTVBJpzmdOcpXZDbQ9yf7NDFs7bC5v2+NCrK8QAMRDB
	Fdopj8RjNNA0poDPbU6yIkVsqlRxGIUGbExMvAIUTseMLUM6TieP8axxAEGD2tsP8Oc6
	Fu5g==
X-Gm-Message-State: APjAAAUKJXeMJ+UArDvqTbFObsy8rCD717axa/+v5SIsbSBM8Wb2d4Wa
	c4g76VG+Lz8Hn41od7eIzMrqcnbf
X-Google-Smtp-Source: APXvYqzwlJ84LqaWNbnbyVmNlDeL/dIWksNtBTE/XYR1LRDP4x3loR5Yr2FJ6gtmtIvaXKZgNn6mBA==
X-Received: by 2002:adf:edce:: with SMTP id v14mr59554670wro.94.1558713706693; 
	Fri, 24 May 2019 09:01:46 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:46 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:12 +0300
Message-Id: <20190524160118.31134-15-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v11 14/20] gdbstub: Implement file io (F pkt)
 with new infra
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
---
 gdbstub.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 781f5882ac..b35acc679c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1775,6 +1775,25 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params >= 2 && gdb_ctx->s->current_syscall_cb) {
+        target_ulong ret, err;
+
+        ret = (target_ulong)gdb_ctx->params[0].val_ull;
+        err = (target_ulong)gdb_ctx->params[1].val_ull;
+        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu, ret, err);
+        gdb_ctx->s->current_syscall_cb = NULL;
+    }
+
+    if (gdb_ctx->num_params >= 3 && gdb_ctx->params[2].opcode == (uint8_t)'C') {
+        put_packet(gdb_ctx->s, "T02");
+        return;
+    }
+
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1916,28 +1935,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         return RS_IDLE;
     case 'F':
         {
-            target_ulong ret;
-            target_ulong err;
-
-            ret = strtoull(p, (char **)&p, 16);
-            if (*p == ',') {
-                p++;
-                err = strtoull(p, (char **)&p, 16);
-            } else {
-                err = 0;
-            }
-            if (*p == ',')
-                p++;
-            type = *p;
-            if (s->current_syscall_cb) {
-                s->current_syscall_cb(s->c_cpu, ret, err);
-                s->current_syscall_cb = NULL;
-            }
-            if (type == 'C') {
-                put_packet(s, "T02");
-            } else {
-                gdb_continue(s);
-            }
+            static const GdbCmdParseEntry file_io_cmd_desc = {
+                .handler = handle_file_io,
+                .cmd = "F",
+                .cmd_startswith = 1,
+                .schema = "L,L,o0"
+            };
+            cmd_parser = &file_io_cmd_desc;
         }
         break;
     case 'g':
-- 
2.21.0


