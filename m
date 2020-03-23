Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C42CC54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7277B2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScG0nRMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7277B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGR5A-00062Q-DR
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3h-0004Ob-UE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3g-0003hM-IG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGR3g-0003d2-5t
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id c81so301468wmd.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+sdCGXZ0IH39nXvNC2u1iOLChVbNjxfhaAdkIpUlxus=;
 b=ScG0nRMunN6UkHbL6ofwZGgl7PqEr+TpHwO3MZLIDEDykB0XrNU6JTAxrpgVOQOjCR
 jgcXMJVvsJ2Cj7i4ZEBmTMc9x8xpLMbwqMqo4ouqeZnxzi8Cbg9iayl7jHvPTVXTOii1
 ObYEqhratblHuedkRZdjwo1t9Ylqzbi99/8sp+NVjxwfHpmAxo3i8xhfi2hgRADk5RJ/
 DWuJpkimojmgdDJ/kWdo9GSTUUKOE1c6WiF03Kk95VEpOS7TfG8g33Wc20KhXmzMq5hW
 TbgtfYsNey1V3/AJnagr+lNmCXhUplGtJA9734N8TxXb5Sxm4mniFebo+wHvSa97hnp0
 4OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+sdCGXZ0IH39nXvNC2u1iOLChVbNjxfhaAdkIpUlxus=;
 b=djFq9ryczRksS0p9yL8MoNHQeoGg/voftoyhLHhgeLUEz6GNv1fgYxMGqqdViQWLNP
 Rxbl7PaZrEAFofB30Fj0AFZ5JJU+8vs35+VUl9hdX6qXfJixyXUOaR5V1ksGoYBYcV09
 JPO0/8P/0uTR1nXG5Yln/s2LXz1sJ3AOjxThhFHvMXt/2EwgtmrEF9/gHBjHuCaaOBFG
 bv0FtBmtzBe0eERs399Ks4AwER6C5MgV+bMuaU5yK/lu957RR18QcCWyJt1HOXDGhzxh
 7C26Dg13PbXX3DiYBtoGzjYT2ryAhRkWRclRY4aJfMrClKtWOgONB+UwwHJzYVduP8ee
 lnQQ==
X-Gm-Message-State: ANhLgQ3lmgjFbcux+HX23uWj5rsrHRq7FLS/pVJM8EA+I4z1audhotuG
 vsxqSkLAK1rcxm+WSGxOHJV8H7ZYRYzvFQ==
X-Google-Smtp-Source: ADFU+vuFwQIj2laXeTCHAHOPYo1adea0RF/SDU9+nSlTxIV/IZiljXAoi94jVJ3sOCrs5uDwRCKGPQ==
X-Received: by 2002:a05:600c:21d2:: with SMTP id
 x18mr396725wmj.75.1584985209739; 
 Mon, 23 Mar 2020 10:40:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm25145282wrw.20.2020.03.23.10.40.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 10:40:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] target-arm queue
Date: Mon, 23 Mar 2020 17:40:01 +0000
Message-Id: <20200323174006.8468-1-peter.maydell@linaro.org>
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

Just a few minor bugfixes, but we might as well get them in
for rc0 tomorrow.

-- PMM

The following changes since commit 787f82407c5056a8b1097e39e53d01dd1abe406b:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200323' into staging (2020-03-23 15:38:30 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200323

for you to fetch changes up to 550a04893c2bd4442211b353680b9a6408d94dba:

  target/arm: Move computation of index in handle_simd_dupe (2020-03-23 17:22:30 +0000)

----------------------------------------------------------------
target-arm queue:
 * target/arm: avoid undefined behaviour shift in watchpoint code
 * target/arm: avoid undefined behaviour shift in handle_simd_dupe()
 * target/arm: add assert that immh != 0 in disas_simd_shift_imm()
 * aspeed/smc: Fix DMA support for AST2600
 * hw/arm/bcm283x: Correct the license text ('and' vs 'or')

----------------------------------------------------------------
Cédric Le Goater (1):
      aspeed/smc: Fix DMA support for AST2600

Philippe Mathieu-Daudé (1):
      hw/arm/bcm283x: Correct the license text

Richard Henderson (3):
      target/arm: Rearrange disabled check for watchpoints
      target/arm: Assert immh != 0 in disas_simd_shift_imm
      target/arm: Move computation of index in handle_simd_dupe

 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 include/hw/arm/bcm2836.h             |  3 ++-
 include/hw/char/bcm2835_aux.h        |  3 ++-
 include/hw/display/bcm2835_fb.h      |  3 ++-
 include/hw/dma/bcm2835_dma.h         |  4 +++-
 include/hw/intc/bcm2835_ic.h         |  4 +++-
 include/hw/intc/bcm2836_control.h    |  3 ++-
 include/hw/misc/bcm2835_mbox.h       |  4 +++-
 include/hw/misc/bcm2835_mbox_defs.h  |  4 +++-
 include/hw/misc/bcm2835_property.h   |  4 +++-
 hw/arm/aspeed_ast2600.c              |  6 ++++++
 hw/arm/bcm2835_peripherals.c         |  3 ++-
 hw/arm/bcm2836.c                     |  3 ++-
 hw/arm/raspi.c                       |  3 ++-
 hw/display/bcm2835_fb.c              |  1 -
 hw/dma/bcm2835_dma.c                 |  4 +++-
 hw/intc/bcm2835_ic.c                 |  4 ++--
 hw/intc/bcm2836_control.c            |  4 +++-
 hw/misc/bcm2835_mbox.c               |  4 +++-
 hw/misc/bcm2835_property.c           |  4 +++-
 hw/ssi/aspeed_smc.c                  | 15 +++++++++++++--
 target/arm/helper.c                  | 11 ++++++-----
 target/arm/translate-a64.c           |  6 +++++-
 hw/ssi/trace-events                  |  1 +
 24 files changed, 76 insertions(+), 28 deletions(-)

