Received: from eggs.gnu.org ([2001:4830:134:3::10]:60307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUs-0000YI-Ha
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUp-0002GF-OX
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:38 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832]:42446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHfUo-0002BT-7t
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:34 -0400
Received: by mail-qt1-x832.google.com with SMTP id z20-v6so15959556qti.9
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 18:40:26 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 20:38:14 -0500
Message-Id: <20181031013821.24023-18-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
References: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 17/24] qga: fix an off-by-one issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index a1b7512d46..ef1d7d48d2 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -485,7 +485,7 @@ static STORAGE_BUS_TYPE win2qemu[] = {
 
 static GuestDiskBusType find_bus_type(STORAGE_BUS_TYPE bus)
 {
-    if (bus > ARRAY_SIZE(win2qemu) || (int)bus < 0) {
+    if (bus >= ARRAY_SIZE(win2qemu) || (int)bus < 0) {
         return GUEST_DISK_BUS_TYPE_UNKNOWN;
     }
     return win2qemu[(int)bus];
-- 
2.17.1
