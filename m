Received: from eggs.gnu.org ([2001:4830:134:3::10]:41461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ciPEa-0001Rw-Ab
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ciPEZ-0000d7-I4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:37:16 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon, 27 Feb 2017 18:37:04 +0100
Message-Id: <20170227173706.15210-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Enable QEMU to control MPIDR values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, imammedo@redhat.com

Igor needs to know/select vcpu MPIDR values early in order to map vcpus
to vnodes. Waiting until after vcpu init, when KVM sets them, is too
late. With this patch, and its KVM counterpart, QEMU can control the
values, allowing it to know/select them whenever it likes.

Andrew Jones (2):
  HACK: update linux/kvm header
  arm: kvm: set MPIDR when we can

 linux-headers/linux/kvm.h |  1 +
 target/arm/cpu.c          |  3 +--
 target/arm/kvm32.c        | 22 ++++++++++++++--------
 target/arm/kvm64.c        | 22 ++++++++++++++--------
 4 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.9.3
