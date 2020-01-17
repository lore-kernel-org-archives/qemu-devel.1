Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7920C33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64932072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNJDmKih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64932072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSdK-0007p8-E8
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbn-00066o-1A
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbl-0006wJ-HC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:22 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbl-0006vY-AU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:21 -0500
Received: by mail-wr1-x42b.google.com with SMTP id q10so22909273wrm.11
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HjJC86jDrpR4P0xOPBsqjBhSbqX1xtk2MoFgZHvUW8U=;
 b=PNJDmKih/6jItbaMEwLfR6A3CbxGxcRzYO89kU+B+pQq6sNmuzb+zjq4WKB4SpZ27v
 rJfMCloRcfBjY6akBRH/30httW/c7Pngc7jgAMTEELFAnJ+ts8FPYh3afua7NQBZA+84
 Ry2nHH0o8ciez2DogJ93XQRNRdRP+wEldjuQ3OQhYCfL4y2kzukL/kJvp4lv94kyU+A1
 McKDkNV9bcHJNe5nqLtmXms+q7yq+aA6rgKjcrLj6mJ9w01L1qVTjKgONGgFynCuU0WW
 tzN76w5py/ewM9OHNKnILyPp6qa+/6Q3CJCpJMs/9Tdy9JUS/mrqJ1zY23X1IAPqrNJK
 XOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HjJC86jDrpR4P0xOPBsqjBhSbqX1xtk2MoFgZHvUW8U=;
 b=nJR6qn4OvKcWJ8C5+mP9tUB2T5U4wcaV7ewI+YhixvqMQbaiLMXtHYG8DqbeX6V/RK
 R++a6knTNR3reaqroZK2GMDc0dGVAZs+lBX297bSjJd8p83CvZC5TI1vwNT5YdnrZFH3
 0VLuT7ipvcNJP2voiM27nKD9s1LPV3HqbkiQuvYiXqDLm4qg3UlxPcMBB2O2oHqkihz0
 AwGh8VOFBOsVmNGEeGrP8tAreDNF/PwNrvbouqJsZLzeZUzUUAZPgAkkTWfFkcu0mBms
 mzkXmO6s563hkglaYfeyj69CWNaihoQjAByN8n31MuGUhjX/46194rWT8r3TJLDx2l5Z
 TY6A==
X-Gm-Message-State: APjAAAWi+ILA6Fpzx6+6fp4mqQ6b1g5Oj7Oh+1GfvJ47FedlWD+259W1
 ZCttSq8Ckx97ogjZmugJWfjh4d3EIv7OxA==
X-Google-Smtp-Source: APXvYqyjJfktcdeIQOJxGkA5vxjheJ9IZvHPRgWMldl1ndlCHLJ2JGMz7/q3bm/cH26iS+nd+DD2qA==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr3602869wrr.158.1579271299402; 
 Fri, 17 Jan 2020 06:28:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] target-arm queue
Date: Fri, 17 Jan 2020 14:28:01 +0000
Message-Id: <20200117142816.15110-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

Latest arm queue, a mixed bag of features and bug fixes.

thanks
-- PMM

The following changes since commit cbf01142b2aef0c0b4e995cecd7e79d342bbc47e:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200115' into staging (2020-01-17 12:13:17 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200117-1

for you to fetch changes up to 1a1fbc6cbb34c26d43d8360c66c1d21681af14a9:

  target/arm: Set ISSIs16Bit in make_issinfo (2020-01-17 14:27:16 +0000)

----------------------------------------------------------------
Add model of the Netduino Plus 2 board
Some allwinner-a10 code cleanup
New test cases for cubieboard
target/arm/arm-semi: fix SYS_OPEN to return nonzero filehandle
i.MX: add an emulation for RNGC device
target/arm: adjust program counter for wfi exception in AArch32
arm/gicv3: update virtual irq state after IAR register read
Set IL bit correctly for syndrome information for data aborts

----------------------------------------------------------------
Alistair Francis (4):
      hw/misc: Add the STM32F4xx Sysconfig device
      hw/misc: Add the STM32F4xx EXTI device
      hw/arm: Add the STM32F4xx SoC
      hw/arm: Add the Netduino Plus 2

Jeff Kubascik (3):
      target/arm: adjust program counter for wfi exception in AArch32
      arm/gicv3: update virtual irq state after IAR register read
      target/arm: Return correct IL bit in merge_syn_data_abort

Martin Kaiser (1):
      i.MX: add an emulation for RNGC

Masahiro Yamada (1):
      target/arm/arm-semi: fix SYS_OPEN to return nonzero filehandle

Philippe Mathieu-Daudé (5):
      tests/boot_linux_console: Add initrd test for the CubieBoard
      tests/boot_linux_console: Add a SD card test for the CubieBoard
      hw/arm/allwinner-a10: Move SoC definitions out of header
      hw/arm/allwinner-a10: Simplify by passing IRQs with qdev_pass_gpios()
      hw/arm/allwinner-a10: Remove local qemu_irq variables

Richard Henderson (1):
      target/arm: Set ISSIs16Bit in make_issinfo

 hw/arm/Makefile.objs                   |   2 +
 hw/misc/Makefile.objs                  |   3 +
 include/hw/arm/allwinner-a10.h         |   7 -
 include/hw/arm/fsl-imx25.h             |   5 +
 include/hw/arm/stm32f405_soc.h         |  73 ++++++++
 include/hw/misc/imx_rngc.h             |  35 ++++
 include/hw/misc/stm32f4xx_exti.h       |  60 +++++++
 include/hw/misc/stm32f4xx_syscfg.h     |  61 +++++++
 hw/arm/allwinner-a10.c                 |  39 +++--
 hw/arm/fsl-imx25.c                     |  11 ++
 hw/arm/netduinoplus2.c                 |  52 ++++++
 hw/arm/stm32f405_soc.c                 | 302 +++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_cpuif.c              |   3 +
 hw/misc/imx_rngc.c                     | 278 ++++++++++++++++++++++++++++++
 hw/misc/stm32f4xx_exti.c               | 188 ++++++++++++++++++++
 hw/misc/stm32f4xx_syscfg.c             | 171 +++++++++++++++++++
 target/arm/arm-semi.c                  |   5 +-
 target/arm/op_helper.c                 |   7 +-
 target/arm/tlb_helper.c                |   2 +-
 target/arm/translate.c                 |   3 +
 MAINTAINERS                            |  14 ++
 default-configs/arm-softmmu.mak        |   1 +
 hw/arm/Kconfig                         |  10 ++
 hw/misc/Kconfig                        |   6 +
 hw/misc/trace-events                   |  11 ++
 tests/acceptance/boot_linux_console.py |  85 ++++++++++
 26 files changed, 1405 insertions(+), 29 deletions(-)
 create mode 100644 include/hw/arm/stm32f405_soc.h
 create mode 100644 include/hw/misc/imx_rngc.h
 create mode 100644 include/hw/misc/stm32f4xx_exti.h
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h
 create mode 100644 hw/arm/netduinoplus2.c
 create mode 100644 hw/arm/stm32f405_soc.c
 create mode 100644 hw/misc/imx_rngc.c
 create mode 100644 hw/misc/stm32f4xx_exti.c
 create mode 100644 hw/misc/stm32f4xx_syscfg.c

