Received: from eggs.gnu.org ([2001:4830:134:3::10]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erqEl-0007i9-RX
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erqEh-0002ek-Jd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:20:59 -0500
Received: from mail-cys01nam02on0631.outbound.protection.outlook.com
	([2a01:111:f400:fe45::631]:5908
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1erqEh-0002eQ-80
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:20:55 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 2 Mar 2018 11:16:03 -0800
Message-ID: <fe0dd90b85ac73f9fc9548c253bededa70a07006.1520018138.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1520018138.git.alistair.francis@xilinx.com>
References: <cover.1520018138.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/2] hw/arm: Set the core count for Xilinx's
 ZynqMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Set the ARM CPU core count property for the A53's attached to the Xilnx
ZynqMP machine.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

 hw/arm/xlnx-zynqmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 69227fd4c9..465796e97c 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -282,6 +282,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                  s->virt, "has_el2", NULL);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
                                 "reset-cbar", &error_abort);
+        object_property_set_int(OBJECT(&s->apu_cpu[i]), num_apus,
+                                "core-count", &error_abort);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
                                  &err);
         if (err) {
-- 
2.14.1
