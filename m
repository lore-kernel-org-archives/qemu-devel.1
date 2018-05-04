Received: from eggs.gnu.org ([2001:4830:134:3::10]:42869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=65534a47b=anthony.perard@citrix.com>)
	id 1fEWre-0008Hm-9N
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=65534a47b=anthony.perard@citrix.com>)
	id 1fEWrb-0003zE-3y
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:18:54 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:30305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=65534a47b=anthony.perard@citrix.com>)
	id 1fEWra-0003v8-Rc
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:18:51 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Fri, 4 May 2018 10:17:56 +0100
Message-ID: <20180504091756.31302-1-anthony.perard@citrix.com>
In-Reply-To: <87lgdjvem0.fsf@dusky.pond.sub.org>
References: <87lgdjvem0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] configure: Add explanation for
 --enable-xen-pci-passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 1443422e83..e961473e76 100755
--- a/configure
+++ b/configure
@@ -1586,7 +1586,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   virtfs          VirtFS
   mpath           Multipath persistent reservation passthrough
   xen             xen backend driver support
-  xen-pci-passthrough
+  xen-pci-passthrough    PCI passthrough support for Xen
   brlapi          BrlAPI (Braile)
   curl            curl connectivity
   membarrier      membarrier system call (for Linux 4.14+ or Windows)
-- 
Anthony PERARD
