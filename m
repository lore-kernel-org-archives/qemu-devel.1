Received: from eggs.gnu.org ([2001:4830:134:3::10]:47281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fYT3u-0005vl-Sq
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fYT3t-0006Fe-Vu
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:17:58 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Fri, 29 Jun 2018 01:22:39 +0800
Message-ID: <1530206561-22348-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 RFC 0/2] add support for VCPU event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, james.morse@arm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, zhengxiang9@huawei.com, gengdongjiu@huawei.com, linuxarm@huawei.com

Support for KVM_GET/SET_VCPU_EVENTS to get/set the SError exception
state, and support the state migration.

change since v3:
1. Add a new new subsection with a suitable 'ras_needed' function
controlling whether it is present
2. Add a ARM_FEATURE_RAS feature bit for CPUARMState

change since v2:
1. add header definition for arm platform

change since v1:
1. update the code to fix the build errors


The corresponding kernel patch is here:
https://lkml.org/lkml/2018/6/25/374

Dongjiu Geng (2):
  linux-headers: sync linux header
  target: arm: Add support for VCPU event states

 linux-headers/asm-arm64/kvm.h | 13 ++++++++++
 linux-headers/linux/kvm.h     |  1 +
 target/arm/cpu.h              |  6 +++++
 target/arm/kvm64.c            | 59 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/machine.c          | 22 ++++++++++++++++
 5 files changed, 101 insertions(+)

-- 
1.8.3.1
