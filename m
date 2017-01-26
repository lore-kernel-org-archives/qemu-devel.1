Received: from eggs.gnu.org ([2001:4830:134:3::10]:34198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWgEA-0004Jm-Vr
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWgEA-0003ui-7O
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:20:23 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 26 Jan 2017 10:19:39 +0100
Message-Id: <1485422381-29019-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 2/4] hw/intc/arm_gicv3_kvm: Rename
 KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, shannon.zhao@linaro.org
Cc: christoffer.dall@linaro.org, drjones@redhat.com, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com

Rename KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS into KVM_DEV_ARM_VGIC_CPU_SYSREGS
as exposed in the kernel user API and pulled by update-linux-headers.sh.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

KVM_DEV_ARM_VGIC_CPU_SYSREGS may be fixed at kernel level instead
---
 hw/intc/arm_gicv3_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 267c2d6..d8ecbc3 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -108,7 +108,7 @@ static inline void kvm_gicr_access(GICv3State *s, int offset, int cpu,
 static inline void kvm_gicc_access(GICv3State *s, uint64_t reg, int cpu,
                                    uint64_t *val, bool write)
 {
-    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_CPU_SYSREGS,
                       KVM_VGIC_ATTR(reg, s->cpu[cpu].gicr_typer),
                       val, write);
 }
-- 
2.5.5
