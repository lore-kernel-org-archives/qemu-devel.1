Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gCxlw-0005an-V4
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gCxls-0001c8-1q
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:10:48 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gCxlr-0001aH-Rg
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:10:43 -0400
Received: by mail-pg1-x543.google.com with SMTP id n31-v6so13422269pgm.7
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 19:10:43 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 17 Oct 2018 19:10:37 -0700
Message-Id: <1539828637-2907-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] qga: fix an off-by-one issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 qga/commands-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 98d9735..e3842d1 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -465,7 +465,7 @@ static STORAGE_BUS_TYPE win2qemu[] = {
 
 static GuestDiskBusType find_bus_type(STORAGE_BUS_TYPE bus)
 {
-    if (bus > ARRAY_SIZE(win2qemu) || (int)bus < 0) {
+    if (bus >= ARRAY_SIZE(win2qemu) || (int)bus < 0) {
         return GUEST_DISK_BUS_TYPE_UNKNOWN;
     }
     return win2qemu[(int)bus];
-- 
1.8.3.1
