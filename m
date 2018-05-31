Received: from eggs.gnu.org ([2001:4830:134:3::10]:58332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8F-0003P5-I5
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8C-0008HW-8C
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8C-0008H8-1k
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:12:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 760E6805A530
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:12:55 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE7AA2026985
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:12:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:00 +0200
Message-Id: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/53] Misc patches for 2018-05-31
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 5a5c383b1373aeb6c87a0d6060f6c3dc7c5308=
2b:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.13-=
pull-request' into staging (2018-05-25 10:04:36 +0100)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2904754bc2ed976acba66a10cb241d23c24b9bcb:

  memory: Make operations using MemoryRegionIoeventfd struct pass by poin=
ter. (2018-05-31 19:12:13 +0200)

----------------------------------------------------------------
* Linux header upgrade (Peter)
* firmware.json definition (Laszlo)
* IPMI migration fix (Corey)
* QOM improvements (Alexey, Philippe, me)
* Memory API cleanups (Jay, me, Tristan, Peter)
* WHPX fixes and improvements (Lucian)
* Chardev fixes (Marc-Andr=C3=A9)
* IOMMU documentation improvements (Peter)
* Coverity fixes (Peter, Philippe)
* Include cleanup (Philippe)
* -clock deprecation (Thomas)
* Disable -sandbox unless CONFIG_SECCOMP (Yi Min Zhao)

----------------------------------------------------------------
Alex Williamson (1):
      virtio-gpu-3d: Define VIRTIO_GPU_CAPSET_VIRGL2 elsewhere

Alexey Kardashevskiy (1):
      qom: Document qom/device-list-properties implementation specific

Corey Minyard (2):
      vmstate: Add a VSTRUCT type
      ipmi: Use proper struct reference for KCS vmstate

Jay Zhou (1):
      memory: delete struct AddressSpaceOps

Laszlo Ersek (1):
      docs/interop: add "firmware.json"

Lucian Petrut (2):
      WHPX: dynamically load WHP libraries
      WHPX: fix some compiler warnings

Marc-Andr=C3=A9 Lureau (1):
      mux: fix ctrl-a b again

Paolo Bonzini (5):
      nios2: do not include exec-all.h from cpu.h
      qom: support orphan objects in object_get_canonical_path
      virtio: free MemoryRegionCache when initialization fails
      memory: get rid of memory_region_init_reservation
      tcg: remove softfloat from --disable-tcg builds

Patryk Olszewski (1):
      char: Remove unwanted crlf conversion

Peter Maydell (8):
      memory.h: Fix typo in documentation comment
      memfd: Avoid Coverity warning about integer overflow
      exec.c: Initialize sa_flags passed to sigaction()
      scripts/update-linux-headers: Handle __aligned_u64
      scripts/update-linux-headers: Handle kernel license no longer being=
 one file
      target/i386/kvm.c: Handle renaming of KVM_HINTS_DEDICATED
      Update Linux headers to 4.17-rc6
      target/i386/kvm.c: Remove compatibility shim for KVM_HINTS_REALTIME

Philippe Mathieu-Daud=C3=A9 (27):
      vfio: Include "exec/address-spaces.h" directly in the source file
      accel: Do not include "exec/address-spaces.h" if it is not necessar=
y
      target: Do not include "exec/address-spaces.h" if it is not necessa=
ry
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
      hw/isa/superio: Fix inconsistent use of Chardev->be
      gdbstub: Prevent fd leakage
      hw/i2c/smbus: Use DeviceClass::realize instead of SMBusDeviceClass:=
:init
      hw/i2c: Use DeviceClass::realize instead of I2CSlaveClass::init
      qdev: Simplify the SysBusDeviceClass::init path
      qdev: Remove DeviceClass::init() and ::exit()

Thomas Huth (1):
      qemu-options: Mark the non-functional -clock option as deprecated

Tristan Burgess (1):
      memory: Make operations using MemoryRegionIoeventfd struct pass by =
pointer.

