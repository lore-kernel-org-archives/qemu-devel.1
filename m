Received: from eggs.gnu.org ([2001:4830:134:3::10]:47301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4366824e0=wei.liu2@citrix.com>)
	id 1dxEuo-0001YW-Ef
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4366824e0=wei.liu2@citrix.com>)
	id 1dxEui-0003NE-Ee
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:10:26 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:10631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4366824e0=wei.liu2@citrix.com>)
	id 1dxEuh-0003Id-SG
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:10:20 -0400
From: Wei Liu <wei.liu2@citrix.com>
Date: Wed, 27 Sep 2017 17:10:09 +0100
Message-ID: <20170927161009.28091-1-wei.liu2@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen-hvm: use errno in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Xen-devel <xen-devel@lists.xenproject.org>, Wei Liu <wei.liu2@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

The error code is encoding in errno, not rc.

Signed-off-by: Wei Liu <wei.liu2@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/xen/xen-hvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d9ccd5d0d6..f79816a649 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1446,7 +1446,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
         if (rc) {
             fprintf(stderr,
                     "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, %s\n",
-                    __func__, start, nb_pages, rc, strerror(-rc));
+                    __func__, start, nb_pages, rc, strerror(errno));
         }
     }
 }
-- 
2.11.0
