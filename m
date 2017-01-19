Received: from eggs.gnu.org ([2001:4830:134:3::10]:47411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0000xA-W9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPo-000590-6z
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPn-00051T-V4
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:12 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPj-0003C8-6j
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:43 +0000
Message-Id: <1484834995-26826-25-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/36] hw/intc/gicv3: Add defines for ICH system
 register fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add defines to gicv3_internal.h for fields in the ICH_*
system registers which form the GIC virtualization control
interface.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1483977924-14522-7-git-send-email-peter.maydell@linaro.org
---
 hw/intc/gicv3_internal.h | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 8f3567e..aeb801d 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -159,6 +159,85 @@
 #define ICC_CTLR_EL3_A3V (1U << 15)
 #define ICC_CTLR_EL3_NDS (1U << 17)
 
+#define ICH_VMCR_EL2_VENG0_SHIFT 0
+#define ICH_VMCR_EL2_VENG0 (1U << ICH_VMCR_EL2_VENG0_SHIFT)
+#define ICH_VMCR_EL2_VENG1_SHIFT 1
+#define ICH_VMCR_EL2_VENG1 (1U << ICH_VMCR_EL2_VENG1_SHIFT)
+#define ICH_VMCR_EL2_VACKCTL (1U << 2)
+#define ICH_VMCR_EL2_VFIQEN (1U << 3)
+#define ICH_VMCR_EL2_VCBPR_SHIFT 4
+#define ICH_VMCR_EL2_VCBPR (1U << ICH_VMCR_EL2_VCBPR_SHIFT)
+#define ICH_VMCR_EL2_VEOIM_SHIFT 9
+#define ICH_VMCR_EL2_VEOIM (1U << ICH_VMCR_EL2_VEOIM_SHIFT)
+#define ICH_VMCR_EL2_VBPR1_SHIFT 18
+#define ICH_VMCR_EL2_VBPR1_LENGTH 3
+#define ICH_VMCR_EL2_VBPR1_MASK (0x7U << ICH_VMCR_EL2_VBPR1_SHIFT)
+#define ICH_VMCR_EL2_VBPR0_SHIFT 21
+#define ICH_VMCR_EL2_VBPR0_LENGTH 3
+#define ICH_VMCR_EL2_VBPR0_MASK (0x7U << ICH_VMCR_EL2_VBPR0_SHIFT)
+#define ICH_VMCR_EL2_VPMR_SHIFT 24
+#define ICH_VMCR_EL2_VPMR_LENGTH 8
+#define ICH_VMCR_EL2_VPMR_MASK (0xffU << ICH_VMCR_EL2_VPMR_SHIFT)
+
+#define ICH_HCR_EL2_EN (1U << 0)
+#define ICH_HCR_EL2_UIE (1U << 1)
+#define ICH_HCR_EL2_LRENPIE (1U << 2)
+#define ICH_HCR_EL2_NPIE (1U << 3)
+#define ICH_HCR_EL2_VGRP0EIE (1U << 4)
+#define ICH_HCR_EL2_VGRP0DIE (1U << 5)
+#define ICH_HCR_EL2_VGRP1EIE (1U << 6)
+#define ICH_HCR_EL2_VGRP1DIE (1U << 7)
+#define ICH_HCR_EL2_TC (1U << 10)
+#define ICH_HCR_EL2_TALL0 (1U << 11)
+#define ICH_HCR_EL2_TALL1 (1U << 12)
+#define ICH_HCR_EL2_TSEI (1U << 13)
+#define ICH_HCR_EL2_TDIR (1U << 14)
+#define ICH_HCR_EL2_EOICOUNT_SHIFT 27
+#define ICH_HCR_EL2_EOICOUNT_LENGTH 5
+#define ICH_HCR_EL2_EOICOUNT_MASK (0x1fU << ICH_HCR_EL2_EOICOUNT_SHIFT)
+
+#define ICH_LR_EL2_VINTID_SHIFT 0
+#define ICH_LR_EL2_VINTID_LENGTH 32
+#define ICH_LR_EL2_VINTID_MASK (0xffffffffULL << ICH_LR_EL2_VINTID_SHIFT)
+#define ICH_LR_EL2_PINTID_SHIFT 32
+#define ICH_LR_EL2_PINTID_LENGTH 10
+#define ICH_LR_EL2_PINTID_MASK (0x3ffULL << ICH_LR_EL2_PINTID_SHIFT)
+/* Note that EOI shares with the top bit of the pINTID field */
+#define ICH_LR_EL2_EOI (1ULL << 41)
+#define ICH_LR_EL2_PRIORITY_SHIFT 48
+#define ICH_LR_EL2_PRIORITY_LENGTH 8
+#define ICH_LR_EL2_PRIORITY_MASK (0xffULL << ICH_LR_EL2_PRIORITY_SHIFT)
+#define ICH_LR_EL2_GROUP (1ULL << 60)
+#define ICH_LR_EL2_HW (1ULL << 61)
+#define ICH_LR_EL2_STATE_SHIFT 62
+#define ICH_LR_EL2_STATE_LENGTH 2
+#define ICH_LR_EL2_STATE_MASK (3ULL << ICH_LR_EL2_STATE_SHIFT)
+/* values for the state field: */
+#define ICH_LR_EL2_STATE_INVALID 0
+#define ICH_LR_EL2_STATE_PENDING 1
+#define ICH_LR_EL2_STATE_ACTIVE 2
+#define ICH_LR_EL2_STATE_ACTIVE_PENDING 3
+#define ICH_LR_EL2_STATE_PENDING_BIT (1ULL << ICH_LR_EL2_STATE_SHIFT)
+#define ICH_LR_EL2_STATE_ACTIVE_BIT (2ULL << ICH_LR_EL2_STATE_SHIFT)
+
+#define ICH_MISR_EL2_EOI (1U << 0)
+#define ICH_MISR_EL2_U (1U << 1)
+#define ICH_MISR_EL2_LRENP (1U << 2)
+#define ICH_MISR_EL2_NP (1U << 3)
+#define ICH_MISR_EL2_VGRP0E (1U << 4)
+#define ICH_MISR_EL2_VGRP0D (1U << 5)
+#define ICH_MISR_EL2_VGRP1E (1U << 6)
+#define ICH_MISR_EL2_VGRP1D (1U << 7)
+
+#define ICH_VTR_EL2_LISTREGS_SHIFT 0
+#define ICH_VTR_EL2_TDS (1U << 19)
+#define ICH_VTR_EL2_NV4 (1U << 20)
+#define ICH_VTR_EL2_A3V (1U << 21)
+#define ICH_VTR_EL2_SEIS (1U << 22)
+#define ICH_VTR_EL2_IDBITS_SHIFT 23
+#define ICH_VTR_EL2_PREBITS_SHIFT 26
+#define ICH_VTR_EL2_PRIBITS_SHIFT 29
+
 /* Special interrupt IDs */
 #define INTID_SECURE 1020
 #define INTID_NONSECURE 1021
-- 
2.7.4
