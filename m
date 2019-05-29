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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3F3C07542
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A17216FD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7g0XgVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A17216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48457 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsXM-0006Ui-Va
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:58:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHq-00011p-Ri
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHp-00016r-T1
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHp-0000zc-NF
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id m3so810809wrv.2
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6BpSj4VncrNQLULTrP7ZGJ4fogVHX3e/cU14TJAFSE4=;
	b=c7g0XgVF7T8Uz5xGPd9s9zd+evaxonHXiJ7gZGCnXlMeqOvciRdITgydXIlxjxnEMH
	0hqcgejs3WlnAoUA566B4zYdwsIcc4TuilnBDMJu9hmlVzDeDx6ImFNGatBeT9JZg4J4
	9XebHEmzOj2ZM5LKJwyKLLh8ZOnFbeF1XwIEwkRobbkqJHKw6aYbXkcnKOgQsZFugRyB
	+IU+U4vYfNKZdSwlzTIJYrhs5/w66ZDzQ3l+nv2CejoAYfqoN6l2l6tka5SxPjGLbO9H
	N2oSTcM/v0lQ4d2sUuJWWpXlt/X/fbkxf0jw6LH8sP+jpefCkGx87KJ7+g5j9r+c6QAp
	l4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6BpSj4VncrNQLULTrP7ZGJ4fogVHX3e/cU14TJAFSE4=;
	b=oQFd2zrV85bIpe6wkHrJqpeLT5qHLaf620mK25B3nN3LcRo0DMubDIEmnjBFbOWaf5
	tjX6XuvAtpP+1WTyHQ6rw+RGFXU3OIsiz9ep0bs30wNosD8QNwHHn70lrEUvq7TyWz2c
	r6tX1qqElUJY25H3sr+ivcjye9WMAS2i9CTQQDEqp/9ygHMjk+lU9n8b9sVpfYNJbeTm
	QN0nkGQF+sVzyMzyPutYsKbvICLTvnmIfPitJabDKfceOs+bu10xgK0aXoG47wH2UGPr
	0X6MRcBrNAR/vKf/Yc0+SjILYpOAqSMUFdc+VMSKF1BVTzGt4Q4RDfg7VYJVdObx8ApY
	/Fuw==
X-Gm-Message-State: APjAAAWirEUHEuXVBI6qmRelaCZhdfCubvVTPUnnkMjHKPUppgoJFAb8
	RKkDORLkLtv84YODmVE1sy7aHBaA
X-Google-Smtp-Source: APXvYqzHvmi3Rdjp+2e69VaVHMji2I/ThMvnV5qppVrkQQVz4MtRoTMCbgWAXxSystkZ3vZD80eAUQ==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr13310735wru.301.1559112128686; 
	Tue, 28 May 2019 23:42:08 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:08 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:36 +0300
Message-Id: <20190529064148.19856-9-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v12 08/20] gdbstub: Implement set register (P
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

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 572222bfa4..fc9526b3f5 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1651,6 +1651,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    if (gdb_ctx->num_params != 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    reg_size = strlen(gdb_ctx->params[1].data) / 2;
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
+    gdb_write_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                       gdb_ctx->params[0].val_ull);
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1895,15 +1916,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'P':
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == '=')
-            p++;
-        reg_size = strlen(p) / 2;
-        hextomem(mem_buf, p, reg_size);
-        gdb_write_register(s->g_cpu, mem_buf, addr);
-        put_packet(s, "OK");
+        {
+            static const GdbCmdParseEntry set_reg_cmd_desc = {
+                .handler = handle_set_reg,
+                .cmd = "P",
+                .cmd_startswith = 1,
+                .schema = "L?s0"
+            };
+            cmd_parser = &set_reg_cmd_desc;
+        }
         break;
     case 'Z':
         {
-- 
2.21.0


