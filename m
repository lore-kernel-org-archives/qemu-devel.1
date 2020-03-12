Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00339C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C464E206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cz7O+I0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C464E206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR0G-0005Ry-TR
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxG-00084z-Lh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxF-0004z9-3X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxE-0004yx-Qb
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id s5so8400717wrg.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rEt+o6axUSgPhmQ9zyoFb+qAnPQkRxDH3mh/1eRedds=;
 b=cz7O+I0B63n8u+WbBD2Ec9LfEAqV7cbtVMK2d0Dtc50twVFw0rpNZ8VS8mGLZ14AYp
 zWM0+wDCcXbjN70/8NSeW5u/Zb01uUoXQv+q63C25bD1oyz0NaqYFs8kQpHL5aRCOElV
 BiIXt18ME27m9eM4Mkr3SQxDiDm/gB+fxKBKbUTyB1zq40QGbQohJ40EyD0eHXjgrwZu
 8QYGreUEdJHlrqPWiidMJ1xMRDrgwzs9IEYJyQPrsCEelHAZ7YBfaPA/rriQDY/gbiak
 XXnC+dtPe6yxKK4TQJQHf9e7ASn1pnUDsbny4P5c4mFncXDdTL2/DLz34mtTUybkECfD
 qGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rEt+o6axUSgPhmQ9zyoFb+qAnPQkRxDH3mh/1eRedds=;
 b=Wvggyf20zo4BMcVhIoU0/QzbgLL9ACJnTOCjH9sNdtrZmXQlFp21detSznP31KYWU6
 jqF29hMWN5gZdwycNO3VzejK7lqa+c9yqXVpeWfJKvh26ccLyGsY9lcmxaqwxc5RUYsL
 ZTqcstU0WziIGvtfYeaCSNYkU4SpU7fDZZLETUReXFfXcU5KYjoYM3z/PO/TJ749+1XO
 o7fbWgbh6JQhKfL0C4TtTGameX/X4o4IBWWkNWex+Qm6/EZa1iq3eTaqokbsbUVY2ho7
 xht5qw7HLF/2+zFj9fvmjOTqCdasVTBeJKRMUghTXiqvuswze1egPhy6FbDGadp86fDp
 NDWw==
X-Gm-Message-State: ANhLgQ3DsRgn933WBSoEfhnbJzbmH6PNOqFh6zXYIS1xVN+laVnVB/pF
 Fs4HwOMGUnVqMOjOisY6VPUPzvCOyX+YnA==
X-Google-Smtp-Source: ADFU+vt0HEGB1QhQNkj6WcEZfO/Wq9ifAJA8bUaFLnqEz/H/5mslKEfQUpggbM12MAUYQpgwKxfdbg==
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr11811756wrx.70.1584031502480; 
 Thu, 12 Mar 2020 09:45:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/36] target-arm queue
Date: Thu, 12 Mar 2020 16:44:23 +0000
Message-Id: <20200312164459.25924-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

arm queue; dunno if this will be the last before softfreeze
or not, but anyway probably the last large one. New orangepi-pc
board model is the big item here.

thanks
-- PMM

The following changes since commit 67d9ef7d541c3d21a25796c51c26da096a433565:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200312' into staging (2020-03-12 15:20:52 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200312

for you to fetch changes up to aca53be34ac3e7cac5f39396a51a338860a5a837:

  target/arm: kvm: Inject events at the last stage of sync (2020-03-12 16:31:10 +0000)

----------------------------------------------------------------
target-arm queue:
 * Fix various bugs that might result in an assert() due to
   incorrect hflags for M-profile CPUs
 * Fix Aspeed SMC Controller user-mode select handling
 * Report correct (with-tag) address in fault address register
   when TBI is enabled
 * cubieboard: make sure SOC object isn't leaked
 * fsl-imx25: Wire up eSDHC controllers
 * fsl-imx25: Wire up USB controllers
 * New board model: orangepi-pc (OrangePi PC)
 * ARM/KVM: if user doesn't select GIC version and the
   host kernel can only provide GICv3, use that, rather
   than defaulting to "fail because GICv2 isn't possible"
 * kvm: Only do KVM_SET_VCPU_EVENTS at the last stage of sync

