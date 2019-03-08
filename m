Received: from eggs.gnu.org ([209.51.188.92]:45604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1h2CDS-0000wl-CT
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1h2CDR-0006VE-4k
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:54:58 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:49532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1h2CDQ-0006U3-7T
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:54:57 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri,  8 Mar 2019 10:54:32 +0100
Message-Id: <20190308095433.12116-2-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190308095433.12116-1-kbastian@mail.uni-paderborn.de>
References: <20190308095433.12116-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] tricore: fixed RCR_CADD instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david.brenken@efs-auto.de, christian.richter@efs-auto.de, georg.hofstetter@efs-auto.de, robert.rasche@efs-auto.de, lars.biermanski@efs-auto.de

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: Christian Richter <christian.richter@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>

Message-Id: <20190207073928.4048-2-david.brenken@efs-auto.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 14f0ddfa1e..5846f95316 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -5867,8 +5867,8 @@ static void decode_rcr_cond_select(CPUTriCoreState *env, DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RCR_CADD:
-        gen_condi_add(TCG_COND_NE, cpu_gpr_d[r1], const9, cpu_gpr_d[r3],
-                      cpu_gpr_d[r4]);
+        gen_condi_add(TCG_COND_NE, cpu_gpr_d[r1], const9, cpu_gpr_d[r4],
+                      cpu_gpr_d[r3]);
         break;
     case OPC2_32_RCR_CADDN:
         gen_condi_add(TCG_COND_EQ, cpu_gpr_d[r1], const9, cpu_gpr_d[r3],
-- 
2.21.0
