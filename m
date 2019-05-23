Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD3CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9622E20851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFr3caxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9622E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTohw-0006Ij-Oz
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:28:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodX-0002WR-8O
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodV-0006oW-Ey
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTodV-0006n5-6Y
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id e15so6529735wrs.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=b12/iNlG/d9Vy90ENIOMpb6JzBZwigdlIPVxxnXJAUI=;
	b=PFr3caxlrCC/uFVgqDXfJo2apmobepS4V9bx6XvdB/LHnzhfjr4FesnjAemdkitAlD
	MqTT64zv5SXB7hwAqHRROY6HqFsVdKExqPk+ZmZi43zvGCbzaNB3v9bDkg0tQDYxZnsa
	HmdLzf37MUmkTgpjMhSr+o7iXX/85WZhx9w8WQm/7TuE39wYpmluvt7h8Yiv32rzppn2
	BVNgiyG2zZhrhhBMrJiapVwDfkGSeGOHLF2ehqd1YXua7B8hsA/CI87ha6AFIK+SZYrH
	iv+GZT38VDXlHknHr3xHUYI7ng4KI7g+U4iln3JakrnBIH7HuUgPhDNQyqKw/hbbpZgx
	P/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=b12/iNlG/d9Vy90ENIOMpb6JzBZwigdlIPVxxnXJAUI=;
	b=DS4N/u9sa3gFyRYj0KsUKxo3TJq5NAt0eNmCaQmcquTSNTG14X3GNKFZF4Cvwmj7lK
	oya+aG0RZ3ejZfFOykqVfZo3ftkJ9hjffCEFwGLYQ5Afy41biUPSR6xqm52RclUnbYk7
	AqSsZWimYLr64C1kNfbFk0SDN33gR2TOkpGp7wHZ7KOxVFcKy1BSgacPxAKBX57fQgzG
	ZY4msu+fzPNLwMxeOLewexR7axGIEFa+/gdhEcu/XjhmLeNzE8ZI7f1LL7EbFFlg9pA5
	bZK3Mt1L7/BGScWHIVDTcq126TstvGw3PyCU0mtKf0FJLXG3tkORYY7E/71j1gW0IH+u
	icsQ==
X-Gm-Message-State: APjAAAVHlOZaOpuxF5CBOJmgGelHpTHUsGFF5vdCKB2+baEcyfqks9b8
	GG98P4f+kzvW4Vh3B/nl5fWgZ/4U8pY17A==
X-Google-Smtp-Source: APXvYqzrIbmCEgr4GaHg66UM2GekvvaZJkPB/ryQlS55tPAwyuy7Va5A4gikHpH+ECifL/b2FOPxxg==
X-Received: by 2002:adf:9023:: with SMTP id h32mr46918500wrh.95.1558621439521; 
	Thu, 23 May 2019 07:23:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id z5sm9700617wmi.34.2019.05.23.07.23.58
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:23:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:23:45 +0100
Message-Id: <20190523142357.5175-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 00/12] target-arm queue
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

Not very much here, but several people have fallen over
the vector operation segfault bug, so let's get the fix
into master.

thanks
-- PMM

The following changes since commit d418238dca7b4e0b124135827ead3076233052b1:

  Merge remote-tracking branch 'remotes/rth/tags/pull-rng-20190522' into staging (2019-05-23 12:57:17 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190523

for you to fetch changes up to 98e4f4fdb8ea05d840f51f47125924c2bb9df2df:

  hw/arm/exynos4210: QOM'ify the Exynos4210 SoC (2019-05-23 14:47:44 +0100)

----------------------------------------------------------------
target-arm queue:
 * exynos4210: QOM'ify the Exynos4210 SoC
 * exynos4210: Add DMA support for the Exynos4210
 * arm_gicv3: Fix writes to ICC_CTLR_EL3
 * arm_gicv3: Fix write of ICH_VMCR_EL2.{VBPR0, VBPR1}
 * target/arm: Fix vector operation segfault
 * target/arm: Minor improvements to BFXIL, EXTR

----------------------------------------------------------------
Alistair Francis (1):
      target/arm: Fix vector operation segfault

Guenter Roeck (1):
      hw/arm/exynos4210: Add DMA support for the Exynos4210

Peter Maydell (5):
      arm: Move system_clock_scale to armv7m_systick.h
      arm: Remove unnecessary includes of hw/arm/arm.h
      arm: Rename hw/arm/arm.h to hw/arm/boot.h
      hw/intc/arm_gicv3: Fix write of ICH_VMCR_EL2.{VBPR0, VBPR1}
      hw/intc/arm_gicv3: Fix writes to ICC_CTLR_EL3

Philippe Mathieu-Daudé (3):
      hw/arm/exynos4: Remove unuseful debug code
      hw/arm/exynos4: Use the IEC binary prefix definitions
      hw/arm/exynos4210: QOM'ify the Exynos4210 SoC

Richard Henderson (2):
      target/arm: Use extract2 for EXTR
      target/arm: Simplify BFXIL expansion

 include/hw/arm/allwinner-a10.h    |  2 +-
 include/hw/arm/aspeed_soc.h       |  1 -
 include/hw/arm/bcm2836.h          |  1 -
 include/hw/arm/{arm.h => boot.h}  | 12 +++------
 include/hw/arm/exynos4210.h       |  9 +++++--
 include/hw/arm/fsl-imx25.h        |  2 +-
 include/hw/arm/fsl-imx31.h        |  2 +-
 include/hw/arm/fsl-imx6.h         |  2 +-
 include/hw/arm/fsl-imx6ul.h       |  2 +-
 include/hw/arm/fsl-imx7.h         |  2 +-
 include/hw/arm/virt.h             |  2 +-
 include/hw/arm/xlnx-versal.h      |  2 +-
 include/hw/arm/xlnx-zynqmp.h      |  2 +-
 include/hw/timer/armv7m_systick.h | 22 ++++++++++++++++
 hw/arm/armsse.c                   |  2 +-
 hw/arm/armv7m.c                   |  2 +-
 hw/arm/aspeed.c                   |  2 +-
 hw/arm/boot.c                     |  2 +-
 hw/arm/collie.c                   |  2 +-
 hw/arm/exynos4210.c               | 54 ++++++++++++++++++++++++++++++++++++---
 hw/arm/exynos4_boards.c           | 40 ++++++++---------------------
 hw/arm/highbank.c                 |  2 +-
 hw/arm/integratorcp.c             |  2 +-
 hw/arm/mainstone.c                |  2 +-
 hw/arm/microbit.c                 |  2 +-
 hw/arm/mps2-tz.c                  |  2 +-
 hw/arm/mps2.c                     |  2 +-
 hw/arm/msf2-soc.c                 |  1 -
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
 hw/intc/arm_gicv3_cpuif.c         |  6 ++---
 hw/intc/armv7m_nvic.c             |  1 -
 target/arm/arm-semi.c             |  1 -
 target/arm/cpu.c                  |  1 -
 target/arm/cpu64.c                |  1 -
 target/arm/kvm.c                  |  1 -
 target/arm/kvm32.c                |  1 -
 target/arm/kvm64.c                |  1 -
 target/arm/translate-a64.c        | 44 ++++++++++++++++---------------
 target/arm/translate.c            |  4 +--
 61 files changed, 164 insertions(+), 123 deletions(-)
 rename include/hw/arm/{arm.h => boot.h} (96%)