----------------------------------------------------------------
Beata Michalska (1):
      target/arm: kvm: Inject events at the last stage of sync

Cédric Le Goater (2):
      aspeed/smc: Add some tracing
      aspeed/smc: Fix User mode select/unselect scheme

Eric Auger (6):
      hw/arm/virt: Document 'max' value in gic-version property description
      hw/arm/virt: Introduce VirtGICType enum type
      hw/arm/virt: Introduce finalize_gic_version()
      target/arm/kvm: Let kvm_arm_vgic_probe() return a bitmap
      hw/arm/virt: kvm: Restructure finalize_gic_version()
      hw/arm/virt: kvm: allow gicv3 by default if v2 cannot work

Guenter Roeck (2):
      hw/arm/fsl-imx25: Wire up eSDHC controllers
      hw/arm/fsl-imx25: Wire up USB controllers

Igor Mammedov (1):
      hw/arm/cubieboard: make sure SOC object isn't leaked

Niek Linnenbank (13):
      hw/arm: add Allwinner H3 System-on-Chip
      hw/arm: add Xunlong Orange Pi PC machine
      hw/arm/allwinner-h3: add Clock Control Unit
      hw/arm/allwinner-h3: add USB host controller
      hw/arm/allwinner-h3: add System Control module
      hw/arm/allwinner: add CPU Configuration module
      hw/arm/allwinner: add Security Identifier device
      hw/arm/allwinner: add SD/MMC host controller
      hw/arm/allwinner-h3: add EMAC ethernet device
      hw/arm/allwinner-h3: add Boot ROM support
      hw/arm/allwinner-h3: add SDRAM controller device
      hw/arm/allwinner: add RTC device support
      docs: add Orange Pi PC document

Peter Maydell (4):
      hw/intc/armv7m_nvic: Rebuild hflags on reset
      target/arm: Update hflags in trans_CPS_v7m()
      target/arm: Recalculate hflags correctly after writes to CONTROL
      target/arm: Fix some comment typos

Philippe Mathieu-Daudé (5):
      tests/boot_linux_console: Add a quick test for the OrangePi PC board
      tests/boot_linux_console: Add initrd test for the Orange Pi PC board
      tests/boot_linux_console: Add a SD card test for the OrangePi PC board
      tests/boot_linux_console: Add a SLOW test booting Ubuntu on OrangePi PC
      tests/boot_linux_console: Test booting NetBSD via U-Boot on OrangePi PC

