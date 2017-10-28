Received: from eggs.gnu.org ([2001:4830:134:3::10]:38947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e8Lbo-0006WE-1d
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 03:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e8Lbj-0001SU-4s
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 03:32:44 -0400
Received: from mail-by2nam01on0067.outbound.protection.outlook.com
	([104.47.34.67]:18080
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e8Lbi-0001Qa-OK
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 03:32:39 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Sat, 28 Oct 2017 00:28:16 -0700
Message-ID: <08178b4217d1692297b8c9620b6d13a80bfb6822.1509175660.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/1] xlnx-zcu102: Specify the number of max
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, f4bug@amsat.org

Specify the number of CPUs that can run on ZynqMP.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud <f4bug@amsat.org>
---
V2:
 - Use macros

 hw/arm/xlnx-zcu102.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 519a16ed98..e2d15a1c9d 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -240,6 +240,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
+    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
 }
 
 static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
-- 
2.11.0
