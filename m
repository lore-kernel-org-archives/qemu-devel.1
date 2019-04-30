Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29009C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 04:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACC52075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 04:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsA8ij/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACC52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39017 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLKap-0007Or-RJ
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 00:42:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZc-0006bj-3c
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZb-0002by-93
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:40:56 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hLKZZ-0002aq-9G; Tue, 30 Apr 2019 00:40:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id i21so2788250pgi.12;
	Mon, 29 Apr 2019 21:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=gFbCi86uIEW652j72gzX8jjTJZ5WmXcv260laN5+gkQ=;
	b=nsA8ij/7y8hg+m8GN0iqRVa7Zh9WGVvC1rb1lC0CUVbrmNuM/1CbSjtPJ9a3UCT+iM
	/2/l3cYO7ctzW0OT5aHjjxjZn1ob/Z/KrRYv9azK9DoLppERS4NP4xBPV2HbndBcc5rr
	HwIzpIV2sLtGyGFciBN/U+BkrGSGGQhvFw2MhCLYO50ydFzzzFU00Q/ucNN6eAgxW5Iu
	NN7BzpJmYDyiWlvD/Y4HwyoYqHHuJKslFBYNtuHBTXlERmtBbG6rUhN+pherr6UBb4ng
	nW1iVYw1tsWEEHidffFxIXXzioDkz+bbMWTsk6kCLe6T2hK5fnuBpcj9Wfa6QbD7HM/d
	iJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=gFbCi86uIEW652j72gzX8jjTJZ5WmXcv260laN5+gkQ=;
	b=AJxkrbe855VjyoXqhLk16BS3g8JEDkXdErpYvNbKuk+slx7TDyRJhQaZ61hxWHRvbX
	Kx9o9prx2/9OeaBaoAX1ogjCXd03BkmbV5+GjMdQb69MJ60V0Y8AUVFQpk+GvT0Y3Ko2
	mYR9tkxosFAy3w5KWuAPvJfPRQVLWDkiK6ZOovcmf0SEs3Dd3TJVqw40PyXImLQKMV57
	04cz3NIHCOR9cI6BN3fko5CbAiSwKgZM2EXgM5aDI7mtIK0QLulCkXKO9tCGaHVwK2Ii
	w24Fn4F1Z2GXaNonq7fNElxB7vRVmwf5WImyJA/UTKsOYAVyU7IN58k+qVKGHXrYGu2e
	5/UQ==
X-Gm-Message-State: APjAAAUOiHp9cqO9IDFJYqQkoFAqaWh6zoEwKaiaeXvCzwFajRgX7MaB
	/ktzdEcYMTsdiqc3HmC5wXo=
X-Google-Smtp-Source: APXvYqwWPHU3fBBpv/Sw43QSuFU3MK3m6oO3GEPTccVrgo/4Sq84gNbMcBZClmaKblQae25hdtadfg==
X-Received: by 2002:a63:117:: with SMTP id 23mr34286pgb.34.1556599251288;
	Mon, 29 Apr 2019 21:40:51 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
	by smtp.gmail.com with ESMTPSA id
	e11sm25312107pfd.151.2019.04.29.21.40.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 21:40:50 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
	Tue, 30 Apr 2019 14:10:44 +0930
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 30 Apr 2019 14:10:33 +0930
Message-Id: <20190430044036.1144-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 0/2] arm: aspeed: Add RTC Model
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430044033.UWy0ymWK2odsNudvluZMr0Az_OQMGpttkQdtw_Eehe4@z>

v3: Add some commit messages, resend as v2 didn't send properly
v2: Minor fixes, added vmstate and reset, and rebased on Cédric's series

Based-on: 20190411161013.4514-4-clg@kaod.org
[PATCH 3/3] aspeed: use sysbus_init_child_obj() to initialize children

A model for the ASPEED BMC real time clock (RTC). The model is sufficient
for running the guest Linux kernel driver, and ticks in time with the
host when programmed.

It does not implement the alarm functionality, which includes the
interrupt.

Joel Stanley (2):
  hw: timer: Add ASPEED RTC device
  hw/arm/aspeed: Add RTC to SoC

 hw/arm/aspeed_soc.c           |  13 +++
 hw/timer/Makefile.objs        |   2 +-
 hw/timer/aspeed_rtc.c         | 180 ++++++++++++++++++++++++++++++++++
 hw/timer/trace-events         |   4 +
 include/hw/arm/aspeed_soc.h   |   2 +
 include/hw/timer/aspeed_rtc.h |  31 ++++++
 6 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 hw/timer/aspeed_rtc.c
 create mode 100644 include/hw/timer/aspeed_rtc.h

-- 
2.20.1


