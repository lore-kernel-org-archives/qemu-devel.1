Received: from eggs.gnu.org ([2001:4830:134:3::10]:50266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rIr-0004Bp-9A
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rIp-0008RI-Lv
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:25 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:26 -0300
Message-Id: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/41] hw: Use the BYTE-based definitions
 when useful
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

This series:

- split the byte-based definitions from "qemu/cutils.h" to "qemu/units.h"
- clean hw/ includes;
- replace different constants used for byte size with their corresponding
  BYTE-based definitions.

Since v2:
- use "qemu/units.h" instead of "qemu/cunits.h" (Daniel P. Berrangé)
- avoid rebuilding the world including "qemu/units.h" in "hw/hw.h" (Thomas Huth)
- more constant replaced

Since v1:
- corrected Xen mult -> div (Alan Robinson)
- tagged 'include "qemu/cunits.h" in "hw/hw.h" as RFC
- fixed mips_r4k 'params_size' (Thomas Huth)
- added command used to generate patch in each commit (Alistair Francis)
- use G_BYTE for the raspi3 machine
- added Reviewed-by tags

Regards,

Phil.

$ git backport-diff -r master.. -u v2
001/41:[down] 'hw: Clean "hw/devices.h" includes'
002/41:[down] 'hw: Do not include "sysemu/block-backend.h" if it is not necessary'
003/41:[----] [--] 'hw/block/nvme: include the "qemu/cutils.h" in the source file'
004/41:[down] 'hw/misc/mips_itu: sort includes'
005/41:[----] [--] 'hw/mips/r4k: constify params_size'
006/41:[down] 'cutils: extract byte-based definitions into a new header: "qemu/units.h"'
007/41:[down] 'hw/ivshmem: use the BYTE-based definitions'
008/41:[0001] [FC] 'hw/ipack: use the BYTE-based definitions'
009/41:[0001] [FC] 'hw/scsi: use the BYTE-based definitions'
010/41:[0001] [FC] 'hw/smbios: use the BYTE-based definitions'
011/41:[down] 'hw/xen: use the BYTE-based definitions'
012/41:[down] 'hw/tpm: use the BYTE-based definitions'
013/41:[down] 'hw/block: use the BYTE-based definitions'
014/41:[0015] [FC] 'hw/display: use the BYTE-based definitions'
015/41:[0004] [FC] 'hw/misc: use the BYTE-based definitions'
016/41:[down] 'hw/riscv: use the BYTE-based definitions'
017/41:[down] 'hw/m68k: use the BYTE-based definitions'
018/41:[0006] [FC] 'hw/sparc: use the BYTE-based definitions'
019/41:[0007] [FC] 'hw/s390x: use the BYTE-based definitions'
020/41:[0003] [FC] 'hw/hppa: use the BYTE-based definitions'
021/41:[0003] [FC] 'hw/xtensa: use the BYTE-based definitions'
022/41:[0001] [FC] 'hw/alpha: use the BYTE-based definitions'
023/41:[0001] [FC] 'hw/tricore: use the BYTE-based definitions'
024/41:[0002] [FC] 'hw/microblaze: use the BYTE-based definitions'
025/41:[0004] [FC] 'hw/nios2: use the BYTE-based definitions'
026/41:[0001] [FC] 'hw/cris: use the BYTE-based definitions'
027/41:[0003] [FC] 'hw/lm32: use the BYTE-based definitions'
028/41:[0003] [FC] 'hw/sh4: use the BYTE-based definitions'
029/41:[0012] [FC] 'hw/mips: use the BYTE-based definitions'
030/41:[0052] [FC] 'hw/arm: use the BYTE-based definitions'
031/41:[0065] [FC] 'hw/ppc: use the BYTE-based definitions'
032/41:[0014] [FC] 'hw/i386: use the BYTE-based definitions'
033/41:[0006] [FC] 'hw/net: use the BYTE-based definitions'
034/41:[down] 'hw/usb: use the BYTE-based definitions'
035/41:[down] 'hw/sd: use the BYTE-based definitions'
036/41:[down] 'hw/vfio: use the BYTE-based definitions'
037/41:[down] 'hw/virtio: use the BYTE-based definitions'
038/41:[down] 'hw/rdma: use the BYTE-based definitions'
039/41:[down] 'hw/nvdimm: use the BYTE-based definitions'
040/41:[down] 'hw/loader: use the BYTE-based definitions'
041/41:[down] 'cutils: do not include "units.h" directly'

