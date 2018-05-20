Received: from eggs.gnu.org ([2001:4830:134:3::10]:44888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHlW-0007n2-RH
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHlT-0008Ji-SP
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:24:22 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:53 +0300
Message-Id: <83e6da02b6bd3401fd6e5ea57915b84144465740.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 07/22] qemu-img.texi: fix command ordering
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

This should match the summary ordering, which is alphabetical.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.texi | 58 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index 8a26400adb..adf5176902 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -193,6 +193,12 @@ sets the number of input blocks to skip
 Command description:
 
 @table @option
+
+@item amend [-p] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+
+Amends the image format specific @var{options} for the image file
+@var{filename}. Not all file formats support this operation.
+
 @item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] @var{filename}
 
 Run a simple sequential I/O benchmark on the specified image. If @code{-w} is
@@ -253,30 +259,6 @@ If @code{-r} is specified, exit codes representing the image state refer to the
 state after (the attempt at) repairing it. That is, a successful @code{-r all}
 will yield the exit code 0, independently of the image state before.
 
-@item create [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
-
-Create the new disk image @var{filename} of size @var{size} and format
-@var{fmt}. Depending on the file format, you can add one or more @var{options}
-that enable additional features of this format.
-
-If the option @var{backing_file} is specified, then the image will record
-only the differences from @var{backing_file}. No size needs to be specified in
-this case. @var{backing_file} will never be modified unless you use the
-@code{commit} monitor command (or qemu-img commit).
-
-If a relative path name is given, the backing file is looked up relative to
-the directory containing @var{filename}.
-
-Note that a given backing file will be opened to check that it is valid. Use
-the @code{-u} option to enable unsafe backing file mode, which means that the
-image will be created even if the associated backing file cannot be opened. A
-matching backing file must be created or additional options be used to make the
-backing file specification valid when you want to use an image created this
-way.
-
-The size can also be specified using the @var{size} option with @code{-o},
-it doesn't need to be specified separately in this case.
-
 @item commit [-q] [-f @var{fmt}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
 
 Commit the changes recorded in @var{filename} in its base image or backing file.
@@ -381,6 +363,30 @@ creating compressed images.
 @var{num_coroutines} specifies how many coroutines work in parallel during
 the convert process (defaults to 8).
 
+@item create [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
+
+Create the new disk image @var{filename} of size @var{size} and format
+@var{fmt}. Depending on the file format, you can add one or more @var{options}
+that enable additional features of this format.
+
+If the option @var{backing_file} is specified, then the image will record
+only the differences from @var{backing_file}. No size needs to be specified in
+this case. @var{backing_file} will never be modified unless you use the
+@code{commit} monitor command (or qemu-img commit).
+
+If a relative path name is given, the backing file is looked up relative to
+the directory containing @var{filename}.
+
+Note that a given backing file will be opened to check that it is valid. Use
+the @code{-u} option to enable unsafe backing file mode, which means that the
+image will be created even if the associated backing file cannot be opened. A
+matching backing file must be created or additional options be used to make the
+backing file specification valid when you want to use an image created this
+way.
+
+The size can also be specified using the @var{size} option with @code{-o},
+it doesn't need to be specified separately in this case.
+
 @item dd [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 
 Dd copies from @var{input} file to @var{output} file converting it from
@@ -585,10 +591,6 @@ how the additional image area should be allocated on the host.  See the format
 description in the @code{NOTES} section which values are allowed.  Using this
 option may result in slightly more data being allocated than necessary.
 
-@item amend [-p] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
-
-Amends the image format specific @var{options} for the image file
-@var{filename}. Not all file formats support this operation.
 @end table
 @c man end
 
-- 
2.11.0
