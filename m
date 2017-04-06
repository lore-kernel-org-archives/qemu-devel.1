Received: from eggs.gnu.org ([2001:4830:134:3::10]:57094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwBTg-0007Kx-U9
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwBTc-0001pZ-Tp
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:45:48 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Thu,  6 Apr 2017 13:45:42 -0400
Message-Id: <433d922c5ad43020493323c5e065b4c4ef4157ab.1491500481.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] qemu-img: img_create does not support
 image-opts, fix docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com

The documentation and help for qemu-img claims that 'qemu-img create'
will take the '--image-opts' argument.  This is not true, so this
patch removes those claims.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 qemu-img-cmds.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 9c9702c..8ac7822 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -22,9 +22,9 @@ STEXI
 ETEXI
 
 DEF("create", img_create,
-    "create [-q] [--object objectdef] [--image-opts] [-f fmt] [-o options] filename [size]")
+    "create [-q] [--object objectdef] [-f fmt] [-o options] filename [size]")
 STEXI
-@item create [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [-o @var{options}] @var{filename} [@var{size}]
+@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-o @var{options}] @var{filename} [@var{size}]
 ETEXI
 
 DEF("commit", img_commit,
-- 
2.9.3
