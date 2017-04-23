Received: from eggs.gnu.org ([2001:4830:134:3::10]:36293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2IZu-0007K4-D4
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 10:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2IZt-0003LU-EF
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 10:33:30 -0400
From: jemmy858585@gmail.com
Date: Sun, 23 Apr 2017 22:33:17 +0800
Message-Id: <1492957997-28587-2-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <lidongchen@tencent.com>

Fix some spelling errors in is_allocated_sectors comment.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 qemu-img.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index df6d165..0b3349c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1033,8 +1033,8 @@ done:
 }
 
 /*
- * Returns true iff the first sector pointed to by 'buf' contains at least
- * a non-NUL byte.
+ * Returns true if the first sector pointed to by 'buf' contains at least
+ * a non-NULL byte.
  *
  * 'pnum' is set to the number of sectors (including and immediately following
  * the first one) that are known to be in the same allocated/unallocated state.
-- 
1.8.3.1
