Received: from eggs.gnu.org ([2001:4830:134:3::10]:45918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvD-00060A-9g
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvA-0002tu-7N
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:23 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:55 +0300
Message-Id: <9775fcdb11ab425cc3537ebe95dcf818bedfc954.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 09/22] qemu-img: Make documentation between
 .texi and .hx consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: John Snow <jsnow@redhat.com>

These are also different and out of order for whatever reason.
I'd like to automate this in the future, but for now let's put
on the band-aid.

In the case of resize, there were options missing from all
three docstrings; the new string is based on the code.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img-cmds.hx |  4 ++--
 qemu-img.texi    | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 8bcefcafe9..84deb858af 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -89,9 +89,9 @@ STEXI
 ETEXI
 
 DEF("resize", img_resize,
-    "resize [--object objectdef] [--image-opts] [-q] [--shrink] filename [+ | -]size")
+    "resize [--object objectdef] [--image-opts] [-f fmt] [--preallocation=prealloc] [-q] [--shrink] filename [+ | -]size")
 STEXI
-@item resize [--object @var{objectdef}] [--image-opts] [-q] [--shrink] @var{filename} [+ | -]@var{size}
+@item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
 ETEXI
 
 STEXI
diff --git a/qemu-img.texi b/qemu-img.texi
index adf5176902..2be8206a05 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -194,12 +194,12 @@ Command description:
 
 @table @option
 
-@item amend [-p] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+@item amend [--object @var{objectdef}] [--image-opts] [-p] [-p] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
 
 Amends the image format specific @var{options} for the image file
 @var{filename}. Not all file formats support this operation.
 
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] @var{filename}
+@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
 
 Run a simple sequential I/O benchmark on the specified image. If @code{-w} is
 specified, a write test is performed, otherwise a read test is performed.
@@ -223,7 +223,7 @@ specified as well.
 For write tests, by default a buffer filled with zeros is written. This can be
 overridden with a pattern byte specified by @var{pattern}.
 
-@item check [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] @var{filename}
+@item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
 
 Perform a consistency check on the disk image @var{filename}. The command can
 output in the format @var{ofmt} which is either @code{human} or @code{json}.
@@ -259,7 +259,7 @@ If @code{-r} is specified, exit codes representing the image state refer to the
 state after (the attempt at) repairing it. That is, a successful @code{-r all}
 will yield the exit code 0, independently of the image state before.
 
-@item commit [-q] [-f @var{fmt}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
+@item commit [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
 
 Commit the changes recorded in @var{filename} in its base image or backing file.
 If the backing file is smaller than the snapshot, then the backing file will be
@@ -281,7 +281,7 @@ all images between @var{base} and the top image will be invalid and may return
 garbage data when read. For this reason, @code{-b} implies @code{-d} (so that
 the top image stays valid).
 
-@item compare [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-s] [-q] @var{filename1} @var{filename2}
+@item compare [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-q] [-s] [-U] @var{filename1} @var{filename2}
 
 Check if two images have the same content. You can compare images with
 different format or settings.
@@ -322,7 +322,7 @@ Error on reading data
 
 @end table
 
-@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-m @var{num_coroutines}] [-W] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 
 Convert the disk image @var{filename} or a snapshot @var{snapshot_param}(@var{snapshot_id_or_name} is deprecated)
 to disk image @var{output_filename} using format @var{output_fmt}. It can be optionally compressed (@code{-c}
@@ -363,7 +363,7 @@ creating compressed images.
 @var{num_coroutines} specifies how many coroutines work in parallel during
 the convert process (defaults to 8).
 
-@item create [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
+@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
 
 Create the new disk image @var{filename} of size @var{size} and format
 @var{fmt}. Depending on the file format, you can add one or more @var{options}
@@ -387,7 +387,7 @@ way.
 The size can also be specified using the @var{size} option with @code{-o},
 it doesn't need to be specified separately in this case.
 
-@item dd [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 
 Dd copies from @var{input} file to @var{output} file converting it from
 @var{fmt} format to @var{output_fmt} format.
@@ -398,7 +398,7 @@ dd will stop reading input after reading @var{blocks} input blocks.
 
 The size syntax is similar to dd(1)'s size syntax.
 
-@item info [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] @var{filename}
+@item info [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] [-U] @var{filename}
 
 Give information about the disk image @var{filename}. Use it in
 particular to know the size reserved on disk which can be different
@@ -506,11 +506,11 @@ been written to all sectors.  This is the maximum size that the image file can
 occupy with the exception of internal snapshots, dirty bitmaps, vmstate data,
 and other advanced image format features.
 
-@item snapshot [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot} ] @var{filename}
+@item snapshot [--object @var{objectdef}] [--image-opts] [-U] [-q] [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}] @var{filename}
 
 List, apply, create or delete snapshots in image @var{filename}.
 
-@item rebase [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_file} [-F @var{backing_fmt}] @var{filename}
+@item rebase [--object @var{objectdef}] [--image-opts] [-U] [-q] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_file} [-F @var{backing_fmt}] @var{filename}
 
 Changes the backing file of an image. Only the formats @code{qcow2} and
 @code{qed} support changing the backing file.
@@ -570,7 +570,7 @@ qemu-img rebase -b base.img diff.qcow2
 At this point, @code{modified.img} can be discarded, since
 @code{base.img + diff.qcow2} contains the same information.
 
-@item resize [--shrink] [--preallocation=@var{prealloc}] @var{filename} [+ | -]@var{size}
+@item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
 
 Change the disk image as if it had been created with @var{size}.
 
-- 
2.11.0
