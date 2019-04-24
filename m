Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FAEC282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894F921905
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si/a1coB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894F921905
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ76-0003c7-Do
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:43:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzK-0004qG-Vc
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsC-0000g6-Ib
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsA-0000Zl-Lt
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id h4so25451006wre.7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/4p/9wcjPsGxuW9B5wn6ecQTpKHg4IUyF0xkxjHpH00=;
	b=si/a1coBSDVL/q591ChAIH/FO1qsiCdaLHP0PtqfA3L9R5ZU6b+C7hEE3VzHs1NuNB
	6oiHIrAxmY5ER48qcWgB9LQTefkTYguj8RQ4Ew5y3f7uxwD/oLfspBdo+4Y6yVMHfbTt
	/G2Ba64loPklftqeccCrfg9/JuCykJ/HuZJGr9qXEREAvuCHgcfB5IyUjilqNc2HYX28
	5ao2sz/TKrS/1iUyklIR7Gsg072ZxuERG6FWX75tgWMQjmFdPtBXGbFAw4oYxy5vEgnI
	EVvv4ntgn3vsQ4MhgNwHZZ0zzF+9jQjiqGWMMWTE4EWaP8roA7PrkXjw5AqNXl/jN5g3
	JNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/4p/9wcjPsGxuW9B5wn6ecQTpKHg4IUyF0xkxjHpH00=;
	b=Y33YmWKRsc71J2rTwyQMQPnOkkT85JJzefqmW1D9BmqJOswijZKInW0iQ2XhZ5QbQi
	3Cx2yQ+c/m84V+jRyzd30PoMfLtQGWmlUDmX7dyRQVKYMEF9Af28rWZCoPgtydSM8Oyw
	/wr0+rN1ubVvvbLmhO5cs4auEor/4soSqI8mVmQRTrxf+XH2IZjKfcdmUgPYe1Xbr3kh
	JS9E5CGrpFkMWdOgv30JlTtKycYnHCkKc/G0wApBdypQNWWwX5yZuGVZ7nmB+o5ONUHR
	WcPk7LSof4GVjgke/MBSOoRq33ELnlFx9NukgCg6+AhcBu6K1We/Z4boFKEohTGmjfjU
	cA9w==
X-Gm-Message-State: APjAAAXU18nUchsDPUumDFG+gZkRtfRkiKhJqA81PB+B6ypufOr372AG
	+twSggY4/ENmpaTwBUVPWOSkHF2Z
X-Google-Smtp-Source: APXvYqzPsZ6ClVop0xZawH8FQ4KUaY2vN9hGoQ0qEqGTiK7f0zQ42H7u/otYslYPiMP/ytYk2RVZug==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr21332814wrv.19.1556116060154; 
	Wed, 24 Apr 2019 07:27:40 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.27.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:27:39 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:03 +0300
Message-Id: <20190424142714.28460-9-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v3 09/20] gdbstub: Implement set register (P
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
Message-ID: <20190424142703.Hy8UKNc8sOAw-RvJR-wbAhUn1XtKf9IbkXrVW1fTKzk@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index d0b27da518..674370a60a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1650,6 +1650,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "");
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
@@ -1893,15 +1914,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+            static GdbCmdParseEntry set_reg_cmd_desc = {
+                .handler = handle_set_reg,
+                .cmd = "P",
+                .cmd_startswith = 1,
+                .schema = "L?s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &set_reg_cmd_desc, 1);
+        }
         break;
     case 'Z':
         {
-- 
2.20.1


