Received: from eggs.gnu.org ([2001:4830:134:3::10]:46554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fQBNR-0007Of-Ri
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fQBNQ-0003Ey-NI
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:47:53 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Wed, 6 Jun 2018 04:52:47 +0800
Message-ID: <1528231969-19584-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/2] add support for VCPU event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, james.morse@arm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, gengdongjiu@huawei.com, linuxarm@huawei.com

support for KVM_GET/SET_VCPU_EVENTS to get/set the SError exception
state, and support the state migration.

change since v1:
1. update the code to fix the build errors

Dongjiu Geng (2):
  kvm: sync linux headers
  target: arm: Add support for VCPU event states

 linux-headers/asm-arm64/kvm.h | 13 +++++++++
 linux-headers/linux/kvm.h     |  1 +
 target/arm/cpu.h              |  5 ++++
 target/arm/kvm64.c            | 64 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/machine.c          |  3 ++
 5 files changed, 86 insertions(+)

-- 
2.7.4
