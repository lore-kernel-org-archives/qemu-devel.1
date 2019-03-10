Received: from eggs.gnu.org ([209.51.188.92]:42394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnm-0000dP-7s
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnk-00014D-Py
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:03 +1100
Message-Id: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/60] ppc-for-4.0 queue 20190310
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit f5b4c31030f45293bb4517445722768434829d=
91:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-03-09 17:35:48 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190310

for you to fetch changes up to 08d020471fcd41cb020fc9987ed1945eefcc8805:

  spapr: Use CamelCase properly (2019-03-10 14:35:44 +1100)

----------------------------------------------------------------
ppc patch queue for 2019-03-10

Here's a final pull request before the 4.0 soft freeze.  Changes
include:
  * A Great Renaming to use camel case properly in spapr code
  * Optimization of some vector instructions
  * Support for POWER9 cpus in the powernv machine
  * Fixes a regression from the last pull request in handling VSX
    instructions with mixed operands from the FPR and VMX parts of the
    register array
  * Optimization hack to avoid scanning all the (empty) entries on a
    new IOMMU window
  * Add FSL I2C controller model for E500
  * Support for KVM acceleration of the H_PAGE_INIT hypercall on spapr
  * Update u-boot image for E500
  * Enable Specre/Meltdown mitigations by default on the new machine type
  * Enable large decrementer support for POWER9

Plus a number of assorted bugfixes and cleanups.

----------------------------------------------------------------
Alexander Graf (1):
      PPC: E500: Update u-boot to v2019.01

Alexey Kardashevskiy (3):
      vfio/spapr: Fix indirect levels calculation
      vfio/spapr: Rename local systempagesize variable
      spapr_iommu: Do not replay mappings from just created DMA window

Andrew Randrianasulu (1):
      PPC: E500: Add FSL I2C controller and integrate RTC with it

C=C3=A9dric Le Goater (27):
      ppc/xive: hardwire the Physical CAM line of the thread context
      ppc: externalize ppc_get_vcpu_by_pir()
      ppc/xive: export the TIMA memory accessors
      ppc/pnv: export the xive_router_notify() routine
      ppc/pnv: change the CPU machine_data presenter type to Object *
      ppc/pnv: add a XIVE interrupt controller model for POWER9
      ppc/pnv: introduce a new dt_populate() operation to the chip model
      ppc/pnv: introduce a new pic_print_info() operation to the chip mod=
el
      ppc/xive: activate HV support
      ppc/pnv: fix logging primitives using Ox
      ppc/pnv: psi: add a PSIHB_REG macro
      ppc/pnv: psi: add a reset handler
      ppc/pnv: add a PSI bridge class model
      ppc/pnv: add a PSI bridge model for POWER9
      ppc/pnv: lpc: fix OPB address ranges
      ppc/pnv: add a LPC Controller class model
      ppc/pnv: add a 'dt_isa_nodename' to the chip
      ppc/pnv: add a LPC Controller model for POWER9
      ppc/pnv: add SerIRQ routing registers
      ppc/pnv: add a OCC model class
      ppc/pnv: add a OCC model for POWER9
      ppc/pnv: extend XSCOM core support for POWER9
      ppc/pnv: POWER9 XSCOM quad support
      ppc/pnv: activate XSCOM tests for POWER9
      ppc/pnv: add more dummy XSCOM addresses
      ppc/pnv: add a "ibm,opal/power-mgt" device tree node on POWER9
      target/ppc: add HV support for POWER9

David Gibson (2):
      spapr: Force SPAPR_MEMORY_BLOCK_SIZE to be a hwaddr (64-bit)
      spapr: Use CamelCase properly

Fabiano Rosas (3):
      target/ppc: Move exception vector offset computation into a functio=
n
      target/ppc: Move handling of hardware breakpoints to a separate fun=
ction
      target/ppc: Refactor kvm_handle_debug

Greg Kurz (2):
      spapr: Simulate CAS for qtest
      Revert "spapr: support memory unplug for qtest"

Mark Cave-Ayland (9):
      target/ppc: introduce single fpr_offset() function
      target/ppc: introduce single vsrl_offset() function
      target/ppc: move Vsr* macros from internal.h to cpu.h
      target/ppc: introduce avr_full_offset() function
      target/ppc: improve avr64_offset() and use it to simplify get_avr64=
()/set_avr64()
      target/ppc: switch fpr/vsrl registers so all VSX registers are in h=
ost endian order
      target/ppc: introduce vsr64_offset() to simplify get_cpu_vsr{l,h}()=
 and set_cpu_vsr{l,h}()
      mac_oldworld: use node name instead of alias name for hd device in =
FWPathProvider
      mac_newworld: use node name instead of alias name for hd device in =
FWPathProvider

Philippe Mathieu-Daud=C3=A9 (2):
      target/ppc: Optimize xviexpdp() using deposit_i64()
      target/ppc: Optimize x[sv]xsigdp using deposit_i64()

Suraj Jitindar Singh (10):
      target/ppc/spapr: Add SPAPR_CAP_LARGE_DECREMENTER
      target/ppc: Implement large decrementer support for TCG
      target/ppc: Implement large decrementer support for KVM
      target/ppc/spapr: Enable the large decrementer for pseries-4.0
      target/ppc/spapr: Add workaround option to SPAPR_CAP_IBS
      target/ppc/spapr: Add SPAPR_CAP_CCF_ASSIST
      target/ppc/tcg: make spapr_caps apply cap-[cfpc/sbbc/ibs] non-fatal=
 for tcg
      target/ppc/spapr: Enable mitigations by default for pseries-4.0 mac=
