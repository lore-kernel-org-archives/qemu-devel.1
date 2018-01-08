Received: from eggs.gnu.org ([2001:4830:134:3::10]:35349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYQNv-0003CO-ON
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 00:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eYQNu-0006Va-Fk
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 00:54:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  8 Jan 2018 16:53:46 +1100
Message-Id: <20180108055348.20444-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180108055348.20444-1-david@gibson.dropbear.id.au>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/12] Update dtc to fix compilation problem on
 Mac OS 10.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: surajjs@au1.ibm.com, groug@kaod.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, John Arbuckle <programmingkidx@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: John Arbuckle <programmingkidx@gmail.com>

Currently QEMU does not build on Mac OS 10.6
because of a missing patch in the dtc
subproject. Updating dtc to make the patch
available fixes this problem.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
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
2.14.3
