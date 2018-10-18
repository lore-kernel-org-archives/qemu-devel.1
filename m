Received: from eggs.gnu.org ([2001:4830:134:3::10]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Km-0005im-So
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Kd-0006hr-Dq
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:31 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 18 Oct 2018 16:30:28 +0200
Message-Id: <20181018143042.29588-3-eric.auger@redhat.com>
In-Reply-To: <20181018143042.29588-1-eric.auger@redhat.com>
References: <20181018143042.29588-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 02/16] linux-headers: header update for
 KVM/ARM KVM_ARM_GET_MAX_VM_PHYS_SHIFT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

This is a header update against kvmarm next branch

git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm kvmarm/next

to get the KVM_ARM_GET_MAX_VM_PHYS_SHIFT ioctl. This allows to retrieve
the IPA address range KVM supports.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- update against kvmarm next
---
 linux-headers/linux/kvm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 83ba4eb571..9647ce4fcb 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -750,6 +750,15 @@ struct kvm_ppc_resize_hpt {
 
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
+/*
+ * On arm64, machine type can be used to request the physical
+ * address size for the VM. Bits[7-0] are reserved for the guest
+ * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
+ * value 0 implies the default IPA size, 40bits.
+ */
+#define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
+#define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
+	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 /*
  * ioctls for /dev/kvm fds:
  */
@@ -953,6 +962,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
 #define KVM_CAP_MSR_PLATFORM_INFO 159
+#define KVM_CAP_ARM_VM_IPA_SIZE 160 /* returns maximum IPA bits for a VM */
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.17.1
