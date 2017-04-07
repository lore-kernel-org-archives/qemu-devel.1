Received: from eggs.gnu.org ([2001:4830:134:3::10]:44877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUFC-0005sN-BX
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUFB-0003Vt-KG
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Apr 2017 15:47:41 +0200
Message-Id: <1491572865-8549-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/10] qemu-img: img_create does not support
 image-opts, fix docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Jeff Cody <jcody@redhat.com>

The documentation and help for qemu-img claims that 'qemu-img create'
will take the '--image-opts' argument.  This is not true, so this
patch removes those claims.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
1.8.3.1
