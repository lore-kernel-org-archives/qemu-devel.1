Received: from eggs.gnu.org ([2001:4830:134:3::10]:33480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMg-0000wV-Tv
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMY-0007Bi-VQ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:57 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:36637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHrMY-000778-Kz
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:50 -0400
Received: by mail-oi1-x230.google.com with SMTP id r127-v6so12001767oie.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:20:45 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2018 09:19:18 -0500
Message-Id: <20181031141925.30026-18-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
References: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 17/24] qga: fix an off-by-one issue
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
