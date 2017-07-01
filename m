Received: from eggs.gnu.org ([2001:4830:134:3::10]:52798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dRLYM-00084H-V5
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 12:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dRLYM-0000SJ-5N
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 12:47:26 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Sat,  1 Jul 2017 12:47:14 -0400
Message-Id: <1498927637-14496-1-git-send-email-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] ARM: KVM: Enable in-kernel PMU with user
 space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, agraf@suse.de

Andrew Jones (3):
  hw/arm/virt: add pmu interrupt state
  target/arm/kvm: split pmu init from creation
  hw/arm/virt: allow pmu instantiation with userspace irqchip

 hw/arm/virt.c        | 13 +++++++++++--
 target/arm/cpu.c     |  2 ++
 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     |  6 +++++-
 target/arm/kvm32.c   |  6 ++++++
 target/arm/kvm64.c   | 55 +++++++++++++++++++++++++---------------------------
 target/arm/kvm_arm.h |  6 ++++++
 7 files changed, 58 insertions(+), 32 deletions(-)

-- 
1.8.3.1
