Received: from eggs.gnu.org ([2001:4830:134:3::10]:51039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb5-0007Fg-A2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb1-0004bI-0m
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 23 Aug 2017 10:32:10 +1000
Message-Id: <20170823003217.6769-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/7] ppc-for-2.10 queue 20170823
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, mdroth@linux.vnet.ibm.com, cohuck@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 1f296733876434118fd766cfef5eb6f29ecab6a8:

  Update version for v2.10.0-rc3 release (2017-08-15 18:53:31 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170823

for you to fetch changes up to 1f98e55385d11da1dc0de6440e66f19d191d2a1b:

  hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" device (2017-08-22 21:26:46 +1000)

----------------------------------------------------------------
ppc patch queue 2017-08-23

This is identical to the pull request from yesterday (20180822),
except that a bug in one patch is fixed so that it doesn't break TCG
on a ppc host.

Last minute ppc related fixes for qemu-2.10.  I'm not sure if these
are critical enough to prompt another rc, but I'm submitting them for
consideration.

First, is Cornelia's fix for 480bc11e6 which meant "make check" would
always fail on a ppc host.  Tracking that down delayed submission of
the rest of these patches, sorry.

The rest are all fairly important bugfixes for qemu crashes or guest
behaviour regression on ppc.  Patches 2-4 specifically are fixes for
regressions from qemu-2.9, caused by the compatibility mode and
hotplug handling cleanups for the pseries machine type.

----------------------------------------------------------------
Bharata B Rao (1):
      spapr: Allow configure-connector to be called multiple times

Cornelia Huck (1):
      boot-serial-test: prefer tcg accelerator

Daniel Henrique Barboza (1):
      target/ppc: 'PVR != host PVR' in KVM_SET_SREGS workaround

Greg Kurz (1):
      ppc: fix ppc_set_compat() with KVM PR

Thomas Huth (3):
      hw/ppc/spapr: Fix segfault when instantiating a 'pc-dimm' without 'memdev'
      hw/ppc/spapr_rtc: Mark the RTC device with user_creatable = false
      hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" device

 hw/i386/pc.c             | 14 ++++++++++++--
 hw/mem/nvdimm.c          |  2 +-
 hw/mem/pc-dimm.c         | 14 +++++++++++---
 hw/ppc/spapr.c           | 42 ++++++++++++++++++++++++++++++------------
 hw/ppc/spapr_drc.c       | 30 +++++++++++++++++++++++-------
 hw/ppc/spapr_iommu.c     |  2 ++
 hw/ppc/spapr_rtc.c       |  2 ++
 include/hw/mem/pc-dimm.h |  2 +-
 target/ppc/compat.c      |  9 +++++----
 target/ppc/kvm.c         | 38 ++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h     |  1 +
 target/ppc/machine.c     | 22 ++++++++++++++++++++++
 tests/boot-serial-test.c |  6 +++++-
 13 files changed, 153 insertions(+), 31 deletions(-)
