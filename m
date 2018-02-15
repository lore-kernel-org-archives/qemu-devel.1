Received: from eggs.gnu.org ([2001:4830:134:3::10]:34167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBAa-0007NK-AG
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBAX-0003pw-29
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:16 -0500
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:44399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBAW-0003pn-Sp
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:12 -0500
Received: by mail-qt0-x234.google.com with SMTP id f18so10449957qth.11
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:29:11 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:30 -0300
Message-Id: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/30] hw: use the BYTE-based definitions when
 useful
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hi,

This series:

- split the byte-based definitions from "qemu/cutils.h" to "qemu/cunits.h"
  and let them available for all hw/ files (via "hw/hw.h");
- clean hw/ includes;
- replace different constants used for byte size with their corresponding
  BYTE-based definitions.

patches generated using:

$ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Regards,

Phil.

Philippe Mathieu-Daudé (30):
  util/cutils: extract byte-based definitions into a new header:
    "qemu/cunits.h"
  hw: include "qemu/cunits.h" and clean unused "qemu/cutils.h"
  hw/block/nvme: include the "qemu/cutils.h" in the source file
  hw/lm32/milkymist: remove unused include
  hw/mips/r4k: constify params_size
  hw/mips: use the BYTE-based definitions
  hw/arm: use the BYTE-based definitions
  hw/i386: use the BYTE-based definitions
  hw/sparc: use the BYTE-based definitions
  hw/ppc: use the BYTE-based definitions
  hw/s390x: use the BYTE-based definitions
  hw/hppa: use the BYTE-based definitions
  hw/xtensa: use the BYTE-based definitions
  hw/alpha: use the BYTE-based definitions
  hw/lm32: use the BYTE-based definitions
  hw/sh4: use the BYTE-based definitions
  hw/tricore: use the BYTE-based definitions
  hw/microblaze: use the BYTE-based definitions
  hw/nios2: use the BYTE-based definitions
  hw/cris: use the BYTE-based definitions
  hw/misc: use the BYTE-based definitions
  hw/display: use the BYTE-based definitions
  hw/net: use the BYTE-based definitions
  hw/ipack: use the BYTE-based definitions
  hw/scsi: use the BYTE-based definitions
  hw/smbios: use the BYTE-based definitions
  vfio/pci: use the BYTE-based definitions
  ivshmem: use the BYTE-based definitions
  tpm: use the BYTE-based definitions
  xen: use the BYTE-based definitions

 hw/block/nvme.h                          |  1 -
 include/hw/acpi/tpm.h                    |  2 +-
 include/hw/arm/stm32f205_soc.h           |  4 ++--
 include/hw/hw.h                          |  1 +
 include/hw/i386/ich9.h                   |  2 +-
 include/hw/intc/mips_gic.h               |  2 +-
 include/hw/mips/bios.h                   |  2 +-
 include/hw/net/allwinner_emac.h          |  4 ++--
 include/hw/ppc/spapr.h                   |  2 +-
 include/qemu/cunits.h                    | 11 +++++++++++
 include/qemu/cutils.h                    |  8 +-------
 hw/alpha/typhoon.c                       | 16 +++++++---------
 hw/arm/boot.c                            |  6 +++---
 hw/arm/collie.c                          |  4 ++--
 hw/arm/digic_boards.c                    |  6 +++---
 hw/arm/gumstix.c                         |  2 +-
 hw/arm/integratorcp.c                    |  2 +-
 hw/arm/mainstone.c                       |  2 +-
 hw/arm/msf2-soc.c                        |  1 -
 hw/arm/msf2-som.c                        |  1 -
 hw/arm/musicpal.c                        |  8 ++++----
 hw/arm/omap_sx1.c                        |  8 ++++----
 hw/arm/raspi.c                           |  2 +-
 hw/arm/stellaris.c                       |  4 ++--
 hw/arm/versatilepb.c                     |  4 ++--
 hw/arm/vexpress.c                        |  6 +++---
 hw/arm/virt.c                            |  4 ++--
 hw/arm/xilinx_zynq.c                     |  4 ++--
 hw/block/nvme.c                          |  1 +
 hw/block/tc58128.c                       |  2 +-
 hw/block/xen_disk.c                      |  4 ++--
 hw/core/loader-fit.c                     |  1 -
 hw/core/loader.c                         |  1 -
 hw/core/machine.c                        |  1 -
 hw/cris/axis_dev88.c                     |  2 +-
 hw/cris/boot.c                           |  1 -
 hw/display/cirrus_vga.c                  |  9 ++++-----
 hw/display/g364fb.c                      |  2 +-
 hw/display/qxl.c                         | 26 +++++++++++---------------
 hw/display/sm501.c                       |  1 -
 hw/display/vga-isa-mm.c                  |  4 ++--
 hw/display/vga.c                         |  4 ++--
 hw/display/virtio-gpu.c                  |  3 +--
 hw/display/vmware_vga.c                  |  2 +-
 hw/display/xenfb.c                       |  2 +-
 hw/hppa/dino.c                           |  2 +-
 hw/hppa/machine.c                        |  9 ++++-----
 hw/i386/acpi-build.c                     |  4 ++--
 hw/i386/pc.c                             | 18 +++++++++---------
 hw/i386/pc_piix.c                        |  2 +-
 hw/i386/pc_q35.c                         |  2 +-
 hw/i386/pc_sysfw.c                       |  8 ++++----
 hw/i386/xen/xen-mapcache.c               |  2 +-
 hw/intc/apic_common.c                    |  2 +-
 hw/ipack/tpci200.c                       |  4 ++--
 hw/lm32/lm32_boards.c                    | 12 ++++++------
 hw/lm32/milkymist.c                      | 10 ++++------
 hw/microblaze/boot.c                     |  1 -
 hw/microblaze/petalogix_ml605_mmu.c      |  6 +++---
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  6 +++---
 hw/mips/boston.c                         |  3 +--
 hw/mips/mips_fulong2e.c                  |  6 +++---
 hw/mips/mips_malta.c                     | 19 ++++++++++---------
 hw/mips/mips_r4k.c                       | 15 +++++++--------
 hw/misc/aspeed_sdmc.c                    |  8 ++++----
 hw/misc/auxbus.c                         |  2 +-
 hw/misc/edu.c                            |  2 +-
 hw/misc/imx7_gpr.c                       |  2 +-
 hw/misc/ivshmem.c                        |  2 +-
 hw/misc/mips_itu.c                       |  2 +-
 hw/misc/mos6522.c                        |  1 -
 hw/misc/omap_gpmc.c                      |  4 ++--
 hw/net/e1000e.c                          |  6 +++---
 hw/net/eepro100.c                        |  6 ++----
 hw/nios2/boot.c                          |  3 +--
 hw/pci-host/gpex.c                       |  2 +-
 hw/pci-host/piix.c                       |  4 ++--
 hw/pci-host/prep.c                       |  2 +-
 hw/pci-host/q35.c                        | 16 ++++++++--------
 hw/pci-host/xilinx-pcie.c                |  4 ++--
 hw/ppc/e500.c                            |  8 ++++----
 hw/ppc/mac_newworld.c                    |  1 -
 hw/ppc/mac_oldworld.c                    |  8 +++-----
 hw/ppc/pnv.c                             |  1 -
 hw/ppc/ppc405_boards.c                   |  8 ++++----
 hw/ppc/ppc405_uc.c                       |  6 +++---
 hw/ppc/ppc4xx_devs.c                     | 21 +++++++++++----------
 hw/ppc/ppce500_spin.c                    |  2 +-
 hw/ppc/prep.c                            |  3 +--
 hw/ppc/rs6000_mc.c                       | 12 ++++++------
 hw/ppc/spapr_rtas.c                      |  1 -
 hw/ppc/virtex_ml507.c                    |  4 ++--
 hw/s390x/sclp.c                          |  4 ++--
 hw/scsi/scsi-disk.c                      |  8 ++++----
 hw/sd/sdhci.c                            |  1 -
 hw/sh4/r2d.c                             |  2 +-
 hw/smbios/smbios.c                       | 14 +++++---------
 hw/sparc/leon3.c                         |  8 ++++----
 hw/sparc/sun4m.c                         |  8 +++-----
 hw/sparc64/niagara.c                     |  2 +-
 hw/sparc64/sun4u.c                       |  3 +--
 hw/ssi/aspeed_smc.c                      | 28 ++++++++++++++--------------
 hw/tricore/tricore_testboard.c           | 12 ++++++------
 hw/usb/dev-serial.c                      |  1 -
 hw/usb/dev-storage.c                     |  1 -
 hw/vfio/pci-quirks.c                     |  8 ++++----
 hw/vfio/pci.c                            |  2 +-
 hw/xenpv/xen_domainbuild.c               | 10 +++++-----
 hw/xtensa/xtfpga.c                       |  2 +-
 109 files changed, 269 insertions(+), 302 deletions(-)
 create mode 100644 include/qemu/cunits.h

-- 
2.16.1
