Received: from eggs.gnu.org ([2001:4830:134:3::10]:41525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHA-0003xY-96
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZH5-0007Ts-P3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:32 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZH5-0007TR-FD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:27 -0500
Received: by mail-wm0-x243.google.com with SMTP id r71so15606204wmd.1
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:27 -0800 (PST)
Received: from 640k.lan ([82.84.102.245])
	by smtp.gmail.com with ESMTPSA id f9sm6870298wmf.12.2018.02.13.04.01.24
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Feb 2018 04:01:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:04 +0100
Message-Id: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/48] Misc patches for 2018-02-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 7d848450b6e2a3e14a776b4c93704710e7f3d233:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.12-20180212' into staging (2018-02-12 14:52:48 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ef07edfd51c4bf375a3185c8a263dd89f2b5b9db:

  travis: use libgcc-4.8-dev (libgcc-6-dev is not available on Ubuntu 14.04) (2018-02-13 11:44:15 +0100)

----------------------------------------------------------------
* CAN bus (will be under network maintainner)
* scsi-block opblockers (myself)
* Dirty log bitmap cleanup (myself)
* SDHCI improvements and tests (Philippe)
* HAX support for larger guest sizese (Yu Ning)

----------------------------------------------------------------
Daniel P. Berrangé (2):
      Revert "build-sys: silence make by default or V=0"
      make: fix help message reference to bogus V=0 variable

Deniz Eren (2):
      hw/net/can: PCM-3680I PCI (dual SJA1000 channel) emulation
      hw/net/can: MIOe-3680 PCI (dual SJA1000 channel) emulation

Marc-André Lureau (2):
      build-sys: remove useless extra*flags variables
      build-sys: check static linking of UBSAN

Paolo Bonzini (5):
      hw/net/can: interrupt cleanup
      g364fb: switch to using DirtyBitmapSnapshot
      memory: remove memory_region_test_and_clear_dirty
      memory: hide memory_region_sync_dirty_bitmap behind DirtyBitmapSnapshot
      memory: unify loops to sync dirty log bitmap

Pavel Pisa (5):
      net/can: simple messages transport implementation for QEMU
      net/can: support for connecting to Linux host SocketCAN interface.
      hw/net/can: SJA1000 chip register level emulation for QEMU
      hw/net/can: Kvaser PCI CAN-S (single SJA1000 channel) emulation
      net/can: documentation

Philippe Mathieu-Daudé (30):
      sdhci: use error_propagate(local_err) in realize()
      sdhci: add qtest to check the SD capabilities register
      sdhci: add check_capab_readonly() qtest
      sdhci: add a check_capab_baseclock() qtest
      sdhci: add a check_capab_sdma() qtest
      sdhci: add qtest to check the SD Spec version
      sdhci: add a 'spec_version property' (default to v2)
      sdhci: use a numeric value for the default CAPAB register
      sdhci: simplify sdhci_get_fifolen()
      sdhci: check the Spec v1 capabilities correctness
      sdhci: replace DMA magic value by BLOCK_SIZE_MASK
      sdhci: check Spec v2 capabilities (DMA and 64-bit bus)
      hw/arm/exynos4210: access the 64-bit capareg with qdev_prop_set_uint64()
      hw/arm/exynos4210: add a comment about a very similar SDHCI (Spec. v2)
      hw/arm/xilinx_zynq: fix the capabilities register to match the datasheet
      sdhci: add support for v3 capabilities
      sdhci: rename the hostctl1 register
      sdhci: implement the Host Control 2 register (tuning sequence)
      sdbus: add trace events
      sdhci: implement UHS-I voltage switch
      sdhci: implement CMD/DAT[] fields in the Present State register
      hw/arm/bcm2835_peripherals: implement SDHCI Spec v3
      hw/arm/bcm2835_peripherals: change maximum block size to 1kB
      hw/arm/fsl-imx6: implement SDHCI Spec. v3
      hw/arm/xilinx_zynqmp: fix the capabilities/spec version to match the datasheet
      hw/arm/xilinx_zynqmp: enable the UHS-I mode
      sdhci: check Spec v3 capabilities qtest
      sdhci: add a check_capab_v3() qtest
      sdhci: add Spec v4.2 register definitions
      travis: use libgcc-4.8-dev (libgcc-6-dev is not available on Ubuntu 14.04)

