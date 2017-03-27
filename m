Received: from eggs.gnu.org ([2001:4830:134:3::10]:55130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1csRGp-0006MB-Sh
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1csRGp-0007Z7-04
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:49:03 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 27 Mar 2017 11:48:44 +0200
Message-Id: <1490608126-22187-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1490608126-22187-1-git-send-email-eric.auger@redhat.com>
References: <1490608126-22187-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 1/3] linux-headers: Partial header update for
 vITS save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org

This is a linux header update against 4.11-rc3 plus the non
upstreamed ITS migration series.

https://github.com/eauger/linux/tree/v4.11-rc3-its-mig-v4

It aims at enhancing the KVM user API with vITS save/restore
capability. This consists in two new groups for the
ARM_VGIC_ITS KVM device, named: KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
KVM_DEV_ARM_VGIC_GRP_ITS_TABLES.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 linux-headers/asm-arm/kvm.h   | 2 ++
 linux-headers/asm-arm64/kvm.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 1101d55..c8b9a68 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -192,6 +192,8 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
 #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
+#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS	8
+#define KVM_DEV_ARM_VGIC_GRP_ITS_TABLES	9
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 651ec30..a8d7d67 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -212,6 +212,8 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
 #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
+#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS 8
+#define KVM_DEV_ARM_VGIC_GRP_ITS_TABLES 9
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
-- 
2.5.5
