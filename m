Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B85CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 23:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BC42075A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 23:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjlIBnl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BC42075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joyD4-0000ip-V8
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 19:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-4r2XgsKCugRcUSXXOWYOXQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--hskinnemoen.bounces.google.com>)
 id 1joyC8-0007Vl-IG
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 19:55:44 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:47269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-4r2XgsKCugRcUSXXOWYOXQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--hskinnemoen.bounces.google.com>)
 id 1joyC6-0001yd-CK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 19:55:44 -0400
Received: by mail-pg1-x54a.google.com with SMTP id p8so7723905pgj.14
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 16:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=Q+/Fo0D+pxJKA5+TZNMoGiD22/K5gQwLGBVbCjcYL+Q=;
 b=fjlIBnl8w2CIpN9/B2364+9OiOk7jPO2BqCDSXr2338Z6ZuerBaNl8U321zYYn47jr
 wbmYdIJSLjP2Mpef0IAEHeH7onNswX2J5Y+MU1JZo/CtTP+1a7fyWwK6Hv17fRUt/a6w
 0VZD2IcOYSgcDCXXLDNnJdY5nGEWWzBjbw92gD2ngMsCJRbGStwxJfOMvLQJbH6kUkkr
 07NbSatJA3DxNIiSHpzmTIHZpkhbHPaZ5OvYWtOZGNUtu/tF81XAmeQtEy8yTGKhid9e
 fgQVVUFhdlqWrxmSBFI5cA+iDamcBP4q/uLHH31oDtpLIuid68UCYKaoU4vBta05pTWG
 uegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=Q+/Fo0D+pxJKA5+TZNMoGiD22/K5gQwLGBVbCjcYL+Q=;
 b=jw8gNz2bDB96OdEasCN975N5yXASXLPkwwmmhwCPzQllvjPhH0Rc6tG8hP9zOpa8Kc
 AG8YJkpDbIbJb7tRtLwbio3ifrX9j7ucR/E6HSILxAI1wBJPaFLFTaAi0V1VZuzZlxxm
 YXUAV6FjZji/aDkxZ7Wqsk5LMiUmAvky+mkchynILNCboZUisQZkodtlxPT4kiaNTJTU
 c0jhYoqRlVCrr3Fz2jP6kJP+PAcrTcIl7jxxfTqefmA8Uj1wDq898G1EWaXpd+Dwqbul
 WuxnJLIDenIDmacVt/mcdsAwKhYH5HeLQXQB+Q5yUlG5/CZ3e4GWZsKX8XBk7SdafB+N
 i4dA==
X-Gm-Message-State: AOAM531T9EVd1xa7jh9axyEHOxsCFPLmtJzjS/7/JbYmAMViCuPG0YgS
 HMj8Ix4smrBLkR8Q8EbWGYwpxnZkv+hD1k+jKg==
X-Google-Smtp-Source: ABdhPJw05aL+Ga/hNCaAu9T5fXj4ofF39NukNhGuyGYFRcdm4OaTTdV+ACzMgXyvI6TJt2VihlAcYttbQIz31VpDiA==
X-Received: by 2002:a17:90b:19c4:: with SMTP id
 nm4mr6244865pjb.66.1593215739732; 
 Fri, 26 Jun 2020 16:55:39 -0700 (PDT)
Date: Fri, 26 Jun 2020 16:55:07 -0700
Message-Id: <20200626235519.591734-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 00/12] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3-4r2XgsKCugRcUSXXOWYOXQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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

Time for another refresh of this patchset. Sorry it took so long -- I've been
trying to figure out why the Winbond flash model isn't working with
npcm750-evb, and I'm fairly convinced the number of dummy cycles in DIO mode
should be 4, not 1. Unfortunately, I don't see any other machines using Winbond
flash in DIO mode, so it's hard to prove that it's correct. I'm planning to
post a libqos-based test suite separately.

I'm also planning to add the vbootrom to qemu as a submodule, similar to the
other roms, but not in this pathset (let me know if you do want me to include
this in the series).

I also pushed this and the previous two patchsets to my qemu fork on github.
The branches are named npcm7xx-v[1-3].

  https://github.com/hskinnemoen/qemu

This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to boot
an OpenBMC image built for quanta-gsj. This includes device models for:

  - Global Configuration Registers
  - Clock Control
  - Timers
  - Fuses
  - Memory Controller
  - Flash Controller

These modules, along with the existing Cortex A9 CPU cores and built-in
peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in turn form
the foundation for the quanta-gsj and npcm750-evb machines, respectively. The
two SoCs are very similar; the only difference is that NPCM730 is missing some
peripherals that NPCM750 has, and which are not considered essential for
datacenter use (e.g. graphics controllers). For more information, see

https://www.nuvoton.com/products/cloud-computing/ibmc/

Both quanta-gsj and npcm750-evb correspond to real boards supported by OpenBMC.
At the end of the series, qemu can boot an OpenBMC image built for one of these
boards with some minor modifications.

The patches in this series were developed by Google and reviewed by Nuvoton. We
will be maintaining the machine and peripheral support together.

The data sheet for these SoCs is not generally available. Please let me know if
more comments are needed to understand the device behavior.

