Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD13C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B10821773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxsyzgRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B10821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50629 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1mJ-0007Qu-FL
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:13:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZR-0005yk-E7
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1ZQ-0007uU-Bx
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1ZQ-0007tG-5C
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id d18so17870006wrs.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=LsYaQ4COmc6e9Lf4V+iWhN6mU2NGrUC/Gr04d6oOij8=;
	b=sxsyzgRx3abVJf9f3wedRCyqCgXjtMhSWBglozP+vnpB0/XGJbKBv3vDtCBt6sBZOo
	M0Azg50BHpHJH88FcFuLu9BhraikQ+PA32pH3mTqz4BGju2bwrdERQlApdNacG71fm1E
	Jc+f31S+vreTUYpa4bMxETmK75KUWbd/gN7/YtbIto+mm7Cx4R00+e7qMdY566zC1iTq
	DnWQFBREWyAYMfKolhqp0PA04+kkIUZ9dQvowFbwyiS2MJjGgmiHQpQMjBGYZt+wFYxJ
	84p6tcCZdG7iqigCYiV9IPVOoKr4eNjtNpNS4MBeaXJalzvFwiJ+jMan0VKv9OuO2QHz
	glkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LsYaQ4COmc6e9Lf4V+iWhN6mU2NGrUC/Gr04d6oOij8=;
	b=C8LdGChyf9cBYOvit3hy+2mTywBze2cCiQl/lHG+sTkTqxDYdZGWwINgiszqs/UgpH
	+/z/mgy+L1onfI09OhC+i1A+0O7dk0kHaGcCTjs3/UtFw1D5LdO9pu0t8fWNfGLzmhnO
	bgQ+Tot8QPdHZnR9z8GtzGgFnUoL0tVE6JM2pBSJvX4gjpbFXnbkDghXuSZIcrSiJEBg
	yF71nx57y7PCI95E9gI2Re1RA523sy9ZH/g0toFfm4qdsj1pyzhMUGCeOwaMmIrM+dwf
	MnvB6IlKX6vZlhMfmAbGyN9+xLjU5Ov17tMvLyQnqK5xfLkCtBSpqmgZIf9cm1sbvsJj
	UcTw==
X-Gm-Message-State: APjAAAXWhiTgWkzbdgovyhQOmeLC7m0xaO4wElW7F/yX2kfL1CnumwP2
	sR/phUBVZFxloaMmEtl0cm+7fnuJ
X-Google-Smtp-Source: APXvYqwxkPLDmMhEqfOW3fx5qkihjmgfvCfQPor/HN8aBz1tgQYWKCpZzHfwo4dWTtw23OwZfvKvwQ==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr25201789wru.299.1558432831097;
	Tue, 21 May 2019 03:00:31 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:30 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:47 +0300
Message-Id: <20190521095948.8204-20-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v10 19/20] gdbstub: Clear unused variables in
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

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 097b7d1231..9dd934a079 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2270,17 +2270,11 @@ static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 
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
@@ -2497,8 +2491,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         break;
     default:
         /* put empty packet */
-        buf[0] = '\0';
-        put_packet(s, buf);
+        put_packet(s, "");
         break;
     }
 
-- 
2.21.0


