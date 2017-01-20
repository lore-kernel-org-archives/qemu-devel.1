Received: from eggs.gnu.org ([2001:4830:134:3::10]:40105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUYLA-0007Rp-5l
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUYL9-0007bQ-8b
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:30:48 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cUYL9-0007bE-1u
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:30:47 -0500
Received: by mail-wm0-x243.google.com with SMTP id r126so6366282wmr.3
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:30:46 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 20 Jan 2017 13:30:16 +0100
Message-Id: <1484915417-10499-2-git-send-email-phil@philjordan.eu>
In-Reply-To: <1484915417-10499-1-git-send-email-phil@philjordan.eu>
References: <1484915417-10499-1-git-send-email-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] hw/usb/dev-hid: set bInterfaceProtocol
 to 0x00 for usb-tablet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>

This should be non-zero for boot protocol devices only, which the usb-tablet is not.

A boot protocol of 0x02 specifically confuses OS X/macOS' HID driver stack, causing it to generate additional bogus HID events with relative motion in addition to the tablet's absolute coordinate events.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/usb/dev-hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 24d05f7..a23e5d4 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -144,7 +144,7 @@ static const USBDescIface desc_iface_tablet = {
     .bInterfaceNumber              = 0,
     .bNumEndpoints                 = 1,
     .bInterfaceClass               = USB_CLASS_HID,
-    .bInterfaceProtocol            = 0x02,
+    .bInterfaceProtocol            = 0x00,
     .ndesc                         = 1,
     .descs = (USBDescOther[]) {
         {
@@ -174,7 +174,7 @@ static const USBDescIface desc_iface_tablet2 = {
     .bInterfaceNumber              = 0,
     .bNumEndpoints                 = 1,
     .bInterfaceClass               = USB_CLASS_HID,
-    .bInterfaceProtocol            = 0x02,
+    .bInterfaceProtocol            = 0x00,
     .ndesc                         = 1,
     .descs = (USBDescOther[]) {
         {
-- 
2.3.2 (Apple Git-55)
