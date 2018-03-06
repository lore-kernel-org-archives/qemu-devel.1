Received: from eggs.gnu.org ([2001:4830:134:3::10]:51288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhenwei.pi@youruncloud.com>) id 1et6Mw-0007Rr-G4
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhenwei.pi@youruncloud.com>) id 1et6Ms-0002BS-JB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:46:38 -0500
Received: from mail139-37.mail.alibaba.com ([198.11.139.37]:55173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhenwei.pi@youruncloud.com>)
	id 1et6Ms-00029e-8D
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:46:34 -0500
From: "zhenwei.pi" <zhenwei.pi@youruncloud.com>
Date: Tue,  6 Mar 2018 14:46:21 +0800
Message-Id: <1520318781-22644-1-git-send-email-zhenwei.pi@youruncloud.com>
Subject: [Qemu-devel] [PATCH] usbredir: reorder fields in USBRedirDevice to
 reduce padding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, zhenwei.pi@youruncloud.com

Changing the current ordering saves 8 bytes per entry in x86_64.

Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>
---
 hw/usb/redirect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index ec17430..65a9196 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -106,10 +106,10 @@ struct USBRedirDevice {
     USBDevice dev;
     /* Properties */
     CharBackend cs;
+    bool enable_streams;
     uint8_t debug;
-    char *filter_str;
     int32_t bootindex;
-    bool enable_streams;
+    char *filter_str;
     /* Data passed from chardev the fd_read cb to the usbredirparser read cb */
     const uint8_t *read_buf;
     int read_buf_size;
-- 
2.7.4
