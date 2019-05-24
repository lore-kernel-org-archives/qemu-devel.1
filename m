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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F304FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA442133D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZrUd2jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA442133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCiJ-0007VR-QN
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:06:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdZ-00040p-Fq
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdX-0001yl-HZ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdV-0001vW-I1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id i3so9912637wml.4
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vmTeYL33TLNt5020gARU6brnGwd9Bi3fSBpfxMRZaXI=;
	b=HZrUd2jQJUra0PGWVgqRE9CmwmmlZDe9qMrlLJTzOr8RUiJ2H+FYGflLt9FqvcDi0o
	OcGWSOWf3vr6o61FonnyEJcbOE0VAJ4zKnWcMK/ZKAS4qaBAGFDWRTTU31R/284EnxPg
	bCn449YiR72ZdorOnXmomtVp3gZ+ckC6i3xk75RlVU/5HMBvmJTNbZiRN+Ttkk08/KxF
	Q/tBM3aB7ccyVIpW5aVVlD95D6YgWl6Rfvh4pyZEh3jvR4oClHg9FJ2yf9GUAGDDMf6i
	WAgzixQOShggP4i9Uzjj1cmyS8uPG+YoERCj9v/lbPqRQCUI5Le+vdu0t4PZWse15rd9
	kb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=vmTeYL33TLNt5020gARU6brnGwd9Bi3fSBpfxMRZaXI=;
	b=E/I26l4PVN6oMHr4wqkOzu1zTlxNYw/OU5Mpk2nhG8f3IqVZFnK5xLnfkvaGfL6ixq
	2nIUKkq7KxcjF7rxPBg0K1XbgLpE22/DOjlQGRBvjciTgqfI2itd3rO6ipVuCVtViYzw
	7rj/Nu01tHPh+zVlapCB1QZXzF2K038hCZ1aM7Ka0V9IxZ3aVVRC1k2Z67aDdtxFw7ot
	np0qcfcYrBtLVqlclEy/bwoa/nFYcW8V5M0qXTWNnRHI6zOmNTz8JMgesQlc3o7Im75a
	osQfLBrha9OKduOZ3GQSrd0H6yw9JA4kBf/CDgmxO5mUHjqPMdbevNn1Ic1HyBz9yQz1
	YSXw==
X-Gm-Message-State: APjAAAWC/R8Afp+zyILpNJDudcRy2W2+zpJdwlE3Rw/VMlK6RIpeCtta
	r6PMrBwqw9UqjdVPGEOsrbjSOwHk
X-Google-Smtp-Source: APXvYqxV9hfD3Ccs7whvzsb7ErrMIl48j5g10VfzTL9yJHInX4EYBvA+e2l/EjboTng22EG6kj0FJg==
X-Received: by 2002:a1c:ca19:: with SMTP id a25mr411555wmg.105.1558713694391; 
	Fri, 24 May 2019 09:01:34 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:33 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:02 +0300
Message-Id: <20190524160118.31134-5-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v11 04/20] gdbstub: Implement continue (c pkt)
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b4c4bd4b08..698d6f558a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1517,6 +1517,16 @@ static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, gdb_ctx->params[0].val_ull);
+    }
+
+    gdb_ctx->s->signal = 0;
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1553,13 +1563,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         gdb_breakpoint_remove_all();
         break;
     case 'c':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static const GdbCmdParseEntry continue_cmd_desc = {
+                .handler = handle_continue,
+                .cmd = "c",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &continue_cmd_desc;
         }
-        s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'C':
         s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
         if (s->signal == -1)
-- 
2.21.0


