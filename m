Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7848DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B8420724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFIWqAt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B8420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhI2-0003yU-Ei
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGh-0002Gb-Iy
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGf-00032T-BP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id g18so11113327wrm.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bp9P8X9qhNhqR1DZYLJlLTpeaJnCEFmUa9xUdHNBspo=;
 b=CFIWqAt6BJIu6p3pGeLuVxsqcMSDBnvswEXAYEqtw2/1eRMGBFgYXKcNGfAWi8Wfw+
 JWgpaRYhvAfFrtuVfL20Jls0fPzJNKaDeg/iAUhybGEzY7+11wJ+Jp+bCV8oPI7GuETo
 JPXeYO9aRCWnVgs8F43dWyuXpS42CwA3sYDjnTnn/jUXgLHEaE9YeyfDYfpoePl72DiM
 4mLdx64j5C5BLxOgoWEYyiCTPdQrGQTxjHHsAwTQ4+Y+oH9DFiRU97Ye3RAkHCVGFYjl
 +Xo9yZmaMm9hRCoevW3INGf8A5lnrqzxD9aVxuu7xTt+vG8BlCV4tjYNtpgHm7wjcHyZ
 0V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bp9P8X9qhNhqR1DZYLJlLTpeaJnCEFmUa9xUdHNBspo=;
 b=FSKQf75FCCviaR4O2P8BKJzazmE8nxlAL+1FEa0xsZj4LOLX3zL6rsVIwXSuQLZLiL
 9iZlrAyw9qZn3K7ERNI6bu6/scCi/qHaHiU+yA0Oqpk4bKFdsIVgENv4C6HGQQVGf4Al
 a8yeNL3YuSI9GUV3w71tAWSlTbmTB76WSRWjt0tJuZbmW/IfEkpM/xThsmnDWBc7MxZL
 a/wd968qFNPvd3dl/ppqFgLM9xwsm5wUEt9qG1CMNdIVWHJf7M8UwxY5SPlCsm2OUPkn
 hNCywXlbWzDr1cWfhDtq+3EwFAtduR3YUiLVWjCOSRXtIeSy/LD2aTKguXsD1PAnEUaX
 mrTg==
X-Gm-Message-State: AOAM531bEa8wicU/Rxvbj3+BiXJ6l1ZuO/4ZVV3MMZNhF99Zqm858b4Z
 Z49YsdYbYQfNl2VWAuj/1N023uKYrDpXLg==
X-Google-Smtp-Source: ABdhPJzFkYtH8IfKh176XA19jei9oXGIUeakl/mhzl9LGB3ZSwBYuPeuvsiVODL6ef2RXsrLLt+g6w==
X-Received: by 2002:adf:f711:: with SMTP id r17mr25222856wrp.409.1592912346833; 
 Tue, 23 Jun 2020 04:39:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/42] target-arm queue
Date: Tue, 23 Jun 2020 12:38:22 +0100
Message-Id: <20200623113904.28805-1-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The following changes since commit 61fee7f45955cd0bf9b79be9fa9c7ebabb5e6a85:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-testing-20200622' into staging (2020-06-22 20:50:10 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200623

for you to fetch changes up to 539533b85fbd269f777bed931de8ccae1dd837e9:

  arm/virt: Add memory hot remove support (2020-06-23 11:39:48 +0100)

----------------------------------------------------------------
target-arm queue:
 * util/oslib-posix : qemu_init_exec_dir implementation for Mac
 * target/arm: Last parts of neon decodetree conversion
 * hw/arm/virt: Add 5.0 HW compat props
 * hw/watchdog/cmsdk-apb-watchdog: Add trace event for lock status
 * mps2: Add CMSDK APB watchdog, FPGAIO block, S2I devices and I2C devices
 * mps2: Add some unimplemented-device stubs for audio and GPIO
 * mps2-tz: Use the ARM SBCon two-wire serial bus interface
 * target/arm: Check supported KVM features globally (not per vCPU)
 * tests/qtest/arm-cpu-features: Add feature setting tests
 * arm/virt: Add memory hot remove support

----------------------------------------------------------------
Andrew Jones (2):
      hw/arm/virt: Add 5.0 HW compat props
      tests/qtest/arm-cpu-features: Add feature setting tests

David CARLIER (1):
      util/oslib-posix : qemu_init_exec_dir implementation for Mac

