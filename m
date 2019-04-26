Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500F3C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203E8206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgmoqyCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203E8206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJt0i-0007KZ-AC
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 01:02:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmf-0000dG-Bz
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsb6-0004WP-Db
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsb6-0004Vy-7S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id a12so2410826wrq.10
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=C5wVxSSu9B3yjrVL1kbdSqghY5biwyr5/S2ykkoUubY=;
	b=kgmoqyCIYRjiJsanjHfvhXOXnK9d/A+YXxNeDoiohUdikM5ponc+AdUmcqfFV0d9Lg
	wXhed/bbYuy4xwLvftaNx6EnFeVvc6oEnvdPRd3Y7HZX18CN2BpyU1DEw379xd3JMmg1
	IGEeYM7fAFj2x4xKY7gKDli7mNC5WktvIZSnrzp85E0/d+pLsP7Kfzna/PhkmnUK2hix
	gTZf9nP4UFExxdIPi8edUKmRf9ghY3p0ZMKtmYCsJh5Wv/KXWBoZIISCilrogmYfr8hA
	+jmTPHmVqXHGl2RsJPWyUIakReK9aLJKXhBS4o+cEb1/fUsG3Fgmlk5BG5cJYHsPd2CY
	/Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=C5wVxSSu9B3yjrVL1kbdSqghY5biwyr5/S2ykkoUubY=;
	b=ucJZAnULqCkGZPcxuPQZo+JvQHJEawa8+fGQLTwH/QPN6EPG/yxLKwY4Q5zANjC5Wg
	VV33oCAblT6WQtVL5bNUtHU1VSQUVY/tdoskJolsCMgmO3Mh2qXrZhj5lXS1zcm8JrKQ
	pyARvtnThfgsSd7lGEeN/+JMr9bdj5hLDOzgC42JJA16JnN80n0TAKV/mHIi2LFOkiaU
	/wSvYKHfdVc4y8l4b2+mlo3bGNvxFgvg5G/RfBCCpPB8BuO6VAqDg7NOJYLL32Mf6bzY
	JYdiByYM3vSaMwkF+K+11FcltnpetO6s0IdPNB9T0v+5W5d5hMHsjdfTed/JOQPTmwni
	bDjA==
X-Gm-Message-State: APjAAAW9KeNbRIrQajgRYztiP8Z8wnTsuLoSxd2ExeO+pTSwz7UYdGcY
	FQe2ul9+DVOMMhvlXqqp6+v/SpiU
X-Google-Smtp-Source: APXvYqx+6F/TJJBApYN5dKwOVuVNDH6IEpPXTv0lzsS6nGUEOONWZJwyF8rXeknJGbQrgFfAV+oeGQ==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr6028705wrw.58.1556253386319;
	Thu, 25 Apr 2019 21:36:26 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:24 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:47 +0300
Message-Id: <20190426043558.6888-11-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v7 10/21] gdbstub: Implement get register (p
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
Message-ID: <20190426043547.qLdHtt6A2sXpS7OHaO9ggdyiLaU68bOgepBQxX7Z-nM@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 10e3f12a68..e9a3d0c2bc 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1655,6 +1655,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1884,18 +1914,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.20.1


