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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2006BC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24C820675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBX4tcJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24C820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCjY-0000CD-4b
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:07:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdl-0004BF-OS
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdf-00027l-F4
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdd-00020y-GF
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id e15so10568581wrs.4
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=V1QVJ4HRbWCoEeLavvf/S+Qb9vILZOoid3DZnX3FkwE=;
	b=ZBX4tcJHGTry1Bu9qVmKJpuvDByKRheKsqPHCdmQvjj1P8mnnqET7KtPjxkV0nLElc
	og0sd0BlZJDi8bAi0outphE6d/gz7TuMjoSkzbIXPgdWqCwRDKogX4aLPjHPdbmFNhHn
	DqjtxBg+zZ6VmuhKXxBjOPaIrxJ2eBg47vQZxKkfMx3VxN5rWWGem6KAerAsKedPGP/s
	d1E7fL6wLuEzqyu811bixBY7kWeAsu4AKGfzHoJ7tRiY2F3JgeJQKn0b2xNc2L/TOYPY
	tUm4yrQDWUxuI5Pe17XDHioxDaD2YaU4xXKEwV+NrLwbcGkOPaJCt5RrznfCwSpDfBsl
	M7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=V1QVJ4HRbWCoEeLavvf/S+Qb9vILZOoid3DZnX3FkwE=;
	b=RueEqRc3KJk5wSbq1jO+k6/rGFEs5lwdyCynBZIBlskJu11zfSnspwJFdomGlQjDnZ
	WrC1YRMVIegU92CL7o5zIj0heJNkJdLwd/2n32QbiWnU9nZP194Q1M9YxBU77sR09lUg
	jyzIUdl/jfL545g6g5vEgIOBS48K8yEKn1uHo0Q1mmKIqzs2nNvzlr/73An/devvy74n
	DTlCKyGBqP9djLMOmKJKhowV5nR1z8LiGVDOq0TocsXdmMeRRa6p3vIFvPxWVEYLGmmS
	BcUrQ9ArH16fU/IJhWgktnxtXzJNZgSyKh5HZThTRv71h/VyA9D+MMk6+8k/LsKlUhXB
	RECQ==
X-Gm-Message-State: APjAAAVxgaJLO+jrXex0DF8afI5VAcNrhH9/2BRycPo4at3kfJ/nwU34
	kJGzX2+f/GcbxC5xmAYcOZpeRn6w
X-Google-Smtp-Source: APXvYqzLkTbyVvcULAjgs1kSo/ViyYQZxjmJAqArI1HLp0gtLXqqYlun63K15ghHhW/9z9eTPxqVfw==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr438118wrn.109.1558713700882;
	Fri, 24 May 2019 09:01:40 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:40 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:07 +0300
Message-Id: <20190524160118.31134-10-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v11 09/20] gdbstub: Implement get register (p
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
 gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 1c210d671a..3284b3e01d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1658,6 +1658,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    /*
+     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
+     * This works, but can be very slow.  Anything new enough to
+     * understand XML also knows how to use this properly.
+     */
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    reg_size = gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                                 gdb_ctx->params[0].val_ull);
+    if (!reg_size) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1887,18 +1917,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'p':
-        /* Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
-           This works, but can be very slow.  Anything new enough to
-           understand XML also knows how to use this properly.  */
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        reg_size = gdb_read_register(s->g_cpu, mem_buf, addr);
-        if (reg_size) {
-            memtohex(buf, mem_buf, reg_size);
-            put_packet(s, buf);
-        } else {
-            put_packet(s, "E14");
+        {
+            static const GdbCmdParseEntry get_reg_cmd_desc = {
+                .handler = handle_get_reg,
+                .cmd = "p",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &get_reg_cmd_desc;
         }
         break;
     case 'P':
-- 
2.21.0


