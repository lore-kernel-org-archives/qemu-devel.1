Received: from eggs.gnu.org ([2001:4830:134:3::10]:33132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePghf-0001Mm-1K
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePghb-0002ZR-SI
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:30:27 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:29:32 -0300
Message-Id: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/43] remove i386/pc dependency from non-PC
 world (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org

Quite a bunch of patches and files modified, but the diffstat is not that big.

Which Michael is willing to merge this? :)

Regards,

Phil.

v4:
- added R-b, A-b
- rebased on 2.12
- fixed an english comment (Thomas)
- replace fprintf() by trace events in hw/i386/vmport.c

since v3:
- addressed Thomas & Paolo comments (thanks for your reviews!)
- split/fixed MAINTAINERS entries
- dropped port92 patch
- dropped i8237* patches

I couldn't test the KVM/XEN/HAX part (thanks Corey Minyard for v1 testing!).

since v2:
- added R-b, A-b
- added missing MAINTAINERS entries (as separate patches)
- dma/i82374: avoid multiple creations on the same ISA bus
- i386/pc: extract port92 from pc.c
- i386/pc: move vmport.c/pvpanic.c from hw/misc/ to hw/i386/

v1:
- clean includes (mostly from script)
- code movement (about no logical changes)

001/43:[----] [--] 'MAINTAINERS: add entries for i2c/ppc4xx'
002/43:[----] [--] 'MAINTAINERS: add an entry for the i82374 (southbridge)'
003/43:[----] [--] 'MAINTAINERS: add an entry for the i8257 (DMA controller)'
004/43:[----] [--] 'MAINTAINERS: add an entry for the i82378 (superio)'
005/43:[----] [--] 'MAINTAINERS: add an entry for watchdog/wdt_ib700'
006/43:[----] [--] 'MAINTAINERS: add an entry for input/pckbd.c'
007/43:[----] [--] 'MAINTAINERS: add entries for timer/m48t59'
008/43:[----] [--] 'MAINTAINERS: add missing entry for include/hw/net/'
009/43:[----] [--] 'hw: use "qemu/osdep.h" as first #include in source files'
010/43:[----] [--] 'hw: remove "qemu/osdep.h" from header files'
011/43:[----] [--] 'block: remove "qemu/osdep.h" from header file'
012/43:[----] [--] 'misc: remove headers implicitly included'
013/43:[----] [--] 'misc: remove duplicated includes'
014/43:[----] [--] 'ppc: remove duplicated includes'
015/43:[----] [--] 'i386/hax: remove duplicated includes'
016/43:[0013] [FC] 'i386/hax: remove duplicated include'
017/43:[----] [--] 'nios2: remove duplicated includes (in code commented out)'
018/43:[----] [--] 'misc: avoid "include/" in include path'
019/43:[----] [--] 'numa: remove unused #include'
020/43:[----] [--] 'hw/input/vmmouse: remove unused #include'
021/43:[----] [--] 'hw/misc/pvpanic: remove unused #include'
022/43:[----] [--] 'hw/ssi/aspeed_smc: remove unused #include'
023/43:[----] [--] 'amd_iommu: avoid needless includes in header file'
024/43:[0003] [FC] 'misc: remove old i386 dependency'
025/43:[----] [--] 'hw/ide: remove old i386 dependency'
026/43:[----] [--] 'hw/ipmi: remove old i386 dependency'
027/43:[----] [--] 'hw/i2c: remove old i386 dependency'
028/43:[----] [-C] 'hw/tpm: remove old i386 dependency'
029/43:[----] [--] 'hw/virtio-balloon: remove old i386 dependency'
030/43:[----] [--] 'hw/unicore32: restrict hw addr defines to source file'
031/43:[----] [--] 'hw/timer/i8254: rename pit_init() -> i8254_pit_init()'
032/43:[----] [--] 'hw/timer/mc146818: rename rtc_init() -> mc146818_rtc_init()'
033/43:[----] [--] 'hw/acpi: ACPI_PM_* defines are not restricted to i386 arch'
034/43:[----] [--] 'hw/acpi/ich9: extract ACPI_PM_PROP_TCO_ENABLED from i386/pc'
035/43:[----] [--] 'hw/display/vga: "vga.h" only contains registers defs, rename it "vga_regs.h"'
036/43:[----] [--] 'hw/display/vga: "vga_int.h" requires "ui/console.h"'
037/43:[----] [--] 'hw/display/vga: extract public API from i386/pc to "hw/display/vga.h"'
038/43:[----] [--] 'hw/net/ne2000: extract ne2k-isa code from i386/pc to ne2000-isa.c'
039/43:[----] [--] 'hw/misc/pvpanic: extract public API from i386/pc to "hw/misc/pvpanic.h"'
040/43:[0017] [FC] 'i386/pc: move vmport.c to hw/i386/'
041/43:[----] [--] 'i386/pc: move vmmouse.c to hw/i386/'
042/43:[down] 'hw/i386/vmport: replace fprintf() by trace events'
043/43:[----] [--] 'misc: drop old i386 dependency'

