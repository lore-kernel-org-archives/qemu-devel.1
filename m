Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A33C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BCE21872
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdCkKLDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BCE21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUgvm-0002x3-FY
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 19:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUgtL-0001N4-5c
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUgtK-0005HQ-Ac
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:15 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUgtI-0005Gx-Aq; Tue, 12 Nov 2019 19:52:12 -0500
Received: by mail-pf1-x443.google.com with SMTP id p26so340987pfq.8;
 Tue, 12 Nov 2019 16:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m0HBsUHijHgIFgKZm6EaOmXclG6Mq1OAILNKtGWTkEo=;
 b=YdCkKLDlfhZ7DEoutIRY0whTzWTnnVTMNKC9DOU4MbEJxARyKdJrGxggCJezsGNnoN
 vRCR3qKFhGDtcUPfUNlHZDX6NXpxt0N2DhvRjrr15HCrb2CaZB+v4p4P3gZZq896wWUT
 EDFSPZSm7oCMuWLeXxvmrd3aSZ5+EEgcZla/rsN1A9svUIUcVQ42azydht1SVvUQs/Cy
 8TLmf0ZKm5+wYjJbYfhCbMyXh6xMcqtXNAVnhHV62FSwyDQUmbEGBJIFqtUJYt7rdClE
 iIxmR0Bq+oCUfDesn7R0jSnntnBr0L5eKoXvHeW8pokviHzSRYS0TxRCKlOA8MNMI5Jo
 CxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=m0HBsUHijHgIFgKZm6EaOmXclG6Mq1OAILNKtGWTkEo=;
 b=E26aJt9g/nW2RqbOP7Kdsgnz83lwam1cAHAJHZV9MkOsiZ/va0NCHBKve9KyEeIo6c
 /n4TAjuvIfMSH01eEefephTknyz4LqPtj2XcfvT7XgHTLFb5105xH1oU1b7nVqnZEB2D
 IRM98UFw1UfTIj4nJDLtVeFpfvO7umPG0EUW5jqaLY95DHe6EcbEZwb8Jn+x21gstJgv
 cLIWeYGflOjZ6aSMFDYrw6puBompzCYZTmnjtRVJ3ZvyRFcT6kHBjdXko6EAJgXVOyAM
 +fb/FNrAEwgpNBBwZMKDKpt+yFCTkZIPd/TvThSDwdMlfIns9DB0NAB7FU19q3dhaH1f
 0L2Q==
X-Gm-Message-State: APjAAAX7UW3UVePJKLgm6LgQwI450yZ2kH1xenyvc3IOle9yw/B4Z1n8
 JJ4dkvMgrz7+3JUwUwIzhV4=
X-Google-Smtp-Source: APXvYqwRdtwXay8bJuzN8va72JlQTpVz1GC3aYrcrIAC8r7NxkN4vSKqy6ZKNa1WgIu4KqMDexlyEg==
X-Received: by 2002:a17:90b:11cb:: with SMTP id
 gv11mr890469pjb.61.1573606330778; 
 Tue, 12 Nov 2019 16:52:10 -0800 (PST)
Received: from voyager.ozlabs.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id i13sm169848pfo.39.2019.11.12.16.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 16:52:10 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 0/4] arm/aspeed: Watchdog and SDRAM fixes
Date: Wed, 13 Nov 2019 11:21:57 +1030
Message-Id: <20191113005201.19005-1-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Three of these are fixes for ast2600 models that I found when testing
master. The forth is a usability improvement that is helpful when
diagnosing why a watchdog is biting.

v2 fixes some review comments from Cédric and adds his r-b.


Joel Stanley (4):
  aspeed/sdmc: Make ast2600 default 1G
  aspeed/scu: Fix W1C behavior
  watchdog/aspeed: Improve watchdog timeout message
  watchdog/aspeed: Fix AST2600 frequency behaviour

 hw/misc/aspeed_scu.c             | 11 ++++++++---
 hw/misc/aspeed_sdmc.c            |  6 +++---
 hw/watchdog/wdt_aspeed.c         | 24 +++++++++++++++++++-----
 include/hw/watchdog/wdt_aspeed.h |  1 +
 4 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.24.0


