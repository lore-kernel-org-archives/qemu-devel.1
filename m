Received: from eggs.gnu.org ([2001:4830:134:3::10]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dws9a-0006GJ-VZ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dws9W-0005yH-VC
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:52:11 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 26 Sep 2017 17:51:56 +0200
Message-Id: <1506441116-16627-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/xlnx-zynqmp: Mark the "xlnx,
 zynqmp" device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

The device uses serial_hds in its realize function and thus can't be
used twice. Apart from that, the comma in its name makes it quite hard
to use for the user anyway, since a comma is normally used to separate
the device name from its properties when using the "-device" parameter
or the "device_add" HMP command.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/xlnx-zynqmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 2b27daf..d4b6560 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -440,6 +440,8 @@ static void xlnx_zynqmp_class_init(ObjectClass *oc, void *data)
 
     dc->props = xlnx_zynqmp_props;
     dc->realize = xlnx_zynqmp_realize;
+    /* Reason: Uses serial_hds in realize function, thus can't be used twice */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo xlnx_zynqmp_type_info = {
-- 
1.8.3.1
