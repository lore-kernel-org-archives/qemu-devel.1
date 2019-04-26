Received: from eggs.gnu.org ([209.51.188.92]:59920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0V-0005ND-N9
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0U-0004LF-B4
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:05:51 +1000
Message-Id: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/36] ppc-for-4.1 queue 20190426
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999=
b6:

  Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22'=
 into staging (2019-04-24 13:19:41 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190426

for you to fetch changes up to aaef873b130f4f9c78f8e97b69c235c81b8b8b88:

  target/ppc: improve performance of large BAT invalidations (2019-04-26 =
11:37:57 +1000)

----------------------------------------------------------------
ppc patch queue 2019-04-26

Here's the first ppc target pull request for qemu-4.1.  This has a
number of things that have accumulated while qemu-4.0 was frozen.

 * A number of emulated MMU improvements from Ben Herrenschmidt

 * Assorted cleanups fro Greg Kurz

 * A large set of mostly mechanical cleanups from me to make target/ppc
   much closer to compliant with the modern coding style

 * Support for passthrough of NVIDIA GPUs using NVLink2

As well as some other assorted fixes.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      spapr: Support NVIDIA V100 GPU with NVLink2

Artyom Tarasenko (1):
      target/ppc: improve performance of large BAT invalidations

Benjamin Herrenschmidt (4):
      target/ppc: Don't check UPRT in radix mode when in HV real mode
      ppc/spapr: Use proper HPTE accessors for H_READ
      ppc/hash64: Rework R and C bit updates
      ppc/hash32: Rework R and C bit updates

C=C3=A9dric Le Goater (2):
      spapr/rtas: modify spapr_rtas_register() to remove RTAS handlers
      spapr/irq: remove spapr_ics_create()

David Gibson (23):
      target/ppc: Style fixes for ppc-models.[ch]
      target/ppc: Style fixes for cpu.[ch]
      target/ppc: Style fixes for int_helper.c
      target/ppc: Style fixes for fpu_helper.c
      target/ppc: Style fixes for dfp_helper.c
      target/ppc: Style fixes for excp_helper.c
      target/ppc: Style fixes for gdbstub.c
      target/ppc: Style fixes for helper_regs.h
      target/ppc: Style fixes for kvm_ppc.h and kvm.c
      target/ppc: Style fixes for machine.c
      target/ppc: Style fixes for mem_helper.c
      target/ppc: Style fixes for mfrom_table.inc.c & mfrom_table_gen.c
      target/ppc: Style fixes for misc_helper.c
      target/ppc: Style fixes for mmu-hash32.[ch]
      target/ppc: Style fixes for mmu-hash64.[ch]
      target/ppc: Style fixes for mmu_helper.c
      target/ppc: Style fixes for monitor.c
      target/ppc: Style fixes for translate_init.inc.c
      target/ppc: Style fixes for translate.c
      target/ppc: Style fixes for translate/fp-impl.inc.c
      target/ppc: Style fixes for translate/vsx-impl.inc.c
      target/ppc: Style fixes for translate/vmx-impl.inc.c
      target/ppc: Style fixes for translate/spe-impl.inc.c

Greg Kurz (4):
      spapr_pci: Get rid of duplicate code for node name creation
      spapr: Drop duplicate PCI swizzle code
      target/ppc/trace-events: Fix trivial typo
      target/ppc/kvm: Convert DPRINTF to traces

Philippe Mathieu-Daud=C3=A9 (1):
      hw/ppc/prep: Drop useless inclusion of "hw/input/i8042.h"

 hw/pci/pci.c                        |   2 +-
 hw/ppc/Makefile.objs                |   2 +-
 hw/ppc/prep.c                       |   1 -
 hw/ppc/spapr.c                      |  89 ++++++-
 hw/ppc/spapr_hcall.c                |  24 +-
 hw/ppc/spapr_irq.c                  |  44 +---
 hw/ppc/spapr_pci.c                  |  48 ++--
 hw/ppc/spapr_pci_nvlink2.c          | 450 ++++++++++++++++++++++++++++++=
++
 hw/ppc/spapr_rtas.c                 |   2 +-
 hw/vfio/pci-quirks.c                | 131 ++++++++++
 hw/vfio/pci.c                       |  14 +
 hw/vfio/pci.h                       |   2 +
 hw/vfio/trace-events                |   4 +
 include/hw/pci-host/spapr.h         |  45 ++++
 include/hw/pci/pci.h                |   4 +
 include/hw/ppc/spapr.h              |  11 +-
 target/ppc/cpu-models.c             |   2 +-
 target/ppc/cpu-models.h             |   3 +-
 target/ppc/cpu.h                    | 241 +++++++++--------
 target/ppc/dfp_helper.c             |  14 +-
 target/ppc/excp_helper.c            |  87 ++++---
 target/ppc/fpu_helper.c             | 134 ++++++----
 target/ppc/gdbstub.c                |  34 +--
 target/ppc/helper_regs.h            |  10 +-
 target/ppc/int_helper.c             |  70 ++---
 target/ppc/kvm.c                    | 244 +++++++++--------
 target/ppc/kvm_ppc.h                |   3 +-
 target/ppc/machine.c                | 106 +++++---
 target/ppc/mem_helper.c             |  33 ++-
 target/ppc/mfrom_table.inc.c        |   3 +-
 target/ppc/mfrom_table_gen.c        |   8 +-
 target/ppc/misc_helper.c            |   9 +-
 target/ppc/mmu-hash32.c             |  59 +++--
 target/ppc/mmu-hash64.c             | 136 ++++++----
 target/ppc/mmu-hash64.h             |   2 -
 target/ppc/mmu-radix64.c            |  16 +-
 target/ppc/mmu_helper.c             | 144 +++++++----
 target/ppc/monitor.c                |  11 +-
 target/ppc/trace-events             |  29 ++-
 target/ppc/translate.c              | 504 ++++++++++++++++++++++--------=
------
 target/ppc/translate/fp-impl.inc.c  |  52 ++--
 target/ppc/translate/spe-impl.inc.c |  14 +-
 target/ppc/translate/vmx-impl.inc.c |  26 +-
 target/ppc/translate/vsx-impl.inc.c |  15 +-
 target/ppc/translate_init.inc.c     | 243 ++++++++++-------
 45 files changed, 2152 insertions(+), 973 deletions(-)
 create mode 100644 hw/ppc/spapr_pci_nvlink2.c
