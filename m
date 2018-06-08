Received: from eggs.gnu.org ([2001:4830:134:3::10]:50503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlo-00034X-Rx
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGln-0004Go-Up
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:32 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGln-0004D2-ML
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:31 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlb-0003bG-IQ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:48 +0100
Message-Id: <20180608124517.29475-3-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/31] aspeed: remove
 ignore_memory_transaction_failures on all boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180530064049.27976-2-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a7110a712f3..4d7201d74a0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -278,7 +278,6 @@ static void palmetto_bmc_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
-    mc->ignore_memory_transaction_failures = true;
 }
 
 static const TypeInfo palmetto_bmc_type = {
@@ -311,7 +310,6 @@ static void ast2500_evb_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
-    mc->ignore_memory_transaction_failures = true;
 }
 
 static const TypeInfo ast2500_evb_type = {
@@ -336,7 +334,6 @@ static void romulus_bmc_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
-    mc->ignore_memory_transaction_failures = true;
 }
 
 static const TypeInfo romulus_bmc_type = {
-- 
2.17.1
