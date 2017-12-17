Received: from eggs.gnu.org ([2001:4830:134:3::10]:37310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQilr-0005Fu-2F
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 18:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQiln-0005sN-5O
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 18:55:03 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:24 +0300
Message-Id: <84df8224309e84ca418e2bc583d2425e7d31b2e5.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 19/61] hw/input/hid: Add support for several
 keys.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Tao Wu <lepton@google.com>

Add support for these keys: audiomute volumedown volumeup power.
Tested with "sendkey" command in monitor and verify the behavior
in guest OS.

Signed-off-by: Tao Wu <lepton@google.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.11.0
