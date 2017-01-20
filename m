Received: from eggs.gnu.org ([2001:4830:134:3::10]:49150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUYyF-000305-R3
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUYyA-0003Fn-S0
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:11:11 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 20 Jan 2017 14:11:04 +0100
Message-Id: <1484917864-7928-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: Set category and description of the MTP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-trivial@nongnu.org

It's a storage device, so let's classify it accordingly. And
while we're at it, also add a short description for people who
do not know what MTP means.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/dev-mtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 9cb0f50..bb73809 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1580,6 +1580,8 @@ static void usb_mtp_class_initfn(ObjectClass *klass, void *data)
     uc->handle_reset   = usb_mtp_handle_reset;
     uc->handle_control = usb_mtp_handle_control;
     uc->handle_data    = usb_mtp_handle_data;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->desc = "USB Media Transfer Protocol device";
     dc->fw_name = "mtp";
     dc->vmsd = &vmstate_usb_mtp;
     dc->props = mtp_properties;
-- 
1.8.3.1
