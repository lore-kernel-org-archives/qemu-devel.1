Received: from eggs.gnu.org ([2001:4830:134:3::10]:50614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1diPxM-0005Di-RL
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1diPxJ-0003py-Ou
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:55:48 -0400
Received: from mail-by2nam03on0063.outbound.protection.outlook.com
	([104.47.42.63]:23136
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1diPxJ-0003ns-Br
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:55:45 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 17 Aug 2017 11:52:09 -0700
Message-ID: <9782dd1cced54ed8d61856234726bd4d09ab3bd4.1502993370.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1502993370.git.alistair.francis@xilinx.com>
References: <cover.1502993370.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 4/5] xlnx-zynqmp: Allow the secure prop to
 enable EL2
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

If the user sets the secure property to true we want to enalbe both EL2
and EL3.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/arm/xlnx-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 9eceadbdc8..d6ca5dcd4e 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -260,7 +260,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         object_property_set_bool(OBJECT(&s->apu_cpu[i]),
                                  s->secure, "has_el3", NULL);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]),
-                                 false, "has_el2", NULL);
+                                 s->secure, "has_el2", NULL);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
                                 "reset-cbar", &error_abort);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
-- 
2.11.0
