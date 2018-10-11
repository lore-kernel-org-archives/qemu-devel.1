Received: from eggs.gnu.org ([2001:4830:134:3::10]:36035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gAUGy-0002vb-Oy
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 02:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gAUGu-00066A-NT
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 02:16:36 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 11 Oct 2018 17:16:06 +1100
Message-Id: <20181011061609.11423-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 0/3] ppc/spapr: Add support for
 nested kvm-hv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, david@gibson.dropbear.id.au, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This patch series adds the qemu support for running nested kvm-hv on a
POWER9 platform with appropriate hypervisor support and migration of
these guests.
That is, the ability to run kvm-hv guests as guests of an operating system
which is itself a kvm-hv guest.

The host (L0 hypervisor) and level 1 guest (L1 guest hypervisor) require
the following patch series:
KVM: PPC: Book3S HV: Nested HV virtualization

And this patch series in the qemu instance running on the L0 hypervisor.

Patch series based on: ppc-for-3.1

The cap number is now in Paolo's tree so hopefully we can rely on it not
changing.

V2 -> V3:
- The enable cap ioctl no longer takes an enable field to indicate
  disable/enable, but just enables the cap. So update to match this
  kernel change. (The cap starts out disable by default)

Suraj Jitindar Singh (3):
  target/ppc: Update linux-headers for v4.19-rc7
  target/ppc: Add one reg id for ptcr
  ppc/spapr_caps: Add SPAPR_CAP_NESTED_KVM_HV

 hw/ppc/spapr.c                  |  2 ++
 hw/ppc/spapr_caps.c             | 32 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h          |  5 ++++-
 linux-headers/asm-powerpc/kvm.h |  1 +
 linux-headers/linux/kvm.h       |  1 +
 target/ppc/kvm.c                | 12 ++++++++++++
 target/ppc/kvm_ppc.h            | 12 ++++++++++++
 target/ppc/translate_init.inc.c | 10 +++++-----
 8 files changed, 69 insertions(+), 6 deletions(-)

-- 
2.13.6
