Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC37C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EA2206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqRvbH8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EA2206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVvK-0000xi-P5
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqk-0001TR-3G
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqf-0001Mk-Mj
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqe-0001Ey-A5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id w15so463723wrv.10
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PpsZsWt4ims4klN0e9XgYMADqfOqIiOChYDI9wJAFf0=;
 b=nqRvbH8+9hfvNeTx9eSTMzz0LasELDoF0GYALrIWE1KiFZr0LdATRmoZBSIrHZ/Wnn
 noxGsq+z2oQj5fAl/8p1FNMvZlEvP8kQCQtiTFr9m94G+yvjpOhZt7X5uyXOOQODWYBQ
 e+pwsSA2pLxe3QukERgUnQEVIX5TrX/ulSce0yTo3PSk49y+mxvh2gHVkzwq/NU6klVW
 ZC7V6sHaS/doEZxa9M1mPUcP8gwTBBKSYM6u/DvlJFKC4EWNvbV3f5DRqFghPc+ch3r3
 2vUhWml3GFlwGrdAyjmgyjqvrKZP4537F5huaIBzbmHKWlYQSAKp4MP+Kqd/cVeb30Ng
 4Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PpsZsWt4ims4klN0e9XgYMADqfOqIiOChYDI9wJAFf0=;
 b=SJoAMf3chsOcXqChfExmoGfI+wi7jTSllpu/CQX3V4nL8dk/Vyp+x4e/EP0j9Jl8AW
 Fa2VMLhneBcMpWLNJgH6dNgPax+P6Jt4mEbbf7AZACQJt+H284VvOgSUDVNguAwOrBS/
 S3lK92y29Bt6zO0S8mUwvTTY5nDJYByqwhSptV9Evy+wMXNLKP9RncKPqMdsndfXobWo
 oCjUcfLOsdYwJ1gcGlG4UQljo22gRusJC7+xUTnbr0vEFx8tFw4VruKogKCzvDJw03aH
 fBysAQwUJDWpmMaA5AKXVyNiJrB5zfLufXdwGAbKDrg57IGiKIeoRkN6qN+RTI5wePI7
 7yJQ==
X-Gm-Message-State: AGi0PuY3lQmxFiah0YAAwOLMsrfbvyA5pXu3l/xxDz7CEtkm3L/1rOLb
 zEb5kWaC581TRTwCxX1VJtfQINQsRsk=
X-Google-Smtp-Source: APiQypJXOwBTEyynL8IjpvXpkTXvGoNNzfc6EsA69sl+jk+sAxueNtUuJau2gQ1T8Q9ldsBQSgS/lw==
X-Received: by 2002:a05:6000:1002:: with SMTP id
 a2mr338918wrx.151.1586195265522; 
 Mon, 06 Apr 2020 10:47:45 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:47:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 00/54] various: Fix error-propagation with
 Coccinelle scripts
Date: Mon,  6 Apr 2020 19:46:49 +0200
Message-Id: <20200406174743.16956-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is inspired of Peter Maydell fix [1]:
"hw/arm/xlnx-zynqmp.c: fix some error-handling code",
but grew after v1 [2] review :/

Markus wanted the reviewed patches in 5.0 [3] but it is too late
(and too big :p).  Ideally I would have split it in 4 sub-series
(roughly one with each cocci script) but since I won't have time
to continue this (soon), I'm sending it altogether so interested
can take/follow it.

If a particular patch is worth for 5.0, it can now be cherry-picked
alone, with its cocci script for reference.

Markus: I added the cocci patches to your Error section, I hope
that's fine :)

Regards,

