Received: from eggs.gnu.org ([2001:4830:134:3::10]:60411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3U-0001vQ-6D
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3T-0006XR-D1
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:04 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4y3T-0006Wv-7E
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:03 -0400
Received: by mail-pf0-x244.google.com with SMTP id g23so25781357pfj.1
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 16:15:03 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  1 May 2017 08:14:19 +0900
Message-Id: <4d3ebb3092f5ac66a58357cee15bd5432e77f2fe.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL 05/11] target/openrisc: add numcores and coreid
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

These are used to identify the processor in SMP system.  Their
definition has been defined in verilog cores but it not yet part of the
spec but it will be soon.

The proposal for this is available:
  https://openrisc.io/proposals/core-identifier-and-number-of-cores

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/sys_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 6ba8162..e13666b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -233,6 +233,12 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 64): /* ESR */
         return env->esr;
 
+    case TO_SPR(0, 128): /* COREID */
+        return 0;
+
+    case TO_SPR(0, 129): /* NUMCORES */
+        return 1;
+
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         return env->tlb->dtlb[0][idx].mr;
-- 
2.9.3
