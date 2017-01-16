Received: from eggs.gnu.org ([2001:4830:134:3::10]:48835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3c5-0003KU-Ou
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3c1-0002Cs-1R
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:30:05 -0500
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Mon, 16 Jan 2017 17:26:57 +0800
Message-ID: <1484558821-15512-3-git-send-email-zhaoshenglong@huawei.com>
In-Reply-To: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
References: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 2/6] target: arm: Add the qemu target for
 KVM_ARM_TARGET_GENERIC_V8
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

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index a2c9518..fc01ac5 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -128,6 +128,7 @@ MISMATCH_CHECK(QEMU_PSCI_RET_DISABLED, PSCI_RET_DISABLED)
 #define QEMU_KVM_ARM_TARGET_CORTEX_A57 2
 #define QEMU_KVM_ARM_TARGET_XGENE_POTENZA 3
 #define QEMU_KVM_ARM_TARGET_CORTEX_A53 4
+#define QEMU_KVM_ARM_TARGET_GENERIC_V8 5
 
 /* There's no kernel define for this: sentinel value which
  * matches no KVM target value for either 64 or 32 bit
@@ -140,6 +141,7 @@ MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_FOUNDATION_V8, KVM_ARM_TARGET_FOUNDATION_V8)
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A57, KVM_ARM_TARGET_CORTEX_A57)
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_XGENE_POTENZA, KVM_ARM_TARGET_XGENE_POTENZA)
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A53, KVM_ARM_TARGET_CORTEX_A53)
+MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_GENERIC_V8, KVM_ARM_TARGET_GENERIC_V8)
 #else
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A15, KVM_ARM_TARGET_CORTEX_A15)
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A7, KVM_ARM_TARGET_CORTEX_A7)
-- 
2.0.4
