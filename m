Received: from eggs.gnu.org ([2001:4830:134:3::10]:45588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGG-000139-Hg
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGF-0006R7-KV
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:46 +0200
Message-Id: <1496070414-6744-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] qemu-img: Fix documentation of convert
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

From: Fam Zheng <famz@redhat.com>

It got lost in commit a8d16f9ca "qemu-img: Update documentation for -U".

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20170515103551.31313-1-famz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img-cmds.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index e5bc28f..31141f9 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -40,9 +40,9 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("dd", img_dd,
-- 
1.8.3.1
