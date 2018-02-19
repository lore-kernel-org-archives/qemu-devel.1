Received: from eggs.gnu.org ([2001:4830:134:3::10]:40152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enenk-0002Re-H1
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enenh-0007Ri-DM
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:48 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:43451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1enenh-0007RF-2o
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:45 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Mon, 19 Feb 2018 07:18:24 +0100
Message-Id: <20180219061827.2112-3-david.brenken@efs-auto.org>
In-Reply-To: <20180219061827.2112-1-david.brenken@efs-auto.org>
References: <20180219061827.2112-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH 2/5] tricore: added CORE_ID
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
index 05c45dd..ca8209c 100644
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