Sai Pavan Boddu (1):
      sdhci: Fix 64-bit ADMA2

Yu Ning (1):
      hax: Support guest RAM sizes of 4GB or more

 .travis.yml                   |   2 +-
 Makefile                      |   5 +-
 configure                     |  16 +-
 default-configs/pci.mak       |   3 +
 docs/can.txt                  | 107 +++++
 hw/arm/bcm2835_peripherals.c  |  23 +-
 hw/arm/exynos4210.c           |  14 +-
 hw/arm/fsl-imx6.c             |   7 +
 hw/arm/xilinx_zynq.c          |  53 +--
 hw/arm/xlnx-zynqmp.c          |  30 +-
 hw/display/cg3.c              |   1 -
 hw/display/exynos4210_fimd.c  |   1 -
 hw/display/framebuffer.c      |   1 -
 hw/display/g364fb.c           |  11 +-
 hw/display/sm501.c            |   1 -
 hw/display/tcx.c              |   2 -
 hw/display/vga.c              |   6 -
 hw/net/Makefile.objs          |   2 +
 hw/net/can/Makefile.objs      |   4 +
 hw/net/can/can_kvaser_pci.c   | 319 ++++++++++++++
 hw/net/can/can_mioe3680_pci.c | 262 ++++++++++++
 hw/net/can/can_pcm3680_pci.c  | 263 ++++++++++++
 hw/net/can/can_sja1000.c      | 953 ++++++++++++++++++++++++++++++++++++++++++
 hw/net/can/can_sja1000.h      | 146 +++++++
 hw/sd/core.c                  |  61 ++-
 hw/sd/sd.c                    |  29 ++
 hw/sd/sdhci-internal.h        |  71 +++-
 hw/sd/sdhci.c                 | 397 +++++++++++++-----
 hw/sd/trace-events            |   9 +
 include/exec/memory.h         |  35 +-
 include/hw/sd/sd.h            |  20 +
 include/hw/sd/sdhci.h         |   6 +-
 include/net/can_emu.h         | 123 ++++++
 include/net/can_host.h        |  55 +++
 include/sysemu/hax.h          |   2 +-
 memory.c                      |  70 +---
 net/Makefile.objs             |   2 +
 net/can/Makefile.objs         |   2 +
 net/can/can_core.c            | 138 ++++++
 net/can/can_host.c            | 112 +++++
 net/can/can_socketcan.c       | 286 +++++++++++++
 rules.mak                     |   2 -
 target/i386/hax-all.c         |   2 +
 target/i386/hax-darwin.c      |  27 +-
 target/i386/hax-darwin.h      |   1 +
 target/i386/hax-i386.h        |   1 +
 target/i386/hax-interface.h   |   8 +
 target/i386/hax-mem.c         |  34 +-
 target/i386/hax-windows.c     |  38 +-
 target/i386/hax-windows.h     |   2 +
 tests/Makefile.include        |   4 +
 tests/sdhci-test.c            | 250 +++++++++++
 52 files changed, 3715 insertions(+), 304 deletions(-)
 create mode 100644 docs/can.txt
 create mode 100644 hw/net/can/Makefile.objs
 create mode 100644 hw/net/can/can_kvaser_pci.c
 create mode 100644 hw/net/can/can_mioe3680_pci.c
 create mode 100644 hw/net/can/can_pcm3680_pci.c
 create mode 100644 hw/net/can/can_sja1000.c
 create mode 100644 hw/net/can/can_sja1000.h
 create mode 100644 include/net/can_emu.h
 create mode 100644 include/net/can_host.h
 create mode 100644 net/can/Makefile.objs
 create mode 100644 net/can/can_core.c
 create mode 100644 net/can/can_host.c
 create mode 100644 net/can/can_socketcan.c
 create mode 100644 tests/sdhci-test.c
-- 
1.8.3.1