Yi Min Zhao (1):
      sandbox: disable -sandbox if CONFIG_SECCOMP undefined

 Makefile.target                                    |   2 +-
 accel/tcg/cpu-exec.c                               |   1 -
 bsd-user/qemu.h                                    |   1 -
 chardev/char-mux.c                                 |   1 +
 chardev/char-serial.c                              |   2 +-
 chardev/char-stdio.c                               |   2 +-
 configure                                          |  15 +-
 docs/devel/memory.txt                              |   5 +-
 docs/interop/firmware.json                         | 540 +++++++++++++++=
++++++
 exec.c                                             |   1 +
 gdbstub.c                                          |   1 +
 hw/acpi/pcihp.c                                    |   1 -
 hw/acpi/piix4.c                                    |   1 -
 hw/arm/aspeed.c                                    |   1 -
 hw/arm/bcm2836.c                                   |   1 -
 hw/arm/collie.c                                    |   1 -
 hw/arm/gumstix.c                                   |   1 -
 hw/arm/mainstone.c                                 |   1 -
 hw/arm/nseries.c                                   |   1 -
 hw/arm/omap1.c                                     |   2 -
 hw/arm/omap2.c                                     |   2 -
 hw/arm/omap_sx1.c                                  |   1 -
 hw/arm/pxa2xx.c                                    |   1 -
 hw/arm/spitz.c                                     |   1 -
 hw/arm/versatilepb.c                               |   1 -
 hw/arm/vexpress.c                                  |   1 -
 hw/arm/virt.c                                      |   1 -
 hw/arm/xilinx_zynq.c                               |   1 -
 hw/arm/xlnx-zcu102.c                               |   1 -
 hw/arm/z2.c                                        |   1 -
 hw/audio/wm8750.c                                  |   8 +-
 hw/block/dataplane/virtio-blk.c                    |   1 -
 hw/block/m25p80.c                                  |   1 -
 hw/block/nvme.c                                    |   1 +
 hw/block/nvme.h                                    |   1 -
 hw/block/onenand.c                                 |   2 -
 hw/block/pflash_cfi01.c                            |   1 -
 hw/block/pflash_cfi02.c                            |   1 -
 hw/block/virtio-blk.c                              |   1 -
 hw/char/mcf_uart.c                                 |   1 -
 hw/char/serial.c                                   |   1 -
 hw/char/sh_serial.c                                |   1 -
 hw/core/loader-fit.c                               |   1 -
 hw/core/platform-bus.c                             |   1 -
 hw/core/qdev-properties.c                          |   1 -
 hw/core/qdev.c                                     |  28 --
 hw/core/sysbus.c                                   |  12 +-
 hw/cris/axis_dev88.c                               |   1 -
 hw/display/sm501.c                                 |   1 -
 hw/display/ssd0303.c                               |   9 +-
 hw/display/tc6393xb.c                              |   1 -
 hw/gpio/max7310.c                                  |   9 +-
 hw/hppa/hppa_sys.h                                 |   1 -
 hw/i2c/core.c                                      |  13 -
 hw/i2c/smbus.c                                     |   9 -
 hw/i2c/smbus_eeprom.c                              |   5 +-
 hw/i386/kvm/i8254.c                                |   2 +-
 hw/i386/kvm/i8259.c                                |   4 +-
 hw/i386/kvm/ioapic.c                               |   2 +-
 hw/i386/kvmvapic.c                                 |   1 -
 hw/i386/pc.c                                       |   1 -
 hw/i386/xen/xen-mapcache.c                         |   1 -
 hw/ide/core.c                                      |   1 -
 hw/ide/pci.c                                       |   1 -
 hw/ide/via.c                                       |   1 -
 hw/input/lm832x.c                                  |   9 +-
 hw/ipmi/isa_ipmi_kcs.c                             |  81 +++-
 hw/isa/isa-superio.c                               |   5 +-
 hw/lm32/lm32_boards.c                              |   1 -
 hw/lm32/milkymist.c                                |   1 -
 hw/m68k/mcf5206.c                                  |   1 -
 hw/m68k/mcf_intc.c                                 |   1 -
 hw/microblaze/petalogix_ml605_mmu.c                |   1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c           |   1 -
 hw/mips/mips_malta.c                               |   1 -
 hw/mips/mips_r4k.c                                 |   1 -
 hw/misc/arm_integrator_debug.c                     |   1 -
 hw/misc/mips_itu.c                                 |   5 +-
 hw/misc/sga.c                                      |   2 +-
 hw/misc/tmp105.c                                   |   7 +-
 hw/misc/tmp421.c                                   |   8 +-
 hw/net/mcf_fec.c                                   |   1 -
 hw/net/ne2000-isa.c                                |   1 -
 hw/nvram/eeprom_at24c.c                            |  24 +-
 hw/pci-host/versatile.c                            |   1 -
 hw/ppc/ppc405_boards.c                             |   1 -
 hw/ppc/sam460ex.c                                  |   1 -
 hw/ppc/spapr.c                                     |   1 -
 hw/ppc/virtex_ml507.c                              |   2 -
 hw/riscv/riscv_htif.c                              |   1 -
 hw/s390x/virtio-ccw.c                              |   2 -
 hw/scsi/mptsas.c                                   |   1 -
 hw/scsi/scsi-generic.c                             |   1 -
 hw/sd/pl181.c                                      |   1 -
 hw/sd/sdhci.c                                      |   2 -
 hw/sd/ssi-sd.c                                     |   1 -
 hw/sh4/r2d.c                                       |   1 -
 hw/sh4/sh7750.c                                    |   1 -
 hw/timer/sh_timer.c                                |   1 -
 hw/timer/twl92230.c                                |  11 +-
 hw/usb/dev-storage.c                               |   1 -
 hw/vfio/ccw.c                                      |   1 +
 hw/vfio/platform.c                                 |   1 +
 hw/virtio/virtio-pci.c                             |   1 -
 hw/virtio/virtio.c                                 |  33 +-
 hw/xen/xen_devconfig.c                             |   1 -
 hw/xtensa/xtfpga.c                                 |   1 -
 include/exec/memory.h                              |  23 -
 include/hw/arm/allwinner-a10.h                     |   1 -
 include/hw/arm/bcm2835_peripherals.h               |   1 -
 include/hw/devices.h                               |   7 +-
 include/hw/display/bcm2835_fb.h                    |   1 -
 include/hw/dma/bcm2835_dma.h                       |   1 -
 include/hw/i2c/i2c.h                               |   3 -
 include/hw/i2c/smbus.h                             |   1 -
 include/hw/misc/bcm2835_mbox.h                     |   1 -
 include/hw/misc/bcm2835_property.h                 |   1 -
 include/hw/misc/mips_itu.h                         |   2 +
 include/hw/qdev-core.h                             |  20 +-
 include/hw/sh4/sh_intc.h                           |   1 -
 include/hw/vfio/vfio-common.h                      |   1 -
 include/hw/virtio/virtio-access.h                  |   1 -
 include/hw/virtio/virtio-gpu.h                     |   6 +
 include/migration/vmstate.h                        |  45 ++
 include/standard-headers/asm-x86/hyperv.h          |   1 -
 include/standard-headers/asm-x86/kvm_para.h        |   2 +-
 include/standard-headers/linux/ethtool.h           |  36 +-
 include/standard-headers/linux/input.h             |   4 +-
 include/standard-headers/linux/pci_regs.h          |   7 +-
 include/standard-headers/linux/virtio_balloon.h    |  15 +
 include/standard-headers/linux/virtio_gpu.h        |   1 -
 include/standard-headers/rdma/vmw_pvrdma-abi.h     |  49 +-
 include/sysemu/seccomp.h                           |   3 +-
 linux-headers/COPYING                              | 358 +-------------
 .../LICENSES/exceptions/Linux-syscall-note         |  25 +
 linux-headers/LICENSES/preferred/BSD-2-Clause      |  32 ++
 linux-headers/LICENSES/preferred/BSD-3-Clause      |  36 ++
 linux-headers/LICENSES/preferred/GPL-2.0           | 353 ++++++++++++++
 linux-headers/asm-arm/kvm.h                        |  15 +
 linux-headers/asm-arm64/kvm.h                      |   6 +
 linux-headers/asm-x86/hyperv.h                     |   1 -
 linux-headers/asm-x86/kvm.h                        |  19 +-
 linux-headers/linux/kvm.h                          |  30 +-
 linux-headers/linux/vfio.h                         |  27 ++
 memory.c                                           |  47 +-
 migration/vmstate.c                                |  25 +-
 monitor.c                                          |   1 -
 qapi/misc.json                                     |   8 +
 qemu-doc.texi                                      |   5 +
 qemu-seccomp.c                                     | 121 ++++-
 qom/object.c                                       |  28 +-
 scripts/update-linux-headers.sh                    |  17 +-
 target/arm/arm-powerctl.c                          |   1 -
 target/arm/arm_ldst.h                              |   1 -
 target/arm/crypto_helper.c                         |   1 -
 target/arm/iwmmxt_helper.c                         |   1 -
 target/arm/neon_helper.c                           |   1 -
 target/arm/psci.c                                  |   1 -
 target/arm/vec_helper.c                            |   1 -
 target/cris/cpu.c                                  |   1 -
 target/hppa/helper.c                               |   1 -
 target/hppa/int_helper.c                           |   2 +-
 target/i386/hax-all.c                              |   2 -
 target/i386/hax-mem.c                              |   1 -
 target/i386/hax-windows.c                          |   1 -
 target/i386/hvf/hvf.c                              |   2 -
 target/i386/hvf/x86_task.c                         |   3 -
 target/i386/kvm.c                                  |   3 +-
 target/i386/whpx-all.c                             | 262 ++++++----
 target/lm32/cpu.c                                  |   1 -
 target/m68k/cpu.c                                  |   1 -
 target/moxie/cpu.c                                 |   1 -
 target/moxie/mmu.c                                 |   1 -
 target/nios2/cpu.h                                 |   1 -
 target/nios2/op_helper.c                           |   1 +
 target/openrisc/cpu.c                              |   1 -
 target/ppc/helper_regs.h                           |   1 +
 target/ppc/int_helper.c                            |   1 -
 target/s390x/cpu.c                                 |   1 -
 target/s390x/diag.c                                |   1 -
 target/s390x/helper.c                              |   1 -
 target/s390x/kvm.c                                 |   1 -
 target/s390x/mem_helper.c                          |   1 -
 target/s390x/misc_helper.c                         |   1 -
 target/sparc/mmu_helper.c                          |   1 -
 target/tilegx/cpu.c                                |   1 -
 target/xtensa/core-dc232b.c                        |   2 +-
 target/xtensa/core-dc233c.c                        |   1 -
 target/xtensa/core-de212.c                         |   1 -
 target/xtensa/core-fsf.c                           |   1 -
 target/xtensa/core-sample_controller.c             |   1 -
 target/xtensa/cpu.c                                |   1 -
 target/xtensa/import_core.sh                       |   1 -
 tcg/tcg-op-vec.c                                   |   1 -
 tests/test-char.c                                  |   8 +
 util/memfd.c                                       |   2 +-
 vl.c                                               | 125 +----
 197 files changed, 1789 insertions(+), 983 deletions(-)
 create mode 100644 docs/interop/firmware.json
 delete mode 100644 include/standard-headers/asm-x86/hyperv.h
 create mode 100644 linux-headers/LICENSES/exceptions/Linux-syscall-note
 create mode 100644 linux-headers/LICENSES/preferred/BSD-2-Clause
 create mode 100644 linux-headers/LICENSES/preferred/BSD-3-Clause
 create mode 100644 linux-headers/LICENSES/preferred/GPL-2.0
 delete mode 100644 linux-headers/asm-x86/hyperv.h
--=20
2.17.0
