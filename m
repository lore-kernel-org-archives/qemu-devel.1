Received: from eggs.gnu.org ([2001:4830:134:3::10]:50658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ4-0001cD-2i
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ3-0007Pf-GO
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fLCJ3-0007PE-An
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:45 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 22 May 2018 11:46:30 -0700
Message-Id: <1527014802-11289-3-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL v2 03/15] configure: Add explanation for
 --enable-xen-pci-passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

From: Anthony PERARD <anthony.perard@citrix.com>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 59f91ab..a8498ab 100755
--- a/configure
+++ b/configure
@@ -1588,7 +1588,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   virtfs          VirtFS
   mpath           Multipath persistent reservation passthrough
   xen             xen backend driver support
-  xen-pci-passthrough
+  xen-pci-passthrough    PCI passthrough support for Xen
   brlapi          BrlAPI (Braile)
   curl            curl connectivity
   membarrier      membarrier system call (for Linux 4.14+ or Windows)
-- 
1.9.1
