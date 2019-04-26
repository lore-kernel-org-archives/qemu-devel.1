Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3077C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852FD206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/EmV8Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852FD206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJstb-0007yV-N1
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:55:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmh-0000dG-JA
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsax-0004Mg-3w
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsav-0004Ja-9L
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id h11so2330683wmb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=x82aHJMzl8f+PCXWhu2ZX9N8tzch1kuJG+XquT6URF0=;
	b=X/EmV8BnohzDcZAzuZYpw9Fpqq3xw/P9Oow6QaJb5e7+PBkDTcFBODxzk5+KVwD2Tw
	Utf6tgRDXDY5tEyT2eVXekd/pOe51QNmvLW/pu60xQGnIp5xY6n5qTFKi82tfYw2/Tgf
	h35I0PKtRIWi99+Bww9QAgnh+bf3wW6ejxUX230Up/Gb14FqxP2WSr/t8uQXZwaQNvBg
	KUE+2dMsMdullZ6l+miIUcIQHyKQTB6oOxkhUhpNV8wNpu7ZRd4gEYP9TEDxFzHYn6PL
	0WdOk1i3OILpjyb0XjHbEzfPjFaGUbrqmN26b1fj5ttzYafpQe7EyeRa93zpi+qd9l5v
	76Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=x82aHJMzl8f+PCXWhu2ZX9N8tzch1kuJG+XquT6URF0=;
	b=A8QpU5hAYUUnXXVHXEY1u4qpYI8z6jmYGgDBLdlEfqmWPXXcWYPPwDCbNHUMsQkQNM
	CiiQZMuuE+ZR7Y1iX5HJK5KAPTEQPcQt6V093cvxk1GnBqr85q81kjckPNWEqKFyOggb
	Gz0ZphlNlDfkhmQGXWYiEKL5IW649uIRtY8CvDfOjW3LaLoa1u/9I1dxvAv/d51prxVJ
	6qqnu9nNDxYISKe9EPi8VwpEaIeIiaCfwXoHvajlm+M/bXXefpjAPpZvFLdF4otYKMnp
	a3JkWfLmafbUAq5rPZ2oDpRTIM9iyn9gw6K918Qdc3EX1AfORSgC5YS5j/AD8/AbPKo/
	vUug==
X-Gm-Message-State: APjAAAWKns/QfV6ifr8rHCYuZHe4JsWjzCZpO9/bT1u46RNUGELgv9x0
	f2DVU+nJsiD7BUx1TuWcHzBIMb6d
X-Google-Smtp-Source: APXvYqxGZiRKnKcU5bToSN1Hl4A9I9F7jFpeCwG/sFUsWIRbf0c+uT7EjVVbF4SpbAXHuRqASEDRHQ==
X-Received: by 2002:a1c:2e8c:: with SMTP id u134mr5996302wmu.146.1556253375826;
	Thu, 25 Apr 2019 21:36:15 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:15 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:42 +0300
Message-Id: <20190426043558.6888-6-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v7 05/21] gdbstub: Implement continue with
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426043542.6YzeP1bEq7rMlbXLzev66l7QfF7SwLi6IeNLrrSkjoQ@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 89f1ab6524..469aaeb875 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1532,6 +1532,21 @@ static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    unsigned long signal = 0;
+
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
@@ -1579,11 +1594,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
2.20.1


