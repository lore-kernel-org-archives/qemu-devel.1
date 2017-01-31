Received: from eggs.gnu.org ([2001:4830:134:3::10]:46156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cYbDJ-0001Do-Kp
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cYbDI-0001Gf-Ql
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:25 -0500
From: vijay.kilari@gmail.com
Date: Tue, 31 Jan 2017 21:52:59 +0530
Message-Id: <1485879782-6075-3-git-send-email-vijay.kilari@gmail.com>
In-Reply-To: <1485879782-6075-1-git-send-email-vijay.kilari@gmail.com>
References: <1485879782-6075-1-git-send-email-vijay.kilari@gmail.com>
Subject: [Qemu-devel] [PATCH v7 RESEND 2/5] hw/intc/arm_gicv3_kvm: Add
 ICC_SRE_EL1 register to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org, eric.auger@redhat.com
Cc: p.fedin@samsung.com, marc.zyngier@arm.com, qemu-devel@nongnu.org, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

To Save and Restore ICC_SRE_EL1 register Add ICC_SRE_EL1 register
to vmstate and GICv3CPUState struct.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
---
 hw/intc/arm_gicv3_common.c         | 1 +
 include/hw/intc/arm_gicv3_common.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 0f8c4b8..f3245d9 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -68,6 +68,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
         VMSTATE_UINT32(gicr_igrpmodr0, GICv3CPUState),
         VMSTATE_UINT32(gicr_nsacr, GICv3CPUState),
         VMSTATE_UINT8_ARRAY(gicr_ipriorityr, GICv3CPUState, GIC_INTERNAL),
+        VMSTATE_UINT64(icc_sre_el1, GICv3CPUState),
         VMSTATE_UINT64_ARRAY(icc_ctlr_el1, GICv3CPUState, 2),
         VMSTATE_UINT64(icc_pmr_el1, GICv3CPUState),
         VMSTATE_UINT64_ARRAY(icc_bpr, GICv3CPUState, 3),
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 341a311..183c7f8 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -166,6 +166,7 @@ struct GICv3CPUState {
     uint8_t gicr_ipriorityr[GIC_INTERNAL];
 
     /* CPU interface */
+    uint64_t icc_sre_el1;
     uint64_t icc_ctlr_el1[2];
     uint64_t icc_pmr_el1;
     uint64_t icc_bpr[3];
-- 
1.9.1
