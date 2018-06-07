Received: from eggs.gnu.org ([2001:4830:134:3::10]:43030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fQtzH-0003BL-1S
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fQtzG-0005qV-8i
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:25:55 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Fri, 8 Jun 2018 04:30:58 +0800
Message-ID: <1528403460-30526-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 RFC 0/2] add support for VCPU event states
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

change since v2:
1. add header definition for arm platform

change since v1:
1. update the code to fix the build errors

Dongjiu Geng (2):
  linux-headers: sync linux headers
  target: arm: Add support for VCPU event states

 linux-headers/asm-arm/kvm.h   | 12 ++++++++
 linux-headers/asm-arm64/kvm.h | 13 +++++++++
 linux-headers/linux/kvm.h     |  1 +
 target/arm/cpu.h              |  5 ++++
 target/arm/kvm64.c            | 64 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/machine.c          |  3 ++
 6 files changed, 98 insertions(+)

-- 
1.8.3.1
