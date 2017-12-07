Received: from eggs.gnu.org ([2001:4830:134:3::10]:37100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eMq7X-0005rM-Mx
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eMq7W-0007I1-S5
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:57:23 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:43936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eMq7W-0007GN-Nl
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:57:22 -0500
Received: by mail-it0-x242.google.com with SMTP id u62so12412032ita.2
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 22:57:21 -0800 (PST)
From: Tao Wu <lepton@google.com>
Date: Wed,  6 Dec 2017 22:56:39 -0800
Message-Id: <20171207065639.164900-1-lepton@google.com>
Subject: [Qemu-devel] [PATCH] hw/input/hid: Add support for several keys.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kraxel@redhat.com, mjt@tls.msk.ru, laurent@vivier.eu, Tao Wu <lepton@google.com>

Add support for these keys: audiomute volumedown volumeup power.
Tested with "sendkey" command in monitor and verify the behavior
in guest OS.

Signed-off-by: Tao Wu <lepton@google.com>
---
 hw/input/hid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 0d049ff61c..aa4fb826fd 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -57,14 +57,14 @@ static const uint8_t hid_usage_keys[0x100] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x58, 0xe4, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x46,
+    0x7f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x81, 0x00,
+    0x80, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x46,
     0xe6, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x48, 0x48, 0x4a,
     0x52, 0x4b, 0x00, 0x50, 0x00, 0x4f, 0x00, 0x4d,
     0x51, 0x4e, 0x49, 0x4c, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0xe3, 0xe7, 0x65, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0xe3, 0xe7, 0x65, 0x66, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-- 
2.15.1.424.g9478a66081-goog
