Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F7C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14A120717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwLvIXl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14A120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJekl-0000ox-W1
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:49:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePa-0008Ba-Fj
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJePW-0000q4-RB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJePU-0000k0-U3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id g3so30319226wrx.9
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=BRVpNhgZ5WsnuwctywQjKEVF66tNSOqIEVrbKsmJ4bY=;
	b=VwLvIXl8gKntSex7O/QPDq/UESFBZxic0rJvdrBHJGD6jE9sO+dR1s2WtA19A8m++/
	NH87VhR5fBMSiOwGSCr0WqcaUv3Lh3oFuSo0i4s/ByC+EPDQzOC19dByHS11Phsvh9mF
	kXPv8sfiPy4aiytiJ9kqUr7b5yNVsZ1z4oXkQmXS/lFdpnlWT2gzwXk2My5lxV5fPdy5
	2A70LWYRHb2SXZlpIophYl9UtL6SPWDwqymXZrYdkLGapzeBWqx964zbkxWIVXw2enW7
	5K71fJLLLFLCqK1K0J92PZYQD+oGayIliQU1ZIYau8smFeby00weHYfmPcPTyA2t58w1
	uF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BRVpNhgZ5WsnuwctywQjKEVF66tNSOqIEVrbKsmJ4bY=;
	b=kdCVaNYlxblBOajor82oQV3wQz7bwAuIuFDYCYg7oUNJuVG1EZwQTso2cSSm/INPAR
	TL3AHRwlzzYfpfqxqQBpws6vo/bCkSQUFfPAcb8oGGw+O47WSC9AQHQDLgu7dfuHvEa5
	t6BOFRBW5v8nxR8dbKt91qXDKE2RD/piJazG7mGM9/w70Jk1usOUSDJ4krjPIQDW40gQ
	LL1CFiH8BQiVp81pngToXjcqA0jJHVb7IZxDh1OgUTQsdZa7jKzbRwfTQilvwtTxsixF
	ykwZstwTw+n1OOsGGrhwEAa5NE31C1g2XD9LMIjsKAeCD4C5nRHc0mC9yfGqNqhwfx6H
	nqhQ==
X-Gm-Message-State: APjAAAWSB6qDBhlMg2ID+MkNW9hYyg4xbFj9nnO2WoJwYnxrNiyV8plA
	9liBrnTDE3fTAukAxP0cXtKSccg2
X-Google-Smtp-Source: APXvYqzBG85ilqufPMzJfPi4WY0QBsPJjpbmIVeUski0cQQOyS1MONTszmKxyEIqGwiIBX2AUGyJ5Q==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr25491923wrj.249.1556198849303;
	Thu, 25 Apr 2019 06:27:29 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.27.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:27:27 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:22 +0300
Message-Id: <20190425132636.31636-8-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v6 07/21] gdbstub: Implement insert breakpoint
 (Z pkt) with new infra
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
Message-ID: <20190425132622.lpKhW1Qp1GCObeC-TODLyJul75PBQwr6C40yaLgKngI@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 83757def9b..8e0446d305 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1589,6 +1589,29 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 }
 
+static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_insert(gdb_ctx->params[1].val_ull,
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
@@ -1844,6 +1867,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case 'Z':
+        {
+            static const GdbCmdParseEntry insert_bp_cmd_desc = {
+                .handler = handle_insert_bp,
+                .cmd = "Z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            cmd_parser = &insert_bp_cmd_desc;
+        }
+        break;
     case 'z':
         type = strtoul(p, (char **)&p, 16);
         if (*p == ',')
-- 
2.20.1


