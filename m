Received: from eggs.gnu.org ([209.51.188.92]:43805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrNi-0002DZ-MC
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL5-00019P-VJ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:37 -0400
Received: from m12-13.163.com ([220.181.12.13]:58274)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL5-000169-9s
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:35 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 20 Apr 2019 07:51:19 -0700
Message-Id: <20190420145120.122847-3-liq3ea@163.com>
In-Reply-To: <20190420145120.122847-1-liq3ea@163.com>
References: <20190420145120.122847-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 2/3] edu: mmio: allow mmio read dispatch accept
 8 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

The edu spec said when address >= 0x80, the MMIO area can
be accessed by 8 bytes.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/misc/edu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 65fc32b928..4018dddcb8 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -189,6 +189,10 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr addr, unsigned size)
         return val;
     }
 
+    if (addr >= 0x80 && size != 4 && size != 8) {
+        return val;
+    }
+
     switch (addr) {
     case 0x00:
         val = 0x010000edu;
-- 
2.17.1
