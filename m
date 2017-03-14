Received: from eggs.gnu.org ([2001:4830:134:3::10]:48907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2d-0007Rn-3Q
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2c-0007AE-7R
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Mar 2017 15:26:22 +1100
Message-Id: <20170314042626.20020-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/4] ppc-for-2.9 queue 20170314
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, pbonzini@redhat.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 5bac3c39c82e149515c10643acafd1d292433775:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-03-13 15:08:01 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170314

for you to fetch changes up to 28df75d8d1aebdb09a2cc511c0b97690eac0b7a7:

  dtc: Update submodule to avoid build errors (2017-03-14 12:24:29 +1100)

----------------------------------------------------------------
ppc patch queue for 2017-03-14

This set has a handful og bugfixes to go into qemu-2.9.  This includes
an update to the dtc/libfdt submodule which will fix the build errors
seen on some distributions.

----------------------------------------------------------------
David Gibson (2):
      pseries: Don't expose PCIe extended config space on older machine types
      dtc: Update submodule to avoid build errors

Nikunj A Dadhania (1):
      target/ppc: fix cpu_ov setting for 32-bit

Thomas Huth (1):
      target/ppc: Fix wrong number of UAMR register

 dtc                         | 2 +-
 hw/ppc/spapr.c              | 9 +++++++--
 hw/ppc/spapr_pci.c          | 4 +++-
 include/hw/pci-host/spapr.h | 2 ++
 target/ppc/cpu.h            | 2 +-
 target/ppc/translate.c      | 2 +-
 6 files changed, 15 insertions(+), 6 deletions(-)
