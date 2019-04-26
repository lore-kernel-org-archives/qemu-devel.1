Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96EBC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971E1206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr7LuTEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971E1206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39370 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJt38-0001Cv-UX
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 01:05:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmg-0000dG-CG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsb2-0004QU-R0
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsb0-0004O0-T5
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id a9so2450279wrp.6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=U4fLhEZHxeWF7Ph12MqOmpuk/185Eq0Ogcw/FW+Pwwg=;
	b=Dr7LuTEp2/fDoRkLxFMZxphChvNFuBUshR8Fy8eNpE7AxQKfDJJdT2YcTEoNlA2ml+
	+cW5z6JRGUT3UgWBSdc9pyJHrb79Y2Tamqc8lBGZoYgaxkZOL3rufHcRgO+OLz7/Xq97
	TOBADuVyPPslF5ox3/P7KLRXx1XDzb6+Lk5uqICA4OxnomqBTl//gZvKNQqFUxTUJ/a3
	v4cslLh1gkI/91qDk/wNnsSUQJZoBnjbeJrc2SM31YlAvqqds6HWPm2RDhBq6ck14u1o
	Cd96Qdt6PL49aAWVW7gjlFHJWvDuU9uoorYxs2zRJknCpp+/e/sESYK4pJNh2GrrELm1
	1Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=U4fLhEZHxeWF7Ph12MqOmpuk/185Eq0Ogcw/FW+Pwwg=;
	b=rqVlKU6iXp/5o+uDhqxWvNErQmTPImo+68PCu59guAcHIv7/9epeADPxEL39Ekzyok
	BYR0GVd26yjZVG/YE7qvWuXKgQrPa9J2IUPuE65Qe7gnD0uy1mO9Bile0SAzybMFXAQu
	NFfKpbwqF3Vxz62uTOLEG4wo/wnrvHjo4+afmAkdeGMtJy9ppBMXCQ/apXiFu+7xaBrL
	NaRJJmeya8ahz6nfwCwa3JNMJSTAJi9h8LpdVF8p/ZgPUYM0HNzTEz0854HeNc/Cxv4B
	oTXAILLWLCeBrkA4o6RcgTr8DumZ0XK7RznhLrf4q8mcnXTn+vIPUXX3udTpHtwqJyNN
	Rf6w==
X-Gm-Message-State: APjAAAX5vjCHyXOuuPSrh3F9iuZbJJAFlOhfcMt8+rPm7fSNda3BKkYC
	8X8qlcy8CUhsz5NnnKBEydy+m2Es
X-Google-Smtp-Source: APXvYqxl15YLF/OFQ2bp8VCORUiQIpV0uUxg6nbtaHPAfZ0PXpyPhI7lRRK39cssODK7tuduJ8aF2A==
X-Received: by 2002:adf:8062:: with SMTP id 89mr1807933wrk.107.1556253381069; 
	Thu, 25 Apr 2019 21:36:21 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:20 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:45 +0300
Message-Id: <20190426043558.6888-9-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v7 08/21] gdbstub: Implement remove breakpoint
 (z pkt) with new infra
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
Message-ID: <20190426043545.tybmysEb8oyS20g-3hCSV-BLvDHxW0Un4lhzJDqrs3A@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 36c7353a22..b42425b24c 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1611,6 +1611,29 @@ static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_remove(gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull,
+                                gdb_ctx->params[0].val_ul);
+    if (res >= 0) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    } else if (res == -ENOSYS) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "E22");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1877,23 +1900,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'z':
-        type = strtoul(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (ch == 'Z')
-            res = gdb_breakpoint_insert(addr, len, type);
-        else
-            res = gdb_breakpoint_remove(addr, len, type);
-        if (res >= 0)
-             put_packet(s, "OK");
-        else if (res == -ENOSYS)
-            put_packet(s, "");
-        else
-            put_packet(s, "E22");
+        {
+            static const GdbCmdParseEntry remove_bp_cmd_desc = {
+                .handler = handle_remove_bp,
+                .cmd = "z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            cmd_parser = &remove_bp_cmd_desc;
+        }
         break;
     case 'H':
         {
-- 
2.20.1


