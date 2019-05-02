Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B58C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7C920873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piynL98K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7C920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7BQ-0003Fg-FU
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:35:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ti-0003ZJ-2Y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0008Mo-2T
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6te-0007vw-Uv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id s15so1967051wra.12
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=AI2gF6CcF107YLL+Yoq5vMjKHAR9DjS56SI4WgjZi0M=;
	b=piynL98KoF2lYG2pnxpAFEV884EF7MppJxl1Y7dVEezW5SS50WPdjaK7XdXXkwMWnl
	UVA/Sd1PEZKl3i0nsIJp5FAdZ28PZG6Ekd/S7vqkKBYyzqnzD5EonhncOV7Bg2ztIle7
	2m5m/4OmycAWbyDIHMm8fLJToty5h+mNa+lHSk8O629TyR0Gi5FpiVxI2rQtPDX2mKDr
	PLf2qKJ766iFOP0wjuznRCFEq4UnjASbkbMVAxI3t8OSjR1FkATBZ6UkEjOdtLToxQ3V
	Bu1jWhl4mq99EQl91OYoUnoWTxXVKBAEXocaDMuV/2TeddVkgEA8UgbrdIaw3F5bYEXU
	E6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=AI2gF6CcF107YLL+Yoq5vMjKHAR9DjS56SI4WgjZi0M=;
	b=YmnpXKDmZ7P6IUaR2cuSjQRcoQASl0+8Pz/GkD66MYRnysrJ8QYGK34a+L/4IMIDew
	ow3wpbfY9IkZvi0bZFTL9B7vFpQ/8RZcBuEJ3rNuzu73CxEZ0IGNVTQvUOuh52N4zYJC
	hP44Sk7kPPfw82edhs87aIL45NZmHXiI4vEuvU6SlwI//6LTwAeNN6cKrBxbXckCxAo6
	EdbtawJRGBNjdfwYNPKI3MJIOc2f85LPvPT+NoQUexji6tDEXPINnPaJCEUybmGQehnP
	68gu4A7O27NCbt8SHuhoCFoQEWS8xsFGON7MASV8pCbGMxgFD8u8KlBv7iIngvJuxwJy
	jK1g==
X-Gm-Message-State: APjAAAVhZJFZCwlGtw1We0PK6QZtksjU6P1mEbhdqY7oSw05PC21H2ui
	awVxr6V9zCnCTdOAi4gKEzbbG3dh
X-Google-Smtp-Source: APXvYqw38V7g47CQb4Wj5hbDYky7H0vByjEcEoKYEzUx7GrvdHiaH7/y0z4E9wszCshi/1kCE/z7Kg==
X-Received: by 2002:a5d:4acc:: with SMTP id y12mr1756570wrs.234.1556785004744; 
	Thu, 02 May 2019 01:16:44 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:44 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:51 +0300
Message-Id: <20190502081554.5521-25-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v9 24/27] gdbstub: Add another handler for
 setting qemu.sstep
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
Message-ID: <20190502081551.ANqy4AorUSKLbn_68G0T8zOAyDcJdb571v3amdl0sMA@z>

Follow GDB general query/set packet conventions, qemu.sstep can now
be set with the following command as well:
gdb> maint packet Qqemu.sstep:Value

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 88ff6224e6..34da10260d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2260,6 +2260,12 @@ static GdbCmdParseEntry gdb_gen_set_table[] = {
         .cmd_startswith = 1,
         .schema = "l0"
     },
+    {
+        .handler = handle_set_qemu_sstep,
+        .cmd = "qemu.sstep:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
 };
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
-- 
2.20.1


