Received: from eggs.gnu.org ([2001:4830:134:3::10]:47237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evLH1-0006GN-5i
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evLGw-000253-LD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:05:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evLGw-00023t-FR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:05:42 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 12:05:32 +0100
Message-Id: <20180312110532.30967-2-kraxel@redhat.com>
In-Reply-To: <20180312110532.30967-1-kraxel@redhat.com>
References: <20180312110532.30967-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] usbredir: reorder fields in USBRedirDevice
 to reduce padding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "zhenwei.pi" <zhenwei.pi@youruncloud.com>

From: "zhenwei.pi" <zhenwei.pi@youruncloud.com>

Changing the current ordering saves 8 bytes per entry in x86_64.

Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>
Message-id: 1520318781-22644-1-git-send-email-zhenwei.pi@youruncloud.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/redirect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index ec174309db..65a9196c1a 100644
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
2.9.3
