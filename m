Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxjr-00083g-1K
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxjm-00065D-4c
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:15 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:13 +0200
Message-Id: <20170711160814.20941-25-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 24/85] specs/qcow2: do not use wording 'bitmap
 header'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

A bitmap directory entry is sometimes called a 'bitmap header'. This
patch leaves only one name - 'bitmap directory entry'. The name 'bitmap
header' creates misunderstandings with 'qcow2 header' and 'qcow2 bitmap
header extension' (which is extension of qcow2 header)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/interop/qcow2.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index aee3553..d7fdb1f 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -203,7 +203,7 @@ The fields of the bitmaps extension are:
 
           8 - 15:  bitmap_directory_size
                    Size of the bitmap directory in bytes. It is the cumulative
-                   size of all (nb_bitmaps) bitmap headers.
+                   size of all (nb_bitmaps) bitmap directory entries.
 
          16 - 23:  bitmap_directory_offset
                    Offset into the image file at which the bitmap directory
@@ -529,8 +529,7 @@ Each bitmap saved in the image is described in a bitmap directory entry. The
 bitmap directory is a contiguous area in the image file, whose starting offset
 and length are given by the header extension fields bitmap_directory_offset and
 bitmap_directory_size. The entries of the bitmap directory have variable
-length, depending on the lengths of the bitmap name and extra data. These
-entries are also called bitmap headers.
+length, depending on the lengths of the bitmap name and extra data.
 
 Structure of a bitmap directory entry:
 
-- 
2.9.4
