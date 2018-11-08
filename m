Received: from eggs.gnu.org ([2001:4830:134:3::10]:43244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjF4-000588-5X
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjF2-0003aI-VT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:16:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:24 +1100
Message-Id: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/22] ppc-for-3.1 queue 20181108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 4de6bb0c02ad3f0ec48f0f84ba1a65ab06e81b=
86:

  Update version for v3.1.0-rc0 release (2018-11-06 18:27:35 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.1-20181108

for you to fetch changes up to b9a477b725788e47bf653eab36e64f232d259f2a:

  ppc/spapr_caps: Add SPAPR_CAP_NESTED_KVM_HV (2018-11-08 13:08:35 +1100)

----------------------------------------------------------------
ppc patch queue 2018-11-08

Here's another patch of accumulated ppc patches for qemu-3.1.
Highlights are:
  * Support for nested HV KVM on POWER9 hosts
  * Remove Alex Graf as ppc maintainer
  * Emulation of external PID instructions

----------------------------------------------------------------
Alexander Graf (1):
      MAINTAINERS: PPC: Remove myself

C=C3=A9dric Le Goater (3):
      ppc440_pcix: convert SysBus init method to a realize method
      ppc4xx_pci: convert SysBus init method to a realize method
      PPC: e500: convert SysBus init method to a realize method

Dr. David Alan Gilbert (1):
      macio/pmu: Fix missing vmsd terminator

Greg Kurz (1):
      spapr_pci: convert g_malloc() to g_new()

Maria Klimushenkova (1):
      This patch fixes processing of rfi instructions in icount mode.

Pavel Dovgalyuk (1):
      target/ppc: fix mtmsr instruction for icount

Peter Maydell (2):
      hw/ppc/mac_newworld: Free openpic_irqs array after use
      hw/ppc/ppc440_uc: Remove dead code in sdram_size()

Prasad J Pandit (1):
      ppc/pnv: check size before data buffer access

Richard Henderson (7):
      target/ppc: Split up float_invalid_op_excp
      target/ppc: Remove float_check_status
      target/ppc: Introduce fp number classification
      target/ppc: Split out float_invalid_op_addsub
      target/ppc: Split out float_invalid_op_mul
      target/ppc: Split out float_invalid_op_div
      target/ppc: Split out float_invalid_cvt

Roman Kapl (1):
      target/ppc: add external PID support

Suraj Jitindar Singh (2):
      target/ppc: Add one reg id for ptcr
      ppc/spapr_caps: Add SPAPR_CAP_NESTED_KVM_HV

Thomas Huth (1):
      hw/ppc/spapr_rng: Introduce CONFIG_SPAPR_RNG switch for spapr_rng.c

 MAINTAINERS                        |  30 +-
 default-configs/ppc64-softmmu.mak  |   1 +
 hw/misc/macio/pmu.c                |   1 +
 hw/pci-host/ppce500.c              |  14 +-
 hw/ppc/Makefile.objs               |   3 +-
 hw/ppc/mac_newworld.c              |   1 +
 hw/ppc/pnv_lpc.c                   |   8 +-
 hw/ppc/ppc440_pcix.c               |  14 +-
 hw/ppc/ppc440_uc.c                 |   6 +-
 hw/ppc/ppc4xx_pci.c                |  14 +-
 hw/ppc/spapr.c                     |  25 ++
 hw/ppc/spapr_caps.c                |  32 ++
 hw/ppc/spapr_pci.c                 |   2 +-
 hw/ppc/spapr_rng.c                 |  23 --
 include/hw/ppc/spapr.h             |   7 +-
 target/ppc/cpu.h                   |  24 +-
 target/ppc/fpu_helper.c            | 661 ++++++++++++++++++-------------=
------
 target/ppc/helper.h                |   4 +
 target/ppc/kvm.c                   |  12 +
 target/ppc/kvm_ppc.h               |  12 +
 target/ppc/mem_helper.c            |  34 +-
 target/ppc/mmu_helper.c            | 172 +++++++---
 target/ppc/translate.c             | 165 +++++++++
 target/ppc/translate/fp-impl.inc.c |  34 ++
 target/ppc/translate/fp-ops.inc.c  |   2 +
 target/ppc/translate_init.inc.c    |  31 +-
 26 files changed, 874 insertions(+), 458 deletions(-)
