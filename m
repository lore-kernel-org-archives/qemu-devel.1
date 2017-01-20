Received: from eggs.gnu.org ([2001:4830:134:3::10]:33868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUbVt-0003Vz-9R
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUbVq-0007uu-4m
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:54:05 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 20 Jan 2017 16:53:59 +0100
Message-Id: <1484927639-3841-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/isa/isa-bus: Set category of the
 "isabus-bridge" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

It has "bridge" in its name, so it should be in the category
DEVICE_CATEGORY_BRIDGE.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/isa/isa-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 9d07b11..0ffbc8d 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -219,6 +219,7 @@ static void isabus_bridge_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "isa";
 }
 
-- 
1.8.3.1
