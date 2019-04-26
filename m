Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EAEC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8565C2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGDYhWj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8565C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39249 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsvr-0002Me-ML
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:57:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmg-0000dE-DN
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsb0-0004Oe-U6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsaz-0004NO-0I
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id y197so2376521wmd.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=y+n9UknESyjS5ywhVhGmu6RRpXVVQXSmReCo/GVxG50=;
	b=qGDYhWj9lBc82LHk4Qri4cyJU0bvMri/6+6D6fXFkAu53qm+vCFAFcBZ1p2RZEFGVO
	UtNWA0DDm8PemTfiS1QhLQ7RnhIIS5+MD9LUwSH6VLbOB/x98ryfg9uqiOaMSI56CsWj
	vKKxEqbxQLzr7dsZ0MovmlfMX6V9RFf1Hsvvvj1zZWJvo9q14VkKFElBKrZWOi1/Y7Os
	bG9NH3JW2qNO+AGbOFnLa4QUkIg4xao9suJ99oo1/4ZQGhndOWN4CeULP3g49MFP1jD4
	b0CztFS8+g74eO4oOXCqM+2wneYuRyRzwhO0po6KbWCRgQ/FY5anc2YR1w7IWi5C2Yja
	zj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=y+n9UknESyjS5ywhVhGmu6RRpXVVQXSmReCo/GVxG50=;
	b=ielAHswK25R23ooIC9WBkeJHbX+KlX+XLwtFzsz3lgbtTE7LxUSSwkBbdZZ+M5YLBR
	Hgnn1dinpQZvLAeIgy/G+IjVcJuH6zcUxKmZYXynA0rJnEngHPV2OghmgrexcNRzXNLi
	x5JDftqBa8+GsnrW9F6uQig4k50XAigLQexlz8ZBuyMRMwDNUBlS24YReEFNGemJPvQX
	eZSWY1iSR2KsH5kpVvphGz9M0r65Bfk9bpJaYpAc97lRjNXvzedmDsN5oZZ7flMA85d0
	j8Cs7PCZZWRNGtAdSKn6MNhtWoIMZ1pV3YrIF6roEupuqMlLRty69pE8GfS9SOSJjPF1
	lD+g==
X-Gm-Message-State: APjAAAWkEJJTlhHWVYpf27bo6LcZVeox+HJPpEPJt7rVLV1tp6cQi0d5
	C52CvabMJhhpGv7adlkkY/2LpBOK
X-Google-Smtp-Source: APXvYqwybX5Y8lEgXbq2BwyG2q9Gpr7ghO9UMM50U9/KRbFCw04GoLwRx2WYmT2sBLEjhT3jPzMT9Q==
X-Received: by 2002:a05:600c:28b:: with SMTP id
	11mr5725252wmk.129.1556253379444; 
	Thu, 25 Apr 2019 21:36:19 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:18 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:44 +0300
Message-Id: <20190426043558.6888-8-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v7 07/21] gdbstub: Implement insert breakpoint
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426043544.tzd6llJdFEuCJos48yc_FokGyCkE4NKcVr-28IMUoFA@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 21cdaf4678..36c7353a22 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1588,6 +1588,29 @@ static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1843,6 +1866,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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


