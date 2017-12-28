Received: from eggs.gnu.org ([2001:4830:134:3::10]:60980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eULtZ-0006E8-9Y
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 19:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eULtV-0004Rt-7v
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 19:18:01 -0500
From: John Arbuckle <programmingkidx@gmail.com>
Date: Wed, 27 Dec 2017 19:17:42 -0500
Message-Id: <20171228001742.62202-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] Update dtc to fix compilation problem on Mac
 OS 10.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-ppc@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Currently QEMU does not build on Mac OS 10.6
because of a missing patch in the dtc
subproject. Updating dtc to make the patch
available fixes this problem.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 dtc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dtc b/dtc
index 558cd81bdd..e671852042 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
+Subproject commit e671852042a77b15ec72ca908291c7d647e4fb01
-- 
2.14.3 (Apple Git-98)