hine type
      target/ppc/spapr: Clear partition table entry when allocating hash =
table
      target/ppc/spapr: Enable H_PAGE_INIT in-kernel handling

 default-configs/ppc-softmmu.mak     |    2 +
 hw/char/spapr_vty.c                 |   58 +-
 hw/i2c/Kconfig                      |    4 +
 hw/i2c/Makefile.objs                |    1 +
 hw/i2c/mpc_i2c.c                    |  357 +++++++
 hw/intc/Makefile.objs               |    2 +-
 hw/intc/pnv_xive.c                  | 1753 +++++++++++++++++++++++++++++=
++++++
 hw/intc/pnv_xive_regs.h             |  248 +++++
 hw/intc/spapr_xive.c                |   86 +-
 hw/intc/xics_kvm.c                  |    4 +-
 hw/intc/xics_spapr.c                |   24 +-
 hw/intc/xive.c                      |  113 ++-
 hw/net/spapr_llan.c                 |  110 +--
 hw/nvram/spapr_nvram.c              |   42 +-
 hw/ppc/e500.c                       |   54 ++
 hw/ppc/mac_newworld.c               |    4 +-
 hw/ppc/mac_oldworld.c               |    4 +-
 hw/ppc/pnv.c                        |  252 ++++-
 hw/ppc/pnv_core.c                   |  189 +++-
 hw/ppc/pnv_lpc.c                    |  316 ++++++-
 hw/ppc/pnv_occ.c                    |  127 ++-
 hw/ppc/pnv_psi.c                    |  425 ++++++++-
 hw/ppc/pnv_xscom.c                  |   33 +-
 hw/ppc/ppc.c                        |  101 +-
 hw/ppc/spapr.c                      |  361 ++++----
 hw/ppc/spapr_caps.c                 |  247 +++--
 hw/ppc/spapr_cpu_core.c             |   52 +-
 hw/ppc/spapr_drc.c                  |  134 +--
 hw/ppc/spapr_events.c               |   92 +-
 hw/ppc/spapr_hcall.c                |  118 +--
 hw/ppc/spapr_iommu.c                |  107 ++-
 hw/ppc/spapr_irq.c                  |  104 +--
 hw/ppc/spapr_ovec.c                 |   46 +-
 hw/ppc/spapr_pci.c                  |  212 ++---
 hw/ppc/spapr_pci_vfio.c             |   14 +-
 hw/ppc/spapr_rng.c                  |   18 +-
 hw/ppc/spapr_rtas.c                 |   30 +-
 hw/ppc/spapr_rtas_ddw.c             |   42 +-
 hw/ppc/spapr_rtc.c                  |   16 +-
 hw/ppc/spapr_vio.c                  |  116 +--
 hw/scsi/spapr_vscsi.c               |   14 +-
 hw/vfio/spapr.c                     |   49 +-
 hw/vfio/trace-events                |    2 +-
 include/hw/pci-host/spapr.h         |   44 +-
 include/hw/ppc/pnv.h                |   42 +-
 include/hw/ppc/pnv_core.h           |   14 +-
 include/hw/ppc/pnv_lpc.h            |   26 +
 include/hw/ppc/pnv_occ.h            |   17 +
 include/hw/ppc/pnv_psi.h            |   59 +-
 include/hw/ppc/pnv_xive.h           |   93 ++
 include/hw/ppc/pnv_xscom.h          |   21 +-
 include/hw/ppc/ppc.h                |    1 +
 include/hw/ppc/spapr.h              |  194 ++--
 include/hw/ppc/spapr_cpu_core.h     |   24 +-
 include/hw/ppc/spapr_drc.h          |  108 +--
 include/hw/ppc/spapr_irq.h          |   58 +-
 include/hw/ppc/spapr_ovec.h         |   30 +-
 include/hw/ppc/spapr_vio.h          |   74 +-
 include/hw/ppc/spapr_xive.h         |   18 +-
 include/hw/ppc/xics_spapr.h         |    6 +-
 include/hw/ppc/xive.h               |    4 +
 pc-bios/u-boot.e500                 |  Bin 388672 -> 349148 bytes
 roms/u-boot                         |    2 +-
 target/ppc/cpu-qom.h                |    1 +
 target/ppc/cpu.h                    |   59 +-
 target/ppc/excp_helper.c            |   30 +-
 target/ppc/internal.h               |   27 +-
 target/ppc/kvm.c                    |  201 ++--
 target/ppc/kvm_ppc.h                |   23 +
 target/ppc/machine.c                |    8 +-
 target/ppc/mmu-hash64.c             |    2 +-
 target/ppc/translate.c              |   22 +-
 target/ppc/translate/vmx-impl.inc.c |   27 +-
 target/ppc/translate/vsx-impl.inc.c |   65 +-
 target/ppc/translate_init.inc.c     |    7 +-
 tests/pnv-xscom-test.c              |    2 -
 76 files changed, 5791 insertions(+), 1601 deletions(-)
 create mode 100644 hw/i2c/mpc_i2c.c
 create mode 100644 hw/intc/pnv_xive.c
 create mode 100644 hw/intc/pnv_xive_regs.h
 create mode 100644 include/hw/ppc/pnv_xive.h
