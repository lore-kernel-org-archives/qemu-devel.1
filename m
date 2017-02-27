Received: from eggs.gnu.org ([2001:4830:134:3::10]:41476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ciPEb-0001Sz-Br
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ciPEa-0000dY-LT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:37:17 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon, 27 Feb 2017 18:37:05 +0100
Message-Id: <20170227173706.15210-2-drjones@redhat.com>
In-Reply-To: <20170227173706.15210-1-drjones@redhat.com>
References: <20170227173706.15210-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] HACK: update linux/kvm header
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

---
 linux-headers/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index bb0ed712232d..38e636c85886 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -870,6 +870,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_ARM_USER_MPIDR 137
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.9.3
