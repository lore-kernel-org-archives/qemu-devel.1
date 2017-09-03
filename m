Received: from eggs.gnu.org ([2001:4830:134:3::10]:46231)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1doYHb-0000VG-UX
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 13:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1doYHX-0004Ys-Id
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 13:02:04 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Sun,  3 Sep 2017 18:49:52 +0200
Message-Id: <20170903164952.26760-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] tests: Do not include lutil on SunOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Kamil Rytarowski <n54@gmx.com>

This fixes build on SmartOS (Joyent).

Patch cherry-picked from pkgsrc by jperkin (Joyent).

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f08b7418f0..0e5e6cb9b8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -810,8 +810,10 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
 	rmdir $(INITRD_WORK_DIR)
 
 ifeq ($(CONFIG_POSIX),y)
+ifneq ($(CONFIG_SOLARIS),y)
 LIBS += -lutil
 endif
+endif
 
 # QTest rules
 
-- 
2.14.1
