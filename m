Received: from eggs.gnu.org ([2001:4830:134:3::10]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eXBWi-0001C2-BW
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eXBWf-0006X0-5G
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:50:08 -0500
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  4 Jan 2018 14:49:52 -0500
Message-Id: <20180104194952.2836-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2] Update dtc to fix compilation problem on
 Mac OS 10.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Currently QEMU does not build on Mac OS 10.6
because of a missing patch in the dtc
subproject. Updating dtc to make the patch
available fixes this problem.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v2 changes:
Updated the commit to point to version 1.4.6.

 dtc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dtc b/dtc
index 558cd81bdd..e54388015a 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
+Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
-- 
2.14.3 (Apple Git-98)
