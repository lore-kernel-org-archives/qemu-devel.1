Received: from eggs.gnu.org ([2001:4830:134:3::10]:47250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSD-00043c-UG
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSD-0007eM-0A
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:13 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eEFSC-0007Yd-Pk
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:12 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFS7-00024k-No
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:11:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:11:42 +0000
Message-Id: <1510582304-27058-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
References: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 7/9] xlnx-zcu102: Specify the max number of CPUs
 for the EP108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Emilio G. Cota" <cota@braap.org>

Just like the zcu102, the ep108 can instantiate several CPUs.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1510343626-25861-5-git-send-email-cota@braap.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index adddd23..190eb69 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -188,6 +188,7 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
+    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
 }
 
 static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
-- 
2.7.4
