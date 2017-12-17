Received: from eggs.gnu.org ([2001:4830:134:3::10]:49510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQhD1-0007tC-Sw
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQhCy-0002Am-Hs
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:14:59 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 01:07:36 +0300
Message-Id: <cover.1513548172.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/61] Trivial patches for 2017-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

> Here's a large pull request for trivial-patches queue.
> It's been quite a whie since the last request, and many
> changes has been accumulated.
>=20
> Also there's a large patchset by Philippe Mathieu-Daud=C3=A9
> named "remove i386/pc dependency from non-PC world (part 1)"
> consisting of 42 patches which makes good portion of this
> pull request.

I forgot to add my S-o-b lines to the large series by
Philippe Mathieu-Daud=C3=A9. So here's a re-send of just the
cover letter (not all the other patches). The only difference
is the addition of 42 of my "S-o-b" line.

Thanks,

/mjt

The following changes since commit 38d1b31e0501f938db39c5b2e5083285304102=
46:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-201712151'=
 into staging (2017-12-15 17:05:26 +0000)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to f4c56de4342e50b9c5a96b579a0cc44a48836536:

  misc: drop old i386 dependency (2017-12-18 01:01:55 +0300)

----------------------------------------------------------------
trivial patches for 2017-12-18

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      configure: check $CC available before verifying host CPU

Emilio G. Cota (3):
      disas/arm: fix 'instuction' typo in comment
      translate-all: fix 'consisits' typo in comment
      qht: fix kernel-doc markup in qht.h

Ladi Prosek (1):
      Remove empty statements

Marc-Andr=C3=A9 Lureau (2):
      .gitignore: remove vscclient
      memory: remove unused memory_region_set_global_locking()

Michael McConville (1):
      mmap(2) returns MAP_FAILED, not NULL, on failure

Mike Frysinger (1):
      build: fix typo in error message

Peter Maydell (1):
      accel/tcg/cpu-exec-common.c: Remove unnecessary include of memory-i=
nternal.h

Philippe Mathieu-Daud=C3=A9 (49):
      hw/alpha/typhoon: simplify using the "unimplemented" sysbus device
      Makefile: use $(MAKE) variable
      Makefile: add more targets to the UNCHECKED_GOALS rule
      MAINTAINERS: add "hw/registerfields.h" in Register API entry
      hw/registerfields: fix a typo in the FIELD() documentation
      hw/registerfields: add 64-bit extract/deposit macros
      hw/registerfields: add missing include
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
      hw/display/vga: "vga.h" only contains registers defs, rename it "vg=
a_regs.h"
      hw/display/vga: "vga_int.h" requires "ui/console.h"
      hw/display/vga: extract public API from i386/pc to "hw/display/vga.=
h"
      hw/net/ne2000: extract ne2k-isa code from i386/pc to ne2000-isa.c
      hw/misc/pvpanic: extract public API from i386/pc to "hw/misc/pvpani=
c.h"
      i386/pc: move vmport.c to hw/i386/
      i386/pc: move vmmouse.c to hw/i386/
      misc: drop old i386 dependency

Tao Wu (1):
      hw/input/hid: Add support for several keys.

