Received: from eggs.gnu.org ([209.51.188.92]:53728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKn-0007hC-65
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKm-0004c6-Cm
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:09 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKm-0004bY-3i
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:08 -0500
Received: by mail-wr1-x430.google.com with SMTP id x10so7687752wrs.8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:37 +0000
Message-Id: <20190214190603.25030-2-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/27] target/arm: Fix CRn to be 14 for
 PMEVTYPER/PMEVCNTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay OS <aaron@os.amperecomputing.com>

This bug was introduced in:
    commit 5ecdd3e47cadae83a62dc92b472f1fe163b56f59
    target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190205135129.19338-1-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 520ceea7a41..bd9f6050eca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5855,25 +5855,25 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
             char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
             ARMCPRegInfo pmev_regs[] = {
-                { .name = pmevcntr_name, .cp = 15, .crn = 15,
+                { .name = pmevcntr_name, .cp = 15, .crn = 14,
                   .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
                   .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
                   .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
                   .accessfn = pmreg_access },
                 { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
-                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 8 | (3 & (i >> 3)),
+                  .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 8 | (3 & (i >> 3)),
                   .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
                   .type = ARM_CP_IO,
                   .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
                   .raw_readfn = pmevcntr_rawread,
                   .raw_writefn = pmevcntr_rawwrite },
-                { .name = pmevtyper_name, .cp = 15, .crn = 15,
+                { .name = pmevtyper_name, .cp = 15, .crn = 14,
                   .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
                   .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
                   .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
                   .accessfn = pmreg_access },
                 { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
-                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 12 | (3 & (i >> 3)),
+                  .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 12 | (3 & (i >> 3)),
                   .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
                   .type = ARM_CP_IO,
                   .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
-- 
2.20.1