Peter Maydell (23):
      target/arm: Convert Neon 2-reg-misc VREV64 to decodetree
      target/arm: Convert Neon 2-reg-misc pairwise ops to decodetree
      target/arm: Convert VZIP, VUZP to decodetree
      target/arm: Convert Neon narrowing moves to decodetree
      target/arm: Convert Neon 2-reg-misc VSHLL to decodetree
      target/arm: Convert Neon VCVT f16/f32 insns to decodetree
      target/arm: Convert vectorised 2-reg-misc Neon ops to decodetree
      target/arm: Convert Neon 2-reg-misc crypto operations to decodetree
      target/arm: Rename NeonGenOneOpFn to NeonGenOne64OpFn
      target/arm: Fix capitalization in NeonGenTwo{Single, Double}OPFn typedefs
      target/arm: Make gen_swap_half() take separate src and dest
      target/arm: Convert Neon 2-reg-misc VREV32 and VREV16 to decodetree
      target/arm: Convert remaining simple 2-reg-misc Neon ops
      target/arm: Convert Neon VQABS, VQNEG to decodetree
      target/arm: Convert simple fp Neon 2-reg-misc insns
      target/arm: Convert Neon 2-reg-misc fp-compare-with-zero insns to decodetree
      target/arm: Convert Neon 2-reg-misc VRINT insns to decodetree
      target/arm: Convert Neon 2-reg-misc VCVT insns to decodetree
      target/arm: Convert Neon VSWP to decodetree
      target/arm: Convert Neon VTRN to decodetree
      target/arm: Move some functions used only in translate-neon.inc.c to that file
      target/arm: Remove unnecessary gen_io_end() calls
      target/arm: Remove dead code relating to SABA and UABA

Philippe Mathieu-Daudé (15):
      hw/watchdog/cmsdk-apb-watchdog: Add trace event for lock status
      hw/i2c/versatile_i2c: Add definitions for register addresses
      hw/i2c/versatile_i2c: Add SCL/SDA definitions
      hw/i2c: Add header for ARM SBCon two-wire serial bus interface
      hw/arm: Use TYPE_VERSATILE_I2C instead of hardcoded string
      hw/arm/mps2: Document CMSDK/FPGA APB subsystem sections
      hw/arm/mps2: Rename CMSDK AHB peripheral region
      hw/arm/mps2: Add CMSDK APB watchdog device
      hw/arm/mps2: Add CMSDK AHB GPIO peripherals as unimplemented devices
      hw/arm/mps2: Map the FPGA I/O block
      hw/arm/mps2: Add SPI devices
      hw/arm/mps2: Add I2C devices
      hw/arm/mps2: Add audio I2S interface as unimplemented device
      hw/arm/mps2-tz: Use the ARM SBCon two-wire serial bus interface
      target/arm: Check supported KVM features globally (not per vCPU)

Shameer Kolothum (1):
      arm/virt: Add memory hot remove support

 include/hw/i2c/arm_sbcon_i2c.h   |   35 ++
 target/arm/cpu.h                 |    2 +-
 target/arm/kvm_arm.h             |   21 +-
 target/arm/translate.h           |    8 +-
 target/arm/neon-dp.decode        |  106 ++++
 hw/acpi/generic_event_device.c   |   29 +
 hw/arm/mps2-tz.c                 |   23 +-
 hw/arm/mps2.c                    |   65 ++-
 hw/arm/realview.c                |    3 +-
 hw/arm/versatilepb.c             |    3 +-
 hw/arm/vexpress.c                |    3 +-
 hw/arm/virt.c                    |   63 +-
 hw/i2c/versatile_i2c.c           |   38 +-
 hw/watchdog/cmsdk-apb-watchdog.c |    1 +
 target/arm/cpu.c                 |    2 +-
 target/arm/cpu64.c               |   10 +-
 target/arm/kvm.c                 |    4 +-
 target/arm/kvm64.c               |   14 +-
 target/arm/translate-a64.c       |   20 +-
 target/arm/translate-neon.inc.c  | 1191 +++++++++++++++++++++++++++++++++++++-
 target/arm/translate-vfp.inc.c   |    7 +-
 target/arm/translate.c           | 1064 +---------------------------------
 tests/qtest/arm-cpu-features.c   |   38 +-
 util/oslib-posix.c               |   15 +
 MAINTAINERS                      |    1 +
 hw/arm/Kconfig                   |    8 +-
 hw/watchdog/trace-events         |    1 +
 27 files changed, 1624 insertions(+), 1151 deletions(-)
 create mode 100644 include/hw/i2c/arm_sbcon_i2c.h

