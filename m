Received: from eggs.gnu.org ([2001:4830:134:3::10]:46812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmcco@mykolab.com>) id 1eKq6T-0002Zo-0D
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmcco@mykolab.com>) id 1eKq6O-0002yo-R3
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:32:01 -0500
From: Michael McConville <mmcco@mykolab.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Message-Id: <A6478011-CD5E-4FDF-A212-6D9BB0E70028@mykolab.com>
Date: Fri, 1 Dec 2017 11:31:57 -0700
Subject: [Qemu-devel] [PATCH] mmap(2) returns MAP_FAILED, not NULL,
 on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Signed-off-by: Michael McConville <mmcco@mykolab.com>
---
 hw/i386/xen/xen-mapcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index baab93b614..efa35dc6e0 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -199,7 +199,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
          */
         vaddr_base = mmap(vaddr, size, PROT_READ | PROT_WRITE,
                           MAP_ANON | MAP_SHARED, -1, 0);
-        if (vaddr_base == NULL) {
+        if (vaddr_base == MAP_FAILED) {
             perror("mmap");
             exit(-1);
         }
-- 
2.15.1
