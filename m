Received: from eggs.gnu.org ([2001:4830:134:3::10]:36094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9o-0001PT-VP
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9n-0006mc-OI
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:08 +0200
Message-Id: <1494513181-7900-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/58] qemu-img: Update documentation for -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img-cmds.hx | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index bf4ce59..e5bc28f 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -10,15 +10,15 @@ STEXI
 ETEXI
 
 DEF("bench", img_bench,
-    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] filename")
+    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename")
 STEXI
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] @var{filename}
+@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
 ETEXI
 
 DEF("check", img_check,
-    "check [-q] [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] filename")
+    "check [-q] [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
 STEXI
-@item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] @var{filename}
+@item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
 ETEXI
 
 DEF("create", img_create,
@@ -34,45 +34,45 @@ STEXI
 ETEXI
 
 DEF("compare", img_compare,
-    "compare [--object objectdef] [--image-opts] [-f fmt] [-F fmt] [-T src_cache] [-p] [-q] [-s] filename1 filename2")
+    "compare [--object objectdef] [--image-opts] [-f fmt] [-F fmt] [-T src_cache] [-p] [-q] [-s] [-U] filename1 filename2")
 STEXI
-@item compare [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-q] [-s] @var{filename1} @var{filename2}
+@item compare [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-q] [-s] [-U] @var{filename1} @var{filename2}
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("dd", img_dd,
-    "dd [--image-opts] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
+    "dd [--image-opts] [-U] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
 STEXI
-@item dd [--image-opts] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 ETEXI
 
 DEF("info", img_info,
-    "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] filename")
+    "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [-U] filename")
 STEXI
-@item info [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] @var{filename}
+@item info [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] [-U] @var{filename}
 ETEXI
 
 DEF("map", img_map,
-    "map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] filename")
+    "map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename")
 STEXI
-@item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] @var{filename}
+@item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename}
 ETEXI
 
 DEF("snapshot", img_snapshot,
-    "snapshot [--object objectdef] [--image-opts] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename")
+    "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename")
 STEXI
-@item snapshot [--object @var{objectdef}] [--image-opts] [-q] [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}] @var{filename}
+@item snapshot [--object @var{objectdef}] [--image-opts] [-U] [-q] [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}] @var{filename}
 ETEXI
 
 DEF("rebase", img_rebase,
-    "rebase [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename")
+    "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename")
 STEXI
-@item rebase [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_file} [-F @var{backing_fmt}] @var{filename}
+@item rebase [--object @var{objectdef}] [--image-opts] [-U] [-q] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_file} [-F @var{backing_fmt}] @var{filename}
 ETEXI
 
 DEF("resize", img_resize,
-- 
1.8.3.1
