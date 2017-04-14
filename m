Received: from eggs.gnu.org ([2001:4830:134:3::10]:43625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cz0ck-0001pR-6P
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 08:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cz0cj-00026p-1k
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 08:46:50 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 14 Apr 2017 14:46:32 +0200
Message-Id: <1492173995-14140-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
References: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 1/4] linux-headers: Update for vITS
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, christoffer.dall@linaro.org, quintela@redhat.com, dgilbert@redhat.com

This is a linux header update against 4.11-rc6 plus the non
upstreamed ITS migration series.

https://github.com/eauger/linux/tree/v4.11-rc6-its-mig-v5

It aims at enhancing the KVM user API with vITS save/restore
capability. Those are new attributes supported in the
ITS and GICv3 KVM device KVM_DEV_ARM_VGIC_GRP_CTRL groups.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 linux-headers/asm-arm/kvm.h   | 6 +++++-
 linux-headers/asm-arm64/kvm.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 1101d55..ca7b5bf 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -192,13 +192,17 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
 #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
+#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS	8
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK 0x3ff
 #define VGIC_LEVEL_INFO_LINE_LEVEL	0
 
-#define   KVM_DEV_ARM_VGIC_CTRL_INIT    0
+#define   KVM_DEV_ARM_VGIC_CTRL_INIT		0
+#define   KVM_DEV_ARM_ITS_SAVE_TABLES		1
+#define   KVM_DEV_ARM_ITS_RESTORE_TABLES	2
+#define   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES	3
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 651ec30..d1a9046 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -212,13 +212,17 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
 #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
+#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS 8
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK	0x3ff
 #define VGIC_LEVEL_INFO_LINE_LEVEL	0
 
-#define   KVM_DEV_ARM_VGIC_CTRL_INIT	0
+#define   KVM_DEV_ARM_VGIC_CTRL_INIT		0
+#define   KVM_DEV_ARM_ITS_SAVE_TABLES           1
+#define   KVM_DEV_ARM_ITS_RESTORE_TABLES        2
+#define   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES	3
 
 /* Device Control API on vcpu fd */
 #define KVM_ARM_VCPU_PMU_V3_CTRL	0
-- 
2.5.5
