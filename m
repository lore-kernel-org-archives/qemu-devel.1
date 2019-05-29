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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6CBC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DBB21670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFbCnDCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DBB21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsJV-0002DQ-7G
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:43:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHr-00012V-Nl
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHq-0001JF-PS
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHq-000190-Jv
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id e19so3627106wme.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=e2K4Chkj3TNfvRg6bH2FBwRgCjBJSljoXPJlT5yCRqs=;
	b=gFbCnDCGgE/+VIQf5Saw5AM5qnVCzEIUd1yKQQ49dZe643HqfdBAWpkDfZtamJyGNB
	z6irEoF21j4w0vuqvnPA2CaeKvDFD1GLet7X9YbMW1HkPH7Kpkhy1cKNYW8sjVKpLr4F
	SMCJik6g8K97wbMC/Mx5EYh2gv4LMFHtwN0yZnCPl8zDyEL02onKxuVH8HXwKYo/OxSy
	w++S7M1DBGLqj81aT0iZrxFZC/XAs6VYFd2Wkc8X9mjSws68U05dHv8QEkj84FmgY+Vd
	LEoGTLBN8lPzHVBpX0b4+5VyHUZiStZ/og//gC/5o34Ls7NE5Yx/PvoHqkA03VK5bHyp
	QlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=e2K4Chkj3TNfvRg6bH2FBwRgCjBJSljoXPJlT5yCRqs=;
	b=NRK5h62ZJRB3BwlodnMIwL3Df5XWxhxlKvUZLkvG4VpaUE5PkOyFvAa+fmisa9jrzS
	+tHXmU+0Wpv219ViletRHxpHoXeJP2pBP8CFdP8FW1AGwOopmEorxUt8uljPu535mKRt
	CODHL5AvA5VN7aswgD7S5nqY3WtRnkEjcKe16XI1SkpSYJk4a0d1Sp1U6z0NAbHx0DOd
	/JO+9iN7Q9tRHp0itNbDg0iNo30zIjDUS0tVqG0gsQMalUwfQK63F1K9yA3/gXikSlBE
	xLsXpXskY+hhf20pNA/npHDIdm/RyolP36JVjxX6wdQz8X0ZZji26EnjOOMH7XGCRto6
	0E8A==
X-Gm-Message-State: APjAAAVop3+XvpD61x5ytBmL1tweYPfAfrpLJAZQqPRqRwIswzIEdHhP
	uhVvWQ/ll7ZOgBh3ly319N7eYa+n
X-Google-Smtp-Source: APXvYqy0SJUqRoVgTkHZUYOdZjdGos+nyVyWClU4q7m38iUgdLzp9b3sd74gPOghQizOFczep20H6Q==
X-Received: by 2002:a1c:7001:: with SMTP id l1mr5904440wmc.40.1559112129585;
	Tue, 28 May 2019 23:42:09 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:09 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:37 +0300
Message-Id: <20190529064148.19856-10-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529064148.19856-1-arilou@gmail.com>
References: <20190529064148.19856-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v12 09/20] gdbstub: Implement get register (p
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
index fc9526b3f5..07740ec0af 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1672,6 +1672,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1901,18 +1931,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


