Received: from eggs.gnu.org ([2001:4830:134:3::10]:60753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRY4-0006ia-GZ
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRY1-0000Nc-8S
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:26:58 -0300
Message-Id: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/21] Includes cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Hi,

I split the previous series "Use the BYTE-based definitions when useful",
this is the first generic part, only headers cleanup, which is big enough.

Many patches, but "12 insertions(+), 145 deletions(-)" \o/

v3 was:
http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg02049.html

Philippe Mathieu-Daudé (21):
  vfio: Include "exec/address-spaces.h" directly in the source file
  accel: Do not include "exec/address-spaces.h" if it is not necessary
  target: Do not include "exec/address-spaces.h" if it is not necessary
  memory: Do not include "exec/ioport.h" if it is not necessary
  target/i386: Do not include "exec/ioport.h" if it is not necessary
  target/xtensa: Include "qemu/timer.h" to use NANOSECONDS_PER_SECOND
  target/ppc: Include "exec/exec-all.h" which provides tlb_flush()
  target/hppa: Include "qemu/log.h" to use qemu_log()
  target: Do not include "exec/exec-all.h" if it is not necessary
  hw: Do not include "exec/ioport.h" if it is not necessary
  hw: Do not include "exec/address-spaces.h" if it is not necessary
  hw: Do not include "sysemu/block-backend.h" if it is not necessary
  hw: Do not include "sysemu/blockdev.h" if it is not necessary
  hw: Do not include "sysemu/blockdev.h" if it is not necessary
  hw/block/nvme: Include "qemu/cutils.h" directly in the source file
  hw/misc/mips_itu: Cleanup includes
  hw/misc/sga: Use the correct ISA include
  hw/hppa: Remove unused include
  hw/i386/pc: Remove unused include
  hw/ide: Remove unused include
  hw: Clean "hw/devices.h" includes

 bsd-user/qemu.h                          | 1 -
 hw/block/nvme.h                          | 1 -
 hw/hppa/hppa_sys.h                       | 1 -
 include/hw/arm/allwinner-a10.h           | 1 -
 include/hw/arm/bcm2835_peripherals.h     | 1 -
 include/hw/devices.h                     | 7 ++-----
 include/hw/display/bcm2835_fb.h          | 1 -
 include/hw/dma/bcm2835_dma.h             | 1 -
 include/hw/misc/bcm2835_mbox.h           | 1 -
 include/hw/misc/bcm2835_property.h       | 1 -
 include/hw/misc/mips_itu.h               | 2 ++
 include/hw/sh4/sh_intc.h                 | 1 -
 include/hw/vfio/vfio-common.h            | 1 -
 include/hw/virtio/virtio-access.h        | 1 -
 target/arm/arm_ldst.h                    | 1 -
 target/ppc/helper_regs.h                 | 1 +
 accel/tcg/cpu-exec.c                     | 1 -
 hw/acpi/pcihp.c                          | 1 -
 hw/acpi/piix4.c                          | 1 -
 hw/arm/aspeed.c                          | 1 -
 hw/arm/bcm2836.c                         | 1 -
 hw/arm/collie.c                          | 1 -
 hw/arm/gumstix.c                         | 1 -
 hw/arm/mainstone.c                       | 1 -
 hw/arm/nseries.c                         | 1 -
 hw/arm/omap1.c                           | 2 --
 hw/arm/omap2.c                           | 2 --
 hw/arm/omap_sx1.c                        | 1 -
 hw/arm/pxa2xx.c                          | 1 -
 hw/arm/spitz.c                           | 1 -
 hw/arm/versatilepb.c                     | 1 -
 hw/arm/vexpress.c                        | 1 -
 hw/arm/virt.c                            | 1 -
 hw/arm/xilinx_zynq.c                     | 1 -
 hw/arm/xlnx-zcu102.c                     | 1 -
 hw/arm/z2.c                              | 1 -
 hw/block/dataplane/virtio-blk.c          | 1 -
 hw/block/m25p80.c                        | 1 -
 hw/block/nvme.c                          | 1 +
 hw/block/onenand.c                       | 2 --
 hw/block/pflash_cfi01.c                  | 1 -
 hw/block/pflash_cfi02.c                  | 1 -
 hw/block/virtio-blk.c                    | 1 -
 hw/char/mcf_uart.c                       | 1 -
 hw/char/serial.c                         | 1 -
 hw/char/sh_serial.c                      | 1 -
 hw/core/loader-fit.c                     | 1 -
 hw/core/platform-bus.c                   | 1 -
 hw/core/qdev-properties.c                | 1 -
 hw/cris/axis_dev88.c                     | 1 -
 hw/display/sm501.c                       | 1 -
 hw/display/tc6393xb.c                    | 1 -
 hw/i386/kvmvapic.c                       | 1 -
 hw/i386/pc.c                             | 1 -
 hw/i386/xen/xen-mapcache.c               | 1 -
 hw/ide/core.c                            | 1 -
 hw/ide/pci.c                             | 1 -
 hw/ide/via.c                             | 1 -
 hw/isa/isa-superio.c                     | 1 -
 hw/lm32/lm32_boards.c                    | 1 -
 hw/lm32/milkymist.c                      | 1 -
 hw/m68k/mcf5206.c                        | 1 -
 hw/m68k/mcf_intc.c                       | 1 -
 hw/microblaze/petalogix_ml605_mmu.c      | 1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 -
 hw/mips/mips_malta.c                     | 1 -
 hw/mips/mips_r4k.c                       | 1 -
 hw/misc/arm_integrator_debug.c           | 1 -
 hw/misc/mips_itu.c                       | 5 +----
 hw/misc/sga.c                            | 2 +-
 hw/net/mcf_fec.c                         | 1 -
 hw/net/ne2000-isa.c                      | 1 -
 hw/pci-host/versatile.c                  | 1 -
 hw/ppc/ppc405_boards.c                   | 1 -
 hw/ppc/sam460ex.c                        | 1 -
 hw/ppc/spapr.c                           | 1 -
 hw/ppc/virtex_ml507.c                    | 2 --
 hw/riscv/riscv_htif.c                    | 1 -
 hw/s390x/virtio-ccw.c                    | 2 --
 hw/scsi/mptsas.c                         | 1 -
 hw/scsi/scsi-generic.c                   | 1 -
 hw/sd/pl181.c                            | 1 -
 hw/sd/sdhci.c                            | 2 --
 hw/sd/ssi-sd.c                           | 1 -
 hw/sh4/r2d.c                             | 1 -
 hw/sh4/sh7750.c                          | 1 -
 hw/timer/sh_timer.c                      | 1 -
 hw/usb/dev-storage.c                     | 1 -
 hw/vfio/ccw.c                            | 1 +
 hw/vfio/platform.c                       | 1 +
 hw/virtio/virtio-pci.c                   | 1 -
 hw/xen/xen_devconfig.c                   | 1 -
 hw/xtensa/xtfpga.c                       | 1 -
 memory.c                                 | 1 -
 monitor.c                                | 1 -
 target/arm/arm-powerctl.c                | 1 -
 target/arm/crypto_helper.c               | 1 -
 target/arm/iwmmxt_helper.c               | 1 -
 target/arm/neon_helper.c                 | 1 -
 target/arm/psci.c                        | 1 -
 target/arm/vec_helper.c                  | 1 -
 target/cris/cpu.c                        | 1 -
 target/hppa/helper.c                     | 1 -
 target/hppa/int_helper.c                 | 2 +-
 target/i386/hax-all.c                    | 2 --
 target/i386/hax-mem.c                    | 1 -
 target/i386/hax-windows.c                | 1 -
 target/i386/hvf/hvf.c                    | 2 --
 target/i386/hvf/x86_task.c               | 3 ---
 target/i386/kvm.c                        | 1 -
 target/i386/whpx-all.c                   | 1 -
 target/lm32/cpu.c                        | 1 -
 target/m68k/cpu.c                        | 1 -
 target/moxie/cpu.c                       | 1 -
 target/moxie/mmu.c                       | 1 -
 target/openrisc/cpu.c                    | 1 -
 target/ppc/int_helper.c                  | 1 -
 target/s390x/cpu.c                       | 1 -
 target/s390x/diag.c                      | 1 -
 target/s390x/helper.c                    | 1 -
 target/s390x/kvm.c                       | 1 -
 target/s390x/mem_helper.c                | 1 -
 target/s390x/misc_helper.c               | 1 -
 target/sparc/mmu_helper.c                | 1 -
 target/tilegx/cpu.c                      | 1 -
 target/xtensa/core-dc232b.c              | 2 +-
 target/xtensa/core-dc233c.c              | 1 -
 target/xtensa/core-de212.c               | 1 -
 target/xtensa/core-fsf.c                 | 1 -
 target/xtensa/core-sample_controller.c   | 1 -
 target/xtensa/cpu.c                      | 1 -
 tcg/tcg-op-vec.c                         | 1 -
 target/xtensa/import_core.sh             | 1 -
 133 files changed, 12 insertions(+), 145 deletions(-)

-- 
2.17.0
