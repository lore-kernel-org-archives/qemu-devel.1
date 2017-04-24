Received: from eggs.gnu.org ([2001:4830:134:3::10]:55943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2THz-0001HG-Ri
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2THz-0003Iv-2S
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:44 +1000
Message-Id: <20170424015927.8933-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/47] hw/ppc/pnv: Classify the "PowerNV Chip"
 devices as CPU devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The devices that are derived from TYPE_PNV_CHIP currently show up
as "uncategorized" devices in the help text of "-device ?". Since
they obviously are related to the CPU, let's put them into the
CPU category instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3fa722a..aad7917 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -723,6 +723,7 @@ static void pnv_chip_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = pnv_chip_realize;
     dc->props = pnv_chip_properties;
     dc->desc = "PowerNV Chip";
-- 
2.9.3
