Received: from eggs.gnu.org ([2001:4830:134:3::10]:59154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3k-0000wZ-MN
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3i-0002QO-33
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:33 +0200
Message-Id: <20171026131741.5059-28-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 27/35] qemu-img.1: Image invalidation on
 qemu-img commit
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

From: Max Reitz <mreitz@redhat.com>

qemu-img commit invalidates all images between base and top.  This
should be mentioned in the man page.

Suggested-by: Ping Li <pingl@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.texi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index ee5c5940d3..fdcf120f36 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -274,11 +274,10 @@ If the backing chain of the given image file @var{filename} has more than one
 layer, the backing file into which the changes will be committed may be
 specified as @var{base} (which has to be part of @var{filename}'s backing
 chain). If @var{base} is not specified, the immediate backing file of the top
-image (which is @var{filename}) will be used. For reasons of consistency,
-explicitly specifying @var{base} will always imply @code{-d} (since emptying an
-image after committing to an indirect backing file would lead to different data
-being read from the image due to content in the intermediate backing chain
-overruling the commit target).
+image (which is @var{filename}) will be used. Note that after a commit operation
+all images between @var{base} and the top image will be invalid and may return
+garbage data when read. For this reason, @code{-b} implies @code{-d} (so that
+the top image stays valid).
 
 @item compare [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-s] [-q] @var{filename1} @var{filename2}
 
-- 
2.13.6
