Received: from eggs.gnu.org ([2001:4830:134:3::10]:44816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXpKm-0001hI-0B
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXpKl-00089O-8N
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:48:12 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Wed, 19 Jul 2017 09:39:53 -0400
Message-Id: <1500471597-2517-1-git-send-email-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] ARM: KVM: Enable in-kernel PMU with
 user space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, agraf@suse.de, cdall@linaro.org

v2:
 - renamed the kvm pmu 'create' function to 'set_irq' after doing the
   create/set-irq split
 - added another patch that improves the error handling of the kvm pmu
   init and set-irq calls

Andrew Jones (4):
  hw/arm/virt: add pmu interrupt state
  target/arm/kvm: pmu: split init and set-irq stages
  hw/arm/virt: allow pmu instantiation with userspace irqchip
  target/arm/kvm: pmu: improve error handling

 hw/arm/virt.c        | 12 ++++++++--
 target/arm/cpu.c     |  2 ++
 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     |  6 ++++-
 target/arm/kvm32.c   |  7 +++++-
 target/arm/kvm64.c   | 63 ++++++++++++++++++++++++++++++----------------------
 target/arm/kvm_arm.h |  9 ++++----
 7 files changed, 65 insertions(+), 36 deletions(-)

-- 
1.8.3.1
