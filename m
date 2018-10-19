Received: from eggs.gnu.org ([2001:4830:134:3::10]:57569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDK1m-0006Uv-Ji
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDK1i-0003wE-Gn
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:56:38 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDK1i-0003kU-4R
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:56:34 -0400
Received: by mail-pg1-x541.google.com with SMTP id n31-v6so15052474pgm.7
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 18:56:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Oct 2018 18:56:15 -0700
Message-Id: <20181019015617.22583-2-richard.henderson@linaro.org>
In-Reply-To: <20181019015617.22583-1-richard.henderson@linaro.org>
References: <20181019015617.22583-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/3] target/arm: Remove writefn from
 TTBR0_EL3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The EL3 version of this register does not include an ASID,
and so the tlb_flush performed by vmsa_ttbr_write is not needed.

Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e3946562aa..24bbde4f76 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4214,7 +4214,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.mvbar) },
     { .name = "TTBR0_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL3_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .access = PL3_RW, .resetvalue = 0,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[3]) },
     { .name = "TCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 2,
-- 
2.17.2
