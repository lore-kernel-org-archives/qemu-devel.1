Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE03C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DC821479
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUXSpzXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DC821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4Rb-00083z-5f
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:06:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48922)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3MK-0007Xa-9P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3MG-00052w-9P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:57:06 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3MF-0004q8-VN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:57:04 -0400
Received: by mail-wm1-f49.google.com with SMTP id c6so967496wml.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d2++TYuRN0e9ZOP7pH/XTp5Sb+K/RkYlREt2Q2bOEzo=;
 b=WUXSpzXTV9+ogDvzIQvDo6bGbhpvJ5cmEzf9dV6pcHFlF44k95UePH9XO9k0woS1C0
 D4Nsdn7qLRRJdD3anM4zUV/yEZkq6+DHuK3XwoBrLaiuUPYjIkwwksLYtwJWL65EgLAq
 S+JCaJF4trxTvPfdMDlICt/360kGFB9tLgDPALcNKq/vJBT+cregEuJsKZUBfVYqA3oL
 rnFx98TepRmNnE9cWDl5nLF0qWaV43iGiVGaaxNJUSVQiKhxhM7kXStJwTB6a8Kz3GGg
 hLx9ns3LPF8EKf9UTnJqooToxOpkKMhjNhyKQAINJ5LYQ5fDmUPThge1isXpaHS4NpHC
 NPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d2++TYuRN0e9ZOP7pH/XTp5Sb+K/RkYlREt2Q2bOEzo=;
 b=H7Za2cG8FmbAAmbnNolK3FwQWbMz1b1v3ELelw8z1eJJwlHWZpZnuHqsFt1bmPX0Jd
 tmw3Y4SWutRO2Q7TFxoTgni0c/h5e3j9EhwnNHOgDMouUXRd11/47YPIhSD2PMNliRof
 4qiUeiPLmiuLHpMvNL6VkgXXIRGw9hShMRhFi156XSo5OnozTESnuVc8r4lgupuubMdd
 YD2+7rQqpif0ZvEJdJcWHmyBG1AYlabuxpx6mcp6AN6tzpVyXEfb7WLUItc74DUDnrQc
 +YdMQHEmPlQiR7bSEBo2G+NWQNWhTSUmSFbOzcYVBbtmbAwmHt6Dl2If2QI+5p955WXs
 aj/A==
X-Gm-Message-State: APjAAAV0zQiAcIJWX3UuiUD0d4WBDh2q5ZH138OZIyzc38BDrK7JYHzY
 F8b05RImGY4YaWJtueA0x5US1kB03SXarA==
X-Google-Smtp-Source: APXvYqwb4HJENdz1m2yq05Uoo5aOCUGKjur9jKFsdqL7juCDshR+mIXZWeUVuzov/D5dw1K1JtrWeg==
X-Received: by 2002:a1c:f102:: with SMTP id p2mr124679wmh.126.1561999185424;
 Mon, 01 Jul 2019 09:39:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:38:57 +0100
Message-Id: <20190701163943.22313-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.49
Subject: [Qemu-devel] [PULL 00/46] target-arm queue
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

target-arm queue for softfreeze: this is quite big as I
was on holiday last week, so this is all just sneaking in
under the wire. I particularly wanted to get Philippe's
patches in before freeze as that sort of code-movement
patchset is painful to have to rebase. 

thanks
-- PMM

The following changes since commit ae9108f8f0746ce64d02afb1a216153a50926132:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-pull-request' into staging (2019-07-01 15:55:40 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190701

