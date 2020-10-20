Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C679C388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65272224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCy90LdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65272224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu1j-000604-HZ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0X-00049C-Dw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0U-0003oJ-Hh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:04 -0400
Received: by mail-wm1-x330.google.com with SMTP id d81so2327333wmc.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qwYzM2Xl3u4ZLBTe5e7+Xs7N+RxPtCXjkk0yxV7aJS8=;
 b=NCy90LdMO91Yqq7nKgyqXUBa9YpWMN5d+BMKQMslqYdZPUv+Zjs3lNNS4InZIHQKu1
 UsKYeO6DF3uE4hygyHg9jFskhngfh755rByo93pre6MNkQ7Rm0znM9XCxqaof/1D9wKy
 TMYAfLtBLVwbhSiL+kEChRQwfxNsr2MqPyl1sFAFONsz7m2CUkvky1nGiKBUKgW8LHiu
 Co+qBysIGbmiIl2BuHMH9OwkuUNvotDAP76jvJx4/w2Q76TM4WgMzSWQORTcbn5tYi2U
 ozJT9lP1uLJ8HE3Ava7g/s5NYdhoYPmMTYhYaYTVafKZrDmDxYoHphVPhh7Z9Wl/OYQI
 O3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qwYzM2Xl3u4ZLBTe5e7+Xs7N+RxPtCXjkk0yxV7aJS8=;
 b=J8zOlh+QWPP9i6oAoNlED6h1woI2+l+8rPeNauCvcvKB6hUDlNcDuxi5YXdMb1alK8
 RX/Rwr8n8GtFoj/dlLcEXDk48SbMjrZb06zX/3F9Lze8jCQRxRk8MHhj88buBj//y7vh
 9ieZ9DaXAu1eWROO0RySK4YYmsoAMuzzAFPgHc4nBnWVaWEx6VHwt2AevKjH0ounFKjo
 1fwlZ9ITe3qprm0xVCqI9YBBMaqquX8JKINjZtID592FqKmEwDxYA+Bho4dJLYPJKteO
 oFcIXTiz17lCStocBC6F1yuf2RslhdZ46vnkk7Ny7rnROME6pEA1nXiBq83yUwhAGIed
 XFSA==
X-Gm-Message-State: AOAM533iv42T9TV34j8G6F+NZbetrMNjzJrTqAKWWwmVrYWYyINoLOY1
 E4tdTJAwJvgcqA36GtAlSv4huUc9r3jvBg==
X-Google-Smtp-Source: ABdhPJwhLo0G4nLhcfJRJnxbcX+tr/waKLkePrnEknVpXou82Gfa+KStUdQMa+VGgot06Vsf75Hhjg==
X-Received: by 2002:a1c:8093:: with SMTP id b141mr3610605wmd.139.1603209419054; 
 Tue, 20 Oct 2020 08:56:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.56.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:56:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] target-arm queue
Date: Tue, 20 Oct 2020 16:56:15 +0100
Message-Id: <20201020155656.8045-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' into staging (2020-10-20 11:20:36 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201020

for you to fetch changes up to 6358890cb939192f6169fdf7664d903bf9b1d338:

  tests/tcg/aarch64: Add bti smoke tests (2020-10-20 16:12:02 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix AArch32 SMLAD incorrect setting of Q bit
 * AArch32 VCVT fixed-point to float is always round-to-nearest
 * strongarm: Fix 'time to transmit a char' unit comment
 * Restrict APEI tables generation to the 'virt' machine
 * bcm2835: minor code cleanups
 * correctly flush TLBs when TBI is enabled
 * tests/qtest: Add npcm7xx timer test
 * loads-stores.rst: add footnote that clarifies GETPC usage
 * Fix reported EL for mte_check_fail
 * Ignore HCR_EL2.ATA when {E2H,TGE} != 11
 * microbit_i2c: Fix coredump when dump-vmstate
 * nseries: Fix loading kernel image on n8x0 machines
 * Implement v8.1M low-overhead-loops
 * linux-user: Support AArch64 BTI

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

Philippe Mathieu-Daudé (10):
      hw/arm/strongarm: Fix 'time to transmit a char' unit comment
      hw/arm: Restrict APEI tables generation to the 'virt' machine
      hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT definition
      hw/timer/bcm2835: Rename variable holding CTRL_STATUS register
      hw/timer/bcm2835: Support the timer COMPARE registers
      hw/arm/bcm2835_peripherals: Correctly wire the SYS_timer IRQs
      hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
      hw/intc/bcm2836_control: Use IRQ definitions instead of magic numbers
      hw/arm/nseries: Fix loading kernel image on n8x0 machines
      linux-user/elfload: Avoid leaking interp_name using GLib memory API

Richard Henderson (16):
      accel/tcg: Add tlb_flush_page_bits_by_mmuidx*
      target/arm: Use tlb_flush_page_bits_by_mmuidx*
      target/arm: Remove redundant mmu_idx lookup
      target/arm: Fix reported EL for mte_check_fail
      target/arm: Ignore HCR_EL2.ATA when {E2H,TGE} != 11
      linux-user/aarch64: Reset btype for signals
      linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
      include/elf: Add defines related to GNU property notes for AArch64
      linux-user/elfload: Fix coding style in load_elf_image
      linux-user/elfload: Adjust iteration over phdr
      linux-user/elfload: Move PT_INTERP detection to first loop
      linux-user/elfload: Use Error for load_elf_image
      linux-user/elfload: Use Error for load_elf_interp
      linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes
      linux-user/elfload: Parse GNU_PROPERTY_AARCH64_FEATURE_1_AND
      tests/tcg/aarch64: Add bti smoke tests

 docs/devel/loads-stores.rst             |   8 +-
 default-configs/devices/arm-softmmu.mak |   1 -
 include/elf.h                           |  22 ++
 include/exec/cpu-all.h                  |   2 +
 include/exec/exec-all.h                 |  36 ++
 include/hw/timer/bcm2835_systmr.h       |  17 +-
 linux-user/qemu.h                       |   4 +
 linux-user/syscall_defs.h               |   4 +
 target/arm/cpu.h                        |  13 +
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
 linux-user/aarch64/signal.c             |  10 +-
 linux-user/elfload.c                    | 326 ++++++++++++++----
 linux-user/mmap.c                       |  16 +
 target/arm/cpu.c                        |  38 ++-
 target/arm/helper.c                     |  55 +++-
 target/arm/mte_helper.c                 |  13 +-
 target/arm/translate-a64.c              |   6 +-
 target/arm/translate.c                  | 239 +++++++++++++-
 target/arm/vfp_helper.c                 |  76 +++--
 tests/qtest/npcm7xx_timer-test.c        | 562 ++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/bti-1.c               |  62 ++++
 tests/tcg/aarch64/bti-2.c               | 108 ++++++
 tests/tcg/aarch64/bti-crt.inc.c         |  51 +++
 hw/arm/Kconfig                          |   1 +
 hw/intc/trace-events                    |   4 +
 hw/timer/trace-events                   |   6 +-
 scripts/decodetree.py                   |   2 +-
 target/arm/translate-vfp.c.inc          |  41 ++-
 tests/qtest/meson.build                 |   1 +
 tests/tcg/aarch64/Makefile.target       |  10 +
 tests/tcg/configure.sh                  |   4 +
 42 files changed, 1973 insertions(+), 208 deletions(-)
 create mode 100644 tests/qtest/npcm7xx_timer-test.c
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-2.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

