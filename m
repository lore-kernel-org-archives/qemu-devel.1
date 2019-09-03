Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153AA2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhT7QJyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153AA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5AtX-0004XF-HZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArI-0002er-K5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArH-0005qh-5k
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArG-0005p2-Rv
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id 30so7041109wrk.11
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=siE66EHNoZSdb5Y8Dt5mz5vybn6gWgzukEagHaOkoTc=;
 b=mhT7QJyFSC+qiyh8SKhWYmGK8C2tV9dlSvaw8y6jyU7j6iBgOEOl+dpKMTTag6+sgS
 faMczmlOVPzwHQDqoNCkBA23sC4i+PYgLjRyJOa/z+N8CUVQUxQF6vGhy8WDL2bFgHjm
 P8RqN724XfHJdv40n/8586lnP7mRzo1HWmux4QBvhZ6YIW2op77m/Mp/LCNGu5SPodgo
 CBJtntiTrGt9jwii2ztv0D21iPnofNmFG6cbgAguXk1/GVcg4YV0HyWFgHRZVK7KI1eM
 huhmZ7ns68Es0HRsPboSf/gs5X+pLXUee7wFlN95yiEgU/p7+1OIEct18vI83clrwwii
 bLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=siE66EHNoZSdb5Y8Dt5mz5vybn6gWgzukEagHaOkoTc=;
 b=s3q2c04fpqiFo+iklB+HJF49QzMaP0qJjCoEbSAFYaHSsCCYMzMBXOn28G+UB/Foo5
 Q3vi7JWKSvF2e7hW34/0SwQCE1+kLBYE0zHKhimTDMbTMykMY4pfSIryn+zrExwcN/EK
 YNr4DAMcCIQ/Fk0oYgty1GJzE+Ben0XKc5yaYRmHSnnS70t2ZhVSxvv1DXBukCCSCfZ0
 /mvFaJLl4SPzAcleFni+4XxSaDtyMqfeOwwNxpPlI6eIE+BfTnCMuf/9DVky2FU1E5Xq
 //ps7UTyonkV4h1+0CzfZDuA7EM780P/zTD6WJ4gkAZTXSJHBmZYZFbO39YeDi57HQHG
 ndtg==
X-Gm-Message-State: APjAAAW4K4VE6q5dOj143XDnQVq0l1PICvD/YpkJPL6t3hwhQkdaFf51
 n6wO82YOI6RjnX2/1kE5lutzA27COCYCPQ==
X-Google-Smtp-Source: APXvYqw4+OuqbfklHrZhKEi5cyYJhSfCfdNzv8sg3Dqg2f0N4+DntskQEjobzbFTWlAx3lP+IdZIsw==
X-Received: by 2002:a5d:458b:: with SMTP id p11mr13960854wrq.160.1567524995725; 
 Tue, 03 Sep 2019 08:36:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:12 +0100
Message-Id: <20190903153633.6651-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 00/21] target-arm queue
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

target-arm queue: this time around is all small fixes
and changes.

thanks
-- PMM

The following changes since commit fec105c2abda8567ec15230429c41429b5ee307c:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190828-pull-request' into staging (2019-09-03 14:03:15 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190903

for you to fetch changes up to 5e5584c89f36b302c666bc6db535fd3f7ff35ad2:

  target/arm: Don't abort on M-profile exception return in linux-user mode (2019-09-03 16:20:35 +0100)

----------------------------------------------------------------
target-arm queue:
 * Revert and correctly fix refactoring of unallocated_encoding()
 * Take exceptions on ATS instructions when needed
 * aspeed/timer: Provide back-pressure information for short periods
 * memory: Remove unused memory_region_iommu_replay_all()
 * hw/arm/smmuv3: Log a guest error when decoding an invalid STE
 * hw/arm/smmuv3: Remove spurious error messages on IOVA invalidations
 * target/arm: Fix SMMLS argument order
 * hw/arm: Use ARM_CPU_TYPE_NAME() macro when appropriate
 * hw/arm: Correct reference counting for creation of various objects
 * includes: remove stale [smp|max]_cpus externs
 * tcg/README: fix typo
 * atomic_template: fix indentation in GEN_ATOMIC_HELPER
 * include/exec/cpu-defs.h: fix typo
 * target/arm: Free TCG temps in trans_VMOV_64_sp()
 * target/arm: Don't abort on M-profile exception return in linux-user mode

