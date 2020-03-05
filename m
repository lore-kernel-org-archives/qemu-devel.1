Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C202C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28529207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1KPbVbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28529207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tS8-0008L7-8k
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOs-0003Ay-Qf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOq-00024H-UI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tOq-00021Y-NQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:04 -0500
Received: by mail-wr1-x432.google.com with SMTP id v11so5843427wrm.9
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bTh3B649XDI9W5fyM9S/2slByoAutwJyvkUDWGWUEPc=;
 b=X1KPbVbM8vfQuNPCGbuybyX3c169RSeF09YuQlMwQY7f95RG3iTfbFpDGpmb7DiiGu
 ipP2nWdurz1JuoVUmcBd4ZxKN0ydBaGKH62cCwe0dTFtEBTrYSNT7JGn7J+6J2/kVred
 pgtroKsmTn78xcMb4wTn61zcqFXFI8PW1ebzg7mKEV7NWhhflhN1OOmIYPzCD3bzIuJv
 q7Gc0HpxhZsR6T07pgOKnuYVy4UEk2b1sKFZ5lNDBTjpMKi2yAEuH30g7Gq9AoQUSTXP
 KMWH+G43OlsRWc3pvphBi1x1DAtixUbt3lNFI0CJDx119zwAz8SDzeyaN3+DRrFL4dJj
 T0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bTh3B649XDI9W5fyM9S/2slByoAutwJyvkUDWGWUEPc=;
 b=gMEwhQDq03snsEhzyhWdY9sO2nWtny3rTLxVIgWPgk0Szzx3asHLCC04md45cSOqI9
 1xu2SEgjgRomIrBNtYPjc/RLIMM5oqEch6K0ie8CUQvUXCa13o9/9of37VF+Hm2HaswR
 jyGDWqia3AQm/dLiJRRKVFqGEjetPuCqZMqd84ri/XA3hGrB2mybWBtptWdJgdIXP84U
 NFDhW0FiyIczO1qS6+9t5DQWOCE2Jybd7+5cHHsiqcwLRVcRM/IUhHZxnt/1WIEJxejp
 OLKYt7HPiuMSX55uB8eD46ZFomTX4NimyBqp3UFvB6+ajN5I4My42jATdVKgxLr4J4Iq
 0OGg==
X-Gm-Message-State: ANhLgQ2C+KgcNEmEd4rpT8mEOHs0kML9I5JJphqauvtC9+zt/JN4nG75
 0+xXG9nZLEysxWmaDK9gNAWV6neJteoY3w==
X-Google-Smtp-Source: ADFU+vvTo5sxwtPcBOi1rSCQ5FVCYB/z0NGou1UAaV3TYJqFvsw4GqC5w0DMtlRT5/2DbZbQlnKoMA==
X-Received: by 2002:adf:a419:: with SMTP id d25mr11661780wra.210.1583425862644; 
 Thu, 05 Mar 2020 08:31:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/37] target-arm queue
Date: Thu,  5 Mar 2020 16:30:23 +0000
Message-Id: <20200305163100.22912-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

Nothing much exciting here, but it's 37 patches worth...

thanks
-- PMM

The following changes since commit e64a62df378a746c0b257105959613c9f8122e59:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-040320-1' into staging (2020-03-05 12:13:51 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200305

for you to fetch changes up to 597d61a3b1f94c53a3aaa77671697c0c5f797dbf:

  target/arm: Clean address for DC ZVA (2020-03-05 16:09:21 +0000)

----------------------------------------------------------------
 * versal: Implement ADMA
 * Implement (trivially) ARMv8.2-TTCNP
 * hw/arm/smmu-common: a fix to smmu_find_smmu_pcibus
 * Remove unnecessary endianness-handling on some boards
 * Avoid minor memory leaks from timer_new in some devices
 * Honour more of the HCR_EL2 trap bits
 * Complain rather than ignoring bad command line options for cubieboard
 * Honour TBI for DC ZVA and exception return

----------------------------------------------------------------
Edgar E. Iglesias (2):
      hw/arm: versal: Add support for the LPD ADMAs
      hw/arm: versal: Generate xlnx-versal-virt zdma FDT nodes

