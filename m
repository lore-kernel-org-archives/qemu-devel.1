Received: from eggs.gnu.org ([2001:4830:134:3::10]:40536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxK-0002IG-Mn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxH-0007S0-Hm
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:26 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:00 +1000
Message-Id: <20170711043917.1757-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/17] ppc-for-2.10 queue 20170711
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296f3=
3d:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-v2=
' into staging (2017-07-10 16:12:47 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170711

for you to fetch changes up to b87680427e8a3ff682f66514e99a8344e7437247:

  spapr: populate device tree depending on XIVE_EXPLOIT option (2017-07-1=
1 11:04:02 +1000)

----------------------------------------------------------------
ppc patch queue 2017-07-11

  * Several minor cleanups from Greg Kurz
  * Fix for migration of pseries-2.7 and earlier machine types
  * More reworking of the DRC hotplug code, fixing several problems
    though there are still more to go
  * Fixes for CPU family / alias handling on POWER9
  * Preliminary patches for POWER9 XIVE (new interrupt controller)
    support
  * Assorted other fixes

----------------------------------------------------------------
Aaron Larson (1):
      target-ppc: SPR_BOOKE_ESR not set on FP exceptions

C=C3=A9dric Le Goater (2):
      spapr: introduce the XIVE_EXPLOIT option in CAS
      spapr: populate device tree depending on XIVE_EXPLOIT option

David Gibson (6):
      spapr: Leave DR-indicator management to the guest
      spapr: Uniform DRC reset paths
      spapr: Add DRC release method
      spapr: Remove unnecessary differences between hotplug and coldplug =
paths
      spapr: Use unplug_request for PCI hot unplug
      spapr: Only report host/guest IOMMU page size mismatches on KVM

Greg Kurz (5):
      spapr: make spapr_populate_hotplug_cpu_dt() static
      spapr: refresh "platform-specific" hcalls comment
      spapr: fix bogus function name in comment
      spapr: fix memory hotplug error path
      ppc/kvm: have the "family" CPU alias to point to TYPE_HOST_POWERPC_=
CPU

Laurent Vivier (1):
      spapr: fix migration to pseries machine < 2.8

Suraj Jitindar Singh (2):
      target/ppc: Refactor tcg radix mmu code
      target/ppc: Add debug function for radix mmu translation

 hw/ppc/spapr.c              | 95 ++++++++++++++++++++-------------------=
------
 hw/ppc/spapr_drc.c          | 37 ++++++------------
 hw/ppc/spapr_pci.c          | 47 +++++++++++-----------
 include/hw/ppc/spapr.h      |  7 +---
 include/hw/ppc/spapr_drc.h  |  3 +-
 include/hw/ppc/spapr_ovec.h |  1 +
 target/ppc/excp_helper.c    |  1 +
 target/ppc/kvm.c            |  5 ++-
 target/ppc/mmu-radix64.c    | 67 +++++++++++++++++++++++++-------
 target/ppc/mmu-radix64.h    |  1 +
 target/ppc/mmu_helper.c     |  3 +-
 11 files changed, 145 insertions(+), 122 deletions(-)
