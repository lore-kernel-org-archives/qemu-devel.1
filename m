Received: from eggs.gnu.org ([2001:4830:134:3::10]:49639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3NHe-0001be-HE
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3NHd-0002NB-DQ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:47:06 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 26 Apr 2017 15:46:49 +0200
Message-Id: <20170426134649.9042-4-mreitz@redhat.com>
In-Reply-To: <20170426134649.9042-1-mreitz@redhat.com>
References: <20170426134649.9042-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qemu-img: Document backing options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The create and convert subcommands have shorthands to set the
backing_file and, in the case of create, the backing_fmt options for the
new image. However, they have not been documented so far, which is
remedied by this patch.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img-cmds.hx | 8 ++++----
 qemu-img.texi    | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 8ac78222af..bf4ce59019 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -22,9 +22,9 @@ STEXI
 ETEXI
 
 DEF("create", img_create,
-    "create [-q] [--object objectdef] [-f fmt] [-o options] filename [size]")
+    "create [-q] [--object objectdef] [-f fmt] [-b backing_file] [-F backing_fmt] [-o options] filename [size]")
 STEXI
-@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-o @var{options}] @var{filename} [@var{size}]
+@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-o @var{options}] @var{filename} [@var{size}]
 ETEXI
 
 DEF("commit", img_commit,
@@ -40,9 +40,9 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("dd", img_dd,
diff --git a/qemu-img.texi b/qemu-img.texi
index c81db3e81c..8c573ae010 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -224,7 +224,7 @@ If @code{-r} is specified, exit codes representing the image state refer to the
 state after (the attempt at) repairing it. That is, a successful @code{-r all}
 will yield the exit code 0, independently of the image state before.
 
-@item create [-f @var{fmt}] [-o @var{options}] @var{filename} [@var{size}]
+@item create [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-o @var{options}] @var{filename} [@var{size}]
 
 Create the new disk image @var{filename} of size @var{size} and format
 @var{fmt}. Depending on the file format, you can add one or more @var{options}
@@ -302,7 +302,7 @@ Error on reading data
 
 @end table
 
-@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-m @var{num_coroutines}] [-W] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-m @var{num_coroutines}] [-W] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
 
 Convert the disk image @var{filename} or a snapshot @var{snapshot_param}(@var{snapshot_id_or_name} is deprecated)
 to disk image @var{output_filename} using format @var{output_fmt}. It can be optionally compressed (@code{-c}
-- 
2.12.2
