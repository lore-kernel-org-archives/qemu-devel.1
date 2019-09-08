Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626FBC433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274CF214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+TK8iaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274CF214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6qVz-0004Pw-O1
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 02:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUH-0002mT-AP
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUG-0002P3-3u
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUF-0002Oi-UB
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id u16so10442976wrr.0
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jxeBooAWNeNgyEWlgkktgHzYTcy+BTe+I6i003sho70=;
 b=U+TK8iaWtCyd3zYeMuRNoa+2FJH1sD5X/2yJeblvT74fE13ks92RW1QrBJLwhJGeB9
 VGJFXZyaO14+LFi8HjXxkuIbDoIYOeY1LCEdIFHYmDWoe9+IZ02oZmH/6N8zgh5FyXjD
 cLpI0aCwV5EUfLhdWe2ANb+ZsZJpXc+hGhQbWjHfBSlCq5F4jAKiuYPRHZufSBkREr8n
 hMj52QWkST3xHd7Oyc1VVnTUolM2MryHo6WNLZYBqVitBGkNGUPwlp9PtFdQH71nagNB
 hd8YEhm7dbBTEro+MJPpHFw/1ZQ/SBlQ0I8siCEd7OFL4r/+9+WGseJ8hIQujfXzCBQq
 5Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jxeBooAWNeNgyEWlgkktgHzYTcy+BTe+I6i003sho70=;
 b=Ce2UYwJIe+or40Wb4akYAkOC1/SQUsm1P/03YEUQLDZ7WiUmineeysSotNEqwnnhWF
 nN2O8DCUN9I6IeQ6s0YN2pJ/cgllejxsKd4w8RfQCxbDcxg38lMGUkGr60UJlJMfleNx
 ddtElyKWkxTW5xM8x0kXX7bjMCWtglIj3vNYNwq9IuFL3XVWJoRhPIP4T5ixdj7pez78
 ptUgcGjsn06/Av7cNHeWuo3b7Dcz2GiWNlkoQWkD/Sqt//WRlcB/rIg1K9q8tpjTD6G0
 IJh20HXdLaux+aenRoSG8gsiE3QIDruihLW+Rb/+DDB6QJ8AQSkQy65Lyl7wIJAhKtAu
 MAfA==
X-Gm-Message-State: APjAAAVoAAPeYDBZsELt/QGCZ3ts5XXYc9FPB9/i2WHCz+MS04yZU0ik
 Z90uLqXTxQV3Gd+rzDcMA5NLR2Uc
X-Google-Smtp-Source: APXvYqyoNZWZfmh/XCJ3O3/KcjCJK03yT5XP5WsDVz3pYSe/J/oFEy/Ww4nw1/sTVdlRcz5fxr0p4Q==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr8920884wrp.303.1567923346730; 
 Sat, 07 Sep 2019 23:15:46 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g201sm15616552wmg.34.2019.09.07.23.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 23:15:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 08:15:36 +0200
Message-Id: <20190908061543.25136-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908061543.25136-1-f4bug@amsat.org>
References: <20190908061543.25136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v6 1/8] linux-user/strace: Display invalid
 pointer in print_timeval()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/strace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index c80e93b5db..f326c357a2 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1243,8 +1243,10 @@ print_timeval(abi_ulong tv_addr, int last)
         struct target_timeval *tv;
 
         tv = lock_user(VERIFY_READ, tv_addr, sizeof(*tv), 1);
-        if (!tv)
+        if (!tv) {
+            print_pointer(tv_addr, last);
             return;
+        }
         gemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
             tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
         unlock_user(tv, tv_addr, 0);
-- 
2.20.1


