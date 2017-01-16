Received: from eggs.gnu.org ([2001:4830:134:3::10]:48963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3cW-0003l2-1p
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3cR-0002Sx-9G
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:30:32 -0500
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Mon, 16 Jan 2017 17:26:55 +0800
Message-ID: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 0/6] target-arm: KVM64: Cross type vCPU
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com, christoffer.dall@linaro.org, kvmarm@lists.cs.columbia.edu, zhaoshenglong@huawei.com, wu.wubin@huawei.com

From: Shannon Zhao <shannon.zhao@linaro.org>

This patch set support use cross type vCPU when using KVM on ARM and add
two new CPU types: generic and cortex-a72.

You can test this patch set with QEMU using
-cpu cortex-a53/cortex-a57/generic/cortex-a72

These patches can be fetched from:
https://git.linaro.org/people/shannon.zhao/qemu.git cross_vcpu_rfc

You corresponding KVM patches can be fetched from:
https://git.linaro.org/people/shannon.zhao/linux-mainline.git cross_vcpu_rfc

Shannon Zhao (6):
  headers: update linux headers
  target: arm: Add the qemu target for KVM_ARM_TARGET_GENERIC_V8
  arm: kvm64: Check if kvm supports cross type vCPU
  target: arm: Add a generic type cpu
  arm: virt: Enable generic type CPU in virt machine
  target-arm: cpu64: Add support for Cortex-A72

 hw/arm/virt.c                 |   2 +
 linux-headers/asm-arm64/kvm.h |   1 +
 linux-headers/linux/kvm.h     |   2 +
 target/arm/cpu64.c            | 110 +++++++++++++++++++++++++
 target/arm/kvm-consts.h       |   2 +
 target/arm/kvm64.c            | 182 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 299 insertions(+)

-- 
2.0.4
