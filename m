Received: from eggs.gnu.org ([2001:4830:134:3::10]:47458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddJ4V-0005dF-D6
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddJ4U-00043o-CC
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:34:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 11:33:50 -0500
Message-Id: <20170803163353.19558-2-eblake@redhat.com>
In-Reply-To: <20170803163353.19558-1-eblake@redhat.com>
References: <20170803163353.19558-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/4] qemu-img: Sort sub-command names in
 --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, berrange@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org

'amend' and 'create' were not listed alphabetically; hoist them
earlier.  Separate the @end table block to make it easier to
copy-and-paste the addition of future sub-commands.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: also sort 'create' [Kevin]
---
 qemu-img-cmds.hx | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 3763f13625..e6ebdbfee4 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -9,6 +9,12 @@ STEXI
 @table @option
 ETEXI

+DEF("amend", img_amend,
+    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename")
+STEXI
+@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+ETEXI
+
 DEF("bench", img_bench,
     "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename")
 STEXI
@@ -21,12 +27,6 @@ STEXI
 @item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
 ETEXI

-DEF("create", img_create,
-    "create [-q] [--object objectdef] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
-STEXI
-@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
-ETEXI
-
 DEF("commit", img_commit,
     "commit [-q] [--object objectdef] [--image-opts] [-f fmt] [-t cache] [-b base] [-d] [-p] filename")
 STEXI
@@ -45,6 +45,12 @@ STEXI
 @item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI

+DEF("create", img_create,
+    "create [-q] [--object objectdef] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
+STEXI
+@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
+ETEXI
+
 DEF("dd", img_dd,
     "dd [--image-opts] [-U] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
 STEXI
@@ -87,9 +93,6 @@ STEXI
 @item resize [--object @var{objectdef}] [--image-opts] [-q] @var{filename} [+ | -]@var{size}
 ETEXI

-DEF("amend", img_amend,
-    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename")
 STEXI
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
 @end table
 ETEXI
-- 
2.13.3
