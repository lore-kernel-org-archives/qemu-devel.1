Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF1C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA29221FC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBxsXD3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA29221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxzk-0003Ei-EY
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 16:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUxyg-0002Xf-FJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:11:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUxye-0005Qi-El
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:11:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id g12so3999343wrp.10
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tXJhsX37JG/vpE+oN5N2/ucFLeg9uvlTns+HZvCHKTs=;
 b=QBxsXD3csYnVwG6P7K0ePdrBLfbp3y9mwYDGGOio8yG+R/O006GcyV0/m09XstzcWw
 h5n2/4Dt3pKnCk/bv/wz2VQ47dHRfjcL1kKTnXAqppvAtlx6bzoNnCk8cYGDJFSAhx8A
 YpXgUn0YyrJyTtt/1DnJF8ygoOfjTpCHROIDG/M93a2wWy+aRpgDhRqrHMPFGFisepMQ
 xxSZnudTKLJBiPgetim0r+21k7fJkpf/76Jf9+mflvE9lMXGWDeaJ+vY5jdGbfrsfAKq
 128+an4AfEzdOxG/G7WuLaxqWfupE0/w6lc354M9bG5VMMS2+H+hEm3KcCKWGckSLdtU
 e3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tXJhsX37JG/vpE+oN5N2/ucFLeg9uvlTns+HZvCHKTs=;
 b=PXly44IChguRb+ocZpMC5KOwn5KtotVuNfmzg6wVSw8zNFG4S5LKpyL0T5/iYoqUS9
 0DE7kEU/J3UoOjgVezIIqpLz9C11jdYaFfYAu/Jq3XcQoCUL5HZn6P7FNMbpw0bPSCd1
 ia/CM9S0s1yc8nP/DIoA3Rh64Un7iqF/DlLGLvTCH8Flxl+ckZ2jU4WvNcYdhMf+0nhG
 nBN0Wx/egh8wE3PtLWwF4bMBhuVESJndGZuOdMY6on7c+o4I2z3yaSKfndnEgXouPjEG
 53zv6FiR+BaXueSgrGWNRJErNk2ZpBCv8YW/fOKsJNh7IVxeTJ7orZiKHyr40hOAzCUR
 84eQ==
X-Gm-Message-State: AOAM531PFZQHTxtggDm9jSr0ny3FPPNGV12k0NE69mHqCehIyfCr5+eM
 q4xZr1t5lhKWmjq0FucqQbX8WoWRgJ+jXw==
X-Google-Smtp-Source: ABdhPJy0MPxWivVk/+iUH9W9blXJEURbXmeznDfdhu9N27Zo6x6mbMR0ck1LnshXWJ1G+a0NKfSyFQ==
X-Received: by 2002:a7b:cc89:: with SMTP id p9mr3938660wma.4.1603224682448;
 Tue, 20 Oct 2020 13:11:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j13sm4537587wru.86.2020.10.20.13.11.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 13:11:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/29] target-arm queue
Date: Tue, 20 Oct 2020 21:11:19 +0100
Message-Id: <20201020201119.9308-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

v2: dropped linux-user bti series.

The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' into staging (2020-10-20 11:20:36 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201020-1

