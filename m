Received: from eggs.gnu.org ([2001:4830:134:3::10]:40217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enent-0002Uo-Uy
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enenq-0007Yn-RU
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:57 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:51413)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1enenq-0007XJ-Hi
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:54 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Mon, 19 Feb 2018 07:18:25 +0100
Message-Id: <20180219061827.2112-4-david.brenken@efs-auto.org>
In-Reply-To: <20180219061827.2112-1-david.brenken@efs-auto.org>
References: <20180219061827.2112-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH 3/5] tricore: fixed wrong masking of IE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
---
 target/tricore/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index c295763..6ed474c 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -257,7 +257,7 @@ void tricore_cpu_dump_state(CPUState *cpu, FILE *f,
 #define MASK_CPUID_REV     0x000000ff
 
 #define MASK_ICR_PIPN 0x00ff0000
-#define MASK_ICR_IE   0x00000100
+#define MASK_ICR_IE   0x00008000
 #define MASK_ICR_CCPN 0x000000ff
 
 #define MASK_FCX_FCXS 0x000f0000
-- 
2.7.4
