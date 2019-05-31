Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC4AC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC4326A03
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWQhEC2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC4326A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44099 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWi9k-00079P-U3
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:05:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhp3-0007ip-1G
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhp1-0000je-TK
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:53 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhp1-0000ix-OG
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:51 -0400
Received: by mail-oi1-x241.google.com with SMTP id v25so7163140oic.9
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ukF5U5/YWULrIZTRqlrGB8Y3cOFI0trhAV1LyR0c8Es=;
	b=lWQhEC2IaAIRs7J/QGxTu6dKe0hqaytXLP4CB+uJsV1vlmK0Vns31smwNY67rYfCJ6
	t4WTnRClJma1C/Nrg6hGgiHiGPj/4dOEXEfrZOC3H7JY166S6POXM4o6+cjRbHj4XbKL
	4VJcFkLu4adhzLfHn3cGhH5AvKPHCrmLn6sUty8GBUtTC5QgGg2YP5u4ou5Cc7cVzHSp
	z/X+nWF0UlmxlwBJOSmYjzt6nHLrrma4Gq5w15xwRIYKWlTwB2Cyshaw6nI8eaJ/GkNS
	pYFZXEDRPB/nBsBr0oT87xH5NZotkLXig/dCABuRFaud1qq9qghJZo1NG9HD+AuMnI7Z
	SV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ukF5U5/YWULrIZTRqlrGB8Y3cOFI0trhAV1LyR0c8Es=;
	b=Qk6kUNCRtvusxFrDLTNa5UhXKBzhma87inKlzxkjXjpV/KF5fXk8wZox/ePoV9L6T+
	w9+ju97w7GjLEkADvvNJYfeJPDnC8pGM6e+WhzNwmkWFEiITZ70eNS+AsLwsjZtvIIQ2
	LovAWdkL+uVuYkUB/pSPNLtfAneDoXHOCMZn0CIrxjiUuuPdAyf9MpOaD3q5ozzQv0gy
	RWnyC4+fE9hfRMOnS7BtnBAyRGViL+PEaIwHKlD02/PK6/YOD/bL0OdD/cqoI4p+0Qbe
	yZGXFUiRIameVPPrNa6eD9oAzPQ0rQCJLtr8OLtnXjw1tqSQFkK0MV2KcpawKcwxet8c
	lE2g==
X-Gm-Message-State: APjAAAUZTJlVFbWVewFG2NMg1L7ecYPmq3/s/3I2H/07IiJJM7PiYO3I
	w6/JU59eDa2ZUXBy0J+ka64BGKlV7eIUsQ==
X-Google-Smtp-Source: APXvYqz1VDYT98fGX8nwnVDw77yzrO4z8UB+2RTYa07nxqxZ4gt+xzOOJpBG8hvQq3paNWuzzjJWeg==
X-Received: by 2002:aca:3942:: with SMTP id g63mr5265549oia.48.1559310230879; 
	Fri, 31 May 2019 06:43:50 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:15 -0500
Message-Id: <20190531134315.4109-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: [Qemu-devel] [PATCH v16 23/23] target/rx: Dump bytes for each insn
 during disassembly
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
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are so many different forms of each RX instruction
that it will be very useful to be able to look at the bytes
to see on which path a bug may lie.

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
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


