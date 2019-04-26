Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A2DC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEF9206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUaSGe+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEF9206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39169 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsqz-0005Jx-8q
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:52:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsme-0000dG-Ac
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsbC-0004bb-MD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsbC-0004bG-GM
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id c12so2425687wrt.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WRCcpUzuoRAzUaN5uQCeSKLXRQ6/9wuQJBWFZBJ3jI8=;
	b=vUaSGe+MhCI7l5636Bm8JfibJnq1VOcnhKNBqSPMVPPP4D53QiKe+15sR9DRDo24iM
	xcH8aie2UA//L/m28rj4WOO6803l4S5FVcvZGMzkl5X2PYxrZvgvQ0kcdpNn1xd9eb3t
	vYy1Dd4vizlzXfntIo50OsD4QL1b+Ik97w9VBk3qWxyD7cLIKa/AlV/tsbKKXGxjRiWL
	QqoME/GFyF/k4dJCJflMtAvjMOC0CBlu8a38KsSAiT9rwQTa2V+UgGtMw5NxUcs+YWNW
	jUEBqFbl64W3zg3ftOOzS+YLa6EKvwVoDuxt2Z7pN+/pnIxY5PYOFju38MqT2X6Ch53T
	ezvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WRCcpUzuoRAzUaN5uQCeSKLXRQ6/9wuQJBWFZBJ3jI8=;
	b=S1tZlbkHQTlFS0Z+mqNn9Bv0DY7y1MhcP5qeI2inH4sji3gazaUt6qAQgxVTr6w4/V
	Eu+LZtbEhzmluFPsueL5wIt2w1F+oIeikHQtaYIPAwejC2vCZa4aLzE+3IC+G3mfzEre
	vkjmzOlcqOw4OiM/KXe326SbKzLdKhmmIHW+PVbn3+ZqHmlh0ptj7HRHRc+xlNxXfHTA
	F1pLcE7H1PvWbN6tmd/8C6nPkYMlzjwn4R9Qo7gVzYypJNDSwtMqOu7OKpfJsMHqlB/h
	gpdCbLlHmS9vFaAjBN1GtcbbykWiZ4srMIc+hoKyi55oOmlGPWrBNBeq+uBRtftXTO5X
	hUfw==
X-Gm-Message-State: APjAAAW7WTDsKtJhHqdR12wrp2oSBeuqmPDHLw7U6VfkzKJB4yJijIUh
	pG/VTvPM25+CspPRLQ11RiX6yAWO
X-Google-Smtp-Source: APXvYqxUmc5v841MWHF4hhQA8hqXvhX2YJjjeDx13MkLjzzwO1XPyXUIJSoIhbv5wD9J7XJms8f8Kg==
X-Received: by 2002:a5d:4684:: with SMTP id u4mr5228849wrq.33.1556253392657;
	Thu, 25 Apr 2019 21:36:32 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:30 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:49 +0300
Message-Id: <20190426043558.6888-13-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v7 12/21] gdbstub: Implement read memory (m
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
Message-ID: <20190426043549.6m0oUD6TLIg3ClVvEOfv7sttATkLLMVIDQxgYPmBENU@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8dc2e1d507..daa602edc3 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1710,6 +1710,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* memtohex() doubles the required space */
+    if (gdb_ctx->params[1].val_ull > MAX_PACKET_LENGTH / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, false)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_ull);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1899,22 +1923,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'm':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, NULL, 16);
-
-        /* memtohex() doubles the required space */
-        if (len > MAX_PACKET_LENGTH / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len, false) != 0) {
-            put_packet (s, "E14");
-        } else {
-            memtohex(buf, mem_buf, len);
-            put_packet(s, buf);
+        {
+            static const GdbCmdParseEntry read_mem_cmd_desc = {
+                .handler = handle_read_mem,
+                .cmd = "m",
+                .cmd_startswith = 1,
+                .schema = "L,L0"
+            };
+            cmd_parser = &read_mem_cmd_desc;
         }
         break;
     case 'M':
-- 
2.20.1


