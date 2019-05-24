Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E7C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9585620675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxAoaiBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9585620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCl5-0001dR-Pq
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:09:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdZ-00040s-GF
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdX-0001zB-SK
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdX-0001w5-FZ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id w9so3636249wmi.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0rAsmcfCRQUIRVqrFl3XK6UCU5xZbeGLTSTV4MiBM08=;
	b=SxAoaiBnypzF6qRc6TGkBi6oJMk6vNjPrApDbHvvnw0bo2o/KDKD6AnAujCajzqvCH
	CwVD8+iwrLQFKYB1GjiEMAeokTK/7t1xZOp8BBVAsGPaIWiJ0sAs7ZIwTc5uijTU9YE0
	O9PLvIPq1FxYyYRRNHQNRcHJg0kvxtf7PimFmlSwxbf3ysWAhiwbY4Bqp3v4V7QvQMD8
	X0QZnpmqy7dHtwnaRBQNCxLlts+Oq/p546mygKyzgd6gDLWWXaXb4AX/8KJpfh924BLM
	WiB19nyGaPcvV28YsJMnzZNvF3+749uDd+eTYuCkD2U3zQXE/OrvnWLivrfW07WWcwyK
	u+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0rAsmcfCRQUIRVqrFl3XK6UCU5xZbeGLTSTV4MiBM08=;
	b=OlrvvRcpncsBgnagrpU8P7OFKa8XsHqby77ZiArCRRkIZksq0lWx92wpfkzRJ0qHPU
	RQVrWAiRKZHhOSimTP/dTiOwsRxIxwJ2C4wp9svDm8jA8+lTCoECChuLtGzRWtj5Lpk0
	EFm9cWLCZN0ar4vExfvFkEnpPHluB4D7QlWyQBN8rCo1HfWNhGFDxOrHSgyLkKRRv8lP
	8pQPD6HhfoLkURdKyqpQHNIWi4GvBU4PfF2sUglaWwJPHLGrXTycbQuZwTehoPiO+ITi
	NmVs1pKTl41/CSSvuLmhJkg60RoAYbqzaOIuo8RTNNVhT25883IBy8Pb6FPZfEK3K8AD
	DFsA==
X-Gm-Message-State: APjAAAUvsIFE/W2CcW+ayuYMOiEqcAYp06YdHKwjhSJv+QhQdqaHX0q6
	EkTNCuISjmdUoQdKhd7o7qKwZCrY
X-Google-Smtp-Source: APXvYqwuwykIHtrd5UBbBwBh3BqT4nX86AGsy15Lr2YciSy8JMZ/OHMk6j0kaaAYefy7u9jmMCWseQ==
X-Received: by 2002:a1c:e386:: with SMTP id a128mr391781wmh.69.1558713695429; 
	Fri, 24 May 2019 09:01:35 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:35 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:03 +0300
Message-Id: <20190524160118.31134-6-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v11 05/20] gdbstub: Implement continue with
 signal (C pkt) with new infra
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 698d6f558a..f74a30da03 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1527,6 +1527,25 @@ static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    unsigned long signal = 0;
+
+    /*
+     * Note: C sig;[addr] is currently unsupported and we simply
+     *       omit the addr parameter
+     */
+    if (gdb_ctx->num_params) {
+        signal = gdb_ctx->params[0].val_ul;
+    }
+
+    gdb_ctx->s->signal = gdb_signal_to_target(signal);
+    if (gdb_ctx->s->signal == -1) {
+        gdb_ctx->s->signal = 0;
+    }
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1574,11 +1593,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'C':
-        s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
-        if (s->signal == -1)
-            s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        {
+            static const GdbCmdParseEntry cont_with_sig_cmd_desc = {
+                .handler = handle_cont_with_sig,
+                .cmd = "C",
+                .cmd_startswith = 1,
+                .schema = "l0"
+            };
+            cmd_parser = &cont_with_sig_cmd_desc;
+        }
+        break;
     case 'v':
         if (strncmp(p, "Cont", 4) == 0) {
             p += 4;
-- 
2.21.0


