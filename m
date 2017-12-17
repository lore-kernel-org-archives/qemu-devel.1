Received: from eggs.gnu.org ([2001:4830:134:3::10]:42050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgcw-0007Ej-PV
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgct-00014w-Hl
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:37:42 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:12 +0300
Message-Id: <c0fafb440946c2f9cc93c9c6070108297ab994e1.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 07/61] mmap(2) returns MAP_FAILED, not NULL,
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
Cc: Michael McConville <mmcco@mykolab.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Michael McConville <mmcco@mykolab.com>

Signed-off-by: Michael McConville <mmcco@mykolab.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.11.0
