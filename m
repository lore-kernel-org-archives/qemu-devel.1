Received: from eggs.gnu.org ([2001:4830:134:3::10]:60569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eESz5-0006Li-Jp
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 23:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eESz1-0002qz-Km
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 23:38:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Nov 2017 15:37:45 +1100
Message-Id: <20171114043747.4810-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/2] ppc-for-2.11 queue 20171114
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 4e8a737c092d25fe5ff99ac7bff01c222c1c017d:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20171110-pull-request' into staging (2017-11-13 14:33:29 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171114

for you to fetch changes up to dcb556fc6ad879f7d29fb233a273a1ea3aa0549c:

  xics/kvm: synchonize state before 'info pic' (2017-11-14 11:12:42 +1100)

----------------------------------------------------------------
ppc patch queue for 2017-11-14

Another couple of fixes for qemu-2.11.

----------------------------------------------------------------
Greg Kurz (1):
      xics/kvm: synchonize state before 'info pic'

Sam Bobroff (1):
      target/ppc: correct htab shift for hash on radix

 hw/intc/xics.c        | 11 +++++++++++
 hw/intc/xics_kvm.c    | 19 +++++++++++++++++++
 hw/ppc/spapr_hcall.c  | 13 ++++++-------
 include/hw/ppc/xics.h |  2 ++
 4 files changed, 38 insertions(+), 7 deletions(-)
