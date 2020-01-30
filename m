Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6114AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6C620707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aI75FW6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6C620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCVP-0006yy-6w
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTj-0005Cv-WC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTi-0002mX-K3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:55195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTi-0002kj-C6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id g1so4388396wmh.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xZaR9rb1/sVNvbvOgVU3MJD3KYb+kjgUbySH3y2vGMU=;
 b=aI75FW6OZdL1IWEOKnHWRNf7cprHarg4cVq6rj0OJAFPPXY0cQgnUfYSRKxEUkcne/
 QPUXD132BOMUKgL9hxMAFz+tMyGjVZAI8o5KdBc93kWeKWbeVgwqDAPeo1o9SVdVqlTf
 TNwt92VBHx4/MImOmNGnD+3/WSdbI9jIj5M+NuDrnNDSYv2FftTdr9O1VVEqYX+HLBN8
 NR2QJPvctloSdipM15UMgig7Us8Nyze4m4wTqPigRgOzeJqv+85JmlJHCEbKTz3prj/Y
 E7+YmXnNNZ/eNEUxObUr6ExW+SpTK5Qjst35bMN/bGf6clx/UaQf6Farcf/z2WLusEAy
 M2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xZaR9rb1/sVNvbvOgVU3MJD3KYb+kjgUbySH3y2vGMU=;
 b=Stwg/rvQ2Zu4T+f5tCoHEid/xzF2s0+zj3ep1w+wNR7rjUgGU/01CZKDW8oVBO+vzu
 oQCNZ5BAjQJvY/zB45npWVCVU8OH/tWaEwWGDNzqvCBVQruri0pI82z4xeM+lw8A+Ep6
 UzCXaUf/tkuWgGRIRKkr8yjga5pExtI1Upn6UjgSfa4yVwBcjmtfrJmV2roMyGCkIEn6
 IjGqMjZYm6EscnggBlqSrAZM0cGQavg10dayz/QdGlcraxDNiIeeomhZcngFT7B4QtfZ
 H1J1gcPlz7Er24cwMHDKxqhtGt41lv6kIvshutLBtoRhuZoCutSbNeuVlfCLyOYEeeF5
 rCnQ==
X-Gm-Message-State: APjAAAXFZ4jjgYZnV221ooUZuShiDpWSlgA9BOD6Wm/fy624zVXyeKRo
 Dh1PvD0LHLraW46OMwLBktHhXhUcs3H/uA==
X-Google-Smtp-Source: APXvYqwuW0NgrxzfIs6Stt5S3MR9MXLZdj2/SMe+ne6vZINiGc+9rcG4UGn/tJJaKspMn+C3okNXmw==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr6309387wmi.178.1580400935848; 
 Thu, 30 Jan 2020 08:15:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] target-arm queue
Date: Thu, 30 Jan 2020 16:15:07 +0000
Message-Id: <20200130161533.8180-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

target-arm queue. The big thing here is the landing of the 3-phase
reset patches...

-- PMM

The following changes since commit 204aa60b37c23a89e690d418f49787d274303ca7:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jan-29-2020' into staging (2020-01-30 14:18:45 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200130

