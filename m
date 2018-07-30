Received: from eggs.gnu.org ([2001:4830:134:3::10]:37781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB01-0002fq-GK
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB00-0001eV-6P
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:26:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42584 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAzz-0001e7-V9
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:26:20 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:12:21 +0200
Message-Id: <1532967169-22265-49-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 48/76] target/mips: Adjust behavior of
 Config3's ISAOnExc bit for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Config3.ISAOnExc is read only in nanoMIPS.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/op_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index cb83b6d..5e10286 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1730,7 +1730,8 @@ void helper_mtc0_config2(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_config3(CPUMIPSState *env, target_ulong arg1)
 {
-    if (env->insn_flags & ASE_MICROMIPS) {
+    if ((env->insn_flags & ASE_MICROMIPS) &&
+        !(env->insn_flags & ISA_NANOMIPS32)) {
         env->CP0_Config3 = (env->CP0_Config3 & ~(1 << CP0C3_ISA_ON_EXC)) |
                            (arg1 & (1 << CP0C3_ISA_ON_EXC));
     }
-- 
2.7.4
