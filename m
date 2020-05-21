Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C0620759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Txw6dxuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C0620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbsPf-0006lC-Nm
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 17:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbsOm-0005xS-Kl
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:06:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbsOl-0004uz-F6
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:06:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id u1so6770659wmn.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BQnja4CLhTIHO/htXAOOPgvjJFfYEFPCs0xxkxoK+AE=;
 b=Txw6dxuFHz25FSC5SVS9+uM2MXmsvajy32xJktnk7hiOPpOCDdGB8j9Ld6y8KJ6ECq
 qSDrg7WFBe+fzJO8MwlcLOk7Ce/qujDLgrQQs2AGGSmL3DMhOpsD5JXt5g/iSareJsF+
 jDKojhG+5PBQF3EEyLzpjQinKSFJhuA4lLHk68ytT/3mVr+E3Bm4GQMl2uvgmyudWom4
 kSVbDhxqV5V9sBG8M5f7zYhPQYwnv+hkUGfBI6gcB7ekp29jkJkTauLQa7RBb33M1vPE
 4R4e/rkA5ODDl699NuDFf5fsuSslZ/bwygXHGc91Gf8825cajgkCgtRiLQd+mcKNXLV5
 q8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BQnja4CLhTIHO/htXAOOPgvjJFfYEFPCs0xxkxoK+AE=;
 b=FMjSOPH8xZde+dfCjzBEjSRpLqlMDFkkdZAEDy2MqNZCZzHb9TDdPLLlcVdXRVdVH7
 D3BrlAs7QLLBCY2RInlwyHCyec9Sjb5Nmq12aPdQNb3vbPSmkt4il/h3p/sidkmldjpe
 d+dhfoZnQ/ItSQNPSx5b5CT0sk5neRHLOk1msyAxLoS5S6WZ6yOP5EjSbshSIkOEyF1+
 1FDKUgCTPNcYX1g3dfDO1gPCVqsqJ/WHzDOEgauhV3KD6XSE/dMTHvot6GSriV6IsomZ
 U8ES7xEzGJa+poKvWgP/GTaJD7ms9bXNqO+ymuyzQAKao7OQKJmZD6gFclJbNGHaB4UC
 7WNQ==
X-Gm-Message-State: AOAM531bHjBdAFnYAsF0Tix6rwd8ea1et02TVVAn1kZvP6efKiOQeGNN
 UTXiofhhY9hyZUfO0YWKWinp3zlz5VHCKQ==
X-Google-Smtp-Source: ABdhPJwxlARyj2GHnka9NMDOEvXOXq/xQ1U9LS0pnxeMJsHyZ8yzhevjlChngC3M7kEGCS08L6kw3g==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr10258302wmh.75.1590095197231; 
 Thu, 21 May 2020 14:06:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t14sm7170387wrb.56.2020.05.21.14.06.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 14:06:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/29] target-arm queue
Date: Thu, 21 May 2020 22:06:35 +0100
Message-Id: <20200521210635.17088-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

v2: added Property array terminator (which caused crashes on
various non-x86 host architectures).

