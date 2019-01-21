Received: from eggs.gnu.org ([209.51.188.92]:37809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=917ecb37e=anthony.perard@citrix.com>)
	id 1glazY-00044o-Jb
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=917ecb37e=anthony.perard@citrix.com>)
	id 1glaso-0003Cq-Ok
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:49:08 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:47411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=917ecb37e=anthony.perard@citrix.com>)
	id 1glasn-00039t-1b
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:49:02 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Mon, 21 Jan 2019 14:48:41 +0000
Message-ID: <20190121144841.24467-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] configure: Don't add Xen's libs to LDFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>, xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Peter Maydell <peter.maydell@linaro.org>

When Xen is detected via pkg-config, it isn't necessary to modify
LDFLAGS as modifying libs_softmmu is enough.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index 12fd34f30b..98b270974d 100755
--- a/configure
+++ b/configure
@@ -2355,7 +2355,6 @@ if test "$xen" != "no" ; then
     fi
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
-    LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
-- 
Anthony PERARD
