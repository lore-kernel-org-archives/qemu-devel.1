Received: from eggs.gnu.org ([2001:4830:134:3::10]:52688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erYWK-0000Fk-6e
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 19:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erYWH-0000pQ-2w
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 19:25:56 -0500
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com
	([104.47.32.58]:36841
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1erYWG-0000oz-OS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 19:25:52 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 1 Mar 2018 16:20:57 -0800
Message-ID: <e2a29860b0eb2591e16a83178e305828d1b0b730.1519950018.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] target/arm: Fix the A53 L2CTLR typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

The cortex A53 TRM specifices that bits 24 and 25 of the L2CTLR register
specify the number of cores present and not the number of processors. We
have correctly been reporting the number of cores, so just fix the
comment to match the TRM.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 target/arm/cpu64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9743bdc8c3..aac1746efe 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -42,7 +42,7 @@ static inline void unset_feature(CPUARMState *env, int feature)
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    /* Number of processors is in [25:24]; otherwise we RAZ */
+    /* Number of cores is in [25:24]; otherwise we RAZ */
     return (smp_cpus - 1) << 24;
 }
 #endif
-- 
2.14.1