Eric Auger (1):
      hw/arm/smmu-common: a fix to smmu_find_smmu_pcibus

Niek Linnenbank (4):
      hw/arm/cubieboard: use ARM Cortex-A8 as the default CPU in machine definition
      hw/arm/cubieboard: restrict allowed CPU type to ARM Cortex-A8
      hw/arm/cubieboard: restrict allowed RAM size to 512MiB and 1GiB
      hw/arm/cubieboard: report error when using unsupported -bios argument

Pan Nengyuan (4):
      hw/arm/pxa2xx: move timer_new from init() into realize() to avoid memleaks
      hw/arm/spitz: move timer_new from init() into realize() to avoid memleaks
      hw/arm/strongarm: move timer_new from init() into realize() to avoid memleaks
      hw/timer/cadence_ttc: move timer_new from init() into realize() to avoid memleaks

Peter Maydell (1):
      target/arm: Implement (trivially) ARMv8.2-TTCNP

Philippe Mathieu-Daudé (6):
      hw/arm/smmu-common: Simplify smmu_find_smmu_pcibus() logic
      hw/arm/gumstix: Simplify since the machines are little-endian only
      hw/arm/mainstone: Simplify since the machines are little-endian only
      hw/arm/omap_sx1: Simplify since the machines are little-endian only
      hw/arm/z2: Simplify since the machines are little-endian only
      hw/arm/musicpal: Simplify since the machines are little-endian only

Richard Henderson (19):
      target/arm: Improve masking of HCR/HCR2 RES0 bits
      target/arm: Add HCR_EL2 bit definitions from ARMv8.6
      target/arm: Disable has_el2 and has_el3 for user-only
      target/arm: Remove EL2 and EL3 setup from user-only
      target/arm: Improve masking in arm_hcr_el2_eff
      target/arm: Honor the HCR_EL2.{TVM,TRVM} bits
      target/arm: Honor the HCR_EL2.TSW bit
      target/arm: Honor the HCR_EL2.TACR bit
      target/arm: Honor the HCR_EL2.TPCP bit
      target/arm: Honor the HCR_EL2.TPU bit
      target/arm: Honor the HCR_EL2.TTLB bit
      tests/tcg/aarch64: Add newline in pauth-1 printf
      target/arm: Replicate TBI/TBID bits for single range regimes
      target/arm: Optimize cpu_mmu_index
      target/arm: Introduce core_to_aa64_mmu_idx
      target/arm: Apply TBI to ESR_ELx in helper_exception_return
      target/arm: Move helper_dc_zva to helper-a64.c
      target/arm: Use DEF_HELPER_FLAGS for helper_dc_zva
      target/arm: Clean address for DC ZVA

 include/hw/arm/xlnx-versal.h |   6 +
 target/arm/cpu.h             |  30 ++--
 target/arm/helper-a64.h      |   1 +
 target/arm/helper.h          |   1 -
 target/arm/internals.h       |   6 +
 hw/arm/cubieboard.c          |  29 +++-
 hw/arm/gumstix.c             |  16 +-
 hw/arm/mainstone.c           |   8 +-
 hw/arm/musicpal.c            |  10 --
 hw/arm/omap_sx1.c            |  11 +-
 hw/arm/pxa2xx.c              |  17 +-
 hw/arm/smmu-common.c         |  20 +--
 hw/arm/spitz.c               |   8 +-
 hw/arm/strongarm.c           |  18 ++-
 hw/arm/xlnx-versal-virt.c    |  28 ++++
 hw/arm/xlnx-versal.c         |  24 +++
 hw/arm/z2.c                  |   8 +-
 hw/timer/cadence_ttc.c       |  18 ++-
 target/arm/cpu.c             |  13 +-
 target/arm/cpu64.c           |   2 +
 target/arm/helper-a64.c      | 114 ++++++++++++-
 target/arm/helper.c          | 373 ++++++++++++++++++++++++++++++-------------
 target/arm/op_helper.c       |  93 -----------
 target/arm/translate-a64.c   |   4 +-
 tests/tcg/aarch64/pauth-1.c  |   2 +-
 25 files changed, 551 insertions(+), 309 deletions(-)

