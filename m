Received: from eggs.gnu.org ([2001:4830:134:3::10]:43800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dddAN-0003lv-P3
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ddd9a-00053a-Ud
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:01:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  4 Aug 2017 21:55:45 +0800
Message-Id: <20170804135545.28266-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: Clarify about relative backing file
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

It's not too surprising when a user specifies the backing file relative
to the current working directory instead of the top layer image. This
causes error when they differ. Though the error message has enough
information to infer the fact about the misunderstanding, it is better
if we document this explicitly, so that users don't have to learn from
mistakes.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.texi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index 72dabd6b3e..cf079f90e2 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -244,6 +244,9 @@ only the differences from @var{backing_file}. No size needs to be specified in
 this case. @var{backing_file} will never be modified unless you use the
 @code{commit} monitor command (or qemu-img commit).
 
+If a relative path name is given, the backing file is looked up against
+@var{filename}, rather than the current working directory.
+
 Note that a given backing file will be opened to check that it is valid. Use
 the @code{-u} option to enable unsafe backing file mode, which means that the
 image will be created even if the associated backing file cannot be opened. A
@@ -343,6 +346,9 @@ created as a copy on write image of the specified base image; the
 @var{backing_file} should have the same content as the input's base image,
 however the path, image format, etc may differ.
 
+If a relative path name is given, the backing file is looked up against
+@var{output_filename}, rather than the current working directory.
+
 If the @code{-n} option is specified, the target volume creation will be
 skipped. This is useful for formats such as @code{rbd} if the target
 volume has already been created with site specific options that cannot
@@ -490,6 +496,9 @@ The backing file is changed to @var{backing_file} and (if the image format of
 string), then the image is rebased onto no backing file (i.e. it will exist
 independently of any backing file).
 
+If a relative path name is given, the backing file is looked up against
+@var{filename}, rather than the current working directory.
+
 @var{cache} specifies the cache mode to be used for @var{filename}, whereas
 @var{src_cache} specifies the cache mode for reading backing files.
 
-- 
2.13.3
