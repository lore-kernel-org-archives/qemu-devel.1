Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAFBFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A917E2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOXaLxnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A917E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL644-0007Zp-Ha
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5q3-0006iV-Dy
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5q1-0002YP-6G
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5q0-0002Y3-W7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id y135so7047655wmc.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nyhhqAl7Z9TETz1bn0jRLKleGGKQCC3sDu2+swR1V/Q=;
 b=IOXaLxnFPFP114/5iBdVo9nM8yQ6CF8C5XkHTeF4X+P2HaOkY8YEujVpM1B9nK3CFO
 t3RG6t6aBif2BCt95EH10WeVZA90Pdvk+67NSFh4UIO6Zh1mJ8CI4cpIWZ36BUMpvIk8
 Ps5DWiSATCkuNu3u9pMKrQEpDjjpu3JEKy935dTB+3FnBmERR4PwLoYkuoXs370gqbrj
 q1JcwggXF5iVsn6LXbWuK1BKUEMjRtbRW7sLSYHUK9dxYxVoRRmCr38hdKwDSM7PG7LI
 txJn7YDR63Ow/2l+RHguZFTWm+vo9uN/M2WQ0noW+pYATgEQAPsPzIIC7DW+EPwF9g0V
 uQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nyhhqAl7Z9TETz1bn0jRLKleGGKQCC3sDu2+swR1V/Q=;
 b=KDr5hTOaQ8p0Tz+oMJB9SjtA9jKXlnFGnWc+XK9h3oJmpy86jcnYsJCSY0+8q6LADa
 bie9yd6ner86ojpwC+5O+QHUijZQjJHO0HU2Vtvu8klEslOE47/NS1Kah7zcDcdRrwwx
 RwO/JxmHrt/XpO7P3dkyoKvshxZazAHyOaidoT4ZFD7O8aIAI2VDDR//txTH9NFM9r7p
 axkvyXwnVt2FiWMfC/eCuRfNI6QRuCd/K33Ktx3tcr5qIT3m6b5sDA6v5INVuS7tfQS/
 auZi322wA1xKqVRTV0G8cJ2pAUeJxjAdNpgawE59TYQ35bF6vysvf8DtjHE6bd/i8W7f
 uA+Q==
X-Gm-Message-State: APjAAAUr06eJl6vLRPGSa586Go78rTpJoV00Xx3M6knGoyhdABX9q3Wa
 dE46wKR+S264tBbhQDFXKYA0+LGSq7bFyQ==
X-Google-Smtp-Source: APXvYqw1ZuqLx7pyT1T96ajKzMA9S1mSs0WG+97qVqxXtxWd/SlgQmsqOHSG6ipoA6N5vlLbFdHwdA==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr2908563wmi.100.1571318947449; 
 Thu, 17 Oct 2019 06:29:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n15sm2703392wrw.47.2019.10.17.06.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:29:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] Convert misc-arch devices to new ptimer API
Date: Thu, 17 Oct 2019 14:28:57 +0100
Message-Id: <20191017132905.5604-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the devices used by the miscellaneous minor
architecture machines to the new ptimer API. More specifically:

cris:
 hw/timer/etraxfs_timer.c

lm32:
 hw/timer/lm32_timer.c
 hw/timer/milkymist-sysctl.c

nios2:
 hw/timer/altera_timer.c

sh4:
 hw/timer/sh_timer.c

unicore32:
 hw/timer/puv3_ost.c

m68k:
 hw/m68k/mcf5206.c
 hw/m68k/mcf5208.c

Currently the ptimer design uses a QEMU bottom-half as its mechanism
for calling back into the device model using the ptimer when the
timer has expired.  Unfortunately this design is fatally flawed,
because it means that there is a lag between the ptimer updating its
own state and the device callback function updating device state, and
guest accesses to device registers between the two can return
inconsistent device state. This was reported as a bug in a specific
timer device but it's a problem with the generic ptimer code:
https://bugs.launchpad.net/qemu/+bug/1777777

The updates to the individual ptimer devices are straightforward:
we need to add begin/commit calls around the various places that
modify the ptimer state, and use the new ptimer_init() function
to create the timer.

Testing I have done:
 * 'make check'
 * running a milkymist system image I had lying around
 * running an sh4 system image

This doesn't exercise the devices very much, so more specific testing
would be appreciated. I plan to collect these patches up and
get them into the tree with other ptimer-related changes (probably
via target-arm just for convenience) unless anybody would specifically
like to take a patch via some other tree.

thanks
--PMM


Peter Maydell (8):
  hw/timer/puv3_ost.c: Switch to transaction-based ptimer API
  hw/timer/sh_timer: Switch to transaction-based ptimer API
  hw/timer/lm32_timer: Switch to transaction-based ptimer API
  hw/watchdog/milkymist-sysctl.c: Switch to transaction-based ptimer API
  hw/timer/altera_timer.c: Switch to transaction-based ptimer API
  hw/watchdog/etraxfs_timer.c: Switch to transaction-based ptimer API
  hw/m68k/mcf5206.c: Switch to transaction-based ptimer API
  hw/m68k/mcf5208.c: Switch to transaction-based ptimer API

 hw/m68k/mcf5206.c           |  9 +++++----
 hw/m68k/mcf5208.c           |  9 +++++----
 hw/timer/altera_timer.c     | 13 +++++++++----
 hw/timer/etraxfs_timer.c    | 23 +++++++++++++----------
 hw/timer/lm32_timer.c       | 13 +++++++++----
 hw/timer/milkymist-sysctl.c | 25 ++++++++++++++++++-------
 hw/timer/puv3_ost.c         |  9 +++++----
 hw/timer/sh_timer.c         | 13 +++++++++----
 8 files changed, 73 insertions(+), 41 deletions(-)

-- 
2.20.1


