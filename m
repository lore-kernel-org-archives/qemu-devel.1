Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92272C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535CE20738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9zY63Uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535CE20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqh7-00047q-BG
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqfw-0001xL-VF
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqfv-0000OC-Ml
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id g12so6564846wrw.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O1s+7iA+RByhX62OpWmTXNBxPZFBvVw8FZxUNLFllrU=;
 b=r9zY63UuSxPmI+QSZco3eOC2eyz96cCXUGt+k0zLqG0goEtBoM/9n/ykBurLnSly7i
 z3FGRclabVO47+RH6RcBVtPO3GQU1xHQ5N2paRY9I1VjzNFUVFSTCYX2Aq8DoJGqVtL/
 hP6K+U64hOkaPhhZoSdSj3sWIuIwSob0gpZMN+IXp4lGk0yCVuTIpcE6+rhzXMUlTPIg
 1pdpOixjdJinshi/ejL3GwXMA8KTrtauy4BSEBWoBeesaUeH0mm/HmBeZjEJ+XT/06z8
 duYMEa1VTPsCgXdSKPBgCzmiVCokdQwzXp2E8KSRn+2SI56ZPVZMCgPTo5wfSHLu1h58
 3c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O1s+7iA+RByhX62OpWmTXNBxPZFBvVw8FZxUNLFllrU=;
 b=PszatQGjsi/YXVIv3kgrkBEH8TmTtWNhnmnqc/xCBY62UyuvuIvefqdQa+tVC+lkp9
 61i2U7yNP8KOk7smaB6iBmt6RroXuwdytN/KhO6uihVmb4jI7ruaO6U4sGYYSARr5hOO
 xLwxfy3qkrhomkgeE68NXvsZanRwTESqdl/APeq8mVzUyBerJGGZEFGmvn+vFPbKe96L
 xaqlxBe9D9Pp6NSWcb9NDGjltbFh+fPkMu0U2Gpie6eH9SSdsYWyxguIrDeb9S2XNrAI
 RKhbrnZetjEmB3zxYHMF3KOad2tFXpZuVtkTwnLOZD6KIOQXNojI/V59sRTj57BuxZUn
 lSEg==
X-Gm-Message-State: AOAM531sqrayq4wnJfyUj4sJ4sDkbOkIUr++Tf170jFXB71LvAlxP+sI
 HRSpwY6HRW3CLp8R+8n0H3uXZj7R0RMWrw==
X-Google-Smtp-Source: ABdhPJzv8AXHmKKsI3KEM5qmUqRDImNqyCDgq4Phl2bAT+QRFJZxAloo/HKAWEG1gY4+2uHxPk4PWA==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr78274wrv.269.1590088573208;
 Thu, 21 May 2020 12:16:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] target-arm queue
Date: Thu, 21 May 2020 20:15:41 +0100
Message-Id: <20200521191610.10941-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

target-arm queue: nothing big, just a collection of minor things.

-- PMM

The following changes since commit ae3aa5da96f4ccf0c2a28851449d92db9fcfad71:

  Merge remote-tracking branch 'remotes/berrange/tags/socket-next-pull-request' into staging (2020-05-21 16:47:28 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200521

for you to fetch changes up to 17b5df7b65d0192c5d775b5e1581518580774c77:

  linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32 (2020-05-21 20:00:19 +0100)

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
 hw/watchdog/wdt_imx2.c                     | 303 +++++++++++++++++++++++++++++
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
 37 files changed, 854 insertions(+), 292 deletions(-)
 create mode 100644 docs/system/arm/mps2.rst
 create mode 100644 docs/system/arm/musca.rst
 create mode 100644 docs/system/arm/vexpress.rst
 delete mode 100644 include/hw/misc/imx2_wdt.h
 create mode 100644 include/hw/watchdog/wdt_imx2.h
 delete mode 100644 hw/misc/imx2_wdt.c
 create mode 100644 hw/watchdog/wdt_imx2.c
 create mode 100644 tests/acceptance/machine_arm_canona1100.py

