Received: from eggs.gnu.org ([2001:4830:134:3::10]:37954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cztWj-0003mG-AY
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 19:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cztWf-0007wy-Cl
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 19:24:17 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cztWf-0007wT-7B
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 19:24:13 -0400
Received: by mail-pf0-x243.google.com with SMTP id a188so22059686pfa.2
	for <qemu-devel@nongnu.org>; Sun, 16 Apr 2017 16:24:13 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon, 17 Apr 2017 08:23:52 +0900
Message-Id: <f8e2371c7a99cc6694b65d5be4f6c265dceae66a.1492384862.git.shorne@gmail.com>
In-Reply-To: <cover.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
In-Reply-To: <cover.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH 3/7] target/openrisc: add numcores and coreid
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>

These are used to identify the processor in SMP system.  Their
definition has been defined in verilog cores but it not yet part of the
spec but it will be soon.

The proposal for this is available:
  https://openrisc.io/proposals/core-identifier-and-number-of-cores

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/sys_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 2eaff87..bd5051b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -227,6 +227,12 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
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
