Received: from eggs.gnu.org ([2001:4830:134:3::10]:42850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7r7t-0001tZ-Uq
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7r7r-0002MU-5S
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e7r7q-0002Kl-W0
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:59:47 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 26 Oct 2017 15:59:43 -0700
Message-Id: <1509058783-25851-3-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1509058783-25851-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1710261556510.3086@sstabellini-ThinkPad-X260>
	<1509058783-25851-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 3/3] xen: Log errno rather than return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

xen_modified_memory() sets errno to communicate what went wrong so log
this rather than the return value which is not interesting.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
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
1.9.1
