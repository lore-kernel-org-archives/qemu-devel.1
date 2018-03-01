Received: from eggs.gnu.org ([2001:4830:134:3::10]:58351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1erQZw-0001Xl-Fh
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1erQZs-0002OK-Jj
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:57:08 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:44925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1erQZs-0002O2-9F
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:57:04 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Thu,  1 Mar 2018 16:56:17 +0100
Message-Id: <20180301155619.8640-3-david.brenken@efs-auto.org>
In-Reply-To: <20180301155619.8640-1-david.brenken@efs-auto.org>
References: <20180301155619.8640-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH v2 2/4] tricore: added CORE_ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
---
 target/tricore/cpu.h    | 1 +
 target/tricore/csfr.def | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index f41d2ce..c295763 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -59,6 +59,7 @@ struct CPUTriCoreState {
     uint32_t PC;
     uint32_t SYSCON;
     uint32_t CPU_ID;
+    uint32_t CORE_ID;
     uint32_t BIV;
     uint32_t BTV;
     uint32_t ISP;
diff --git a/target/tricore/csfr.def b/target/tricore/csfr.def
index 05c45dd..ff004cb 100644
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
2.7.4
