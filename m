Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC6C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4827F20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpVOIu21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4827F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46644 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6Iq-000425-As
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:38:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69n-0004cd-4g
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69g-0002c2-Re
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69Y-0000iz-DC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id e28so1840500wra.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PH0hXIwENcqo6TbPIzo2Qw9MFujZWmL0zJ/Tm+4JKGw=;
	b=kpVOIu21i7EpDcJi6Nl8sVXEHncvrWW6OCKkbD9Yuu+DZMexDzOFV4AcDu78pcs+PV
	VbWR9wfQLvkxzy/nomh3ns+pzwx5x87Xze5NSQfwQLIeyTs2QoMJxm6kt6JOa41Xn+vL
	Dhg+Kys8O0jyiS4NWKcvwBWTofVE2XbdIXPgZjUl4EM4vy7wRey7B4yeaVVZQ6Dxur1C
	yHxYdOWWV/6RWSJoSVYt/Ub+t8PZ1ezRMldvI/coCQINjHJafmQOaaqmeInAceXGGiLQ
	IMycADDA3SufctTc1xSsvBZAO51qsoFTGSzRhP9fZwdiBjGlZI8ikjA/XffXTZ638tXu
	D5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PH0hXIwENcqo6TbPIzo2Qw9MFujZWmL0zJ/Tm+4JKGw=;
	b=j3X5FVVDp/JUSFNwTjdPXyCVtbw/fxNrRRii7lw75+il4mOrQlSUFqDSXKy3gEygn+
	EtEefSlKzOjrF5+rXc0wjpKMnDeYPw7tLdn3i5elnDV5K6tRmMluGOppkwLTVDzQ36Ow
	Fz/pFtXG76AUD8L9BYpqPqvbqCnJcACDs9m2Q54PpGaZ1pcwXFOz6O857Rv2ANbYqkyQ
	g3Rnq+iNQ2znMh5wJdYPVaSYxmympVmmXM7Rf7xjVYxSL/ML9r/ZLG+O91pkkeUqRA/4
	aZYfM4d8VkwPqibpuWap226PgZAvFRPC5P+ZW4T2iq3Wl4lS7Ij83230xYWWMesSXg5j
	QjrQ==
X-Gm-Message-State: APjAAAUlMMSo7+ujGcWI04UbQ30MFe6/o9R9mIYSKY41ghxKHK/TBY+c
	zaBFDusIIRhIqmgogJ1kmxsuwve2
X-Google-Smtp-Source: APXvYqzlBmjC8Auf5vqINEIq9BrMoPl4aqHnWxtc5QDl3XYrnfIRPW3Jrl/tjBjIOwV9MBWL1BmZMA==
X-Received: by 2002:a05:6000:145:: with SMTP id
	r5mr1502846wrx.19.1556782049989; 
	Thu, 02 May 2019 00:27:29 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.27.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:27:29 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:35 +0300
Message-Id: <20190502072641.4667-22-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v8 21/27] gdbstub: Clear unused variables in
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072635.G0VyZVdLqR2wIlZHcu02JLxBaT156HyGVv1KUnehq5U@z>

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


