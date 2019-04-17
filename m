Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A296C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202AC20693
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="0WdmqvmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202AC20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60437 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGsmU-0005vg-7w
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 18:11:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdU-00075N-Ao
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdT-0004aV-8f
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:32 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:51164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hGsdT-0004Zn-3B
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:31 -0400
Received: by mail-it1-x143.google.com with SMTP id q14so287918itk.0
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=lnIQMa985gJdik6sa+sHszvNo6LvfSu/P2J8+RNmRRI=;
	b=0WdmqvmM9WsW8nviqC9mZPt/4QETM7KhNqGO7xVnkykBbyp2xWgl0iqHE/0+bhVA80
	b5tUuOZAN7cx4bHMX4whT2A4LSAiIy/QfLYKW2eAkjOFs7yY4FWwgU5TmBGJkySlPdC+
	kwVzdrHrvKwhyeIh9BIte9X3p55YfLuHiJwK1SlSTfOfWsjj6BGdSwbnKXaL7IsYWNYw
	khIPCm3WgaaFoZgL01aGqxJN6ixvOUzK6erWTRyS3ilEpDRQ0CArxum2FZu0fmH+CNdq
	xsskmAK0p80qh+1P60Q3wQPo1Qiqi2cDSnWb0RInnyGzt2JgUx+WgInKps4TAoHp994O
	S09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lnIQMa985gJdik6sa+sHszvNo6LvfSu/P2J8+RNmRRI=;
	b=hL5TUEJyiTPv0AC9rxci66rP/gDVgv9a7PI06IMuJf/+S6kY6VBjThd/lhHjZ4/ipj
	n8jCixDbDbsoiQrowpIWyAl7IiXiOVLHY7EqwDR03czmOnQftS8m8BIDkLjVvXykoShC
	h7uCsHDzIzlHwX0tx1eu/pILyvtpxQN3MihYgNP86sUhome9UG2zMYwJJwgKN2PIgbZ+
	nFDacmyHO/U2JsBQt/yDt1xk2UjAHBkREBAbJyRw/oMRbecR/XeEGl1W5EUar5Vb3104
	oD+laiNE99E7VjgjMNEmtB9MDZT9bwTU6Hi7JKjllOqcjBGfOqZygsO+miOwvOoA2jp9
	ipzw==
X-Gm-Message-State: APjAAAXpA/hQWMO1Jmnm21wDYihaDlNl9uImSvDKVMMwnD8ZYQjZRp8b
	r17kM9do0pZ0Z3SWPesGlPiKd2hLk7gckf7C
X-Google-Smtp-Source: APXvYqxOVAo0eFdBWx7lz2F0G8HRvnK0rwyzUkyWhyEx93AbmwhsPmm6ztP7m+6Y7GaFzW+F0ab3DA==
X-Received: by 2002:a24:7354:: with SMTP id y81mr693665itb.87.1555538550451;
	Wed, 17 Apr 2019 15:02:30 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93])
	by smtp.gmail.com with ESMTPSA id e81sm147874itc.3.2019.04.17.15.02.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 17 Apr 2019 15:02:30 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2019 18:01:44 -0400
Message-Id: <20190417220147.67648-8-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH v3 07/10] block/pflash_cfi02: Fix reset command
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417220144.UNTaAkX-93ZBFCGXzJ-WshTt7KeXHNfUIriPzM6qLgQ@z>

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


