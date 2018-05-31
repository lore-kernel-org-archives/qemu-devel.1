Received: from eggs.gnu.org ([2001:4830:134:3::10]:54731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fOEQH-000321-1s
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fOEQG-0007FX-7V
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:38:45 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Thu, 31 May 2018 19:43:54 +0800
Message-ID: <1527767037-6105-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/3] add support for VCPU event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linuxarm@huawei.com

support for KVM_GET/SET_VCPU_EVENTS to get/set the SError exception
state, and support the state migration.

Dongjiu Geng (3):
  linux-headers: update to v4.17-rc7
  kvm: sync linux headers
  target: arm: Add support for VCPU event states

 include/standard-headers/asm-x86/hyperv.h       |   1 -
 include/standard-headers/asm-x86/kvm_para.h     |   2 +-
 include/standard-headers/linux/ethtool.h        |  36 ++-
 include/standard-headers/linux/input.h          |   4 +-
 include/standard-headers/linux/pci_regs.h       |   7 +-
 include/standard-headers/linux/virtio_balloon.h |  15 +
 include/standard-headers/linux/virtio_gpu.h     |   1 -
 include/standard-headers/rdma/vmw_pvrdma-abi.h  |  49 ++--
 linux-headers/COPYING                           | 358 +-----------------------
 linux-headers/asm-arm/kvm.h                     |  15 +
 linux-headers/asm-arm64/kvm.h                   |  19 ++
 linux-headers/asm-x86/hyperv.h                  |   1 -
 linux-headers/asm-x86/kvm.h                     |  19 +-
 linux-headers/linux/kvm.h                       |  31 +-
 linux-headers/linux/vfio.h                      |  27 ++
 target/arm/cpu.h                                |   5 +
 target/arm/kvm64.c                              |  64 +++++
 target/arm/machine.c                            |   3 +
 18 files changed, 268 insertions(+), 389 deletions(-)
 delete mode 100644 include/standard-headers/asm-x86/hyperv.h
 delete mode 100644 linux-headers/asm-x86/hyperv.h

-- 
2.7.4
