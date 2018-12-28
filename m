Received: from eggs.gnu.org ([208.118.235.92]:55943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gctbE-00007P-NJ
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gctTc-0004mW-Sj
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:51:07 -0500
From: Julio Faracco <jcfaracco@gmail.com>
Date: Fri, 28 Dec 2018 12:50:55 -0200
Message-Id: <20181228145055.18039-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] dmg: Fixing wrong dmg block type value for
 block terminator.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

This is a trivial patch to fix a wrong value for block terminator.
The old value was 0x7fffffff which is wrong. It was not affecting the
code because QEMU dmg block is not handling block terminator right now.
Neverthless, it should be fixed.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 block/dmg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/dmg.c b/block/dmg.c
index 50e91aef6d..2c806e3389 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -54,7 +54,7 @@ enum {
     UDBZ,
     ULFO,
     UDCM = 0x7ffffffe, /* Comments */
-    UDLE               /* Last Entry */
+    UDLE = 0xffffffff  /* Last Entry */
 };
 
 static int dmg_probe(const uint8_t *buf, int buf_size, const char *filename)
-- 
2.19.1
