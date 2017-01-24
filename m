Received: from eggs.gnu.org ([2001:4830:134:3::10]:45276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxoU-0001g5-FK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxoQ-0005iw-FH
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:54:54 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:34 +0300
Message-Id: <b3cc4b39748a42e7bb541f6c596884d2b7c7b017.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 30/31] usb: Set category and description of the
 MTP device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

It's a storage device, so let's classify it accordingly. And
while we're at it, also add a short description for people who
do not know what MTP means.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/dev-mtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 809dcf5..94c2e94 100644
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
2.1.4
