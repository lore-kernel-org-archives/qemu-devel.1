Received: from eggs.gnu.org ([2001:4830:134:3::10]:43931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPtIv-0002mj-M8
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPtIs-0000zU-Vi
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:02:17 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 22 Nov 2018 19:01:43 +0100
Message-Id: <20181122180143.14237-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1] MAINTAINERS: Add an ARM SMMU section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com

Add a new ARM SMMU section and set Eric Auger as the maintainer
for ARM SMMU emulation sources.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1032406c56..3cac9f0a0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -151,6 +151,13 @@ F: disas/arm.c
 F: disas/arm-a64.cc
 F: disas/libvixl/
 
+ARM SMMU
+M: Eric Auger <eric.auger@redhat.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/smmu*
+F: include/hw/arm/smmu*
+
 CRIS
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-- 
2.17.2
