Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC53C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882F02186A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXs3OmNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882F02186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOy0-0006B9-NN
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx1-0004Re-KP
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:36513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOwz-0005di-GW
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 17so34697821wmo.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZW0SIqdeT0i01plHkzXlYZ7aOUhmN4FeDWx37zPpsMw=;
 b=OXs3OmNlxxMoOSD7B5DxDu/2f553IwGn4jA8T9gyPDnQPWi161xXFKKXUKwBDxnzjb
 ctgII9sJIKRkRE02NpqPSZzN0BMPk9BX3g8ElWtpA2K3iJfxYqOVBb4dyaJ0wInDK0Su
 Ybxv7aHKZHbhaVGKHpxvLrv52Zxvd7vYoXZSdNgc2vtPHzMPj3PwfVDVeFjYKRUu29X3
 WK+yZ1q5hANI2+7VuGLv+ScouM3GkS5pzxOGpNWfYdLAOn0pudSOnNJ/iHN4OuegFEOU
 w7LMVSnPuidIaSVbXss3NTzw1oeqmrUsbLNHn+ZggUmmoTHVe/Xopch332oPXuKt60m4
 C5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZW0SIqdeT0i01plHkzXlYZ7aOUhmN4FeDWx37zPpsMw=;
 b=jEhPMEs4D/4Oifa5POU5YHaml7Z9N0P25FyYyyCXPXQ3l6XnRL+TbNW54iZGGtH/NQ
 ymQMgsq009CDeTlnT3CoL8j8EINe52Mm4KvloVD0bdkekAznyrzFji4vkzCnKj4A8g35
 6p8XgGYuPF1l9TrPaVoiJ/snkEACKfPGLNX3sLLEopwdexIUJhqLvn6Oh1E5sRe+tNMZ
 uML4gQd2Q1IwhgShL6XJtoMPSfTDvAaD17tQXmQLAEeZI1K8aOBitAm4pOrZrFcMq3I4
 cNZjSoY4X+jF67QBTpxqQIM1mWeUPWilb2Lx0VxDf3t6eZQ/uqEWnoPC4zVQE1opesz5
 Rjiw==
X-Gm-Message-State: AOAM531z3m83VBF2OCjE1ZRgXFbUGmsth9KhV3s0XMrEUcjMXuk6TDNN
 26TK31dkIIwMEIqs2ITWOCUkogHgRL00hg==
X-Google-Smtp-Source: ABdhPJzOABMOVcacSgK36hobLMK7YS4FwxJoKOmqEmSX7KBMeR4z8JOAykkkumTFQ95HVZhXLBPI7A==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr37282672wmf.103.1593795247175; 
 Fri, 03 Jul 2020 09:54:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/34] target-arm queue
Date: Fri,  3 Jul 2020 17:53:31 +0100
Message-Id: <20200703165405.17672-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

I might squeeze in another pullreq before softfreeze, but the
queue was already big enough that I wanted to send this lot out now.

-- PMM

The following changes since commit 4abf70a661a5df3886ac9d7c19c3617fa92b922a:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-06-24' into staging (2020-07-03 15:34:45 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200703

for you to fetch changes up to 0f10bf84a9d489259a5b11c6aa1b05c1175b76ea:

  Deprecate TileGX port (2020-07-03 16:59:46 +0100)

----------------------------------------------------------------
target-arm queue:
 * i.MX6UL EVK board: put PHYs in the correct places
 * hw/arm/virt: Let the virtio-iommu bypass MSIs
 * target/arm: kvm: Handle DABT with no valid ISS
 * hw/arm/virt-acpi-build: Only expose flash on older machine types
 * target/arm: Fix temp double-free in sve ldr/str
 * hw/display/bcm2835_fb.c: Initialize all fields of struct
 * hw/arm/spitz: Code cleanup to fix Coverity-detected memory leak
 * Deprecate TileGX port

----------------------------------------------------------------
Andrew Jones (4):
      tests/acpi: remove stale allowed tables
      tests/acpi: virt: allow DSDT acpi table changes
      hw/arm/virt-acpi-build: Only expose flash on older machine types
      tests/acpi: virt: update golden masters for DSDT

Beata Michalska (2):
      target/arm: kvm: Handle DABT with no valid ISS
      target/arm: kvm: Handle misconfigured dabt injection

Eric Auger (5):
      qdev: Introduce DEFINE_PROP_RESERVED_REGION
      virtio-iommu: Implement RESV_MEM probe request
      virtio-iommu: Handle reserved regions in the translation process
      virtio-iommu-pci: Add array of Interval properties
      hw/arm/virt: Let the virtio-iommu bypass MSIs

