Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48A7C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723A720665
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cdi80Ybw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723A720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpTK-0006XE-Mw
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:17:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKL-0007TY-3t
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKK-0001uF-5v
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:17 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:42749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpKK-0001te-27
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:16 -0400
Received: by mail-ua1-x943.google.com with SMTP id e9so2290451uar.9
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xcihCMTg6jd3N0tSpSeDkVUUj/HYgQaaJEhimiQbbQQ=;
	b=Cdi80Ybw8+jb/EdnRp2dqA8qJI8x0fiYppUCb697NL0GCj84d6jCBwHrmgtoRpeD29
	VExKmV3BAGRuusj19+Hb1cQ+8nyXpZwJuU6+P/ayhHBlhFGIthz2FhODYYB3jXxHCRaR
	iMyeDvt6KZ8P34i+1YueaTvZWVhptTo/2FO6Cl+EPSlCTld57/TuhEbl4CceGYabS0nJ
	IXANE/KKkmzDdXn5GD4Py6IxYaGWUwt2HqjUylbsq69IG/UiosOELD98CMkJBL/uQwVw
	3ZpRKBEMXTuu6/4pkKS9pPVbTY/LMPbmDeNkN2UYRS32vFauhaes6CE6QiQ4zsvSlj/f
	cLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=xcihCMTg6jd3N0tSpSeDkVUUj/HYgQaaJEhimiQbbQQ=;
	b=ccxLgb8T34BLBECF5AnNqt4mYA39nr5XQfMsADrfxI4kPA2uLpN+yHaujyWstUQe5J
	o3oERcHPnXEQYDsc+N10xZrhP7NEiBqyrIrqXJOV7HeWMkjRx3L6dW6J4HdrdX7bk27R
	Fb1qVzlXsaXVLbYfTbmAvr4hPre8RiB9EwunlpyRBofrNSvg1U4EHxFYsavVF9t8KNIU
	/unHhJzZUsoQPVXxIEqPO3rtlQX2pHFuyN1J8k5v1xHAug/prLmrYJyAXW1KZ/8pme8z
	I1iauwnKMZf6OERk0IIog95qJnAzRXXTzU7HYfBg0/CJtvKxU4bM/BPUVj6o5JLnbAxd
	Ly9g==
X-Gm-Message-State: APjAAAXQZfwDadIHeB1SBgR2fcqHZeUKnebMG8D1Dsv75BtHH4ENbF9d
	uYSIYYHxcruGxtG8zFc4Emq/b795QyY=
X-Google-Smtp-Source: APXvYqxrPmMj0lzKKA4NBIOaOHof6MCg8aKHPue/W9/FpE8wM3qqpChhNeh1vKeowR27MA36vsymog==
X-Received: by 2002:ab0:29cc:: with SMTP id i12mr39566731uaq.12.1558624094878; 
	Thu, 23 May 2019 08:08:14 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	p70sm4227462vsd.25.2019.05.23.08.08.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:08:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:08:03 -0400
Message-Id: <20190523150803.31504-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523150803.31504-1-richard.henderson@linaro.org>
References: <20190523150803.31504-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::943
Subject: [Qemu-devel] [PATCH 6/6] target/rx: Dump bytes for each insn during
 disassembly
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are so many different forms of each RX instruction
that it will be very useful to be able to look at the bytes
to see on which path a bug may lie.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 5a32a87534..d73b53db44 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -102,7 +102,21 @@ static int bdsp_s(DisasContext *ctx, int d)
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
 
-#define prt(...) (ctx->dis->fprintf_func)((ctx->dis->stream), __VA_ARGS__)
+static void dump_bytes(DisasContext *ctx)
+{
+    int i, len = ctx->len;
+
+    for (i = 0; i < len; ++i) {
+        ctx->dis->fprintf_func(ctx->dis->stream, "%02x ", ctx->bytes[i]);
+    }
+    ctx->dis->fprintf_func(ctx->dis->stream, "%*c", (8 - i) * 3, '\t');
+}
+
+#define prt(...) \
+    do {                                                        \
+        dump_bytes(ctx);                                        \
+        ctx->dis->fprintf_func(ctx->dis->stream, __VA_ARGS__);  \
+    } while (0)
 
 #define RX_MEMORY_BYTE 0
 #define RX_MEMORY_WORD 1
-- 
2.17.1


