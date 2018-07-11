Received: from eggs.gnu.org ([2001:4830:134:3::10]:47885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd3q7-00067K-Ad
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 21:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd3q6-0002e3-Gl
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 21:22:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 11 Jul 2018 09:22:27 +0800
Message-Id: <20180711012227.31600-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: Document copy offloading
 implications with -S and -c
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

Explicitly enabling zero detection or compression suppresses copy
offloading during convert. Document it.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.texi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index aeb1b9e66c..5853cd18d1 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -96,7 +96,8 @@ will enumerate information about backing files in a disk image chain. Refer
 below for further description.
 
 @item -c
-indicates that target image must be compressed (qcow format only)
+indicates that target image must be compressed (qcow format only). If this
+option is used, copy offloading will not be attempted.
 
 @item -h
 with or without a command shows help and lists the supported formats
@@ -115,7 +116,8 @@ in case both @var{-q} and @var{-p} options are used.
 indicates the consecutive number of bytes that must contain only zeros
 for qemu-img to create a sparse image during conversion. This value is rounded
 down to the nearest 512 bytes. You may use the common size suffixes like
-@code{k} for kilobytes.
+@code{k} for kilobytes. If this option is used, copy offloading will not be
+attempted.
 
 @item -t @var{cache}
 specifies the cache mode that should be used with the (destination) file. See
-- 
2.17.1
