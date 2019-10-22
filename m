Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2A3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D62214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLpIgDmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D62214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwYp-0005OT-1K
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMwWv-0004Td-8h
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMwWt-0001Ja-UQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:57:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:32998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMwWt-0001Hm-NC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:57:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id 6so3983371wmf.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TGso5ABDkcNKxlbR6FgRltGA0d4knGh6DjdcFkIjQgU=;
 b=rLpIgDmo9ndaB26xzSeOiMCwb2FcT7s3gC0QD7zwHRfAYS1gdTNZekhQJF33xEXTV/
 wTns5eNjuHFMoG/UNeeY/hXCMEpUpIh6Uh5OpS3TWkMRDMFAb7pvYfz7kF5KZZm8oytC
 tokZwgSV+BNtZkrigb8zsJkr+5DLGPMmbDNiobB1dbnoPEIC8EbaoQtX3vy5Ogm7M14n
 dDDlEUUHAcV3VDWjWOzogyvw+zmQFjLEtCyAkj4d09FUcSAyCokKaaMhHjs/kBQcBzrQ
 VPQXT5J7j0YiVUGlEqpDxGQQ+MzzuHqytFngzuNJQftEy2jbKXX9T1mLJL+g8V8NIrfI
 yscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TGso5ABDkcNKxlbR6FgRltGA0d4knGh6DjdcFkIjQgU=;
 b=EdBPyASkmV7+DoVJGkSvwyYcTB9wgDx2kym5UNY8Enj8/TOwC7FIMyhsBe14BUc+PI
 LNjmlj29YLqYg8vSyLcI4GIV/aj1undlGoNKzeYe5jX8wqYURbqx6h67wXvv/NHqZN1Q
 G2EBtl9+yCPJko3Xr0Cu/5ghwvLPOJXZZTwm8w4PaF6Bt838Z7YagT0XgRmPxFoHjoiV
 DaNQKs4hcQHeZbS7sNC3WXndV7BelAalmmP0+/bL9FOqmwjj07CcPoy11epdoCCL6q5v
 JAKGUCyBAt2AfVCFgH8HbUdoUnkjUWCkUpB0ITfATQYHq5Zr5wo4kPyFyqGZSE8I7+Bz
 CUkw==
X-Gm-Message-State: APjAAAX+2DXmNc1drSTyRcTnB0SyO/fm9ZpJ/0Q6qKQfv8twuZqKkkOb
 J74eaBCp1DuJZju6no5bUqBSU16xWOk=
X-Google-Smtp-Source: APXvYqxh4k2Kf9yJ7Zyz+tloyUBI7jMEmpdE8uBkKHGdI1bNwugFz800OlSsQv309p7eiioS9PBItA==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr3369133wmc.24.1571759820665; 
 Tue, 22 Oct 2019 08:57:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z125sm25937907wme.37.2019.10.22.08.56.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 08:56:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/19] target-arm queue
Date: Tue, 22 Oct 2019 16:56:58 +0100
Message-Id: <20191022155658.18323-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

Changes v1->v2: dropped rth's patchset as it causes an
assert with the qemu-armeb binary.

I expect I'll do another pullreq at the end of the week.

thanks
-- PMM

The following changes since commit f9bec781379dd7ccf9d01b4b6a79a9ec82c192e5:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20191022' into staging (2019-10-22 13:45:09 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191022-1

for you to fetch changes up to f9c1fe62a16f32c3d6fe34c2856475052b7efdaf:

  hw/arm/digic4: Inline digic4_board_setup_ram() function (2019-10-22 16:50:38 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix sign-extension for SMLAL* instructions
 * aspeed: Add an AST2600 eval board
 * Various ptimer device conversions to new transaction API
 * Add a dummy Samsung SDHCI controller model to exynos4 boards
 * Minor refactorings of RAM creation for some arm boards

----------------------------------------------------------------
Cédric Le Goater (1):
      aspeed: Add an AST2600 eval board

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
 include/hw/arm/aspeed.h   |  1 +
 include/hw/arm/omap.h     | 10 +++----
 include/hw/sd/sdhci.h     |  2 ++
 hw/arm/aspeed.c           | 23 ++++++++++++++++
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
 27 files changed, 198 insertions(+), 86 deletions(-)