----------------------------------------------------------------
Alex Bennée (2):
      includes: remove stale [smp|max]_cpus externs
      include/exec/cpu-defs.h: fix typo

Andrew Jeffery (1):
      aspeed/timer: Provide back-pressure information for short periods

Emilio G. Cota (2):
      tcg/README: fix typo s/afterwise/afterwards/
      atomic_template: fix indentation in GEN_ATOMIC_HELPER

Eric Auger (3):
      memory: Remove unused memory_region_iommu_replay_all()
      hw/arm/smmuv3: Log a guest error when decoding an invalid STE
      hw/arm/smmuv3: Remove spurious error messages on IOVA invalidations

Peter Maydell (4):
      target/arm: Allow ARMCPRegInfo read/write functions to throw exceptions
      target/arm: Take exceptions on ATS instructions when needed
      target/arm: Free TCG temps in trans_VMOV_64_sp()
      target/arm: Don't abort on M-profile exception return in linux-user mode

Philippe Mathieu-Daudé (6):
      hw/arm: Use ARM_CPU_TYPE_NAME() macro when appropriate
      hw/arm: Use object_initialize_child for correct reference counting
      hw/arm: Use sysbus_init_child_obj for correct reference counting
      hw/arm/fsl-imx: Add the cpu as child of the SoC object
      hw/dma/xilinx_axi: Use object_initialize_child for correct ref. counting
      hw/net/xilinx_axi: Use object_initialize_child for correct ref. counting

Richard Henderson (3):
      Revert "target/arm: Use unallocated_encoding for aarch32"
      target/arm: Factor out unallocated_encoding for aarch32
      target/arm: Fix SMMLS argument order

 accel/tcg/atomic_template.h    |   2 +-
 hw/arm/smmuv3-internal.h       |   1 +
 include/exec/cpu-defs.h        |   2 +-
 include/exec/memory.h          |  10 ----
 include/sysemu/sysemu.h        |   2 -
 target/arm/cpu.h               |   6 ++-
 target/arm/translate-a64.h     |   2 +
 target/arm/translate.h         |   2 -
 hw/arm/allwinner-a10.c         |   3 +-
 hw/arm/cubieboard.c            |   3 +-
 hw/arm/digic.c                 |   3 +-
 hw/arm/exynos4_boards.c        |   4 +-
 hw/arm/fsl-imx25.c             |   4 +-
 hw/arm/fsl-imx31.c             |   4 +-
 hw/arm/fsl-imx6.c              |   3 +-
 hw/arm/fsl-imx6ul.c            |   2 +-
 hw/arm/mcimx7d-sabre.c         |   9 ++--
 hw/arm/mps2-tz.c               |  15 +++---
 hw/arm/musca.c                 |   9 ++--
 hw/arm/smmuv3.c                |  18 ++++---
 hw/arm/xlnx-zynqmp.c           |   8 +--
 hw/dma/xilinx_axidma.c         |  16 +++---
 hw/net/xilinx_axienet.c        |  17 +++----
 hw/timer/aspeed_timer.c        |  17 ++++++-
 memory.c                       |   9 ----
 target/arm/helper.c            | 107 +++++++++++++++++++++++++++++++++++------
 target/arm/translate-a64.c     |  13 +++++
 target/arm/translate-vfp.inc.c |   2 +
 target/arm/translate.c         |  50 +++++++++++++++++--
 tcg/README                     |   2 +-
 30 files changed, 244 insertions(+), 101 deletions(-)

