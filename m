Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A063C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9922080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEj8+lM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9922080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1FZ-0000DE-02
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51701)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FD-0007l2-01
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FB-00068Q-8f
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1FA-000677-4Z
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id x15so15239300wmj.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UWX6QXmDoFJ278a9HbBPA6R32kk9R+Iufwr/0nC+PpM=;
 b=nEj8+lM7xmc3d8v6YX+53PtO/QnDY+ZUp4EUEv9Rl5hEN9R1OtWIDhTeFmtTYIQ7xM
 sfGdE/ehgqS6l8QumXk6i4oEmwaUURDYCXlD9IUhaz5VZ2orIk/nkqfDrUfzon4u79MN
 C5idVY8bqcHHJzwdALCNVQqjSURIkopYnakPmi/lWeW80rZLKiFfcScqk0aHbtzNLjRY
 XRpMc3wCTc/FnyLfVPPhMdZv8RLID1iySpKc69NrcqAzy/14MrP11N5OAOz6qyjtdW4K
 82iClO+44f6nrGYFxIQRlhP+313l12JV6fskiyDV8aZuztIXXT4+pxG/KeoPYwbv5JwO
 yaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UWX6QXmDoFJ278a9HbBPA6R32kk9R+Iufwr/0nC+PpM=;
 b=hfVZEmvUtZNoBeH7yh7C943TuDnlYwGAjHNF3Ts8JFykxSi+SpFJ7f/WHFixqWl+cN
 pxNpxQX2JPWK4hkojlBwXyliaOoi7/yOjFXnnwak/0749ChXSGQE2mfUWVssc1ZxTdpy
 PR1KwK6BWtc3/L89fPos8ZChPiHT/t+kkJTNbHnettJljbe+rpwboUfSflKcMvgJcEuS
 XRZd2azm0CDApDCRhmvcPDP/bZq0PbspmrbwBqtVUwYsc6YHAXCFrZcxj6tfi+Zo00/+
 EyDKG4sNsYVHJemi21dh9GL96wFS+CZFELK2ocMQRx3M+JcPynzocGWtFcudzdjRNPlR
 oC3g==
X-Gm-Message-State: APjAAAU4RBhVnwi1lAKlgDL6HPpQwtZJ6bZGklXfWWDV2Zw//pCwJ3PT
 yHi3narF6s+Q71h8dsL7I8S0IyoR4Oxkqw==
X-Google-Smtp-Source: APXvYqyh4rZ4Jn+PxnVCOUaufmoMsIRD4GTgUDLy7XojCegxZD10QwdpYwzi+VqiTSQFM5xfBVy6ZA==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr24759206wma.120.1563198133046; 
 Mon, 15 Jul 2019 06:42:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm14221808wro.70.2019.07.15.06.42.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 06:42:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 14:42:01 +0100
Message-Id: <20190715134211.23063-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 00/10] target-arm queue
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

target-arm queue for rc1 -- these are all bug fixes.

thanks
-- PMM

The following changes since commit b9404bf592e7ba74180e1a54ed7a266ec6ee67f2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20190715' into staging (2019-07-15 12:22:07 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190715

for you to fetch changes up to 51c9122e92b776a3f16af0b9282f1dc5012e2a19:

  target/arm: NS BusFault on vector table fetch escalates to NS HardFault (2019-07-15 14:17:04 +0100)

----------------------------------------------------------------
target-arm queue:
 * report ARMv8-A FP support for AArch32 -cpu max
 * hw/ssi/xilinx_spips: Avoid AXI writes to the LQSPI linear memory
 * hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[]
 * hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO
 * hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO
 * hw/arm/virt: Fix non-secure flash mode
 * pl031: Correctly migrate state when using -rtc clock=host
 * fix regression that meant arm926 and arm1026 lost VFP
   double-precision support
 * v8M: NS BusFault on vector table fetch escalates to NS HardFault

----------------------------------------------------------------
Alex Bennée (1):
      target/arm: report ARMv8-A FP support for AArch32 -cpu max

David Engraf (1):
      hw/arm/virt: Fix non-secure flash mode

Peter Maydell (3):
      pl031: Correctly migrate state when using -rtc clock=host
      target/arm: Set VFP-related MVFR0 fields for arm926 and arm1026
      target/arm: NS BusFault on vector table fetch escalates to NS HardFault

Philippe Mathieu-Daudé (5):
      hw/ssi/xilinx_spips: Convert lqspi_read() to read_with_attrs
      hw/ssi/xilinx_spips: Avoid AXI writes to the LQSPI linear memory
      hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[]
      hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO
      hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO

 include/hw/timer/pl031.h |  2 ++
 hw/arm/virt.c            |  2 +-
 hw/core/machine.c        |  1 +
 hw/display/xlnx_dp.c     | 15 +++++---
 hw/ssi/mss-spi.c         |  8 ++++-
 hw/ssi/xilinx_spips.c    | 43 +++++++++++++++-------
 hw/timer/pl031.c         | 92 +++++++++++++++++++++++++++++++++++++++++++++---
 target/arm/cpu.c         | 16 +++++++++
 target/arm/m_helper.c    | 21 ++++++++---
 9 files changed, 174 insertions(+), 26 deletions(-)

