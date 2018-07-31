Received: from eggs.gnu.org ([2001:4830:134:3::10]:43282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkKmM-0004nX-4Z
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 22:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkKmL-0003CK-CS
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 22:52:54 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon, 30 Jul 2018 22:52:31 -0400
Message-Id: <20180731025231.17482-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] qemu-img-cmds.hx: Add example usage for create
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Add an example on how to use the create command. I believe this will make qemu-img easier to use.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 qemu-img-cmds.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 69758fb6e8..92f7437944 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -50,7 +50,7 @@ STEXI
 ETEXI
 
 DEF("create", img_create,
-    "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
+    "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]\nExample: qemu-img create -f qcow2 WindowsXP.qcow2 10G")
 STEXI
 @item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
 ETEXI
-- 
2.14.3 (Apple Git-98)
