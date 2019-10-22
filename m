Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EDFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825B520684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUxRQIwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825B520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxYB-00038J-Ls
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxHh-0000Oj-9R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxHf-0000Zb-SX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:45:25 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMxHf-0000ZD-Kq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:45:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id f22so16847985wmc.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QVge7cXCIY/J8VzoOmh7ufVtuSZJIoNxcx6cil5SDVk=;
 b=HUxRQIwH/W/zSqdWZ+Jenrujb8AvgPgiIXlrKksiH+Kpmh27wc0bzRjZSpNVem+Fpl
 mxM7hb1eSNWqIT1TrJjntinmGLzXp4Vec+jcjSV08tvfvSWOqk2FYZ5mqBSOQIthQhiP
 gDc5EBiUYzIQQJyyvEpy+bfxJZWSiNN+myTfbFp+MXfFJwfi2i2lAmhjqFaU+nEtwUUP
 3xAUDvakFSOM78G1qq00JgKbTLSUPJTda2yB5vhu4JBRGwFb7n129n44FF6sjeAj/L1K
 NOP4L70ZGPMe9MAzlxfd936tL4BdQmVIs4D5D8WHudVAvAbddjVF4IIRBYcDTGIg6djs
 BSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QVge7cXCIY/J8VzoOmh7ufVtuSZJIoNxcx6cil5SDVk=;
 b=g9V7+BM2Yju/DbGe+vaZvuYvRWeKWFg0e7Qsbna2nb6P8b1CdYTrxudzI6resbr/dX
 1mL707u39sEAXX4XyQl7CsILWu7LPaK9YRs4cHhiz3LGk8E5OwuHLE7kZW/NNNM8endA
 uW5+3Dbrx5heAJAFZYLwZcXkDBcClQxJJ4AaVVWf1G7TbDmRy59Q5SdI5I5zEqaygXbG
 pXe6FsJQFdYfF58sGTzmuWY356MB2Lf8tBHvirvHbtu/52dZQTWU+LZcW/PvYrdEdZey
 1SCgBJ+W3BZE3V2ij0oSCWJW2AQ7T/+VEUrwb9qgFZDpbZlf4KyLXjbkbxZTC/Iqm66c
 CGEA==
X-Gm-Message-State: APjAAAUKpfGZfWhXh4h+93QntaCzOn582QC/GpcZSgHo6ekTYy6Fz3hJ
 myB/0OWEbUpw78qdVZWA3eb2gOgj1zU=
X-Google-Smtp-Source: APXvYqxNeBFOIxhEuyjRjAf17dL0gCIrP4IK36VP0tDf3M6GdQlbBeDxPv8IYX5PE3DEBQFOppTREw==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr3810517wmc.88.1571762721854;
 Tue, 22 Oct 2019 09:45:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g10sm4396289wrr.28.2019.10.22.09.45.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 09:45:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/18] target-arm queue
Date: Tue, 22 Oct 2019 17:45:18 +0100
Message-Id: <20191022164518.6933-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes v2->v3:
dropped the aspeed new board patch as it fails in
tests/qom-test on OSX (intermittently).

thanks
-- PMM

The following changes since commit f9bec781379dd7ccf9d01b4b6a79a9ec82c192e5:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20191022' into staging (2019-10-22 13:45:09 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191022-2

for you to fetch changes up to 90600829b3355b8d27b791b893095c18f529aec3:

  hw/arm/digic4: Inline digic4_board_setup_ram() function (2019-10-22 17:44:01 +0100)

----------------------------------------------------------------
 * Fix sign-extension for SMLAL* instructions
 * Various ptimer device conversions to new transaction API
 * Add a dummy Samsung SDHCI controller model to exynos4 boards
 * Minor refactorings of RAM creation for some arm boards

----------------------------------------------------------------
Guenter Roeck (1):
      hw/timer/exynos4210_mct: Initialize ptimer before starting it

Peter Maydell (7):
      hw/timer/arm_mptimer.c: Undo accidental rename of arm_mptimer_init()
      hw/timer/puv3_ost.c: Switch to transaction-based ptimer API
      hw/timer/sh_timer: Switch to transaction-based ptimer API
      hw/timer/lm32_timer: Switch to transaction-based ptimer API
      hw/timer/altera_timer.c: Switch to transaction-based ptimer API
      hw/watchdog/etraxfs_timer.c: Switch to transaction-based ptimer API
      hw/m68k/mcf5208.c: Switch to transaction-based ptimer API

Philippe Mathieu-Daudé (9):
      hw/sd/sdhci: Add a comment to distinct the i.MX eSDHC functions
      hw/sd/sdhci: Add dummy Samsung SDHCI controller
      hw/arm/exynos4210: Use the Samsung s3c SDHCI controller
      hw/arm/xilinx_zynq: Use the IEC binary prefix definitions
      hw/arm/mps2: Use the IEC binary prefix definitions
      hw/arm/collie: Create the RAM in the board
      hw/arm/omap2: Create the RAM in the board
      hw/arm/omap1: Create the RAM in the board
      hw/arm/digic4: Inline digic4_board_setup_ram() function

Richard Henderson (1):
      target/arm: Fix sign-extension for SMLAL*

 hw/arm/strongarm.h        |  4 +--
 include/hw/arm/omap.h     | 10 +++----
 include/hw/sd/sdhci.h     |  2 ++
 hw/arm/collie.c           |  8 ++++--
 hw/arm/digic_boards.c     |  9 ++-----
 hw/arm/exynos4210.c       |  2 +-
 hw/arm/mps2-tz.c          |  3 ++-
 hw/arm/mps2.c             |  3 ++-
 hw/arm/nseries.c          | 10 ++++---
 hw/arm/omap1.c            | 12 ++++-----
 hw/arm/omap2.c            | 13 ++++-----
 hw/arm/omap_sx1.c         |  8 ++++--
 hw/arm/palm.c             |  8 ++++--
 hw/arm/strongarm.c        |  7 +----
 hw/arm/xilinx_zynq.c      |  3 ++-
 hw/m68k/mcf5208.c         |  9 ++++---
 hw/sd/sdhci.c             | 68 ++++++++++++++++++++++++++++++++++++++++++++++-
 hw/timer/altera_timer.c   | 13 ++++++---
 hw/timer/arm_mptimer.c    |  4 +--
 hw/timer/etraxfs_timer.c  | 23 +++++++++-------
 hw/timer/exynos4210_mct.c |  2 +-
 hw/timer/lm32_timer.c     | 13 ++++++---
 hw/timer/puv3_ost.c       |  9 ++++---
 hw/timer/sh_timer.c       | 13 ++++++---
 target/arm/translate.c    |  4 ++-
 25 files changed, 174 insertions(+), 86 deletions(-)