Richard Henderson (2):
      target/arm: Check addresses for disabled regimes
      target/arm: Disable clean_data_tbi for system mode

 Makefile.objs                          |   1 +
 hw/arm/Makefile.objs                   |   1 +
 hw/misc/Makefile.objs                  |   5 +
 hw/net/Makefile.objs                   |   1 +
 hw/rtc/Makefile.objs                   |   1 +
 hw/sd/Makefile.objs                    |   1 +
 hw/usb/hcd-ehci.h                      |   1 +
 include/hw/arm/allwinner-a10.h         |   4 +
 include/hw/arm/allwinner-h3.h          | 161 ++++++
 include/hw/arm/fsl-imx25.h             |  18 +
 include/hw/arm/virt.h                  |  12 +-
 include/hw/misc/allwinner-cpucfg.h     |  52 ++
 include/hw/misc/allwinner-h3-ccu.h     |  66 +++
 include/hw/misc/allwinner-h3-dramc.h   | 106 ++++
 include/hw/misc/allwinner-h3-sysctrl.h |  67 +++
 include/hw/misc/allwinner-sid.h        |  60 +++
 include/hw/net/allwinner-sun8i-emac.h  |  99 ++++
 include/hw/rtc/allwinner-rtc.h         | 134 +++++
 include/hw/sd/allwinner-sdhost.h       | 135 +++++
 target/arm/helper.h                    |   1 +
 target/arm/kvm_arm.h                   |   3 +
 hw/arm/allwinner-a10.c                 |  19 +
 hw/arm/allwinner-h3.c                  | 465 ++++++++++++++++++
 hw/arm/cubieboard.c                    |  18 +
 hw/arm/fsl-imx25.c                     |  56 +++
 hw/arm/imx25_pdk.c                     |  16 +
 hw/arm/orangepi.c                      | 130 +++++
 hw/arm/virt.c                          | 145 ++++--
 hw/intc/armv7m_nvic.c                  |   6 +
 hw/misc/allwinner-cpucfg.c             | 282 +++++++++++
 hw/misc/allwinner-h3-ccu.c             | 242 +++++++++
 hw/misc/allwinner-h3-dramc.c           | 358 ++++++++++++++
 hw/misc/allwinner-h3-sysctrl.c         | 140 ++++++
 hw/misc/allwinner-sid.c                | 168 +++++++
 hw/net/allwinner-sun8i-emac.c          | 871 +++++++++++++++++++++++++++++++++
 hw/rtc/allwinner-rtc.c                 | 411 ++++++++++++++++
 hw/sd/allwinner-sdhost.c               | 854 ++++++++++++++++++++++++++++++++
 hw/ssi/aspeed_smc.c                    |  56 ++-
 hw/usb/hcd-ehci-sysbus.c               |  17 +
 target/arm/helper.c                    |  49 +-
 target/arm/kvm.c                       |  14 +-
 target/arm/kvm32.c                     |  15 +-
 target/arm/kvm64.c                     |  15 +-
 target/arm/translate-a64.c             |  11 +
 target/arm/translate.c                 |  14 +-
 MAINTAINERS                            |   9 +
 default-configs/arm-softmmu.mak        |   1 +
 docs/system/arm/orangepi.rst           | 253 ++++++++++
 docs/system/target-arm.rst             |   2 +
 hw/arm/Kconfig                         |  12 +
 hw/misc/trace-events                   |  19 +
 hw/net/Kconfig                         |   3 +
 hw/net/trace-events                    |  10 +
 hw/rtc/trace-events                    |   4 +
 hw/sd/trace-events                     |   7 +
 hw/ssi/trace-events                    |  10 +
 tests/acceptance/boot_linux_console.py | 230 +++++++++
 57 files changed, 5787 insertions(+), 74 deletions(-)
 create mode 100644 include/hw/arm/allwinner-h3.h
 create mode 100644 include/hw/misc/allwinner-cpucfg.h
 create mode 100644 include/hw/misc/allwinner-h3-ccu.h
 create mode 100644 include/hw/misc/allwinner-h3-dramc.h
 create mode 100644 include/hw/misc/allwinner-h3-sysctrl.h
 create mode 100644 include/hw/misc/allwinner-sid.h
 create mode 100644 include/hw/net/allwinner-sun8i-emac.h
 create mode 100644 include/hw/rtc/allwinner-rtc.h
 create mode 100644 include/hw/sd/allwinner-sdhost.h
 create mode 100644 hw/arm/allwinner-h3.c
 create mode 100644 hw/arm/orangepi.c
 create mode 100644 hw/misc/allwinner-cpucfg.c
 create mode 100644 hw/misc/allwinner-h3-ccu.c
 create mode 100644 hw/misc/allwinner-h3-dramc.c
 create mode 100644 hw/misc/allwinner-h3-sysctrl.c
 create mode 100644 hw/misc/allwinner-sid.c
 create mode 100644 hw/net/allwinner-sun8i-emac.c
 create mode 100644 hw/rtc/allwinner-rtc.c
 create mode 100644 hw/sd/allwinner-sdhost.c
 create mode 100644 docs/system/arm/orangepi.rst
 create mode 100644 hw/ssi/trace-events

