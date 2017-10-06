Received: from eggs.gnu.org ([2001:4830:134:3::10]:58170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1n-0004GK-2c
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1l-0007rB-Lr
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:07 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e0V1l-0007kt-BR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1Z-0002sD-Ch
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:58:53 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Oct 2017 16:59:28 +0100
Message-Id: <1507305585-20608-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
References: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/20] hw/arm/xlnx-zynqmp: Mark the "xlnx,
 zynqmp" device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The device uses serial_hds in its realize function and thus can't be
used twice. Apart from that, the comma in its name makes it quite hard
to use for the user anyway, since a comma is normally used to separate
the device name from its properties when using the "-device" parameter
or the "device_add" HMP command.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1506441116-16627-1-git-send-email-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
