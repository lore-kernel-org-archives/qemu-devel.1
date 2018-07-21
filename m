Received: from eggs.gnu.org ([2001:4830:134:3::10]:34787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fgoe3-0001SI-MB
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 05:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fgoe2-0001aH-MU
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 05:57:47 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sat, 21 Jul 2018 14:02:39 -0400
Message-ID: <1532196162-29453-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 0/3] add support for VCPU event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: gengdongjiu@huawei.com, linuxarm@huawei.com

Support for KVM_GET/SET_VCPU_EVENTS to get/set the SError exception
state, and support the state migration.

change since v4:
1. update the linux header files to 4.18-rc5 

change since v3:
1. Add a new new subsection with a suitable 'ras_needed' function
controlling whether it is present
2. Add a ARM_FEATURE_RAS feature bit for CPUARMState

change since v2:
1. add header definition for arm platform

change since v1:
1. update the code to fix the build errors

The related kernel change has been already applied to kvmarm/next.
(https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/log/?h=next)

Dongjiu Geng (3):
  Update Linux headers to 4.18-rc5
  kvm: sync linux headers
  target: arm: Add support for VCPU event states

 include/standard-headers/linux/virtio_config.h | 16 +++++--
 linux-headers/asm-arm/kvm.h                    | 13 ++++++
 linux-headers/asm-arm64/kvm.h                  | 13 ++++++
 linux-headers/asm-mips/unistd.h                | 18 +++++---
 linux-headers/asm-powerpc/kvm.h                |  1 +
 linux-headers/asm-powerpc/unistd.h             |  1 +
 linux-headers/asm-s390/unistd_32.h             |  2 +
 linux-headers/asm-s390/unistd_64.h             |  2 +
 linux-headers/linux/kvm.h                      |  1 +
 target/arm/cpu.h                               |  6 +++
 target/arm/kvm64.c                             | 59 ++++++++++++++++++++++++++
 target/arm/machine.c                           | 22 ++++++++++
 12 files changed, 144 insertions(+), 10 deletions(-)

-- 
1.8.3.1
