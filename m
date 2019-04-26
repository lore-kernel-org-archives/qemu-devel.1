Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948E9C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F9820656
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8SqferM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F9820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39167 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsqj-00054g-FY
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:52:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmP-0000dG-OG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsbY-00053Z-3D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsbX-00052f-SA
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id t17so2384999wrw.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PH0hXIwENcqo6TbPIzo2Qw9MFujZWmL0zJ/Tm+4JKGw=;
	b=L8SqferM1OaybvHivFyxMdAcLXm6Ly9CslZy5z0WQh73gVa9cE/40wyMv4ExL789RK
	5WtaSzQrcFMVS2xfj709tWlcG89LAh9qawTg3PvUiwNMwA4skqkApLj5dlFomHB2DJUK
	vByG2IZ3o1U8Dm/+QYOJTZnDlfXr2TflFmBJ/wO0niQQc9HlbmlqFwrUJ8X3PXmqrmSn
	qsUottbKJ69i0Oe+AFhp/JyUS9Y/1gJJCNH4CTTWQe4eh3J/yNrPlDsk5VnuAEOLiOXf
	XGmUuLN912cJCxcW0NdX0cTahspk6SWTTpA/m7ywVndtwNyDnC8WWRjlTX7aBu8iGrpU
	+uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PH0hXIwENcqo6TbPIzo2Qw9MFujZWmL0zJ/Tm+4JKGw=;
	b=hoCsnMO0jg+/WmxNTNfbV/duExjbtNtQPWWziLS4opGr6af46qtYTUBNIHvQ6btg+D
	++QA3IWxOrDrMTsO1ICn4smZ1P3Ht8U0norVFcsP9hmDwRVuZy7xJDagcxYAnTmLX1AL
	onCpOf6sO3zMLcKQEMDZ4BWMrI19nu8peGIHavdnKnlSTcVCSwrwzeIKEc+INCNjthO5
	g0sRM6/4utt5CBtYIiCacWaAe8mTQa6N35KclgLOQUUL9rQF3lrLWggSADREFi+Y5efT
	2SvjZLeLoxKnf6QThn5rbWigOnBa85ztN2LE8EvEE3m2RfCxj5wUbk8tz7E1T/hDWQRC
	mg2A==
X-Gm-Message-State: APjAAAWocVvGKQWmEUHo/HC8G9Ay9Nolae/kPaacprSHNC10LrOQv/lk
	URhDYdIFDNrP1nCG1h2gpWbV4Nry
X-Google-Smtp-Source: APXvYqxjlLyO7t3TccronAZXmuQoA/WHnxB5Hhpw7M+Y9dB7HrxfHYlMSI1Vn0Xc8VlASZQAyWOvxA==
X-Received: by 2002:adf:c993:: with SMTP id f19mr2810001wrh.246.1556253414370; 
	Thu, 25 Apr 2019 21:36:54 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:53 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:58 +0300
Message-Id: <20190426043558.6888-22-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v7 21/21] gdbstub: Clear unused variables in
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
Message-ID: <20190426043558.cBDmdHpytd6VTvkWEl-tOvO0WfISPPhUASa3vYbbhoQ@z>

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