for you to fetch changes up to dea101a1ae9968c9fec6ab0291489dad7c49f36f:

  target/arm/cpu: Add the kvm-no-adjvtime CPU property (2020-01-30 16:02:06 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/core/or-irq: Fix incorrect assert forbidding num-lines == MAX_OR_LINES
 * target/arm/arm-semi: Don't let the guest close stdin/stdout/stderr
 * aspeed: some minor bugfixes
 * aspeed: add eMMC controller model for AST2600 SoC
 * hw/arm/raspi: Remove obsolete use of -smp to set the soc 'enabled-cpus'
 * New 3-phase reset API for device models
 * hw/intc/arm_gicv3_kvm: Stop wrongly programming GICR_PENDBASER.PTZ bit
 * Arm KVM: stop/restart the guest counter when the VM is stopped and started

----------------------------------------------------------------
Andrew Jeffery (2):
      hw/sd: Configure number of slots exposed by the ASPEED SDHCI model
      hw/arm: ast2600: Wire up the eMMC controller

Andrew Jones (6):
      target/arm/kvm: trivial: Clean up header documentation
      hw/arm/virt: Add missing 5.0 options call to 4.2 options
      target/arm/kvm64: kvm64 cpus have timer registers
      tests/arm-cpu-features: Check feature default values
      target/arm/kvm: Implement virtual time adjustment
      target/arm/cpu: Add the kvm-no-adjvtime CPU property

Cédric Le Goater (2):
      ftgmac100: check RX and TX buffer alignment
      hw/arm/aspeed: add a 'execute-in-place' property to boot directly from CE0

Damien Hedde (11):
      add device_legacy_reset function to prepare for reset api change
      hw/core/qdev: add trace events to help with resettable transition
      hw/core: create Resettable QOM interface
      hw/core: add Resettable support to BusClass and DeviceClass
      hw/core/resettable: add support for changing parent
      hw/core/qdev: handle parent bus change regarding resettable
      hw/core/qdev: update hotplug reset regarding resettable
      hw/core: deprecate old reset functions and introduce new ones
      docs/devel/reset.rst: add doc about Resettable interface
      vl: replace deprecated qbus_reset_all registration
      hw/s390x/ipl: replace deprecated qdev_reset_all registration

Joel Stanley (1):
      misc/pca9552: Add qom set and get

Peter Maydell (2):
      hw/core/or-irq: Fix incorrect assert forbidding num-lines == MAX_OR_LINES
      target/arm/arm-semi: Don't let the guest close stdin/stdout/stderr

Philippe Mathieu-Daudé (1):
      hw/arm/raspi: Remove obsolete use of -smp to set the soc 'enabled-cpus'

Zenghui Yu (1):
      hw/intc/arm_gicv3_kvm: Stop wrongly programming GICR_PENDBASER.PTZ bit

 hw/core/Makefile.objs          |   1 +
 tests/Makefile.include         |   1 +
 include/hw/arm/aspeed.h        |   2 +
 include/hw/arm/aspeed_soc.h    |   2 +
 include/hw/arm/virt.h          |   1 +
 include/hw/qdev-core.h         |  58 +++++++-
 include/hw/resettable.h        | 247 +++++++++++++++++++++++++++++++++
 include/hw/sd/aspeed_sdhci.h   |   1 +
 target/arm/cpu.h               |   7 +
 target/arm/kvm_arm.h           |  95 ++++++++++---
 hw/arm/aspeed.c                |  72 ++++++++--
 hw/arm/aspeed_ast2600.c        |  31 ++++-
 hw/arm/aspeed_soc.c            |   2 +
 hw/arm/raspi.c                 |   2 -
 hw/arm/virt.c                  |   9 ++
 hw/audio/intel-hda.c           |   2 +-
 hw/core/bus.c                  | 102 ++++++++++++++
 hw/core/or-irq.c               |   2 +-
 hw/core/qdev.c                 | 160 ++++++++++++++++++++--
 hw/core/resettable.c           | 301 +++++++++++++++++++++++++++++++++++++++++
 hw/hyperv/hyperv.c             |   2 +-
 hw/i386/microvm.c              |   2 +-
 hw/i386/pc.c                   |   2 +-
 hw/ide/microdrive.c            |   8 +-
 hw/intc/arm_gicv3_kvm.c        |  11 +-
 hw/intc/spapr_xive.c           |   2 +-
 hw/misc/pca9552.c              |  90 ++++++++++++
 hw/net/ftgmac100.c             |  13 ++
 hw/ppc/pnv_psi.c               |   4 +-
 hw/ppc/spapr_pci.c             |   2 +-
 hw/ppc/spapr_vio.c             |   2 +-
 hw/s390x/ipl.c                 |  10 +-
 hw/s390x/s390-pci-inst.c       |   2 +-
 hw/scsi/vmw_pvscsi.c           |   2 +-
 hw/sd/aspeed_sdhci.c           |  11 +-
 hw/sd/omap_mmc.c               |   2 +-
 hw/sd/pl181.c                  |   2 +-
 target/arm/arm-semi.c          |   9 ++
 target/arm/cpu.c               |   2 +
 target/arm/cpu64.c             |   1 +
 target/arm/kvm.c               | 120 ++++++++++++++++
 target/arm/kvm32.c             |   3 +
 target/arm/kvm64.c             |   4 +
 target/arm/machine.c           |   7 +
 target/arm/monitor.c           |   1 +
 tests/qtest/arm-cpu-features.c |  41 ++++--
 vl.c                           |  10 +-
 docs/arm-cpu-features.rst      |  37 ++++-
 docs/devel/index.rst           |   1 +
 docs/devel/reset.rst           | 289 +++++++++++++++++++++++++++++++++++++++
 hw/core/trace-events           |  27 ++++
 51 files changed, 1727 insertions(+), 90 deletions(-)
 create mode 100644 include/hw/resettable.h
 create mode 100644 hw/core/resettable.c
 create mode 100644 docs/devel/reset.rst

