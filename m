Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D9C10F13
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D62213F2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="fwF7saAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D62213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDg8n-0004K5-N0
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 22:05:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg6t-000377-0Y
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg6r-0006iV-UZ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:38 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:52446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDg6r-0006hw-PF
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:37 -0400
Received: by mail-it1-x142.google.com with SMTP id x132so2423093itf.2
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 19:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=lnIQMa985gJdik6sa+sHszvNo6LvfSu/P2J8+RNmRRI=;
	b=fwF7saATcYG36I7mpxArvqvB+hz9CGdyS0djqMNEtZ3vrZI2MO8J19/WMqByl3w5aE
	ZKlyJ3m6Xl9JW3J305L2IRw60LJVRJsMYwr7bL3OJAu6umKAKqCtxY4uHbwPjDF3pr3Z
	nBLLNGzIcTVHis5KOC2Y57mB8pCHFXMToaesvXLhIauwBIzw1578A77eCRevgBXXgdMQ
	jwHasHeEmQDFRxu6dQsUw0+LNYYNEQcUD/ZE5y5DpRA36Nq3qgndllo737mKxouzdnsE
	M7tEKzJf4tEaoBiFJqcdIc+pEutMB/vYfpI1zkX9Jfze4Y2o/EzZ0Sdp53elQjnKLnqL
	dXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lnIQMa985gJdik6sa+sHszvNo6LvfSu/P2J8+RNmRRI=;
	b=fEzh8NNF5uwkqn0HhSRfUJ43bSSIfCKWmwf25iure33r96hJOF42W7eyvQf6ZX/x/j
	Y/KhKjKZkb3OwmgQrXXTKm5mM3SoGAHbMCY29NYQ2YCBxoJmiKyhpEIZyxvJwU3kQeZ8
	hOZbYGlYvYvujpj2vNQZXqw7PUyeZ13LKHT9Gry4lfAVA67+EY8AamIaYQUQpYxmnnkK
	3T8qvCdAai1uE21zly8hXv3uVvlm4fV3+v+4yepZKTD+mSlM5uIUpufD3owfNhMH+bVg
	DtO73nCqrx7fx5Uvn10YF2ecafNt8b5Y6aR93JP2AYVXq+5FxyBnEHvcgCIUieINloZl
	j8ZA==
X-Gm-Message-State: APjAAAXkxz0OJ/GH2rv7pAXMUjEOLkiXipv1Bg4kmRRKu4KqnK/fm7rz
	cp1wXcybbH9KbZyUWajK9Mj3kZqSlOyOCw==
X-Google-Smtp-Source: APXvYqxJjjILjB/pw1rTWzwVy1PCeAkoqPBrrrKBtxCbPw7e4rUyJeKIaMgZgQaDwt9/2iL10ZutMQ==
X-Received: by 2002:a24:9a86:: with SMTP id
	l128mr22112710ite.126.1554775417033; 
	Mon, 08 Apr 2019 19:03:37 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	y203sm5969838itb.22.2019.04.08.19.03.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 19:03:36 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 22:01:31 -0400
Message-Id:
 <635e67a22cbc89e73315dd1bb80f9ce65a303523.1554774454.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
References: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::142
Subject: [Qemu-devel] [PATCH v2 07/10] block/pflash_cfi02: Fix reset command
 not ignored during erase
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409020131.mtQOA5BYs4B2lg4FU5lD7766w6XY4QGaYnwx97jRtFY@z>

When the flash device is performing a chip erase, all commands are
ignored. When it is performing a sector erase, only the erase suspend
command is valid, which is currently not supported.

In particular, the reset command should not cause the device to reset to
read array mode while programming is on going.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index be10036886..cb1160eb35 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -325,7 +325,8 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                     pfl->bank_width * 2, value);
         }
 
-        if (cmd == 0xF0) {
+        /* Reset does nothing during chip erase and sector erase. */
+        if (cmd == 0xF0 && pfl->cmd != 0x10 && pfl->cmd != 0x30) {
             if (pfl->wcycle == WCYCLE_AUTOSELECT_CFI) {
                 /* Return to autoselect mode. */
                 pfl->wcycle = 3;
-- 
2.20.1 (Apple Git-117)


