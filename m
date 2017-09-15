Received: from eggs.gnu.org ([2001:4830:134:3::10]:54045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfH-0006Sv-UE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfH-0003Jm-0n
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:12 +1000
Message-Id: <20170915035130.8354-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/18] ppc-for-2.11 queue 20170915
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 3dabde1128b671f36ac6cb36b97b2731399644=
20:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' =
into staging (2017-09-14 16:33:02 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20170915

for you to fetch changes up to 70a0c19e83aa4c71c879d51e426e89e4b3d4e014:

  ppc/kvm: use kvm_vm_check_extension() in kvmppc_is_pr() (2017-09-15 10:=
29:48 +1000)

----------------------------------------------------------------
ppc patch queue 2017-09-15

Here's the current batch of accumulated ppc patches.  These are all
pretty simple bugfixes or cleanups, no big new features here.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      vfio, spapr: Fix levels calculation

Benjamin Herrenschmidt (1):
      net: Add SunGEM device emulation as found on Apple UniNorth

C=C3=A9dric Le Goater (2):
      ppc/xive: fix OV5_XIVE_EXPLOIT bits
      spapr: fix CAS-generated reset

Daniel Henrique Barboza (1):
      hw/ppc/spapr.c: cleaning up qdev_get_machine() calls

Greg Kurz (13):
      spapr_pci: drop useless check in spapr_phb_vfio_get_loc_code()
      spapr_pci: drop useless check in spapr_populate_pci_child_dt()
      spapr_pci: use g_strdup_printf()
      spapr: only update SDR1 once per-cpu during CAS
      spapr_pci: use the common _FDT() helper
      spapr_pci: handle FDT creation errors with _FDT()
      xics: fix several error leaks
      spapr_cpu_core: fail gracefully with non-pseries machine types
      spapr_pci: convert sprintf() to g_strdup_printf()
      spapr_pci: don't create 64-bit MMIO window if we don't need to
      spapr_cpu_core: cleaning up qdev_get_machine() calls
      spapr_events: use QTAILQ_FOREACH_SAFE() in spapr_clear_pending_even=
ts()
      ppc/kvm: use kvm_vm_check_extension() in kvmppc_is_pr()

 default-configs/ppc-softmmu.mak |    1 +
 hw/intc/xics.c                  |   12 +-
 hw/net/Makefile.objs            |    1 +
 hw/net/sungem.c                 | 1447 +++++++++++++++++++++++++++++++++=
++++++
 hw/net/trace-events             |   44 ++
 hw/pci/pci.c                    |    2 +
 hw/ppc/spapr.c                  |   21 +-
 hw/ppc/spapr_cpu_core.c         |   11 +-
 hw/ppc/spapr_events.c           |    4 +-
 hw/ppc/spapr_hcall.c            |   21 +-
 hw/ppc/spapr_pci.c              |  106 ++-
 hw/vfio/spapr.c                 |    2 +-
 include/hw/pci/pci_ids.h        |    1 +
 include/hw/ppc/spapr_ovec.h     |    3 +-
 target/ppc/kvm.c                |    2 +-
 15 files changed, 1580 insertions(+), 98 deletions(-)
 create mode 100644 hw/net/sungem.c
