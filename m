Received: from eggs.gnu.org ([2001:4830:134:3::10]:59672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmw-0008Sf-1b
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmu-00068O-Tv
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmu-00060G-K2
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmi-00073s-E7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:24 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:25:59 +0000
Message-Id: <20180309172622.4277-3-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/25] hw/arm: Set the core count for Xilinx's
 ZynqMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Set the ARM CPU core count property for the A53's attached to the Xilnx
ZynqMP machine.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: fe0dd90b85ac73f9fc9548c253bededa70a07006.1520018138.git.alistair.francis@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.16.2
