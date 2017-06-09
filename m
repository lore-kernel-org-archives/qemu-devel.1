Received: from eggs.gnu.org ([2001:4830:134:3::10]:46981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRw-0003vW-I9
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRs-0006bu-L8
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:32 +1000
Message-Id: <20170609052652.23200-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/20] ppc-for-2.10 queue 20170609
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 64175afc695c0672876fbbfc31b299c86d562c=
b4:

  arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06-0=
7 17:21:44 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170609

for you to fetch changes up to 593080936a06a04eacc589350e3a7ebc02f2ed8e:

  Revert "spapr: fix memory hot-unplugging" (2017-06-09 12:35:46 +1000)

----------------------------------------------------------------
ppc patch queue 2017-06-09

This batch contains more patches to rework the pseries machine hotplug
infrastructure, plus an assorted batch of bugfixes.

It contains a start on fixes to restore migration from older machine
types on older versions which was broken by some xics changes.  There
are still a few missing pieces here, though.

----------------------------------------------------------------
David Gibson (8):
      pseries: Correct panic behaviour for pseries machine type
      spapr: Clean up DR entity sense handling
      spapr: Don't misuse DR-indicator in spapr_recover_pending_dimm_stat=
e()
      spapr: Clean up RTAS set-indicator
      spapr: Clean up handling of DR-indicator
      spapr: Change DRC attach & detach methods to functions
      spapr: Fold spapr_phb_{add,remove}_pci_device() into their only cal=
lers
      spapr: Rework DRC name handling

Greg Kurz (9):
      target/ppc: pass const string to kvmppc_is_mem_backend_page_size_ok=
()
      target/ppc: fix memory leak in kvmppc_is_mem_backend_page_size_ok()
      spapr: fix memory leak in spapr_memory_pre_plug()
      pnv_core: drop reference on ICPState object during CPU realization
      xics: add reset() handler to ICPStateClass
      xics: introduce macros for ICP/ICS link properties
      xics: pass appropriate types to realize() handlers.
      xics: setup cpu at realize time
      xics: drop ICPStateClass::cpu_setup() handler

Laurent Vivier (1):
      Revert "spapr: fix memory hot-unplugging"

Thomas Huth (2):
      hw/ppc/spapr: Adjust firmware name for PCI bridges
      hw/cpu: core.c can be compiled as common object

 hw/cpu/Makefile.objs       |   3 +-
 hw/intc/xics.c             |  95 +++++++--------
 hw/intc/xics_kvm.c         |  45 ++-----
 hw/intc/xics_pnv.c         |   6 +-
 hw/ppc/pnv_core.c          |  16 +--
 hw/ppc/pnv_psi.c           |   3 +-
 hw/ppc/spapr.c             |  44 +++----
 hw/ppc/spapr_cpu_core.c    |  22 ++--
 hw/ppc/spapr_drc.c         | 289 +++++++++++++++++++--------------------=
------
 hw/ppc/spapr_pci.c         |  72 ++++-------
 hw/ppc/spapr_rtas.c        |   7 +-
 hw/ppc/trace-events        |   5 +-
 include/hw/ppc/spapr_drc.h |  31 +++--
 include/hw/ppc/xics.h      |  17 +--
 target/ppc/kvm.c           |   5 +-
 target/ppc/kvm_ppc.h       |   4 +-
 16 files changed, 278 insertions(+), 386 deletions(-)
