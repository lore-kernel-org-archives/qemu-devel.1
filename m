Received: from eggs.gnu.org ([2001:4830:134:3::10]:44081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oS-0003KV-1Z
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oN-0008Ih-7m
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:51 +0200
Message-Id: <20180730150958.14607-7-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/13] Revert "qemu-img: Document copy
 offloading implications with -S and -c"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

This reverts commit eb461485f4558e362fab905735b50987505bca44.

Now that we introduce an explicit option, these implicit rules are not
used.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.texi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qemu-img.texi b/qemu-img.texi
index 5853cd18d1..aeb1b9e66c 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -96,8 +96,7 @@ will enumerate information about backing files in a disk image chain. Refer
 below for further description.
 
 @item -c
-indicates that target image must be compressed (qcow format only). If this
-option is used, copy offloading will not be attempted.
+indicates that target image must be compressed (qcow format only)
 
 @item -h
 with or without a command shows help and lists the supported formats
@@ -116,8 +115,7 @@ in case both @var{-q} and @var{-p} options are used.
 indicates the consecutive number of bytes that must contain only zeros
 for qemu-img to create a sparse image during conversion. This value is rounded
 down to the nearest 512 bytes. You may use the common size suffixes like
-@code{k} for kilobytes. If this option is used, copy offloading will not be
-attempted.
+@code{k} for kilobytes.
 
 @item -t @var{cache}
 specifies the cache mode that should be used with the (destination) file. See
-- 
2.13.6
