Received: from eggs.gnu.org ([2001:4830:134:3::10]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZUyK-00031b-6U
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 00:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZUyJ-0000FV-5y
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 00:00:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 Jan 2018 15:59:26 +1100
Message-Id: <20180111045937.2119-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] ppc-for-2.12 queue 20180111
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, groug@kaod.org, mdroth@linux.vnet.ibm.com, surajjs@au1.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 3cee4db661ab9c0fce7937b3bbfa188a1845f3=
1f:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-08' i=
nto staging (2018-01-09 15:22:47 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180111

for you to fetch changes up to 51f84465dd985fc21589b2eac1f18658fc9783e9:

  spapr: Correct compatibility mode setting for hotplugged CPUs (2018-01-=
10 12:53:00 +1100)

----------------------------------------------------------------
ppc patch queue 2018-01-11

This pull request supersedes ppc-for-2.12-20180108 and several before
it.  The earlier pull request included a patch which exposed a bug in
the ARM TCG backend.  I've pulled that out and will repost once the
ARM bug is fixed (a patch has been posted by Richard Henderson).

Higlights from this series:
  * SLOF update
  * Several new devices for embedded platforms
  * Fix to correctly set compatiblity mode for hotplugged CPUs
  * dtc compile fix for older MacOS versions

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image to qemu-slof-20171214

BALATON Zoltan (4):
      sm501: Add panel hardware cursor registers also to read function
      sm501: Add some more unimplemented registers
      ppc4xx_i2c: Implement basic I2C functions
      hw/ide: Emulate SiI3112 SATA controller

C=C3=A9dric Le Goater (2):
      ppc/pnv: change powernv_ prefix to pnv_ for overall naming consiste=
ncy
      target/ppc: more use of the PPC_*() macros

David Gibson (1):
      spapr: Correct compatibility mode setting for hotplugged CPUs

Greg Kurz (1):
      spapr_pci: use warn_report()

John Arbuckle (1):
      Update dtc to fix compilation problem on Mac OS 10.6

Thomas Huth (1):
      hw/ppc: Remove the deprecated spapr-pci-vfio-host-bridge device

 MAINTAINERS                        |   6 +
 default-configs/ppcemb-softmmu.mak |   1 +
 dtc                                |   2 +-
 hw/display/sm501.c                 |  30 +++
 hw/i2c/ppc4xx_i2c.c                | 198 +++++++++++++++++---
 hw/ide/Makefile.objs               |   1 +
 hw/ide/sii3112.c                   | 368 +++++++++++++++++++++++++++++++=
++++++
 hw/ide/trace-events                |   5 +
 hw/ppc/pnv.c                       |  94 +++++-----
 hw/ppc/pnv_bmc.c                   |   2 +-
 hw/ppc/pnv_core.c                  |   8 +-
 hw/ppc/pnv_lpc.c                   |  16 +-
 hw/ppc/pnv_psi.c                   |   4 +-
 hw/ppc/pnv_xscom.c                 |  10 +-
 hw/ppc/spapr.c                     |   2 +-
 hw/ppc/spapr_pci.c                 |   6 +-
 hw/ppc/spapr_pci_vfio.c            |  47 -----
 hw/ppc/spapr_rtas.c                |   9 +
 include/hw/i2c/ppc4xx_i2c.h        |   3 +
 include/hw/ppc/pnv.h               |  10 +-
 include/hw/ppc/pnv_xscom.h         |   4 +-
 pc-bios/README                     |   2 +-
 pc-bios/slof.bin                   | Bin 905200 -> 913880 bytes
 qemu-doc.texi                      |   5 -
 roms/SLOF                          |   2 +-
 scripts/device-crash-test          |   1 -
 target/ppc/cpu.h                   |  56 +++---
 target/ppc/int_helper.c            |   2 +-
 28 files changed, 705 insertions(+), 189 deletions(-)
 create mode 100644 hw/ide/sii3112.c
