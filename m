Received: from eggs.gnu.org ([2001:4830:134:3::10]:32873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FUm-0005dR-Lr
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FUj-0003Xk-Cw
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:12:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Oct 2017 21:11:30 -0300
Message-Id: <20171017001209.32276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/39] remove i386/pc dependency from non-PC
 world (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi,

quite a bunch of patches and files modified, but the diffstat is not that big.

patches missing review: 28, 30, 35...39

since v2:
- added R-b, A-b
- added missing MAINTAINERS entries (as separate patches)
- dma/i82374: avoid multiple creations on the same ISA bus
- i386/pc: extract port92 from pc.c
- i386/pc: move vmport.c/pvpanic.c from hw/misc/ to hw/i386/

I couldn't test the KVM/XEN/HAX part (thanks Corey Minyard for v1 testing!).

v1:

- clean includes (mostly from script)
- code movement (about no logical changes)

Regards,

Phil.

[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/39:[down] 'MAINTAINERS: add entries for i2c/ppc4xx_i2c'
002/39:[down] 'MAINTAINERS: add entries for dma/i82374'
003/39:[down] 'MAINTAINERS: add an entry for the i82378 (superio)'
004/39:[down] 'MAINTAINERS: add an entry for watchdog/wdt_ib700'
005/39:[down] 'MAINTAINERS: add an entry for input/pckbd.c'
006/39:[down] 'MAINTAINERS: add entries for timer/m48t59'
007/39:[down] 'MAINTAINERS: add missing entry for include/hw/net/'
008/39:[----] [--] 'hw: use "qemu/osdep.h" as first #include in source files'
009/39:[0002] [FC] 'hw: remove "qemu/osdep.h" from header files'
010/39:[----] [--] 'block: remove "qemu/osdep.h" from header file'
011/39:[----] [--] 'misc: remove headers implicitly included'
012/39:[----] [--] 'misc: remove duplicated includes'
013/39:[----] [--] 'ppc: remove duplicated includes'
014/39:[----] [--] 'i386/hax: remove duplicated includes'
015/39:[0013] [FC] 'i386/hax: remove duplicated include'
016/39:[down] 'nios2: remove duplicated includes (in code commented out)'
017/39:[0002] [FC] 'misc: avoid "include/" in include path'
018/39:[down] 'numa: remove unused #include'
019/39:[down] 'hw/ssi/aspeed_smc: remove unused #include'
020/39:[----] [--] 'amd_iommu: avoid needless includes in header file'
021/39:[----] [--] 'misc: remove old i386 dependency'
022/39:[----] [--] 'hw/ide: remove old i386 dependency'
023/39:[----] [--] 'hw/ipmi: remove old i386 dependency'
024/39:[----] [--] 'hw/i2c: remove old i386 dependency'
025/39:[----] [-C] 'hw/tpm: remove old i386 dependency'
026/39:[----] [--] 'hw/virtio-balloon: remove old i386 dependency'
027/39:[----] [--] 'hw/unicore32: restrict hw addr defines to source file'
028/39:[0001] [FC] 'hw/acpi: ACPI_PM_* defines are not restricted to i386 arch'
029/39:[0001] [FC] 'hw/timer/i8254: rename pit_init() -> i8254_pit_init()'
030/39:[0001] [FC] 'hw/display/vga: remove the old i386/pc dependency'
031/39:[down] 'hw/input/i8042: extract pckbd and vmmouse API from hw/i386/pc.h'
032/39:[down] 'hw/timer/mc146818: rename rtc_init() -> mc146818_rtc_init()'
033/39:[0001] [FC] 'hw/net/ne2000: extract ne2k-isa code from i386/pc to ne2000-isa.c'
034/39:[0001] [FC] 'misc: drop old i386 dependency'
035/39:[down] 'i386/pc: move vmport.c from hw/misc/ to hw/i386/'
036/39:[down] 'i386/pc: move pvpanic.c from hw/misc/ to hw/i386/'
037/39:[down] 'i386/pc: extract port92 from pc.c'
038/39:[down] 'hw/dma/i82374: avoid multiple creations on the same ISA bus'
039/39:[0006] [FC] 'hw/dma/i8257: rename DMA_init() to i8257_dma_init()'

Philippe Mathieu-Daudé (39):
  MAINTAINERS: add entries for i2c/ppc4xx_i2c
  MAINTAINERS: add entries for dma/i82374
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
  hw/ssi/aspeed_smc: remove unused #include
  amd_iommu: avoid needless includes in header file
  misc: remove old i386 dependency
  hw/ide: remove old i386 dependency
  hw/ipmi: remove old i386 dependency
  hw/i2c: remove old i386 dependency
  hw/tpm: remove old i386 dependency
  hw/virtio-balloon: remove old i386 dependency
  hw/unicore32: restrict hw addr defines to source file
  hw/acpi: ACPI_PM_* defines are not restricted to i386 arch
  hw/timer/i8254: rename pit_init() -> i8254_pit_init()
  hw/display/vga: remove the old i386/pc dependency
  hw/input/i8042: extract pckbd and vmmouse API from hw/i386/pc.h
  hw/timer/mc146818: rename rtc_init() -> mc146818_rtc_init()
  hw/net/ne2000: extract ne2k-isa code from i386/pc to ne2000-isa.c
  misc: drop old i386 dependency
  i386/pc: move vmport.c from hw/misc/ to hw/i386/
  i386/pc: move pvpanic.c from hw/misc/ to hw/i386/
  i386/pc: extract port92 from pc.c
  hw/dma/i82374: avoid multiple creations on the same ISA bus
  hw/dma/i8257: rename DMA_init() to i8257_dma_init()

 default-configs/i386-softmmu.mak            |   2 -
 default-configs/x86_64-softmmu.mak          |   2 -
 block/dmg.h                                 |   1 -
 hw/audio/fmopl.h                            |   1 -
 hw/display/vga_int.h                        |   3 +-
 hw/display/{vga.h => vga_int_regs.h}        |   0
 hw/i386/amd_iommu.h                         |   5 -
 hw/net/ne2000.h                             |   3 +
 include/hw/acpi/acpi.h                      |  12 +++
 include/hw/acpi/ipmi.h                      |   1 -
 include/hw/cpu/core.h                       |   1 -
 include/hw/display/vga.h                    |  25 +++++
 include/hw/{isa/i8257.h => dma/i8257_dma.h} |   6 ++
 include/hw/i2c/ppc4xx_i2c.h                 |   1 -
 include/hw/i386/pc.h                        |  59 +-----------
 include/hw/input/i8042.h                    |  30 ++++++
 include/hw/isa/isa.h                        |   2 -
 include/hw/net/ne2000-isa.h                 |  33 +++++++
 include/hw/timer/i8254.h                    |   5 +-
 include/hw/timer/i8254_internal.h           |   2 +-
 include/hw/timer/mc146818rtc.h              |   3 +-
 include/hw/unicore32/puv3.h                 |  10 --
 include/sysemu/hax.h                        |   1 -
 target/i386/hax-darwin.h                    |   3 -
 target/i386/hax-windows.h                   |   3 -
 target/nios2/cpu.h                          |   1 -
 accel/tcg/translate-all.c                   |   1 -
 bsd-user/main.c                             |   1 -
 chardev/wctablet.c                          |   4 -
 disas/nios2.c                               |   3 -
 exec.c                                      |   3 -
 hw/acpi/core.c                              |   1 -
 hw/acpi/ipmi-stub.c                         |   1 +
 hw/alpha/dp264.c                            |   7 +-
 hw/arm/spitz.c                              |   1 -
 hw/audio/fmopl.c                            |   1 -
 hw/audio/pcspk.c                            |   1 -
 hw/char/debugcon.c                          |   1 -
 hw/char/xen_console.c                       |   1 -
 hw/core/machine.c                           |   1 -
 hw/cpu/core.c                               |   1 +
 hw/display/vga-isa-mm.c                     |   4 +-
 hw/display/vga-isa.c                        |   2 +-
 hw/display/vga.c                            |   4 +-
 hw/dma/i82374.c                             |  10 +-
 hw/dma/i8257.c                              |   4 +-
 hw/i2c/pm_smbus.c                           |   1 -
 hw/i2c/smbus_ich9.c                         |   1 -
 hw/i386/amd_iommu.c                         |   5 +-
 hw/i386/kvm/pci-assign.c                    |   1 -
 hw/i386/pc.c                                | 139 +++-------------------------
 hw/i386/pci-assign-load-rom.c               |   1 -
 hw/i386/port92.c                            | 122 ++++++++++++++++++++++++
 hw/{misc => i386}/pvpanic.c                 |   0
 hw/{misc => i386}/vmport.c                  |   1 +
 hw/i386/xen/xen_platform.c                  |   1 -
 hw/ide/ahci.c                               |   1 -
 hw/ide/cmd646.c                             |   1 -
 hw/ide/core.c                               |   3 +-
 hw/ide/ich.c                                |   1 -
 hw/ide/isa.c                                |   1 -
 hw/ide/microdrive.c                         |   1 -
 hw/ide/pci.c                                |   1 -
 hw/ide/piix.c                               |   2 +-
 hw/ide/via.c                                |   1 -
 hw/input/adb.c                              |   2 +-
 hw/input/pckbd.c                            |   2 +-
 hw/input/vmmouse.c                          |   3 +-
 hw/intc/lm32_pic.c                          |   1 -
 hw/ipmi/isa_ipmi_bt.c                       |   1 -
 hw/ipmi/isa_ipmi_kcs.c                      |   1 -
 hw/isa/i82378.c                             |   5 +-
 hw/isa/vt82c686.c                           |   1 -
 hw/mips/mips_fulong2e.c                     |  10 +-
 hw/mips/mips_jazz.c                         |   9 +-
 hw/mips/mips_malta.c                        |  10 +-
 hw/mips/mips_r4k.c                          |   8 +-
 hw/misc/ivshmem.c                           |   1 -
 hw/misc/sga.c                               |   1 -
 hw/moxie/moxiesim.c                         |   1 -
 hw/net/ne2000-isa.c                         |   6 +-
 hw/net/ne2000.c                             |   2 -
 hw/nios2/boot.c                             |   1 -
 hw/pci-bridge/pci_expander_bridge.c         |   1 -
 hw/ppc/pnv.c                                |   2 +-
 hw/ppc/prep.c                               |   6 +-
 hw/ppc/spapr_cpu_core.c                     |   1 +
 hw/ppc/spapr_hcall.c                        |   1 -
 hw/s390x/css.c                              |   1 -
 hw/scsi/vhost-user-scsi.c                   |   1 -
 hw/smbios/smbios_type_38-stub.c             |   1 +
 hw/sparc/sun4m.c                            |   5 -
 hw/sparc64/sun4u.c                          |   7 +-
 hw/ssi/aspeed_smc.c                         |   3 +-
 hw/timer/i8254.c                            |   1 -
 hw/timer/i8254_common.c                     |   1 -
 hw/timer/mc146818rtc.c                      |   2 +-
 hw/tpm/tpm_passthrough.c                    |   1 -
 hw/tpm/tpm_tis.c                            |   1 -
 hw/unicore32/puv3.c                         |  17 ++--
 hw/vfio/ccw.c                               |   2 +-
 hw/virtio/vhost-vsock.c                     |   2 +-
 hw/virtio/virtio-balloon.c                  |   2 +-
 hw/watchdog/wdt_ib700.c                     |   1 -
 linux-user/main.c                           |   1 -
 monitor.c                                   |   1 -
 net/colo-compare.c                          |   1 -
 numa.c                                      |   1 -
 target/i386/hax-darwin.c                    |   6 +-
 target/nios2/helper.c                       |   5 +-
 target/nios2/op_helper.c                    |   1 +
 target/nios2/translate.c                    |   1 +
 target/openrisc/exception_helper.c          |   1 -
 target/ppc/kvm.c                            |   3 -
 tests/test-aio-multithread.c                |   1 -
 tests/test-clone-visitor.c                  |   1 -
 tests/vhost-user-test.c                     |   1 -
 tests/vmgenid-test.c                        |   3 -
 util/qemu-sockets.c                         |   1 -
 vl.c                                        |   3 +-
 MAINTAINERS                                 |  14 ++-
 hw/i386/Makefile.objs                       |   3 +-
 hw/misc/Makefile.objs                       |   3 -
 123 files changed, 358 insertions(+), 368 deletions(-)
 rename hw/display/{vga.h => vga_int_regs.h} (100%)
 create mode 100644 include/hw/display/vga.h
 rename include/hw/{isa/i8257.h => dma/i8257_dma.h} (86%)
 create mode 100644 include/hw/input/i8042.h
 create mode 100644 include/hw/net/ne2000-isa.h
 create mode 100644 hw/i386/port92.c
 rename hw/{misc => i386}/pvpanic.c (100%)
 rename hw/{misc => i386}/vmport.c (99%)

-- 
2.15.0.rc0
