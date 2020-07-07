Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51B0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B28206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b098FiyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B28206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsseN-00027h-Nd
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ScMEXwsKCuAJUMKPPGOQGPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--hskinnemoen.bounces.google.com>)
 id 1jssd3-0008NW-N0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:41 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:46138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ScMEXwsKCuAJUMKPPGOQGPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--hskinnemoen.bounces.google.com>)
 id 1jssd1-0007XI-EG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:41 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id u64so33637920ybf.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=UfjGjuK6ki2IMCiDVXtnyZH2TsHuq1C3vdhKvOLJ4Fk=;
 b=b098FiyAo7LmLc1/dvCNRpWQVcm5qdABPS/Z1FDuaG1o5fYQ5548EqsTrhBWwG8l10
 PwIW7SK9m08LDqByQGa/BuAm997q2kkndZuhQBTes5vXvT4IlmrRXtzXmODRRb8b950P
 2BX2x/VfFwGt4st/BWSBB9ow1+1PkpDH1DaCuTj6v2e0d/HEc0bHH44OYmFV/BNBh2ep
 +kMqunrUvQ5v/WjejSq0JU0H0l/2IELjlJfLMGcIsk3/nqHZB5b4C6WRc/sogfNHuZBG
 DsVROIg9ISOydmQagUKQ4Ebnpy+lMcb9Bofkb2jG1qq5J1mVJlfuhHHcswcMbsAGoPpg
 eSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=UfjGjuK6ki2IMCiDVXtnyZH2TsHuq1C3vdhKvOLJ4Fk=;
 b=BbyPgjIQVUzyOu0OyOy+FyOG2E+pRWhGkj+oq1KMQPjKb3A5/tFkafbWD3lO+br4LS
 W0vYBaLxGxb+Nl9qj2BxFeI7szr6+n2XPfFJWaAP34dIe02uqqP6j9bi1hKw2dsOfGVE
 LEs1K47MmgvczjJ5K2tzc9Iogjl0m8Qn9m94jHGganQ1f24mqll9clCrR2iUzkjkobbd
 Y02VeLuFIcJAX5BIp3o3sG1gPVYlAidShHDkr/ko5gB0OGiScYZnrf/DD5qlf+DxeGQ0
 cU+KGkQaGj55qogh5/muHnJxNTfWWMDVMsIyOVQeRUmf4LGnvK7vvQ15ZjvMokBIv7pf
 G4Lg==
X-Gm-Message-State: AOAM530qIDk3akm5L5nYZzptmgeSNYs0hDBm15G3JQrxh0iTQFc1E/G8
 CvM8eEzt22EU3QNkR3uuBYg1AXMce5ICWnFdaQ==
X-Google-Smtp-Source: ABdhPJxp3JGSLgf1o0yLY7oP/eDrpTeKopzJ7ux0E85MgMELy9iyq1PXZ6nx0VmBgLYrwC0jlxiJHZzbOiA86e6GDg==
X-Received: by 2002:a25:ad03:: with SMTP id y3mr4310535ybi.411.1594147657712; 
 Tue, 07 Jul 2020 11:47:37 -0700 (PDT)
Date: Tue,  7 Jul 2020 11:47:18 -0700
Message-Id: <20200707184730.3047754-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 00/12] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, philmd@redhat.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3ScMEXwsKCuAJUMKPPGOQGPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

I also pushed this and the previous two patchsets to my qemu fork on github.
The branches are named npcm7xx-v[1-4].

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

Changes since v3:

  - License headers are now GPL v2-or-later throughout.
  - Added vmstate throughout (except the memory controller, which doesn't
    really have any state worth saving). Successfully booted a gsj image
    with two stop/savevm/quit/loadvm cycles along the way.
      - JFFS2 really doesn't like it if I let qemu keep running after savevm,
        and then jump back in time with loadvm. I assume this is expected.
  - Fixed an error API violation in npcm7xx_realize, removed pointless error
    check after object_property_set_link().
  - Switched the OTP device to use an embedded array instead of a g_malloc0'd
    one because I couldn't figure out how to set up vmstate for the latter.

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
 hw/arm/npcm7xx.c                 | 427 ++++++++++++++++++++++++++
 hw/arm/npcm7xx_boards.c          | 189 ++++++++++++
 hw/mem/Makefile.objs             |   1 +
 hw/mem/npcm7xx_mc.c              |  84 +++++
 hw/misc/Makefile.objs            |   2 +
 hw/misc/npcm7xx_clk.c            | 230 ++++++++++++++
 hw/misc/npcm7xx_gcr.c            | 224 ++++++++++++++
 hw/misc/trace-events             |   8 +
 hw/nvram/Makefile.objs           |   1 +
 hw/nvram/npcm7xx_otp.c           | 405 ++++++++++++++++++++++++
 hw/ssi/Makefile.objs             |   1 +
 hw/ssi/npcm7xx_fiu.c             | 510 +++++++++++++++++++++++++++++++
 hw/ssi/trace-events              |   9 +
 hw/timer/Makefile.objs           |   1 +
 hw/timer/npcm7xx_timer.c         | 468 ++++++++++++++++++++++++++++
 hw/timer/trace-events            |   5 +
 include/hw/arm/npcm7xx.h         | 107 +++++++
 include/hw/mem/npcm7xx_mc.h      |  36 +++
 include/hw/misc/npcm7xx_clk.h    |  66 ++++
 include/hw/misc/npcm7xx_gcr.h    |  77 +++++
 include/hw/nvram/npcm7xx_otp.h   |  94 ++++++
 include/hw/ssi/npcm7xx_fiu.h     | 100 ++++++
 include/hw/timer/npcm7xx_timer.h |  96 ++++++
 29 files changed, 3253 insertions(+)
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


