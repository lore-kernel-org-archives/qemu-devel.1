Received: from eggs.gnu.org ([2001:4830:134:3::10]:34333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRj-0008S7-5H
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRg-0007s8-1Y
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:11 +1000
Message-Id: <20170630104632.27942-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] ppc-for-2.10 queue 20170730
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit c5eb5846d2d207bbde7f4b665d9ff90b92c8ad=
ff:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170629' =
into staging (2017-06-29 17:37:11 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170630

for you to fetch changes up to 0dfabd39d523fc3f6f0f8c441f41c013cc429b52:

  spapr: Clean up DRC set_isolation_state() path (2017-06-30 14:03:32 +10=
00)

----------------------------------------------------------------
ppc patch queue 2017-06-30

  * More DRC cleanups, these now actually fix a few bugs
  * Properly implements the openpic timers (they now count and
    generate interrupts)
  * Fixes for XICS migration
  * Fixes for migration of POWER9 RPT guests
  * The last of the compatibility mode rework

----------------------------------------------------------------
Aaron Larson (1):
      target-ppc: Enable open-pic timers to count and generate interrupts

Bharata B Rao (4):
      spapr: Add a "no HPT" encoding to HTAB migration stream
      spapr: Fix migration of Radix guests
      target/ppc: Proper cleanup when ppc_cpu_realizefn fails
      spapr: prevent QEMU crash when CPU realization fails

Daniel Henrique Barboza (1):
      hw/ppc/spapr.c: consecutive 'spapr->patb_entry =3D 0' statements

David Gibson (9):
      pseries: Move CPU compatibility property to machine
      pseries: Reset CPU compatibility mode
      ppc: Rework CPU compatibility testing across migration
      spapr: Start hotplugged PCI devices in ISOLATED state
      spapr: Eliminate DRC 'signalled' state variable
      spapr: Split DRC release from DRC detach
      spapr: Make DRC reset force DRC into known state
      spapr: Clean up DRC set_allocation_state path
      spapr: Clean up DRC set_isolation_state() path

Greg Kurz (3):
      qapi: add explicit null to string input and output visitors
      xics: directly register ICPState objects to vmstate
      spapr: fix migration of ICPState objects from/to older QEMU

Suraj Jitindar Singh (1):
      target/ppc: Fix return value in tcg radix mmu fault handler

Thomas Huth (2):
      hw/ppc/prep: Remove superfluous call to soundhw_init()
      target/ppc/excp_helper: Take BQL before calling cpu_interrupt()

 hw/intc/openpic.c            | 117 +++++++++++++-
 hw/intc/xics.c               |   5 +-
 hw/ppc/prep.c                |   4 -
 hw/ppc/spapr.c               | 160 ++++++++++++++++---
 hw/ppc/spapr_cpu_core.c      |  68 +++++++--
 hw/ppc/spapr_drc.c           | 355 +++++++++++++++++++++++--------------=
------
 hw/ppc/spapr_events.c        |  10 --
 hw/ppc/spapr_hcall.c         |   8 +-
 include/hw/ppc/spapr.h       |  13 +-
 include/hw/ppc/spapr_drc.h   |  10 +-
 qapi/string-input-visitor.c  |  11 ++
 qapi/string-output-visitor.c |  14 ++
 target/ppc/compat.c          | 102 +++++++++++++
 target/ppc/cpu.h             |   6 +-
 target/ppc/excp_helper.c     |   3 +
 target/ppc/machine.c         |  69 ++++++++-
 target/ppc/mmu-radix64.c     |   2 +-
 target/ppc/translate_init.c  | 100 +++++-------
 18 files changed, 749 insertions(+), 308 deletions(-)
