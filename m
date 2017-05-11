Received: from eggs.gnu.org ([2001:4830:134:3::10]:37769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=297e619e5=anthony.perard@citrix.com>)
	id 1d8mO4-0001mB-46
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=297e619e5=anthony.perard@citrix.com>)
	id 1d8mO0-0000mz-1l
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:36:04 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:63009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=297e619e5=anthony.perard@citrix.com>)
	id 1d8mNz-0000mq-Ns
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:35:59 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 11 May 2017 12:35:42 +0100
Message-ID: <20170511113542.16682-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] configure: Remove -lxencall for Xen detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

QEMU does not depends on libxencall, it was added because it was a
missing link dependency of libxendevicemodel, but now the later should
be built properly.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 7c020c076b..fa3522d18a 100755
--- a/configure
+++ b/configure
@@ -2014,7 +2014,7 @@ if test "$xen" != "no" ; then
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
-    xen_stable_libs="-lxencall -lxenforeignmemory -lxengnttab -lxenevtchn"
+    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
 
     # First we test whether Xen headers and libraries are available.
     # If no, we are done and there is no Xen support.
-- 
Anthony PERARD
