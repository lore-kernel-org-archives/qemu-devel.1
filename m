Received: from eggs.gnu.org ([2001:4830:134:3::10]:57739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e2nZd-0001la-BE
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 20:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e2nZY-0006h3-BF
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 20:11:33 -0400
Received: from mail-bl2nam02on0068.outbound.protection.outlook.com
	([104.47.38.68]:3712
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e2nZY-0006fx-1K
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 20:11:28 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 12 Oct 2017 17:07:28 -0700
Message-ID: <58ffc3cdc439a23cbfbd36f313770eef150efba4.1507852977.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1507852977.git.alistair.francis@xilinx.com>
References: <cover.1507852977.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/5] bcm2836: Use the Cortex-A7 instead of
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
V2:
 - Fix the BCM2836 CPU

 hw/arm/bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8c43291112..931795a878 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -30,7 +30,7 @@ static void bcm2836_init(Object *obj)
 
     for (n = 0; n < BCM2836_NCPUS; n++) {
         object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
-                          "cortex-a15-" TYPE_ARM_CPU);
+                          "cortex-a7-" TYPE_ARM_CPU);
         object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
                                   &error_abort);
     }
-- 
2.11.0