Philippe Mathieu-Daudé (41):
  hw: Clean "hw/devices.h" includes
  hw: Do not include "sysemu/block-backend.h" if it is not necessary
  hw/block/nvme: include the "qemu/cutils.h" in the source file
  hw/misc/mips_itu: sort includes
  hw/mips/r4k: constify params_size
  cutils: extract byte-based definitions into a new header: "qemu/units.h"
  hw/ivshmem: use the BYTE-based definitions
  hw/ipack: use the BYTE-based definitions
  hw/scsi: use the BYTE-based definitions
  hw/smbios: use the BYTE-based definitions
  hw/xen: use the BYTE-based definitions
  hw/tpm: use the BYTE-based definitions
  hw/block: use the BYTE-based definitions
  hw/display: use the BYTE-based definitions
  hw/misc: use the BYTE-based definitions
  hw/riscv: use the BYTE-based definitions
  hw/m68k: use the BYTE-based definitions
  hw/sparc: use the BYTE-based definitions
  hw/s390x: use the BYTE-based definitions
  hw/hppa: use the BYTE-based definitions
  hw/xtensa: use the BYTE-based definitions
  hw/alpha: use the BYTE-based definitions
  hw/tricore: use the BYTE-based definitions
  hw/microblaze: use the BYTE-based definitions
  hw/nios2: use the BYTE-based definitions
  hw/cris: use the BYTE-based definitions
  hw/lm32: use the BYTE-based definitions
  hw/sh4: use the BYTE-based definitions
  hw/mips: use the BYTE-based definitions
  hw/arm: use the BYTE-based definitions
  hw/ppc: use the BYTE-based definitions
  hw/i386: use the BYTE-based definitions
  hw/net: use the BYTE-based definitions
  hw/usb: use the BYTE-based definitions
  hw/sd: use the BYTE-based definitions
  hw/vfio: use the BYTE-based definitions
  hw/virtio: use the BYTE-based definitions
  hw/rdma: use the BYTE-based definitions
  hw/nvdimm: use the BYTE-based definitions
  hw/loader: use the BYTE-based definitions
  cutils: do not include "qemu/units.h" directly

 hw/block/nvme.h                          |  1 -
 hw/ppc/mac.h                             |  3 ++-
 hw/rdma/vmw/pvrdma.h                     |  3 ++-
 include/hw/acpi/tpm.h                    |  3 ++-
 include/hw/arm/fsl-imx7.h                |  5 ++--
 include/hw/arm/stm32f205_soc.h           |  5 ++--
 include/hw/devices.h                     |  7 ++----
 include/hw/display/xlnx_dp.h             |  5 ++--
 include/hw/i386/ich9.h                   |  3 ++-
 include/hw/intc/mips_gic.h               |  3 ++-
 include/hw/loader.h                      |  5 ++--
 include/hw/mem/nvdimm.h                  |  3 ++-
 include/hw/mips/bios.h                   |  3 ++-
 include/hw/misc/mips_itu.h               |  2 ++
 include/hw/net/allwinner_emac.h          |  5 ++--
 include/hw/ppc/spapr.h                   |  3 ++-
 include/hw/virtio/virtio-net.h           |  3 ++-
 include/qemu/cutils.h                    |  7 ------
 include/qemu/units.h                     | 11 +++++++++
 hw/alpha/typhoon.c                       | 17 +++++++-------
 hw/arm/bcm2835_peripherals.c             |  3 ++-
 hw/arm/boot.c                            |  7 +++---
 hw/arm/collie.c                          |  5 ++--
 hw/arm/digic_boards.c                    |  7 +++---
 hw/arm/exynos4_boards.c                  |  3 ++-
 hw/arm/gumstix.c                         |  3 ++-
 hw/arm/imx25_pdk.c                       |  1 +
 hw/arm/integratorcp.c                    |  3 ++-
 hw/arm/mainstone.c                       |  3 ++-
 hw/arm/msf2-soc.c                        |  2 +-
 hw/arm/msf2-som.c                        |  2 +-
 hw/arm/musicpal.c                        |  9 ++++----
 hw/arm/omap_sx1.c                        | 11 +++++----
 hw/arm/raspi.c                           |  5 ++--
 hw/arm/stellaris.c                       |  5 ++--
 hw/arm/versatilepb.c                     |  5 ++--
 hw/arm/vexpress.c                        |  7 +++---
 hw/arm/virt.c                            |  5 ++--
 hw/arm/xilinx_zynq.c                     |  7 +++---
 hw/block/nvme.c                          |  4 +++-
 hw/block/tc58128.c                       |  3 ++-
 hw/block/xen_disk.c                      |  5 ++--
 hw/core/loader-fit.c                     |  2 +-
 hw/core/machine.c                        |  2 +-
 hw/cris/axis_dev88.c                     |  4 ++--
 hw/display/cirrus_vga.c                  | 10 ++++----
 hw/display/g364fb.c                      |  3 ++-
 hw/display/qxl.c                         | 27 ++++++++++------------
 hw/display/sm501.c                       |  2 +-
 hw/display/vga-isa-mm.c                  |  5 ++--
 hw/display/vga.c                         |  5 ++--
 hw/display/virtio-gpu.c                  |  4 ++--
 hw/display/vmware_vga.c                  |  3 ++-
 hw/display/xenfb.c                       |  3 ++-
 hw/hppa/dino.c                           |  3 ++-
 hw/hppa/machine.c                        | 10 ++++----
 hw/i386/acpi-build.c                     |  5 ++--
 hw/i386/pc.c                             | 19 ++++++++--------
 hw/i386/pc_piix.c                        |  4 ++--
 hw/i386/pc_q35.c                         |  3 ++-
 hw/i386/pc_sysfw.c                       |  9 ++++----
 hw/i386/xen/xen-mapcache.c               |  3 ++-
 hw/intc/apic_common.c                    |  3 ++-
 hw/ipack/tpci200.c                       |  5 ++--
 hw/lm32/lm32_boards.c                    | 13 ++++++-----
 hw/lm32/milkymist.c                      | 10 ++++----
 hw/m68k/mcf5208.c                        |  3 ++-
 hw/mem/nvdimm.c                          |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c      |  7 +++---
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  7 +++---
 hw/mips/boston.c                         |  4 ++--
 hw/mips/mips_fulong2e.c                  |  7 +++---
 hw/mips/mips_malta.c                     | 23 +++++++++++--------
 hw/mips/mips_r4k.c                       | 15 ++++++------
 hw/misc/aspeed_sdmc.c                    |  9 ++++----
 hw/misc/auxbus.c                         |  3 ++-
 hw/misc/edu.c                            |  3 ++-
 hw/misc/imx7_gpr.c                       |  3 ++-
 hw/misc/ivshmem.c                        |  3 ++-
 hw/misc/mips_itu.c                       |  8 +++----
 hw/misc/omap_gpmc.c                      |  5 ++--
 hw/net/e1000e.c                          |  7 +++---
 hw/net/e1000x_common.c                   |  3 ++-
 hw/net/eepro100.c                        |  7 +++---
 hw/nios2/boot.c                          |  6 ++---
 hw/nvram/spapr_nvram.c                   | 10 ++++----
 hw/pci-host/gpex.c                       |  3 ++-
 hw/pci-host/piix.c                       |  5 ++--
 hw/pci-host/prep.c                       |  3 ++-
 hw/pci-host/q35.c                        | 17 +++++++-------
 hw/pci-host/xilinx-pcie.c                |  5 ++--
 hw/ppc/e500.c                            | 13 ++++++-----
 hw/ppc/e500plat.c                        |  3 ++-
 hw/ppc/mac_newworld.c                    |  1 -
 hw/ppc/mac_oldworld.c                    |  9 ++++----
 hw/ppc/pnv.c                             |  2 +-
 hw/ppc/ppc405_boards.c                   |  9 ++++----
 hw/ppc/ppc405_uc.c                       |  7 +++---
 hw/ppc/ppc440_bamboo.c                   |  6 +++--
 hw/ppc/ppc440_uc.c                       |  2 +-
 hw/ppc/ppc4xx_devs.c                     | 22 ++++++++++--------
 hw/ppc/ppce500_spin.c                    |  3 ++-
 hw/ppc/prep.c                            |  4 ++--
 hw/ppc/rs6000_mc.c                       | 13 ++++++-----
 hw/ppc/sam460ex.c                        | 16 +++++++------
 hw/ppc/spapr.c                           |  2 +-
 hw/ppc/spapr_rtas.c                      |  1 +
 hw/ppc/virtex_ml507.c                    |  7 +++---
 hw/riscv/virt.c                          |  3 ++-
 hw/s390x/s390-skeys.c                    |  3 ++-
 hw/s390x/s390-stattrib.c                 |  3 ++-
 hw/s390x/sclp.c                          |  5 ++--
 hw/scsi/scsi-disk.c                      |  9 ++++----
 hw/sd/sd.c                               |  4 ++--
 hw/sd/sdhci.c                            |  4 ++--
 hw/sh4/r2d.c                             |  4 ++--
 hw/smbios/smbios.c                       | 15 +++++-------
 hw/sparc/leon3.c                         |  9 ++++----
 hw/sparc/sun4m.c                         |  9 ++++----
 hw/sparc64/niagara.c                     |  3 ++-
 hw/sparc64/sun4u.c                       |  4 ++--
 hw/ssi/aspeed_smc.c                      | 29 ++++++++++++------------
 hw/tricore/tricore_testboard.c           | 13 ++++++-----
 hw/usb/ccid-card-passthru.c              |  5 ++--
 hw/usb/combined-packet.c                 |  3 ++-
 hw/usb/dev-smartcard-reader.c            |  3 ++-
 hw/usb/redirect.c                        |  3 ++-
 hw/vfio/pci-quirks.c                     |  9 ++++----
 hw/vfio/pci.c                            |  3 ++-
 hw/xenpv/xen_domainbuild.c               | 13 ++++++-----
 hw/xtensa/xtfpga.c                       |  5 ++--
 131 files changed, 450 insertions(+), 358 deletions(-)
 create mode 100644 include/qemu/units.h

-- 
2.17.0
