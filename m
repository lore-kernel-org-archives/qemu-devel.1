Received: from eggs.gnu.org ([2001:4830:134:3::10]:44971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cm2wx-0001i5-53
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cm2wr-0002TO-SH
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:38:07 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  9 Mar 2017 19:37:53 +0100
Message-Id: <1489084673-31595-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/pnv: Classify the "PowerNV Chip"
 devices as CPU devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The devices that are derived from TYPE_PNV_CHIP currently show up
as "uncategorized" devices in the help text of "-device ?". Since
they obviously are related to the CPU, let's put them into the
CPU category instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/pnv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 09f0d22..b97055c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -722,6 +722,7 @@ static void pnv_chip_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = pnv_chip_realize;
     dc->props = pnv_chip_properties;
     dc->desc = "PowerNV Chip";
-- 
1.8.3.1
