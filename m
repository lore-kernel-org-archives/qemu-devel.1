Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D28FC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C833920873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocjw+b60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C833920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47507 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7CG-0004Cu-QF
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:36:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tk-0003bX-7j
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0008OW-Ce
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6th-0007k4-1V
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id p21so1486781wmc.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PH0hXIwENcqo6TbPIzo2Qw9MFujZWmL0zJ/Tm+4JKGw=;
	b=Ocjw+b600EID3SmwmdlKFoILn6PyqIdLOu17mVLYrTPfq6e7z77r8FpScYh0F5vNpA
	9NLH55MR3terbSYIQbynHQaGzCBT9nseDqeI8D7mzKYLnUDja8RqJCTxwKY66chdB0T6
	9fZAxxK8YSJLxWmdD7S4+kNVyN6F9A2j5rfQNV/Yv+4sM02SpgulaHRRprHUMaiJqDnH
	FnrGAVM3QeHBg9VN4cSV8yTbW6hkvw+CktbPsJQDbV+FMl5z4RSSssvx6nw/6dloR/B7
	UlGaqDTc3Q5P5OjxLNS1g8P/NES1AKgNn8RxvIjtvloKI382szoZFp7NyZ3nE53vW0/t
	RW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PH0hXIwENcqo6TbPIzo2Qw9MFujZWmL0zJ/Tm+4JKGw=;
	b=OeRkGd8pRQtt0rjg1m6v8uAkJSlNXQ//VFaM5GDHoU+Y3X1lTcO987uVtQWHusWMrW
	QGih18oNTDK1kq2FBVr73w226HtLouN07FBziwppIEJsmg5VuFclE9DXC1ZylYvBHYSN
	MSyG8B1UptdO+feCB1gO7+RKQEe+N+XUk/YI67z4my0q3+1+kmVuOE374as4K6tOFF8l
	S4v65gTAhJBUn2xcnRWAJFKF5JoUf9zea1OKR3QJ16MvUwMYWhrtuHTAKIy+5FRUKAfE
	TP8MB09nqDmoOyodhB6e/zCInFAvXecZhq6przKkwSIH4Nt4zcqZrV9QL5vCMAxPtD0S
	cuIw==
X-Gm-Message-State: APjAAAVzCd/SX1lCoI+gBUucxvQWkimHEGZD67whDLGGWXEPPnkvI9+w
	/c3Jg/Da/pxqM3RA/qPy2m9ynqGO
X-Google-Smtp-Source: APXvYqwSNcbUr8dZAwuoXmAaQY+UGrayJvVJ264Bbn9tw26Vwq59Ur7Iz6w87iEicoufUevluyK6yw==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr1374998wma.28.1556785000126;
	Thu, 02 May 2019 01:16:40 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:39 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:48 +0300
Message-Id: <20190502081554.5521-22-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v9 21/27] gdbstub: Clear unused variables in
 gdb_handle_packet
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
Message-ID: <20190502081548.udX2WKUXzfE-ZcgMWnWJDIErX3UwbAIQnbx8JUVZPBE@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index d678191705..8bdfae4b29 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2259,17 +2259,11 @@ static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
-    const char *p;
-    int ch;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
 
-    p = line_buf;
-    ch = *p++;
-    switch(ch) {
+    switch (line_buf[0]) {
     case '!':
         put_packet(s, "OK");
         break;
@@ -2486,8 +2480,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         break;
     default:
         /* put empty packet */
-        buf[0] = '\0';
-        put_packet(s, buf);
+        put_packet(s, "");
         break;
     }
 
-- 
2.20.1


