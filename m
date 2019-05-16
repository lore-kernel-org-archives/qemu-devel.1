Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E19BC04E84
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B16420833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1EsU55i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B16420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60925 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRJRI-0005Xi-7o
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 12:41:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRJPM-0004MA-HD
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRJPL-0002kZ-2B
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:39:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRJPK-0002k9-Q1
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:39:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so4149566wrs.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=MME9Oi3lbo4MAHkzTc5YE7+1fkWaadRrcOOldw06nOU=;
	b=c1EsU55iMq+G5ZVcp1lYVXDVOb7ReiW8ApKU2iubMgou/I5Vh/8yFAuWVjoyqnT6oy
	mN5tSWtJyFw1hVe5psFpXwdePy7DK1ZFxKlXEcUqU4tQdr+IWcnkph646AKOEuO8pP07
	v8Q1LwaeV5hHS+4KkgFYLgS1iKk/BgtaC++O+pxbf+nkZUUNPwFTEf2MVOZX4ZptGS7Z
	Kjq9T8rlGkJSnUfb+/TbTTgDDOh2XhiiKgFKK0LntB+jiJ8Q+apwldqqiD47aiqm7oCC
	J9ZYrGX/ZrwiNNEk6NilB+KC/mwQ9B2/8/6/Ubwx3v6Ll0kinppPooAVbJlTVCfQnDuW
	YJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=MME9Oi3lbo4MAHkzTc5YE7+1fkWaadRrcOOldw06nOU=;
	b=eYYf7V/lGwE5tIFGpwLL2ENW9dKNRXOYGu+j7+ueXHTVDZhpgEqqorrWRhA2iET9/d
	J0/IOTFYbR2Rob9bqprUd/yaMWhkWanRodIo+3bfjtjrx5Lyvrl5KP+5DgmrWpdHHS8d
	mnalyI2lCCO6llufnL3eiCTB0CfCgqbVmsJzs0oanXnqsPFi1F0fcEvydoa7X7mDaOC4
	NzQ234JrWtCYOEfoFsemwTSpKDeVOTou+gqhDl0xk7EoaVBBtKIaGuTghNqTcfkKKKRt
	BOVhKxWRZOXN4xlKfBPGhund3AUbHPzlVoh3DJ/J57v3xe0q7nbwoVw84K+5tT+9MbR2
	5SNA==
X-Gm-Message-State: APjAAAVnL4HtrI0MqVOc1C8eTEmnXXjCzsqgApAFU8CqAWzw91guXF1A
	naZqsUFwscW2QWEbKF2lpFEjUQ==
X-Google-Smtp-Source: APXvYqxZIRSDSslgPk62Dfpsv7U5m9vtUxjlM4Qf7yevaUbnMf6ic4UsdlElVYx2mZKqswurdjiTVQ==
X-Received: by 2002:a5d:68d2:: with SMTP id p18mr24540206wrw.56.1558024741179; 
	Thu, 16 May 2019 09:39:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	y130sm6702844wmc.44.2019.05.16.09.39.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 09:39:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 16 May 2019 17:38:54 +0100
Message-Id: <20190516163857.6430-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 0/3] arm: Clean up and rename hw/arm/arm.h to
 hw/arm/boot.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The header hw/arm/arm.h used to be a general bucket for
putting all kinds of arm-related declarations in. It now
has mostly kernel-boot related declarations, with one
exception: the declaration of the system_clock_scale global.
This patchset:
 * moves system_clock_scale to armv7m_systick.h (since that
   is the only device that uses it)
 * deletes some unnecessary #includes of hw/arm/arm.h
 * renames it to hw/arm/boot.h, since it now only has
   declarations relating to hw/arm/boot.c functionality

Since system_clock_scale is a weird thing, I have included
in the first patch an expansion of the comment describing
it to be clearer about what it does, and also a TODO note
sketching out how we could go about eradicating this global.

thanks
-- PMM

Peter Maydell (3):
  arm: Move system_clock_scale to armv7m_systick.h
  arm: Remove unnecessary includes of hw/arm/arm.h
  arm: Rename hw/arm/arm.h to hw/arm/boot.h

 include/hw/arm/allwinner-a10.h    |  2 +-
 include/hw/arm/aspeed_soc.h       |  2 +-
 include/hw/arm/bcm2836.h          |  2 +-
 include/hw/arm/{arm.h => boot.h}  | 12 ++++--------
 include/hw/arm/fsl-imx25.h        |  2 +-
 include/hw/arm/fsl-imx31.h        |  2 +-
 include/hw/arm/fsl-imx6.h         |  2 +-
 include/hw/arm/fsl-imx6ul.h       |  2 +-
 include/hw/arm/fsl-imx7.h         |  2 +-
 include/hw/arm/virt.h             |  2 +-
 include/hw/arm/xlnx-versal.h      |  2 +-
 include/hw/arm/xlnx-zynqmp.h      |  2 +-
 include/hw/timer/armv7m_systick.h | 22 ++++++++++++++++++++++
 hw/arm/armsse.c                   |  2 +-
 hw/arm/armv7m.c                   |  2 +-
 hw/arm/aspeed.c                   |  2 +-
 hw/arm/boot.c                     |  2 +-
 hw/arm/collie.c                   |  2 +-
 hw/arm/exynos4210.c               |  2 +-
 hw/arm/exynos4_boards.c           |  2 +-
 hw/arm/highbank.c                 |  2 +-
 hw/arm/integratorcp.c             |  2 +-
 hw/arm/mainstone.c                |  2 +-
 hw/arm/microbit.c                 |  2 +-
 hw/arm/mps2-tz.c                  |  2 +-
 hw/arm/mps2.c                     |  2 +-
 hw/arm/msf2-soc.c                 |  2 +-
 hw/arm/msf2-som.c                 |  2 +-
 hw/arm/musca.c                    |  2 +-
 hw/arm/musicpal.c                 |  2 +-
 hw/arm/netduino2.c                |  2 +-
 hw/arm/nrf51_soc.c                |  2 +-
 hw/arm/nseries.c                  |  2 +-
 hw/arm/omap1.c                    |  2 +-
 hw/arm/omap2.c                    |  2 +-
 hw/arm/omap_sx1.c                 |  2 +-
 hw/arm/palm.c                     |  2 +-
 hw/arm/raspi.c                    |  2 +-
 hw/arm/realview.c                 |  2 +-
 hw/arm/spitz.c                    |  2 +-
 hw/arm/stellaris.c                |  2 +-
 hw/arm/stm32f205_soc.c            |  2 +-
 hw/arm/strongarm.c                |  2 +-
 hw/arm/tosa.c                     |  2 +-
 hw/arm/versatilepb.c              |  2 +-
 hw/arm/vexpress.c                 |  2 +-
 hw/arm/virt.c                     |  2 +-
 hw/arm/xilinx_zynq.c              |  2 +-
 hw/arm/xlnx-versal.c              |  2 +-
 hw/arm/z2.c                       |  2 +-
 hw/intc/armv7m_nvic.c             |  1 -
 target/arm/arm-semi.c             |  1 -
 target/arm/cpu.c                  |  1 -
 target/arm/cpu64.c                |  1 -
 target/arm/kvm.c                  |  1 -
 target/arm/kvm32.c                |  1 -
 target/arm/kvm64.c                |  1 -
 57 files changed, 74 insertions(+), 63 deletions(-)
 rename include/hw/arm/{arm.h => boot.h} (96%)

-- 
2.20.1


