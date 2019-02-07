Received: from eggs.gnu.org ([209.51.188.92]:35134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1greHq-0002Ph-KU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1greHo-0008Np-MM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:39:54 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:47511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1greHm-0008JN-BV
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:39:52 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Thu,  7 Feb 2019 08:39:28 +0100
Message-Id: <20190207073928.4048-3-david.brenken@efs-auto.org>
In-Reply-To: <20190207073928.4048-1-david.brenken@efs-auto.org>
References: <20190207073928.4048-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH 2/2] tricore: fixed RCR_CADDN instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>, Christian Richter <christian.richter@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>, Robert Rasche <robert.rasche@efs-auto.de>, Lars Biermanski <lars.biermanski@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: Christian Richter <christian.richter@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>

---
 target/tricore/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 0511756..fce0595 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -5871,8 +5871,8 @@ static void decode_rcr_cond_select(CPUTriCoreState *env, DisasContext *ctx)
                       cpu_gpr_d[r3]);
         break;
     case OPC2_32_RCR_CADDN:
-        gen_condi_add(TCG_COND_EQ, cpu_gpr_d[r1], const9, cpu_gpr_d[r3],
-                      cpu_gpr_d[r4]);
+        gen_condi_add(TCG_COND_EQ, cpu_gpr_d[r1], const9, cpu_gpr_d[r4],
+                      cpu_gpr_d[r3]);
         break;
     case OPC2_32_RCR_SEL:
         temp = tcg_const_i32(0);
-- 
2.7.4