The following changes since commit ae3aa5da96f4ccf0c2a28851449d92db9fcfad71:

  Merge remote-tracking branch 'remotes/berrange/tags/socket-next-pull-request' into staging (2020-05-21 16:47:28 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200521-1

for you to fetch changes up to fafe7229272f39500c14845bc7ea60a8504a5a20:

  linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32 (2020-05-21 22:05:27 +0100)

----------------------------------------------------------------
target-arm queue:
 * tests/acceptance: Add a test for the canon-a1100 machine
 * docs/system: Document some of the Arm development boards
 * linux-user: make BKPT insn cause SIGTRAP, not be a syscall
 * target/arm: Remove unused GEN_NEON_INTEGER_OP macro
 * fsl-imx25, fsl-imx31, fsl-imx6, fsl-imx6ul, fsl-imx7: implement watchdog
 * hw/arm: Use qemu_log_mask() instead of hw_error() in various places
 * ARM: PL061: Introduce N_GPIOS
 * target/arm: Improve clear_vec_high() usage
 * target/arm: Allow user-mode code to write CPSR.E via MSR
 * linux-user/arm: Reset CPSR_E when entering a signal handler
 * linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32

----------------------------------------------------------------
Amanieu d'Antras (1):
      linux-user/arm: Reset CPSR_E when entering a signal handler

Geert Uytterhoeven (1):
      ARM: PL061: Introduce N_GPIOS

Guenter Roeck (8):
      hw: Move i.MX watchdog driver to hw/watchdog
      hw/watchdog: Implement full i.MX watchdog support
      hw/arm/fsl-imx25: Wire up watchdog
      hw/arm/fsl-imx31: Wire up watchdog
      hw/arm/fsl-imx6: Connect watchdog interrupts
      hw/arm/fsl-imx6ul: Connect watchdog interrupts
      hw/arm/fsl-imx7: Instantiate various unimplemented devices
      hw/arm/fsl-imx7: Connect watchdog interrupts

Peter Maydell (12):
      docs/system: Add 'Arm' to the Integrator/CP document title
      docs/system: Sort Arm board index into alphabetical order
      docs/system: Document Arm Versatile Express boards
      docs/system: Document the various MPS2 models
      docs/system: Document Musca boards
      linux-user/arm: BKPT should cause SIGTRAP, not be a syscall
      linux-user/arm: Remove bogus SVC 0xf0002 handling
      linux-user/arm: Handle invalid arm-specific syscalls correctly
      linux-user/arm: Fix identification of syscall numbers
      target/arm: Remove unused GEN_NEON_INTEGER_OP macro
      target/arm: Allow user-mode code to write CPSR.E via MSR
      linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32

Philippe Mathieu-Daudé (4):
      hw/arm/integratorcp: Replace hw_error() by qemu_log_mask()
      hw/arm/pxa2xx: Replace hw_error() by qemu_log_mask()
      hw/char/xilinx_uartlite: Replace hw_error() by qemu_log_mask()
      hw/timer/exynos4210_mct: Replace hw_error() by qemu_log_mask()

Richard Henderson (2):
      target/arm: Use tcg_gen_gvec_mov for clear_vec_high
      target/arm: Use clear_vec_high more effectively

Thomas Huth (1):
      tests/acceptance: Add a test for the canon-a1100 machine

 docs/system/arm/integratorcp.rst           |   4 +-
 docs/system/arm/mps2.rst                   |  29 +++
 docs/system/arm/musca.rst                  |  31 +++
 docs/system/arm/vexpress.rst               |  60 ++++++
 docs/system/target-arm.rst                 |  20 +-
 include/hw/arm/fsl-imx25.h                 |   5 +
 include/hw/arm/fsl-imx31.h                 |   4 +
 include/hw/arm/fsl-imx6.h                  |   2 +-
 include/hw/arm/fsl-imx6ul.h                |   2 +-
 include/hw/arm/fsl-imx7.h                  |  23 ++-
 include/hw/misc/imx2_wdt.h                 |  33 ----
 include/hw/watchdog/wdt_imx2.h             |  90 +++++++++
 target/arm/cpu.h                           |   2 +-
 hw/arm/fsl-imx25.c                         |  10 +
 hw/arm/fsl-imx31.c                         |   6 +
 hw/arm/fsl-imx6.c                          |   9 +
 hw/arm/fsl-imx6ul.c                        |  10 +
 hw/arm/fsl-imx7.c                          |  35 ++++
 hw/arm/integratorcp.c                      |  23 ++-
 hw/arm/pxa2xx_gpio.c                       |   7 +-
 hw/char/xilinx_uartlite.c                  |   5 +-
 hw/display/pxa2xx_lcd.c                    |   8 +-
 hw/dma/pxa2xx_dma.c                        |  14 +-
 hw/gpio/pl061.c                            |  12 +-
 hw/misc/imx2_wdt.c                         |  90 ---------
 hw/timer/exynos4210_mct.c                  |  12 +-
 hw/watchdog/wdt_imx2.c                     | 304 +++++++++++++++++++++++++++++
 linux-user/arm/cpu_loop.c                  | 145 ++++++++------
 linux-user/arm/signal.c                    |  15 +-
 target/arm/translate-a64.c                 |  63 +++---
 target/arm/translate.c                     |  23 ---
 MAINTAINERS                                |   6 +
 hw/arm/Kconfig                             |   5 +
 hw/misc/Makefile.objs                      |   1 -
 hw/watchdog/Kconfig                        |   3 +
 hw/watchdog/Makefile.objs                  |   1 +
 tests/acceptance/machine_arm_canona1100.py |  35 ++++
 37 files changed, 855 insertions(+), 292 deletions(-)
 create mode 100644 docs/system/arm/mps2.rst
 create mode 100644 docs/system/arm/musca.rst
 create mode 100644 docs/system/arm/vexpress.rst
 delete mode 100644 include/hw/misc/imx2_wdt.h
 create mode 100644 include/hw/watchdog/wdt_imx2.h
 delete mode 100644 hw/misc/imx2_wdt.c
 create mode 100644 hw/watchdog/wdt_imx2.c
 create mode 100644 tests/acceptance/machine_arm_canona1100.py

