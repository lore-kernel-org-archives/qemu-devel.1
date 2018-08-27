Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fuH6q-0003EV-Bd
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fuGqG-0002lB-8E
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:42:00 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Mon, 27 Aug 2018 16:46:15 -0400
Message-ID: <1535402777-46620-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 0/2] add support for VCPU event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: gengdongjiu@huawei.com

Support for KVM_GET/SET_VCPU_EVENTS to get/set the SError exception
state, and support the state migration.

Now the VCPU event only includes the SError exception status, it can be
extended if needed. When do migration, If source machine has serror pending, 
the target machine is also needed to pend this serror regardless of whether
target machine can support to set the serror syndrome. 

Dongjiu Geng (2):
  linux-headers: Update to kernel mainline commit 815f0ddb3
  target: arm: Add support for VCPU event states

 include/standard-headers/linux/input.h |  9 +++--
 linux-headers/asm-arm/kvm.h            | 13 +++++++
 linux-headers/asm-arm64/kvm.h          | 13 +++++++
 linux-headers/linux/kvm.h              |  1 +
 target/arm/cpu.h                       |  7 ++++
 target/arm/kvm64.c                     | 68 ++++++++++++++++++++++++++++++++++
 target/arm/machine.c                   | 22 +++++++++++
 7 files changed, 129 insertions(+), 4 deletions(-)

-- 
1.8.3.1
