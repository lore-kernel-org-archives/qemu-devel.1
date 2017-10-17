Received: from eggs.gnu.org ([2001:4830:134:3::10]:41571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e4aSF-0003oC-6E
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e4aSB-0000Nx-Tp
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:35:19 -0400
Received: from mail-sn1nam02on0058.outbound.protection.outlook.com
	([104.47.36.58]:16960
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e4aSB-0000Lj-N0
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:35:15 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 17 Oct 2017 15:31:14 -0700
Message-ID: <ef4e172df6cdf3d9ee8bb3aa896cacab5efdd1f1.1508279421.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1508279421.git.alistair.francis@xilinx.com>
References: <cover.1508279421.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/5] bcm2836: Use the Cortex-A7 instead of
 Cortex-A15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org

The BCM2836 uses a Cortex-A7 not a Cortex-A15. Update the device to use
the correct CPU.
https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
V3:
 - Use ARM_CPU_TYPE_NAME() macro
V2:
 - Fix the BCM2836 CPU

 hw/arm/bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8c43291112..c477772484 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -30,7 +30,7 @@ static void bcm2836_init(Object *obj)
 
     for (n = 0; n < BCM2836_NCPUS; n++) {
         object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
-                          "cortex-a15-" TYPE_ARM_CPU);
+                          ARM_CPU_TYPE_NAME("cortex-a7"));
         object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
                                   &error_abort);
     }
-- 
2.11.0