Phil.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg691636.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg692155.html
[3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg694413.html
Supersedes: <20200325191830.16553-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (54):
  various: Remove suspicious '\' character outside of #define in C code
  scripts/coccinelle: Script to simplify DeviceClass error propagation
  hw/arm/allwinner-a10: Move some code from realize() to init()
  hw/arm/aspeed_ast2600: Simplify use of Error*
  hw/arm/aspeed_ast2600: Move some code from realize() to init()
  hw/arm/aspeed_soc: Move some code from realize() to init()
  hw/arm/aspeed_soc: Simplify use of Error*
  hw/arm/fsl-imx6: Simplify checks on 'smp_cpus' count
  hw/arm/fsl-imx6: Move some code from realize() to init()
  hw/arm/fsl-imx31: Move some code from realize() to init()
  hw/arm/msf2-soc: Store MemoryRegion in MSF2State
  hw/arm/stm32f205_soc: Store MemoryRegion in STM32F205State
  hw/arm/stm32f205_soc: Move some code from realize() to init()
  hw/arm/xlnx-zynqmp: Use single propagate_error() call
  hw/arm/xlnx-zynqmp: Split xlnx_zynqmp_create_rpu() as init + realize
  hw/arm/xlnx-zynqmp: Move some code from realize() to init()
  hw/microblaze/xlnx-zynqmp-pmu: Move some code from realize() to init()
  hw/pci-host/pnv_phb3: Move some code from realize() to init()
  hw/riscv/sifive_e: Move some code from realize() to init()
  hw/riscv/sifive_u: Use single type_init()
  hw/riscv/sifive_u: Move some code from realize() to init()
  hw/riscv/sifive_u: Store MemoryRegion in SiFiveUSoCState
  hw/riscv/sifive_u: Move some code from realize() to init()
  hw/riscv/sifive_u: Rename MachineClass::init()
  scripts/coccinelle: Catch missing error_propagate() calls in realize()
  hw/arm/fsl-imx: Add missing error-propagation code
  hw/arm/stm32f*05_soc: Add missing error-propagation code
  hw/arm/aspeed: Add missing error-propagation code
  hw/arm/allwinner-a10: Add missing error-propagation code
  hw/arm/msf2-soc: Add missing error-propagation code
  hw/riscv/sifive: Add missing error-propagation code
  hw/arm/armv7m: Add missing error-propagation code
  hw/intc/arm_gicv3_its_kvm: Add missing error-propagation code
  hw/microblaze/xlnx-zynqmp-pmu: Add missing error-propagation code
  hw/pci-host/pnv_phb3: Add missing error-propagation code
  hw/block/onenand: Add missing error-propagation code
  scripts/coccinelle: Add script to catch missing error_propagate()
    calls
  hw/arm/bcm2835_peripherals: Add missing error-propagation code
  hw/arm/fsl-imx: Add missing error-propagation code
  hw/arm/stm32fx05_soc: Add missing error-propagation code
  hw/dma/xilinx_axidma: Add missing error-propagation code
  hw/i386/x86: Add missing error-propagation code
  hw/mips/cps: Add missing error-propagation code
  hw/misc/macio/macio: Add missing error-propagation code
  hw/net/xilinx_axienet: Add missing error-propagation code
  hw/riscv/sifive_u: Add missing error-propagation code
  hw/sd/milkymist-memcard: Add missing error-propagation code
  scripts/coccinelle: Use &error_abort in TypeInfo::instance_init()
  various: Use &error_abort in instance_init()
  scripts/coccinelle: Find eventually missing error_propagate() calls
  migration/colo: Add missing error-propagation code
  hw/mips/boston: Add missing error-propagation code
  hw/mips/mips_malta: Add missing error-propagation code
  qga/commands-win32: Add missing error-propagation code

 .../add-missing-error_propagate.cocci         |  30 +++++
 .../find-missing-error_propagate.cocci        |  53 ++++++++
 ...implify-init-realize-error_propagate.cocci |  69 ++++++++++
 .../use-error_abort-in-instance_init.cocci    |  52 ++++++++
 .../use-error_propagate-in-realize.cocci      |  54 ++++++++
 include/hw/arm/msf2-soc.h                     |   4 +
 include/hw/arm/stm32f205_soc.h                |   4 +
 include/hw/riscv/sifive_u.h                   |   2 +
 backends/cryptodev-vhost-user.c               |   2 +-
 backends/rng-egd.c                            |   2 +-
 backends/rng-random.c                         |   2 +-
 backends/vhost-user.c                         |   3 +-
 block/replication.c                           |   4 +-
 block/vhdx.c                                  |   8 +-
 dump/dump.c                                   |   2 +-
 hw/arm/allwinner-a10.c                        |  44 +++---
 hw/arm/armv7m.c                               |  12 +-
 hw/arm/aspeed_ast2600.c                       |  93 ++++++++-----
 hw/arm/aspeed_soc.c                           |  27 ++--
 hw/arm/bcm2835_peripherals.c                  |  14 +-
 hw/arm/fsl-imx25.c                            |  14 +-
 hw/arm/fsl-imx31.c                            |   4 +-
 hw/arm/fsl-imx6.c                             |  81 ++++++-----
 hw/arm/msf2-soc.c                             |  42 +++---
 hw/arm/stm32f205_soc.c                        |  38 +++---
 hw/arm/stm32f405_soc.c                        |  10 +-
 hw/arm/vexpress.c                             |   8 +-
 hw/arm/xlnx-zcu102.c                          |   8 +-
 hw/arm/xlnx-zynqmp.c                          | 126 +++++++++---------
 hw/block/fdc.c                                |   4 +-
 hw/block/onenand.c                            |   6 +-
 hw/block/vhost-user-blk.c                     |   2 +-
 hw/block/virtio-blk.c                         |   2 +-
 hw/core/machine.c                             |   6 +-
 hw/cpu/core.c                                 |   4 +-
 hw/display/vga-pci.c                          |   7 +-
 hw/display/xlnx_dp.c                          |   4 +-
 hw/dma/sparc32_dma.c                          |   2 +-
 hw/dma/xilinx_axidma.c                        |   6 +
 hw/gpio/aspeed_gpio.c                         |   2 +-
 hw/i386/x86.c                                 |   4 +
 hw/ide/macio.c                                |   4 +-
 hw/ide/qdev.c                                 |   4 +-
 hw/intc/apic_common.c                         |   2 +-
 hw/intc/arm_gicv3_its_kvm.c                   |   6 +-
 hw/mem/nvdimm.c                               |   4 +-
 hw/microblaze/xlnx-zynqmp-pmu.c               |  52 ++++----
 hw/mips/boston.c                              |  17 +--
 hw/mips/cps.c                                 |  48 +++++++
 hw/mips/mips_malta.c                          |  19 ++-
 hw/misc/aspeed_sdmc.c                         |   2 +-
 hw/misc/edu.c                                 |   3 +-
 hw/misc/macio/macio.c                         |   8 +-
 hw/misc/macio/pmu.c                           |   3 +-
 hw/misc/pca9552.c                             |   2 +-
 hw/misc/tmp105.c                              |   2 +-
 hw/misc/tmp421.c                              |   8 +-
 hw/net/e1000.c                                |   3 +-
 hw/net/lance.c                                |   3 +-
 hw/net/lasi_i82596.c                          |   3 +-
 hw/net/ne2000-isa.c                           |   4 +-
 hw/net/spapr_llan.c                           |   2 +-
 hw/net/virtio-net.c                           |   4 +-
 hw/net/xilinx_axienet.c                       |   6 +
 hw/pci-host/grackle.c                         |   2 +-
 hw/pci-host/i440fx.c                          |   8 +-
 hw/pci-host/pnv_phb3.c                        |  32 +++--
 hw/pci-host/prep.c                            |   2 +-
 hw/pci-host/q35.c                             |  23 ++--
 hw/pci-host/sabre.c                           |   3 +-
 hw/pci-host/uninorth.c                        |   9 +-
 hw/pcmcia/pxa2xx.c                            |   3 +-
 hw/ppc/spapr_drc.c                            |   6 +-
 hw/ppc/spapr_rng.c                            |   2 +-
 hw/riscv/sifive_e.c                           |  32 +++--
 hw/riscv/sifive_u.c                           | 102 ++++++++------
 hw/s390x/event-facility.c                     |   6 +-
 hw/s390x/s390-ccw.c                           |   2 +-
 hw/s390x/s390-skeys.c                         |   4 +-
 hw/s390x/s390-stattrib.c                      |   4 +-
 hw/s390x/sclp.c                               |   2 +-
 hw/scsi/scsi-bus.c                            |   2 +-
 hw/scsi/scsi-disk.c                           |   2 +-
 hw/sd/milkymist-memcard.c                     |   4 +
 hw/sd/sdhci.c                                 |   2 +-
 hw/ssi/xilinx_spips.c                         |   2 +-
 hw/usb/bus.c                                  |   4 +-
 hw/usb/dev-network.c                          |   2 +-
 hw/usb/dev-storage.c                          |   4 +-
 hw/usb/host-libusb.c                          |   2 +-
 hw/usb/redirect.c                             |   2 +-
 hw/virtio/virtio-balloon.c                    |   4 +-
 migration/colo.c                              |   3 +
 net/dump.c                                    |   4 +-
 net/filter-buffer.c                           |   2 +-
 net/filter-mirror.c                           |  10 +-
 net/filter-rewriter.c                         |   3 +-
 qga/commands-win32.c                          |  26 ++--
 target/arm/cpu64.c                            |   4 +-
 target/i386/cpu.c                             |  41 +++---
 target/microblaze/cpu.c                       |  14 +-
 target/ppc/translate_init.inc.c               |   4 +-
 target/s390x/cpu.c                            |   3 +-
 tests/check-qom-proplist.c                    |   7 +-
 tests/test-qdev-global-props.c                |   4 +-
 MAINTAINERS                                   |   5 +
 106 files changed, 1014 insertions(+), 458 deletions(-)
 create mode 100644 scripts/coccinelle/add-missing-error_propagate.cocci
 create mode 100644 scripts/coccinelle/find-missing-error_propagate.cocci
 create mode 100644 scripts/coccinelle/simplify-init-realize-error_propagate.=
cocci
 create mode 100644 scripts/coccinelle/use-error_abort-in-instance_init.cocci
 create mode 100644 scripts/coccinelle/use-error_propagate-in-realize.cocci

--=20
2.21.1


