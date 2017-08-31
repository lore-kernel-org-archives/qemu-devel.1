Received: from eggs.gnu.org ([2001:4830:134:3::10]:46160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnZ2Z-0003W4-QD
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 19:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnZ2Y-0003nn-Ut
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 19:38:27 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 31 Aug 2017 16:34:28 -0700
Message-ID: <f983776b936050963c229f981bd83c1d04c4896c.1504222314.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1504222314.git.alistair.francis@xilinx.com>
References: <cover.1504222314.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 5/5] xlnx-zcu102: Mark the EP108 machine as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

The EP108 is the same as the ZCU102, mark it as deprecated as we don't
need two machines.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/arm/xlnx-zcu102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 40c1f5bbf6..d3694f67db 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -180,7 +180,7 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "Xilinx ZynqMP EP108 board";
+    mc->desc = "Xilinx ZynqMP EP108 board (Deprecated, please use xlnx-zcu102)";
     mc->init = xlnx_ep108_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
-- 
2.11.0
