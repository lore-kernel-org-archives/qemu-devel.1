Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E75FC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7A2206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl4W7Bz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7A2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57797 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeuk-0002OV-3I
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:59:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQ1-0000Cb-Ok
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQ0-0001bW-Q0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeQ0-0001Ya-Jl
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id s18so5518351wrp.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EG9sk85M4LsflXbUNBRhLCHZfOCHF6EVSbclOy8vwek=;
	b=Fl4W7Bz9JRJCeiJlRbCZowy+PZtRd+Z2Rp8Yv7dx+tCYW4O6lvJgBtk/UsEVL5ClF8
	h7tCyBWLdY35Wf+djmC6kqOj85nuI7E/j9idjWuXadpccKJG29DysXnPpaAElsj5gQOh
	tXBnPZwkgaTAhz+ZKYpBRnPemGisT5FSbp5krV4beIGMp9K0aDl4yWFwXfjLwETBDc9Q
	snoJ6UtIN7IbKyDWWViB/ZXEblUJZ/VNLsSO4QyKsvaFKW+AHc/3SJee638RxGZ8QKuS
	22RyN4a4BgCXbKTjU3SfIFj2+0PkXk4g88GLMJZJYzRuyMTQBX2roagtMUFqDY3Kzv2z
	jPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=EG9sk85M4LsflXbUNBRhLCHZfOCHF6EVSbclOy8vwek=;
	b=aeKdjMwBy0uUi8a78jZwn7SHegYmZvBZSdS3hfsiT+Je0T9s7EsgmjpUCUDhtPJHSy
	WILRq7AMMKP9IcLvdI1jzX7Kn6VEc2TehHv06Y4Sf6uKbNtcr5LKkxGbY3pMsqIPWsAk
	Hop03kLrKHt4X6HClriLpmoSG/kuIwdBRHUdmesZ+UZqKtKfIwVbY5UDludgBcIWeevw
	IfqfLV8aLMXbVpOYyVqPLPcwb7VxAeuHExptt2j0VDzfqnyZdbWj6ABYvffFbflQm9XB
	M45cehpDtrD+LoTTo4zZRhvUwqkzr0j53lWBIhcgPO/4GRa/hXSSSjtXf6h0SmoAMdsc
	Hqlg==
X-Gm-Message-State: APjAAAWTnRT8udlRbjFRIazxXPSmwHEBPAyKF0GQgyS/hrJi16TOnfa9
	QYKAQUiT7TIQAXaQMN3WkRM9nNZ+
X-Google-Smtp-Source: APXvYqwqvV6PzMDXgwuvUU54LppW3a+4iyKgT/n/x1tmDRxJg2mRPQ21LLBVb/K3mnq8kBvgL6mUDA==
X-Received: by 2002:adf:f309:: with SMTP id i9mr25304648wro.258.1556198882187; 
	Thu, 25 Apr 2019 06:28:02 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:59 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:30 +0300
Message-Id: <20190425132636.31636-16-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v6 15/21] gdbstub: Implement file io (F pkt)
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132630.yAPWxAoXXwDqw2ZaM8aD6XNWwQqKr1hTmHrP4kT4K_g@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 62 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3a7ef5eea6..18949120be 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1773,6 +1773,39 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int num_syscall_params;
+    GdbCmdVariant syscall_params[3] = {};
+
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (cmd_parse_params(gdb_ctx->params[0].data, "L,L,o0", syscall_params,
+                         &num_syscall_params)) {
+        return;
+    }
+
+    if (!num_syscall_params) {
+        return;
+    }
+
+    if (gdb_ctx->s->current_syscall_cb) {
+        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu,
+                                       (target_ulong)syscall_params[0].val_ull,
+                                       (target_ulong)syscall_params[1].val_ull);
+        gdb_ctx->s->current_syscall_cb = NULL;
+    }
+
+    if (syscall_params[2].opcode == (uint8_t)'C') {
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
@@ -1914,28 +1947,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+                .schema = "s0"
+            };
+            cmd_parser = &file_io_cmd_desc;
         }
         break;
     case 'g':
-- 
2.20.1


