Received: from eggs.gnu.org ([2001:4830:134:3::10]:47286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dAi2h-0003Ke-GO
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dAi2e-0007nb-Hl
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dAi2e-0007nF-C0
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:21:56 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 16 May 2017 12:21:50 -0700
Message-Id: <1494962512-4831-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1494962512-4831-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1705161157280.4103@sstabellini-ThinkPad-X260>
	<1494962512-4831-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 2/4] configure: Remove -lxencall for Xen
 detection
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

QEMU does not depends on libxencall, it was added because it was a
missing link dependency of libxendevicemodel, but now the later should
be built properly.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 57b5ae6..139638e 100755
--- a/configure
+++ b/configure
@@ -2015,7 +2015,7 @@ if test "$xen" != "no" ; then
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
-    xen_stable_libs="-lxencall -lxenforeignmemory -lxengnttab -lxenevtchn"
+    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
 
     # First we test whether Xen headers and libraries are available.
     # If no, we are done and there is no Xen support.
-- 
1.9.1
