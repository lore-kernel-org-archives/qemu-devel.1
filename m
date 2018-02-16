Received: from eggs.gnu.org ([2001:4830:134:3::10]:35382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuT-0001aV-Gc
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuQ-000565-9C
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:29 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 16 Feb 2018 21:06:03 +1100
Message-Id: <20180216100617.25265-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] ppc-for-2.12 queue 20180216
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, surajjs@au1.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit cc5a0ae03e0d011521ca5b32d3995a299b6b3a=
d3:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80215-1' into staging (2018-02-15 18:37:46 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180216

for you to fetch changes up to 58d5b22bbd505dc942d137d5d3da89ad9bc16c0a:

  ppc4xx: Add device models found in PPC440 core SoCs (2018-02-16 14:06:0=
7 +1100)

----------------------------------------------------------------
ppc patch queue 2018-02-16

Highlights of this batch:
  * Conversion to TranslatorOps (Emilio Cota)
  * Further bugfixes and cleanups to vcpu id allocation for pseries
    (Greg Kurz)
  * Another bugfix for HPT resizing (Daniel Henrique-Barboza)
  * Macintosh CUDA cleanups (Mark Cave-Ayland)
  * Further tweaks to Spectre/Meltdown mitigations (Suraj Singh)

----------------------------------------------------------------
BALATON Zoltan (1):
      ppc4xx: Add device models found in PPC440 core SoCs

Daniel Henrique Barboza (1):
      hw/ppc/spapr_hcall: set htab_shift after kvmppc_resize_hpt_commit

Emilio G. Cota (2):
      target/ppc: convert to DisasContextBase
      target/ppc: convert to TranslatorOps

Greg Kurz (4):
      spapr: use spapr->vsmt to compute VCPU ids
      spapr: move VCPU calculation to core machine code
      spapr: rename spapr_vcpu_id() to spapr_get_vcpu_id()
      spapr: consolidate the VCPU id numbering logic in a single place

Laurent Vivier (1):
      hw/char: remove legacy interface escc_init()

Mark Cave-Ayland (3):
      cuda: convert to use the shared mos6522 device
      ppc: move CUDAState and other CUDA-related definitions into separat=
e cuda.h file
      cuda: convert to trace-events

Suraj Jitindar Singh (2):
      ppc/spapr-caps: Change migration macro to take full spapr-cap name
      ppc/spapr-caps: Disallow setting workaround for spapr-cap-ibs

 Makefile.objs                       |    1 +
 hw/char/escc.c                      |  209 ++-----
 hw/misc/macio/cuda.c                |  649 ++++++--------------
 hw/misc/macio/macio.c               |    1 +
 hw/misc/macio/trace-events          |   11 +
 hw/ppc/mac.h                        |   76 +--
 hw/ppc/mac_newworld.c               |   19 +-
 hw/ppc/mac_oldworld.c               |   19 +-
 hw/ppc/ppc440.h                     |   26 +
 hw/ppc/ppc440_uc.c                  | 1159 +++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr.c                      |   75 ++-
 hw/ppc/spapr_caps.c                 |   36 +-
 hw/ppc/spapr_cpu_core.c             |    9 +-
 hw/ppc/spapr_hcall.c                |   12 +-
 hw/sparc/sun4m.c                    |   34 +-
 include/hw/char/escc.h              |   54 +-
 include/hw/misc/macio/cuda.h        |  107 ++++
 include/hw/pci/pcie_host.h          |    2 +-
 include/hw/ppc/spapr.h              |    3 +-
 target/ppc/translate.c              |  388 ++++++------
 target/ppc/translate/dfp-impl.inc.c |   16 +-
 target/ppc/translate_init.c         |   32 +-
 22 files changed, 1960 insertions(+), 978 deletions(-)
 create mode 100644 hw/misc/macio/trace-events
 create mode 100644 hw/ppc/ppc440.h
 create mode 100644 hw/ppc/ppc440_uc.c
 create mode 100644 include/hw/misc/macio/cuda.h
