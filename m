Received: from eggs.gnu.org ([2001:4830:134:3::10]:60077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fEN9r-0001LU-UK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fEN9r-0005tx-57
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:57:04 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu,  3 May 2018 18:56:44 -0400
Message-Id: <20180503225648.13153-2-jsnow@redhat.com>
In-Reply-To: <20180503225648.13153-1-jsnow@redhat.com>
References: <20180503225648.13153-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] qemu-img-commands.hx: argument ordering
 fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>

The TEXI and string versions are actually identical, except for markup.
We can probably automate this... but make the ordering the same until
then.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-img-cmds.hx | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 2fe31893cf..8bcefcafe9 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -23,13 +23,13 @@ STEXI
 ETEXI
 
 DEF("check", img_check,
-    "check [-q] [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
+    "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
 STEXI
 @item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
 ETEXI
 
 DEF("commit", img_commit,
-    "commit [-q] [--object objectdef] [--image-opts] [-f fmt] [-t cache] [-b base] [-d] [-p] filename")
+    "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-d] [-p] filename")
 STEXI
 @item commit [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
 ETEXI
@@ -47,7 +47,7 @@ STEXI
 ETEXI
 
 DEF("create", img_create,
-    "create [-q] [--object objectdef] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
+    "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
 STEXI
 @item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
 ETEXI
-- 
2.14.3
