Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09280C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313162071A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3Em7/0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313162071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdMl-00022A-Tf
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLQ-0000Rs-OW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:12 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLO-0006Mh-R1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id c18so10146407wme.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LPvoNWrcuAbMt3Bczs+XY+88ieZh8Wvp6wIliMrEJnQ=;
 b=g3Em7/0ARn4mKYhciCHPyQaPmvPh5DGLOB3wfT6h4NfeDVGmVEeEwJUj924NQ3f9aL
 jdUxyyNR/GYmXIjYPP7FtnTHMHsKALvX2ksRAf3/k14DRDau4hI+6HLBPD9NV4tT/MzJ
 BXkNcv82ibZ+JfVAjfXUfZ7HiglMtDiRwJtwPUFSlljO5yK6tlkvz+lax+4nHCDfyX3M
 qdpeAANdvymWxQQ+JWRk4z3YTloXbFEdvwWfGvlMiilumfem0p1xVM+hVpRxfGW/UR8F
 ooqkWORvCgyW1PoKNL1ritUKk1iu5Q9RgaYFyDtARlKcR5p1WpmEm8ECFBuXtDSoB1w/
 RpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LPvoNWrcuAbMt3Bczs+XY+88ieZh8Wvp6wIliMrEJnQ=;
 b=J3Nw9XQC2OsZ90UvnDcxpJPs3WGAjeZM2rncqnpfARPlw/B2Fq8Y7tuv2jKw4MiUef
 62CobnSOOmPjI6HDHrTTNKoeU3sOpQL9Y1obNf0BbQyajlQ+PCEYkft6jI9RkVbyN5ud
 P9+KkxhNq2fR7P8nyxxfwPQjKHPGEOGHEfoo1a3H7h1zl+313zfQ4ZJihqykNrN2/POH
 lQi1Uazph18pxl79g5870jp69ZOzMTKeUxL0/ZOvR1PX99taLjefWCZd63+JabyYDIW+
 3oczWuk03qs+sOMZoavnaPSeohjCxqquyGmidiVuD5nORVILuxYhKo86g0sYiNo9i/K4
 PmMA==
X-Gm-Message-State: AOAM533qcmGxZRjYZJF8nmIUyLMqS1CWiKND1FWZtO6vLXqiKk8+LuCy
 DP3jSIxBUYi9mnlBU7eeccZvQ2Lg6FwzRQ==
X-Google-Smtp-Source: ABdhPJwkck5Hq35XBpC7Utybm4TrvgXtcf2n510IdShGOSBktbvdoTtO6xd5xE/FwoF6oFiqzxzcmA==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr17979417wmj.125.1604337008416; 
 Mon, 02 Nov 2020 09:10:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] target-arm queue
Date: Mon,  2 Nov 2020 17:09:39 +0000
Message-Id: <20201102171005.30690-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Small pile of bug fixes for rc1. I've included my patches to get
our docs building with Sphinx 3, just for convenience...

-- PMM

The following changes since commit b149dea55cce97cb226683d06af61984a1c11e96:

  Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20201102' into staging (2020-11-02 10:57:48 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201102

for you to fetch changes up to ffb4fbf90a2f63c9cb33e4bb9f854c79bf04ca4a:

  tests/qtest/npcm7xx_rng-test: Disable randomness tests (2020-11-02 16:52:18 +0000)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Fix Neon emulation bugs on big-endian hosts
 * target/arm: fix handling of HCR.FB
 * target/arm: fix LORID_EL1 access check
 * disas/capstone: Fix monitor disassembly of >32 bytes
 * hw/arm/smmuv3: Fix potential integer overflow (CID 1432363)
 * hw/arm/boot: fix SVE for EL3 direct kernel boot
 * hw/display/omap_lcdc: Fix potential NULL pointer dereference
 * hw/display/exynos4210_fimd: Fix potential NULL pointer dereference
 * target/arm: Get correct MMU index for other-security-state
 * configure: Test that gio libs from pkg-config work
 * hw/intc/arm_gicv3_cpuif: Make GIC maintenance interrupts work
 * docs: Fix building with Sphinx 3
 * tests/qtest/npcm7xx_rng-test: Disable randomness tests

----------------------------------------------------------------
AlexChen (2):
      hw/display/omap_lcdc: Fix potential NULL pointer dereference
      hw/display/exynos4210_fimd: Fix potential NULL pointer dereference

Peter Maydell (9):
      target/arm: Fix float16 pairwise Neon ops on big-endian hosts
      target/arm: Fix VUDOT/VSDOT (scalar) on big-endian hosts
      disas/capstone: Fix monitor disassembly of >32 bytes
      target/arm: Get correct MMU index for other-security-state
      configure: Test that gio libs from pkg-config work
      hw/intc/arm_gicv3_cpuif: Make GIC maintenance interrupts work
      scripts/kerneldoc: For Sphinx 3 use c:macro for macros with arguments
      qemu-option-trace.rst.inc: Don't use option:: markup
      tests/qtest/npcm7xx_rng-test: Disable randomness tests

Philippe Mathieu-Daudé (1):
      hw/arm/smmuv3: Fix potential integer overflow (CID 1432363)

Richard Henderson (11):
      target/arm: Introduce neon_full_reg_offset
      target/arm: Move neon_element_offset to translate.c
      target/arm: Use neon_element_offset in neon_load/store_reg
      target/arm: Use neon_element_offset in vfp_reg_offset
      target/arm: Add read/write_neon_element32
      target/arm: Expand read/write_neon_element32 to all MemOp
      target/arm: Rename neon_load_reg32 to vfp_load_reg32
      target/arm: Add read/write_neon_element64
      target/arm: Rename neon_load_reg64 to vfp_load_reg64
      target/arm: Simplify do_long_3d and do_2scalar_long
      target/arm: Improve do_prewiden_3d

Rémi Denis-Courmont (3):
      target/arm: fix handling of HCR.FB
      target/arm: fix LORID_EL1 access check
      hw/arm/boot: fix SVE for EL3 direct kernel boot

 docs/qemu-option-trace.rst.inc     |   6 +-
 configure                          |  10 +-
 include/hw/intc/arm_gicv3_common.h |   1 -
 disas/capstone.c                   |   2 +-
 hw/arm/boot.c                      |   3 +
 hw/arm/smmuv3.c                    |   3 +-
 hw/display/exynos4210_fimd.c       |   4 +-
 hw/display/omap_lcdc.c             |  10 +-
 hw/intc/arm_gicv3_cpuif.c          |   5 +-
 target/arm/helper.c                |  24 +-
 target/arm/m_helper.c              |   3 +-
 target/arm/translate.c             | 153 +++++++++---
 target/arm/vec_helper.c            |  12 +-
 tests/qtest/npcm7xx_rng-test.c     |  14 +-
 scripts/kernel-doc                 |  18 +-
 target/arm/translate-neon.c.inc    | 472 ++++++++++++++++++++-----------------
 target/arm/translate-vfp.c.inc     | 341 +++++++++++----------------
 17 files changed, 588 insertions(+), 493 deletions(-)

