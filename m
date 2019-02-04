Received: from eggs.gnu.org ([209.51.188.92]:52180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqcQQ-0005yZ-DV
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqcQO-00078o-Kk
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:28:30 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:14928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqcQO-00076s-7j
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:28:28 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Mon, 4 Feb 2019 11:28:01 +0000
Message-ID: <20190204112803.11645-3-anthony.perard@citrix.com>
In-Reply-To: <20190204112803.11645-1-anthony.perard@citrix.com>
References: <20190204112803.11645-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/4] configure: Don't add Xen's libs to LDFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>

When Xen is detected via pkg-config, it isn't necessary to modify
LDFLAGS as modifying libs_softmmu is enough.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index ca1986125d..3d89870d99 100755
--- a/configure
+++ b/configure
@@ -2359,7 +2359,6 @@ if test "$xen" != "no" ; then
     fi
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
-    LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
-- 
Anthony PERARD