for you to fetch changes up to 787a7e76c2e93a48c47b324fea592c9910a70483:

  target/arm: Declare some M-profile functions publicly (2019-07-01 17:29:01 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/boot: fix direct kernel boot with initrd
 * hw/arm/msf2-som: Exit when the cpu is not the expected one
 * i.mx7: fix bugs in PCI controller needed to boot recent kernels
 * aspeed: add RTC device
 * aspeed: fix some timer device bugs
 * aspeed: add swift-bmc board
 * aspeed: vic: Add support for legacy register interface
 * aspeed: add aspeed-xdma device
 * Add new sbsa-ref board for aarch64
 * target/arm: code refactoring in preparation for support of
   compilation with TCG disabled

----------------------------------------------------------------
Adriana Kobylak (1):
      aspeed: Add support for the swift-bmc board

Andrew Jeffery (3):
      aspeed/timer: Status register contains reload for stopped timer
      aspeed/timer: Fix match calculations
      aspeed: vic: Add support for legacy register interface

Andrew Jones (1):
      hw/arm/boot: fix direct kernel boot with initrd

Andrey Smirnov (5):
      i.mx7d: Add no-op/unimplemented APBH DMA module
      i.mx7d: Add no-op/unimplemented PCIE PHY IP block
      pci: designware: Update MSI mapping unconditionally
      pci: designware: Update MSI mapping when MSI address changes
      i.mx7d: pci: Update PCI IRQ mapping to match HW

Christian Svensson (1):
      aspeed/timer: Ensure positive muldiv delta

Cédric Le Goater (7):
      aspeed: add a per SoC mapping for the interrupt space
      aspeed: add a per SoC mapping for the memory space
      aspeed: introduce a configurable number of CPU per machine
      aspeed: add support for multiple NICs
      aspeed: remove the "ram" link
      aspeed: add a RAM memory region container
      aspeed/smc: add a 'sdram_base' property

Eddie James (1):
      hw/misc/aspeed_xdma: New device

Hongbo Zhang (2):
      hw/arm: Add arm SBSA reference machine, skeleton part
      hw/arm: Add arm SBSA reference machine, devices part

Jan Kiszka (1):
      hw/arm/virt: Add support for Cortex-A7

Joel Stanley (4):
      hw: timer: Add ASPEED RTC device
      hw/arm/aspeed: Add RTC to SoC
      aspeed/timer: Fix behaviour running Linux
      aspeed: Link SCU to the watchdog

Philippe Mathieu-Daudé (19):
      hw/arm/msf2-som: Exit when the cpu is not the expected one
      target/arm: Makefile cleanup (Aarch64)
      target/arm: Makefile cleanup (ARM)
      target/arm: Makefile cleanup (KVM)
      target/arm: Makefile cleanup (softmmu)
      target/arm: Add copyright boilerplate
      target/arm/helper: Remove unused include
      target/arm: Fix multiline comment syntax
      target/arm: Fix coding style issues
      target/arm: Move CPU state dumping routines to cpu.c
      target/arm: Declare get_phys_addr() function publicly
      target/arm: Move TLB related routines to tlb_helper.c
      target/arm/vfp_helper: Move code around
      target/arm/vfp_helper: Extract vfp_set_fpscr_to_host()
      target/arm/vfp_helper: Extract vfp_set_fpscr_from_host()
      target/arm/vfp_helper: Restrict the SoftFloat use to TCG
      target/arm: Restrict PSCI to TCG
      target/arm: Declare arm_log_exception() function publicly
      target/arm: Declare some M-profile functions publicly

Samuel Ortiz (1):
      target/arm: Move the DC ZVA helper into op_helper

 hw/arm/Makefile.objs                |   1 +
 hw/misc/Makefile.objs               |   1 +
 hw/timer/Makefile.objs              |   2 +-
 target/arm/Makefile.objs            |  24 +-
 include/hw/arm/aspeed_soc.h         |  53 ++-
 include/hw/arm/fsl-imx7.h           |  14 +-
 include/hw/misc/aspeed_xdma.h       |  30 ++
 include/hw/ssi/aspeed_smc.h         |   3 +
 include/hw/timer/aspeed_rtc.h       |  31 ++
 include/hw/watchdog/wdt_aspeed.h    |   1 +
 target/arm/cpu.h                    |   2 -
 target/arm/internals.h              |  69 ++-
 target/arm/translate.h              |   5 -
 hw/arm/aspeed.c                     |  76 +++-
 hw/arm/aspeed_soc.c                 | 262 +++++++++---
 hw/arm/boot.c                       |   3 +-
 hw/arm/fsl-imx7.c                   |  11 +
 hw/arm/msf2-som.c                   |   1 +
 hw/arm/sbsa-ref.c                   | 806 ++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c                       |   1 +
 hw/intc/aspeed_vic.c                | 105 +++--
 hw/misc/aspeed_xdma.c               | 165 ++++++++
 hw/pci-host/designware.c            |  18 +-
 hw/ssi/aspeed_smc.c                 |   1 +
 hw/timer/aspeed_rtc.c               | 180 ++++++++
 hw/timer/aspeed_timer.c             |  76 ++--
 hw/watchdog/wdt_aspeed.c            |  20 +
 target/arm/cpu.c                    | 232 ++++++++++-
 target/arm/helper.c                 | 498 +++++++++-------------
 target/arm/op_helper.c              | 262 ++++++------
 target/arm/tlb_helper.c             | 200 +++++++++
 target/arm/translate-a64.c          | 128 ------
 target/arm/translate.c              |  91 +---
 target/arm/vfp_helper.c             | 199 +++++----
 MAINTAINERS                         |   8 +
 default-configs/aarch64-softmmu.mak |   1 +
 hw/arm/Kconfig                      |  14 +
 hw/misc/trace-events                |   3 +
 hw/timer/trace-events               |   4 +
 39 files changed, 2675 insertions(+), 926 deletions(-)
 create mode 100644 include/hw/misc/aspeed_xdma.h
 create mode 100644 include/hw/timer/aspeed_rtc.h
 create mode 100644 hw/arm/sbsa-ref.c
 create mode 100644 hw/misc/aspeed_xdma.c
 create mode 100644 hw/timer/aspeed_rtc.c
 create mode 100644 target/arm/tlb_helper.c

