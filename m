Received: from eggs.gnu.org ([2001:4830:134:3::10]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e85ni-0008HZ-BV
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e85nd-0006UG-Dy
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:39:58 -0400
Received: from mail-by2nam01on0041.outbound.protection.outlook.com
	([104.47.34.41]:47482
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e85nd-0006Ry-0h
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:39:53 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 27 Oct 2017 07:35:34 -0700
Message-ID: <382833937419ccd4de5de9b65f74ca561cfa328d.1509114880.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] xlnx-zcu102: Specify the number of max
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

Specify the number of CPUs that can run on ZynqMP.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/arm/xlnx-zcu102.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 519a16ed98..b86c048bb3 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -240,6 +240,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
+    mc->max_cpus = 6;
 }
 
 static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
-- 
2.11.0