Philippe Mathieu-Daudé (43):
  MAINTAINERS: add entries for i2c/ppc4xx
  MAINTAINERS: add an entry for the i82374 (southbridge)
  MAINTAINERS: add an entry for the i8257 (DMA controller)
  MAINTAINERS: add an entry for the i82378 (superio)
  MAINTAINERS: add an entry for watchdog/wdt_ib700
  MAINTAINERS: add an entry for input/pckbd.c
  MAINTAINERS: add entries for timer/m48t59
  MAINTAINERS: add missing entry for include/hw/net/
  hw: use "qemu/osdep.h" as first #include in source files
  hw: remove "qemu/osdep.h" from header files
  block: remove "qemu/osdep.h" from header file
  misc: remove headers implicitly included
  misc: remove duplicated includes
  ppc: remove duplicated includes
  i386/hax: remove duplicated includes
  i386/hax: remove duplicated include
  nios2: remove duplicated includes (in code commented out)
  misc: avoid "include/" in include path
  numa: remove unused #include
  hw/input/vmmouse: remove unused #include
  hw/misc/pvpanic: remove unused #include
  hw/ssi/aspeed_smc: remove unused #include
  amd_iommu: avoid needless includes in header file
  misc: remove old i386 dependency
  hw/ide: remove old i386 dependency
  hw/ipmi: remove old i386 dependency
  hw/i2c: remove old i386 dependency
  hw/tpm: remove old i386 dependency
  hw/virtio-balloon: remove old i386 dependency
  hw/unicore32: restrict hw addr defines to source file
  hw/timer/i8254: rename pit_init() -> i8254_pit_init()
  hw/timer/mc146818: rename rtc_init() -> mc146818_rtc_init()
  hw/acpi: ACPI_PM_* defines are not restricted to i386 arch
  hw/acpi/ich9: extract ACPI_PM_PROP_TCO_ENABLED from i386/pc
  hw/display/vga: "vga.h" only contains registers defs, rename it "vga_regs.h"
  hw/display/vga: "vga_int.h" requires "ui/console.h"
  hw/display/vga: extract public API from i386/pc to "hw/display/vga.h"
  hw/net/ne2000: extract ne2k-isa code from i386/pc to ne2000-isa.c
  hw/misc/pvpanic: extract public API from i386/pc to "hw/misc/pvpanic.h"
  i386/pc: move vmport.c to hw/i386/
  i386/pc: move vmmouse.c to hw/i386/
  hw/i386/vmport: replace fprintf() by trace events
  misc: drop old i386 dependency

 block/dmg.h                         |  1 -
 hw/audio/fmopl.h                    |  1 -
 hw/display/qxl.h                    |  1 -
 hw/display/vga_int.h                |  3 ++-
 hw/display/{vga.h => vga_regs.h}    |  0
 hw/i386/amd_iommu.h                 |  5 ----
 hw/net/ne2000.h                     |  3 +++
 include/hw/acpi/acpi.h              | 11 +++++++++
 include/hw/acpi/ich9.h              |  2 ++
 include/hw/acpi/ipmi.h              |  1 -
 include/hw/cpu/core.h               |  1 -
 include/hw/display/vga.h            | 25 +++++++++++++++++++
 include/hw/i2c/ppc4xx_i2c.h         |  1 -
 include/hw/i386/pc.h                | 48 -------------------------------------
 include/hw/misc/pvpanic.h           | 21 ++++++++++++++++
 include/hw/net/ne2000-isa.h         | 33 +++++++++++++++++++++++++
 include/hw/timer/i8254.h            |  5 ++--
 include/hw/timer/i8254_internal.h   |  2 +-
 include/hw/timer/mc146818rtc.h      |  3 ++-
 include/hw/unicore32/puv3.h         | 10 --------
 include/sysemu/hax.h                |  1 -
 target/i386/hax-darwin.h            |  3 ---
 target/i386/hax-windows.h           |  3 ---
 target/nios2/cpu.h                  |  1 -
 accel/tcg/translate-all.c           |  1 -
 bsd-user/main.c                     |  1 -
 chardev/wctablet.c                  |  4 ----
 disas/nios2.c                       |  3 ---
 exec.c                              |  3 ---
 hw/acpi/core.c                      |  1 -
 hw/acpi/ipmi-stub.c                 |  1 +
 hw/alpha/dp264.c                    |  4 ++--
 hw/arm/spitz.c                      |  1 -
 hw/audio/fmopl.c                    |  1 -
 hw/audio/pcspk.c                    |  1 -
 hw/char/debugcon.c                  |  1 -
 hw/char/xen_console.c               |  1 -
 hw/core/machine.c                   |  1 -
 hw/cpu/core.c                       |  1 +
 hw/display/cirrus_vga.c             |  1 -
 hw/display/vga-isa-mm.c             |  4 +---
 hw/display/vga-isa.c                |  3 +--
 hw/display/vga-pci.c                |  1 -
 hw/display/vga.c                    |  5 ++--
 hw/display/virtio-vga.c             |  1 -
 hw/display/vmware_vga.c             |  1 -
 hw/i2c/pm_smbus.c                   |  1 -
 hw/i2c/smbus_ich9.c                 |  1 -
 hw/i386/acpi-build.c                |  2 +-
 hw/i386/amd_iommu.c                 |  5 +++-
 hw/i386/pc.c                        |  5 ++--
 hw/{input => i386}/vmmouse.c        |  1 -
 hw/{misc => i386}/vmport.c          | 23 +++++++++---------
 hw/i386/xen/xen_platform.c          |  1 -
 hw/ide/ahci.c                       |  1 -
 hw/ide/cmd646.c                     |  1 -
 hw/ide/core.c                       |  3 +--
 hw/ide/ich.c                        |  1 -
 hw/ide/isa.c                        |  1 -
 hw/ide/microdrive.c                 |  1 -
 hw/ide/pci.c                        |  1 -
 hw/ide/piix.c                       |  2 +-
 hw/ide/via.c                        |  1 -
 hw/input/adb.c                      |  2 +-
 hw/intc/lm32_pic.c                  |  1 -
 hw/ipmi/isa_ipmi_bt.c               |  1 -
 hw/ipmi/isa_ipmi_kcs.c              |  1 -
 hw/isa/i82378.c                     |  5 ++--
 hw/isa/vt82c686.c                   |  1 -
 hw/mips/mips_fulong2e.c             |  4 ++--
 hw/mips/mips_jazz.c                 |  5 ++--
 hw/mips/mips_malta.c                |  4 ++--
 hw/mips/mips_r4k.c                  |  5 ++--
 hw/misc/ivshmem.c                   |  1 -
 hw/misc/pvpanic.c                   | 12 ++++------
 hw/misc/sga.c                       |  1 -
 hw/moxie/moxiesim.c                 |  1 -
 hw/net/ne2000-isa.c                 |  6 ++---
 hw/net/ne2000.c                     |  2 --
 hw/nios2/boot.c                     |  1 -
 hw/pci-bridge/pci_expander_bridge.c |  1 -
 hw/ppc/pnv.c                        |  2 +-
 hw/ppc/prep.c                       |  1 +
 hw/ppc/spapr_cpu_core.c             |  1 +
 hw/ppc/spapr_hcall.c                |  1 -
 hw/s390x/css.c                      |  1 -
 hw/scsi/vhost-user-scsi.c           |  1 -
 hw/smbios/smbios_type_38-stub.c     |  1 +
 hw/sparc/sun4m.c                    |  1 -
 hw/ssi/aspeed_smc.c                 |  3 +--
 hw/timer/i8254.c                    |  1 -
 hw/timer/i8254_common.c             |  1 -
 hw/timer/mc146818rtc.c              |  2 +-
 hw/tpm/tpm_passthrough.c            |  1 -
 hw/tpm/tpm_tis.c                    |  1 -
 hw/unicore32/puv3.c                 | 15 ++++++++----
 hw/vfio/ccw.c                       |  2 +-
 hw/virtio/vhost-vsock.c             |  2 +-
 hw/virtio/virtio-balloon.c          |  2 +-
 hw/watchdog/wdt_ib700.c             |  1 -
 linux-user/main.c                   |  1 -
 monitor.c                           |  1 -
 net/colo-compare.c                  |  1 -
 numa.c                              |  1 -
 target/i386/hax-darwin.c            |  6 +----
 target/nios2/helper.c               |  5 +---
 target/nios2/op_helper.c            |  1 +
 target/nios2/translate.c            |  1 +
 target/openrisc/exception_helper.c  |  1 -
 target/ppc/kvm.c                    |  3 ---
 tests/test-aio-multithread.c        |  1 -
 tests/test-clone-visitor.c          |  1 -
 tests/vhost-user-test.c             |  1 -
 tests/vmgenid-test.c                |  3 ---
 util/qemu-sockets.c                 |  1 -
 vl.c                                |  3 +--
 MAINTAINERS                         | 13 +++++++++-
 hw/i386/Makefile.objs               |  2 ++
 hw/i386/trace-events                |  4 ++++
 hw/input/Makefile.objs              |  1 -
 hw/misc/Makefile.objs               |  2 --
 121 files changed, 194 insertions(+), 230 deletions(-)
 rename hw/display/{vga.h => vga_regs.h} (100%)
 create mode 100644 include/hw/display/vga.h
 create mode 100644 include/hw/misc/pvpanic.h
 create mode 100644 include/hw/net/ne2000-isa.h
 rename hw/{input => i386}/vmmouse.c (99%)
 rename hw/{misc => i386}/vmport.c (93%)

-- 
2.15.1
