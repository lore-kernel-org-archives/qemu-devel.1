Received: from eggs.gnu.org ([2001:4830:134:3::10]:42769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=450599c34=ross.lagerwall@citrix.com>)
	id 1e2JJ3-0007lo-9X
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=450599c34=ross.lagerwall@citrix.com>)
	id 1e2JIz-0003u3-EH
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:52:25 -0400
Received: from smtp.citrix.com ([66.165.176.89]:15244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=450599c34=ross.lagerwall@citrix.com>)
	id 1e2JIz-0003sM-8S
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:52:21 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Wed, 11 Oct 2017 16:52:03 +0100
Message-ID: <20171011155203.16502-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen: Log errno rather than return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

xen_modified_memory() sets errno to communicate what went wrong so log
this rather than the return value which is not interesting.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 hw/i386/xen/xen-hvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d9ccd5d..8028bed 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1446,7 +1446,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
         if (rc) {
             fprintf(stderr,
                     "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, %s\n",
-                    __func__, start, nb_pages, rc, strerror(-rc));
+                    __func__, start, nb_pages, errno, strerror(errno));
         }
     }
 }
-- 
2.9.5