Jean-Christophe Dubois (3):
      Add a phy-num property to the i.MX FEC emulator
      Add the ability to select a different PHY for each i.MX6UL FEC interface
      Select MDIO device 2 and 1 as PHY devices for i.MX6UL EVK board.

Peter Maydell (19):
      hw/display/bcm2835_fb.c: Initialize all fields of struct
      hw/arm/spitz: Detabify
      hw/arm/spitz: Create SpitzMachineClass abstract base class
      hw/arm/spitz: Keep pointers to MPU and SSI devices in SpitzMachineState
      hw/arm/spitz: Keep pointers to scp0, scp1 in SpitzMachineState
      hw/arm/spitz: Implement inbound GPIO lines for bit5 and power signals
      hw/misc/max111x: provide QOM properties for setting initial values
      hw/misc/max111x: Don't use vmstate_register()
      ssi: Add ssi_realize_and_unref()
      hw/arm/spitz: Use max111x properties to set initial values
      hw/misc/max111x: Use GPIO lines rather than max111x_set_input()
      hw/misc/max111x: Create header file for documentation, TYPE_ macros
      hw/arm/spitz: Encapsulate misc GPIO handling in a device
      hw/gpio/zaurus.c: Use LOG_GUEST_ERROR for bad guest register accesses
      hw/arm/spitz: Use LOG_GUEST_ERROR for bad guest register accesses
      hw/arm/pxa2xx_pic: Use LOG_GUEST_ERROR for bad guest register accesses
      hw/arm/spitz: Provide usual QOM macros for corgi-ssp and spitz-lcdtg
      Replace uses of FROM_SSI_SLAVE() macro with QOM casts
      Deprecate TileGX port

Richard Henderson (1):
      target/arm: Fix temp double-free in sve ldr/str

 docs/system/deprecated.rst                  |  11 +
 include/exec/memory.h                       |   6 +
 include/hw/arm/fsl-imx6ul.h                 |   2 +
 include/hw/arm/pxa.h                        |   1 -
 include/hw/arm/sharpsl.h                    |   3 -
 include/hw/arm/virt.h                       |   8 +
 include/hw/misc/max111x.h                   |  56 +++
 include/hw/net/imx_fec.h                    |   1 +
 include/hw/qdev-properties.h                |   3 +
 include/hw/ssi/ssi.h                        |  31 +-
 include/hw/virtio/virtio-iommu.h            |   2 +
 include/qemu/typedefs.h                     |   1 +
 target/arm/cpu.h                            |   2 +
 target/arm/kvm_arm.h                        |  10 +
 target/arm/translate-a64.h                  |   1 +
 tests/qtest/bios-tables-test-allowed-diff.h |  18 -
 hw/arm/fsl-imx6ul.c                         |  10 +
 hw/arm/mcimx6ul-evk.c                       |   2 +
 hw/arm/pxa2xx_pic.c                         |   9 +-
 hw/arm/spitz.c                              | 507 ++++++++++++++++------------
 hw/arm/virt-acpi-build.c                    |   5 +-
 hw/arm/virt.c                               |  33 ++
 hw/arm/z2.c                                 |  11 +-
 hw/core/qdev-properties.c                   |  89 +++++
 hw/display/ads7846.c                        |   9 +-
 hw/display/bcm2835_fb.c                     |   4 +
 hw/display/ssd0323.c                        |  10 +-
 hw/gpio/zaurus.c                            |  12 +-
 hw/misc/max111x.c                           |  86 +++--
 hw/net/imx_fec.c                            |  24 +-
 hw/sd/ssi-sd.c                              |   4 +-
 hw/ssi/ssi.c                                |   7 +-
 hw/virtio/virtio-iommu-pci.c                |  11 +
 hw/virtio/virtio-iommu.c                    | 114 ++++++-
 target/arm/kvm.c                            |  80 +++++
 target/arm/kvm32.c                          |  34 ++
 target/arm/kvm64.c                          |  49 +++
 target/arm/translate-a64.c                  |   6 +
 target/arm/translate-sve.c                  |   8 +-
 MAINTAINERS                                 |   1 +
 hw/net/trace-events                         |   4 +-
 hw/virtio/trace-events                      |   1 +
 tests/data/acpi/virt/DSDT                   | Bin 5307 -> 5205 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 6668 -> 6566 bytes
 tests/data/acpi/virt/DSDT.numamem           | Bin 5307 -> 5205 bytes
 45 files changed, 974 insertions(+), 312 deletions(-)
 create mode 100644 include/hw/misc/max111x.h

