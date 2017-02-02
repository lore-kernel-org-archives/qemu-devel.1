Received: from eggs.gnu.org ([2001:4830:134:3::10]:51286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jk-0007GA-28
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9ji-0003dr-8C
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:13:19 +1100
Message-Id: <20170202051445.5735-22-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 021/107] target-ppc: implement stop instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Use the nap code.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 87fc153..772929e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3172,6 +3172,11 @@ static void gen_nap(DisasContext *ctx)
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
+static void gen_stop(DisasContext *ctx)
+{
+    gen_nap(ctx);
+}
+
 static void gen_sleep(DisasContext *ctx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -6240,6 +6245,7 @@ GEN_HANDLER(mcrf, 0x13, 0x00, 0xFF, 0x00000001, PPC_INTEGER),
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
+GEN_HANDLER_E(stop, 0x13, 0x12, 0x0b, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(doze, 0x13, 0x12, 0x0c, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
 GEN_HANDLER_E(nap, 0x13, 0x12, 0x0d, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
 GEN_HANDLER_E(sleep, 0x13, 0x12, 0x0e, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
-- 
2.9.3
