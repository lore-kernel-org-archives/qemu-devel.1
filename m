Received: from eggs.gnu.org ([2001:4830:134:3::10]:36038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gAUGy-0002ve-PD
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 02:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gAUGw-00066a-7A
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 02:16:36 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 11 Oct 2018 17:16:07 +1100
Message-Id: <20181011061609.11423-2-sjitindarsingh@gmail.com>
In-Reply-To: <20181011061609.11423-1-sjitindarsingh@gmail.com>
References: <20181011061609.11423-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 1/3] target/ppc: Update
 linux-headers for v4.19-rc7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, david@gibson.dropbear.id.au, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 linux-headers/asm-powerpc/kvm.h | 1 +
 linux-headers/linux/kvm.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 1b32b56a03..8c876c166e 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -634,6 +634,7 @@ struct kvm_ppc_cpu_char {
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
 #define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
+#define KVM_REG_PPC_PTCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc0)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 66790724f1..d49767ad25 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -951,6 +951,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_TLBFLUSH 155
 #define KVM_CAP_S390_HPAGE_1M 156
 #define KVM_CAP_NESTED_STATE 157
+#define KVM_CAP_PPC_NESTED_HV 160
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.13.6
