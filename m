Received: from eggs.gnu.org ([2001:4830:134:3::10]:40229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enenv-0002Uy-K8
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enens-0007Zr-Fb
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:59 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:56149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1enens-0007ZR-5P
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:56 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Mon, 19 Feb 2018 07:18:26 +0100
Message-Id: <20180219061827.2112-5-david.brenken@efs-auto.org>
In-Reply-To: <20180219061827.2112-1-david.brenken@efs-auto.org>
References: <20180219061827.2112-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH 4/5] tricore: fixed wrong mask of PCXI_PIE
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
index 6ed474c..3f8c029 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -230,7 +230,7 @@ void tricore_cpu_dump_state(CPUState *cpu, FILE *f,
 
 
 #define MASK_PCXI_PCPN 0xff000000
-#define MASK_PCXI_PIE  0x00800000
+#define MASK_PCXI_PIE  0x00200000
 #define MASK_PCXI_UL   0x00400000
 #define MASK_PCXI_PCXS 0x000f0000
 #define MASK_PCXI_PCXO 0x0000ffff
-- 
2.7.4
