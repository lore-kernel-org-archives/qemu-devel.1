Received: from eggs.gnu.org ([2001:4830:134:3::10]:56404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjK2-0001oE-OM
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjJy-0001zg-Ov
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:58 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1erjJy-0001xx-Ej
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:54 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri,  2 Mar 2018 12:57:41 +0100
Message-Id: <20180302115743.3409-3-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
References: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 2/4] tricore: added CORE_ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Message-Id: <20180301155619.8640-3-david.brenken@efs-auto.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.h    | 1 +
 target/tricore/csfr.def | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index e7dfe4bcc6..045126181a 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -58,6 +58,7 @@ struct CPUTriCoreState {
     uint32_t PC;
     uint32_t SYSCON;
     uint32_t CPU_ID;
+    uint32_t CORE_ID;
     uint32_t BIV;
     uint32_t BTV;
     uint32_t ISP;
diff --git a/target/tricore/csfr.def b/target/tricore/csfr.def
index 05c45dd628..ff004cbddc 100644
--- a/target/tricore/csfr.def
+++ b/target/tricore/csfr.def
@@ -10,6 +10,7 @@ A(0xfe00, PCXI, TRICORE_FEATURE_13)
 A(0xfe08, PC, TRICORE_FEATURE_13)
 A(0xfe14, SYSCON, TRICORE_FEATURE_13)
 R(0xfe18, CPU_ID, TRICORE_FEATURE_13)
+R(0xfe1c, CORE_ID, TRICORE_FEATURE_161)
 E(0xfe20, BIV, TRICORE_FEATURE_13)
 E(0xfe24, BTV, TRICORE_FEATURE_13)
 E(0xfe28, ISP, TRICORE_FEATURE_13)
-- 
2.16.2
