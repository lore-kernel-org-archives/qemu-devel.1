Received: from eggs.gnu.org ([2001:4830:134:3::10]:59848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQY-0001m8-B1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQR-0005KP-Mk
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:14 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:42341 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dKmQR-0005Hx-9h
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:07 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Jun 2017 17:03:30 +0300
Message-Id: <20170613140358.81651-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v21 02/30] specs/qcow2: do not use wording
 'bitmap header'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

A bitmap directory entry is sometimes called a 'bitmap header'. This
patch leaves only one name - 'bitmap directory entry'. The name 'bitmap
header' creates misunderstandings with 'qcow2 header' and 'qcow2 bitmap
header extension' (which is extension of qcow2 header)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 docs/specs/qcow2.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/docs/specs/qcow2.txt b/docs/specs/qcow2.txt
index dda53dd2a3..8874e8c774 100644
--- a/docs/specs/qcow2.txt
+++ b/docs/specs/qcow2.txt
@@ -201,7 +201,7 @@ The fields of the bitmaps extension are:
 
           8 - 15:  bitmap_directory_size
                    Size of the bitmap directory in bytes. It is the cumulative
-                   size of all (nb_bitmaps) bitmap headers.
+                   size of all (nb_bitmaps) bitmap directory entries.
 
          16 - 23:  bitmap_directory_offset
                    Offset into the image file at which the bitmap directory
@@ -426,8 +426,7 @@ Each bitmap saved in the image is described in a bitmap directory entry. The
 bitmap directory is a contiguous area in the image file, whose starting offset
 and length are given by the header extension fields bitmap_directory_offset and
 bitmap_directory_size. The entries of the bitmap directory have variable
-length, depending on the lengths of the bitmap name and extra data. These
-entries are also called bitmap headers.
+length, depending on the lengths of the bitmap name and extra data.
 
 Structure of a bitmap directory entry:
 
-- 
2.11.1
