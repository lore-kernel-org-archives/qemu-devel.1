Received: from eggs.gnu.org ([2001:4830:134:3::10]:36413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbzb-000888-Tu
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbzY-0007hN-Mi
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:13:43 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbzY-0007aR-Ci
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:13:40 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:10 +0100
Message-ID: <20180620120620.12806-26-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 25/35] target/mips: Config3.ISAOnExc is read
 only in nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Yongbok Kim <yongbok.kim@imgtec.com>

Config3.ISAOnExc is read only in nanoMIPS

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/op_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 102a039..9946f77 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1734,7 +1734,8 @@ void helper_mtc0_config2(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_config3(CPUMIPSState *env, target_ulong arg1)
 {
-    if (env->insn_flags & ASE_MICROMIPS) {
+    if ((env->insn_flags & ASE_MICROMIPS) &&
+        !(env->insn_flags & ISA_NANOMIPS32)) {
         env->CP0_Config3 = (env->CP0_Config3 & ~(1 << CP0C3_ISA_ON_EXC)) |
                            (arg1 & (1 << CP0C3_ISA_ON_EXC));
     }
-- 
1.9.1
