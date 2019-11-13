Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00A8C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74DE206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYSnFNi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74DE206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV0xN-0003h1-Ff
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iV0t4-0001iP-6e
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iV0t3-00011m-9F
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:13:18 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43733)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iV0t0-0000yS-T7; Wed, 13 Nov 2019 17:13:15 -0500
Received: by mail-pl1-x644.google.com with SMTP id a18so1646031plm.10;
 Wed, 13 Nov 2019 14:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ufOagEkF5eMwDKIkGywA+c2/zP6DlOH3JxK6kKvdjE8=;
 b=CYSnFNi91bJlOKbK/Oh6pt2YKRWLIjBx6Gj1HXL01lyESCT/tnz6bgqaDp5/upyESZ
 FYA4HRSDbg9sEYrXhbQvmKLFghRlhDAHf9P+aE+lEs6UBjGgtE2fTQMTA/C0YpreEuth
 WcysJua/ze6L/9JBV7a5QBV2e+0WhN3eripZ7a1NwVFEFB/+pSlF1bd+8heofmxk7636
 eEO4oo7mh7H86mBognxeasVVNqpXn3ULRQ8Dhu5ZUNPlvupRWQnWMsOoWdFo+lSn8B2y
 zi/RQsOWrO53qjJtVSjfYMwjQXz1m3BtZNDHHhMhOUpcXVobxI9ijJf/suzrlPz9S1CO
 lnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ufOagEkF5eMwDKIkGywA+c2/zP6DlOH3JxK6kKvdjE8=;
 b=QPshFHTwJTms+Nfp1jWUtGA8rogQ2ku6fOr8T/GH5Yd6cuactmtJ5doVBd2npEPS92
 QLqdPMEWJZ/nG2YIZtt1kEs289Cbhqf/4ZSqiudVmk1bUxcJcHyekjVjLCaObQQ8GH8k
 ePltN52NSQYihRNs7ktCY1OqX71mpyWJaWlLx3jUfjCtXElsO9zqOUZocAcCM/BbqnTm
 ASa9rSg5KcDvaGj/9SYpwskdPIhKXpwNVPzsoMexOHUbtoTlstQUyQs0HKjShRjDEWHa
 PRwrOxhorr5JiHM51XjHrp5wooJqm8oaEIX5MctXj2pd7YIQBoMuxjquKCD0EdPYdD35
 w/LA==
X-Gm-Message-State: APjAAAXq/HjoNi2y08fGTzTUv5bOF6e/QUk81Wy48qwZOELgMjw7qUGt
 eOdq2rtEnFMiPZV9D0ZIys8=
X-Google-Smtp-Source: APXvYqz2DQ5LizG9g65X9Em+nEhcxKPI+Te+nQPxr2SxI8WMKsHrdvy3UBFsT+sdogErrdyWLjw1dg==
X-Received: by 2002:a17:902:9683:: with SMTP id
 n3mr5933541plp.53.1573683192123; 
 Wed, 13 Nov 2019 14:13:12 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
 by smtp.gmail.com with ESMTPSA id w69sm5252005pfc.164.2019.11.13.14.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 14:13:11 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 0/4] arm/aspeed: Watchdog and SDRAM fixes
Date: Thu, 14 Nov 2019 08:42:57 +1030
Message-Id: <20191113221301.8768-1-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Three of these are fixes for ast2600 models that I found when testing
master. The forth is a usability improvement that is helpful when
diagnosing why a watchdog is biting.

v3 adds some comments and fixes whitespace, and r-b from Alex. Thanks
for the review Alex.

v2 fixes some review comments from Cédric and adds his r-b.

Joel Stanley (4):
  aspeed/sdmc: Make ast2600 default 1G
  aspeed/scu: Fix W1C behavior
  watchdog/aspeed: Improve watchdog timeout message
  watchdog/aspeed: Fix AST2600 frequency behaviour

 hw/misc/aspeed_scu.c             | 15 +++++++++++----
 hw/misc/aspeed_sdmc.c            |  6 +++---
 hw/watchdog/wdt_aspeed.c         | 24 +++++++++++++++++++-----
 include/hw/watchdog/wdt_aspeed.h |  1 +
 4 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.24.0