for you to fetch changes up to 8128c8e8cc9489a8387c74075974f86dc0222e7f:

  target/arm: Implement FPSCR.LTPSIZE for M-profile LOB extension (2020-10-20 16:12:01 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix AArch32 SMLAD incorrect setting of Q bit
 * AArch32 VCVT fixed-point to float is always round-to-nearest
 * strongarm: Fix 'time to transmit a char' unit comment
 * Restrict APEI tables generation to the 'virt' machine
 * bcm2835: minor code cleanups
 * bcm2835: connect all IRQs from SYS_timer device
 * correctly flush TLBs when TBI is enabled
 * tests/qtest: Add npcm7xx timer test
 * loads-stores.rst: add footnote that clarifies GETPC usage
 * Fix reported EL for mte_check_fail
 * Ignore HCR_EL2.ATA when {E2H,TGE} != 11
 * microbit_i2c: Fix coredump when dump-vmstate
 * nseries: Fix loading kernel image on n8x0 machines
 * Implement v8.1M low-overhead-loops

----------------------------------------------------------------
Emanuele Giuseppe Esposito (1):
      loads-stores.rst: add footnote that clarifies GETPC usage

Havard Skinnemoen (1):
      tests/qtest: Add npcm7xx timer test

Peng Liang (1):
      microbit_i2c: Fix coredump when dump-vmstate

Peter Maydell (12):
      target/arm: Fix SMLAD incorrect setting of Q bit
      target/arm: AArch32 VCVT fixed-point to float is always round-to-nearest
      decodetree: Fix codegen for non-overlapping group inside overlapping group
      target/arm: Implement v8.1M NOCP handling
      target/arm: Implement v8.1M conditional-select insns
      target/arm: Make the t32 insn[25:23]=111 group non-overlapping
      target/arm: Don't allow BLX imm for M-profile
      target/arm: Implement v8.1M branch-future insns (as NOPs)
      target/arm: Implement v8.1M low-overhead-loop instructions
      target/arm: Fix has_vfp/has_neon ID reg squashing for M-profile
      target/arm: Allow M-profile CPUs with FP16 to set FPSCR.FP16
      target/arm: Implement FPSCR.LTPSIZE for M-profile LOB extension

Philippe Mathieu-Daudé (9):
      hw/arm/strongarm: Fix 'time to transmit a char' unit comment
      hw/arm: Restrict APEI tables generation to the 'virt' machine
      hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT definition
      hw/timer/bcm2835: Rename variable holding CTRL_STATUS register
      hw/timer/bcm2835: Support the timer COMPARE registers
      hw/arm/bcm2835_peripherals: Correctly wire the SYS_timer IRQs
      hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
      hw/intc/bcm2836_control: Use IRQ definitions instead of magic numbers
      hw/arm/nseries: Fix loading kernel image on n8x0 machines

Richard Henderson (5):
      accel/tcg: Add tlb_flush_page_bits_by_mmuidx*
      target/arm: Use tlb_flush_page_bits_by_mmuidx*
      target/arm: Remove redundant mmu_idx lookup
      target/arm: Fix reported EL for mte_check_fail
      target/arm: Ignore HCR_EL2.ATA when {E2H,TGE} != 11

 docs/devel/loads-stores.rst             |   8 +-
 default-configs/devices/arm-softmmu.mak |   1 -
 include/exec/exec-all.h                 |  36 ++
 include/hw/timer/bcm2835_systmr.h       |  17 +-
 target/arm/cpu.h                        |   8 +
 target/arm/helper.h                     |  13 +
 target/arm/internals.h                  |   9 +-
 target/arm/m-nocp.decode                |  10 +-
 target/arm/t32.decode                   |  50 ++-
 accel/tcg/cputlb.c                      | 275 +++++++++++++++-
 hw/arm/bcm2835_peripherals.c            |  13 +-
 hw/arm/nseries.c                        |   1 +
 hw/arm/strongarm.c                      |   2 +-
 hw/i2c/microbit_i2c.c                   |   1 +
 hw/intc/bcm2835_ic.c                    |   4 +-
 hw/intc/bcm2836_control.c               |   8 +-
 hw/timer/bcm2835_systmr.c               |  57 ++--
 target/arm/cpu.c                        |  38 ++-
 target/arm/helper.c                     |  55 +++-
 target/arm/mte_helper.c                 |  13 +-
 target/arm/translate.c                  | 239 +++++++++++++-
 target/arm/vfp_helper.c                 |  76 +++--
 tests/qtest/npcm7xx_timer-test.c        | 562 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                          |   1 +
 hw/intc/trace-events                    |   4 +
 hw/timer/trace-events                   |   6 +-
 scripts/decodetree.py                   |   2 +-
 target/arm/translate-vfp.c.inc          |  41 ++-
 tests/qtest/meson.build                 |   1 +
 29 files changed, 1404 insertions(+), 147 deletions(-)
 create mode 100644 tests/qtest/npcm7xx_timer-test.c