Changes since v2:

  - Simplified the MAINTAINERS entry.
  - Added link to OpenPOWER jenkins for gsj BMC images.
  - Reverted the smpboot change, back to byte swapping.
  - Adapted to upstream API changes:
      - sysbus_init_child_obj -> object_initialize_child
      - object_property_set_bool -> qdev_realize / sysbus_realize
      - ssi_create_slave_no_init -> qdev_new
      - qdev_init_nofail -> qdev_realize_and_unref
      - ssi_auto_connect_slaves removed
  - Moved Boot ROM loading from soc to machine init.
  - Plumbed power-on-straps property from GCR to the machine init code so it
    can be properly initialized. Turns out npcm750 memory init doesn't work
    without this. npcm730 is fine either way, though I'm not sure why.
  - Reworked the flash init code so it looks more like aspeed (i.e. the flash
    device gets added even if there's no drive).

Changes since v1 (requested by reviewers):

  - Clarify the source of CLK reset values.
  - Made smpboot a constant byte array, eliinated byte swapping.
  - NPCM7xxState now stores an array of ARMCPUs, not pointers to ARMCPUs.
  - Clarify why EL3 is disabled.
  - Introduce NPCM7XX_NUM_IRQ constant.
  - Set the number of CPUs according to SoC variant, and disallow command line
    overrides (i.e. you can no longer override the number of CPUs with the -smp
    parameter). This is trying to follow the spirit of
    https://patchwork.kernel.org/patch/11595407/.
  - Switch register operations to DEVICE_LITTLE_ENDIAN throughout.
  - Machine documentation added (new patch).

Changes since v1 to support flash booting:

  - GCR reset value changes to get past memory initialization when booting
    from flash (patches 2 and 5):
      - INTCR2 now indicates that the DDR controller is initialized.
      - INTCR3 is initialized according to DDR memory size. A realize()
	method was implemented to achieve this.
  - Refactor the machine initialization a bit to make it easier to drop in
    machine-specific flash initialization (patch 6).
  - Extend the series with additional patches to enable booting from flash:
      - Boot ROM (through the -bios option).
      - OTP (fuse) controller.
      - Memory Controller stub (just enough to skip memory training).
      - Flash controller.
      - Board-specific flash initialization.

Thanks for reviewing,

Havard

Havard Skinnemoen (12):
  npcm7xx: Add config symbol
  hw/misc: Add NPCM7xx System Global Control Registers device model
  hw/misc: Add NPCM7xx Clock Controller device model
  hw/timer: Add NPCM7xx Timer device model
  hw/arm: Add NPCM730 and NPCM750 SoC models
  hw/arm: Add two NPCM7xx-based machines
  hw/arm: Load -bios image as a boot ROM for npcm7xx
  hw/nvram: NPCM7xx OTP device model
  hw/mem: Stubbed out NPCM7xx Memory Controller model
  hw/ssi: NPCM7xx Flash Interface Unit device model
  hw/arm: Wire up BMC boot flash for npcm750-evb and quanta-gsj
  docs/system: Add Nuvoton machine documentation

 MAINTAINERS                      |   8 +
 default-configs/arm-softmmu.mak  |   1 +
 docs/system/arm/nuvoton.rst      |  92 ++++++
 docs/system/target-arm.rst       |   1 +
 hw/arm/Kconfig                   |   9 +
 hw/arm/Makefile.objs             |   1 +
 hw/arm/npcm7xx.c                 | 429 ++++++++++++++++++++++++++
 hw/arm/npcm7xx_boards.c          | 188 ++++++++++++
 hw/mem/Makefile.objs             |   1 +
 hw/mem/npcm7xx_mc.c              |  83 ++++++
 hw/misc/Makefile.objs            |   2 +
 hw/misc/npcm7xx_clk.c            | 216 ++++++++++++++
 hw/misc/npcm7xx_gcr.c            | 211 +++++++++++++
 hw/misc/trace-events             |   8 +
 hw/nvram/Makefile.objs           |   1 +
 hw/nvram/npcm7xx_otp.c           | 391 ++++++++++++++++++++++++
 hw/ssi/Makefile.objs             |   1 +
 hw/ssi/npcm7xx_fiu.c             | 496 +++++++++++++++++++++++++++++++
 hw/ssi/trace-events              |   9 +
 hw/timer/Makefile.objs           |   1 +
 hw/timer/npcm7xx_timer.c         | 437 +++++++++++++++++++++++++++
 hw/timer/trace-events            |   5 +
 include/hw/arm/npcm7xx.h         | 106 +++++++
 include/hw/mem/npcm7xx_mc.h      |  35 +++
 include/hw/misc/npcm7xx_clk.h    |  65 ++++
 include/hw/misc/npcm7xx_gcr.h    |  76 +++++
 include/hw/nvram/npcm7xx_otp.h   |  93 ++++++
 include/hw/ssi/npcm7xx_fiu.h     |  99 ++++++
 include/hw/timer/npcm7xx_timer.h |  95 ++++++
 29 files changed, 3160 insertions(+)
 create mode 100644 docs/system/arm/nuvoton.rst
 create mode 100644 hw/arm/npcm7xx.c
 create mode 100644 hw/arm/npcm7xx_boards.c
 create mode 100644 hw/mem/npcm7xx_mc.c
 create mode 100644 hw/misc/npcm7xx_clk.c
 create mode 100644 hw/misc/npcm7xx_gcr.c
 create mode 100644 hw/nvram/npcm7xx_otp.c
 create mode 100644 hw/ssi/npcm7xx_fiu.c
 create mode 100644 hw/timer/npcm7xx_timer.c
 create mode 100644 include/hw/arm/npcm7xx.h
 create mode 100644 include/hw/mem/npcm7xx_mc.h
 create mode 100644 include/hw/misc/npcm7xx_clk.h
 create mode 100644 include/hw/misc/npcm7xx_gcr.h
 create mode 100644 include/hw/nvram/npcm7xx_otp.h
 create mode 100644 include/hw/ssi/npcm7xx_fiu.h
 create mode 100644 include/hw/timer/npcm7xx_timer.h

-- 
2.27.0.212.ge8ba1cc988-goog