Vicente Jimenez Aguilar (1):
      Document pretty parameter for mon option

 .gitignore                          |  1 -
 MAINTAINERS                         | 14 ++++++++++-
 Makefile                            | 11 +++++----
 accel/tcg/cpu-exec-common.c         |  1 -
 accel/tcg/translate-all.c           |  3 +--
 block/dmg.h                         |  1 -
 bsd-user/main.c                     |  1 -
 chardev/wctablet.c                  |  4 ----
 configure                           | 25 ++++++++++---------
 disas/arm.c                         |  2 +-
 disas/nios2.c                       |  3 ---
 exec.c                              |  3 ---
 hw/acpi/core.c                      |  1 -
 hw/acpi/ipmi-stub.c                 |  1 +
 hw/alpha/alpha_sys.h                |  1 -
 hw/alpha/dp264.c                    |  4 ++--
 hw/alpha/pci.c                      | 26 --------------------
 hw/alpha/typhoon.c                  |  6 ++---
 hw/arm/spitz.c                      |  1 -
 hw/audio/fmopl.c                    |  1 -
 hw/audio/fmopl.h                    |  1 -
 hw/audio/pcspk.c                    |  1 -
 hw/char/debugcon.c                  |  1 -
 hw/char/xen_console.c               |  1 -
 hw/core/machine.c                   |  1 -
 hw/cpu/core.c                       |  1 +
 hw/display/cirrus_vga.c             |  1 -
 hw/display/qxl.h                    |  1 -
 hw/display/vga-isa-mm.c             |  4 +---
 hw/display/vga-isa.c                |  3 +--
 hw/display/vga-pci.c                |  1 -
 hw/display/vga.c                    |  5 ++--
 hw/display/vga_int.h                |  3 ++-
 hw/display/{vga.h =3D> vga_regs.h}    |  0
 hw/display/virtio-vga.c             |  1 -
 hw/display/vmware_vga.c             |  1 -
 hw/i2c/pm_smbus.c                   |  1 -
 hw/i2c/smbus_ich9.c                 |  1 -
 hw/i386/Makefile.objs               |  2 ++
 hw/i386/acpi-build.c                |  2 +-
 hw/i386/amd_iommu.c                 |  5 +++-
 hw/i386/amd_iommu.h                 |  5 ----
 hw/i386/pc.c                        |  5 ++--
 hw/{input =3D> i386}/vmmouse.c        |  1 -
 hw/{misc =3D> i386}/vmport.c          | 17 ++++++-------
 hw/i386/xen/xen-mapcache.c          |  2 +-
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
 hw/input/Makefile.objs              |  1 -
 hw/input/adb.c                      |  2 +-
 hw/input/hid.c                      |  8 +++----
 hw/intc/lm32_pic.c                  |  1 -
 hw/ipmi/isa_ipmi_bt.c               |  1 -
 hw/ipmi/isa_ipmi_kcs.c              |  1 -
 hw/isa/i82378.c                     |  5 ++--
 hw/isa/vt82c686.c                   |  1 -
 hw/mips/mips_fulong2e.c             |  4 ++--
 hw/mips/mips_jazz.c                 |  5 ++--
 hw/mips/mips_malta.c                |  4 ++--
 hw/mips/mips_r4k.c                  |  5 ++--
 hw/misc/Makefile.objs               |  2 --
 hw/misc/imx6_ccm.c                  |  2 +-
 hw/misc/ivshmem.c                   |  1 -
 hw/misc/pvpanic.c                   | 12 ++++------
 hw/misc/sga.c                       |  1 -
 hw/moxie/moxiesim.c                 |  1 -
 hw/net/ne2000-isa.c                 |  6 ++---
 hw/net/ne2000.c                     |  2 --
 hw/net/ne2000.h                     |  3 +++
 hw/nios2/boot.c                     |  1 -
 hw/pci-bridge/pci_expander_bridge.c |  1 -
 hw/ppc/pnv.c                        |  2 +-
 hw/ppc/prep.c                       |  1 +
 hw/ppc/spapr_cpu_core.c             |  1 +
 hw/ppc/spapr_hcall.c                |  1 -
 hw/s390x/css.c                      |  1 -
 hw/s390x/virtio-ccw.c               |  2 +-
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
 include/exec/memory.h               | 12 ----------
 include/hw/acpi/acpi.h              | 11 +++++++++
 include/hw/acpi/ich9.h              |  2 ++
 include/hw/acpi/ipmi.h              |  1 -
 include/hw/cpu/core.h               |  1 -
 include/hw/display/vga.h            | 25 +++++++++++++++++++
 include/hw/i2c/ppc4xx_i2c.h         |  1 -
 include/hw/i386/pc.h                | 48 -------------------------------=
------
 include/hw/misc/pvpanic.h           | 21 ++++++++++++++++
 include/hw/net/ne2000-isa.h         | 33 +++++++++++++++++++++++++
 include/hw/registerfields.h         | 15 +++++++++++-
 include/hw/timer/i8254.h            |  5 ++--
 include/hw/timer/i8254_internal.h   |  2 +-
 include/hw/timer/mc146818rtc.h      |  3 ++-
 include/hw/unicore32/puv3.h         | 10 --------
 include/qemu/qht.h                  |  6 ++---
 include/sysemu/hax.h                |  1 -
 linux-user/main.c                   |  1 -
 linux-user/signal.c                 |  2 +-
 memory.c                            |  5 ----
 migration/block.c                   |  2 +-
 monitor.c                           |  1 -
 net/colo-compare.c                  |  1 -
 numa.c                              |  1 -
 qemu-options.hx                     |  7 +++---
 scripts/git-submodule.sh            |  2 +-
 target/i386/cpu.c                   |  2 +-
 target/i386/hax-darwin.c            |  6 +----
 target/i386/hax-darwin.h            |  3 ---
 target/i386/hax-windows.h           |  3 ---
 target/i386/kvm.c                   |  2 +-
 target/nios2/cpu.h                  |  1 -
 target/nios2/helper.c               |  5 +---
 target/nios2/op_helper.c            |  1 +
 target/nios2/translate.c            |  1 +
 target/openrisc/exception_helper.c  |  1 -
 target/ppc/kvm.c                    |  3 ---
 target/sh4/translate.c              |  2 +-
 tests/Makefile.include              | 20 ++++++++--------
 tests/test-aio-multithread.c        |  1 -
 tests/test-clone-visitor.c          |  1 -
 tests/vhost-user-test.c             |  1 -
 tests/vmgenid-test.c                |  3 ---
 util/qemu-sockets.c                 |  1 -
 vl.c                                |  3 +--
 144 files changed, 258 insertions(+), 323 deletions(-)
 rename hw/display/{vga.h =3D> vga_regs.h} (100%)
 rename hw/{input =3D> i386}/vmmouse.c (99%)
 rename hw/{misc =3D> i386}/vmport.c (95%)
 create mode 100644 include/hw/display/vga.h
 create mode 100644 include/hw/misc/pvpanic.h
 create mode 100644 include/hw/net/ne2000-isa.h
