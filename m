Received: from eggs.gnu.org ([2001:4830:134:3::10]:41010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4J-0004Gz-Js
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4G-0002uM-EN
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:40:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:43 -0300
Message-Id: <20170922154014.29350-4-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/34] block: remove "qemu/osdep.h" from header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-trivial@nongnu.org

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 block/dmg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/dmg.h b/block/dmg.h
index b592d6fa8b..2ecf239ba5 100644
--- a/block/dmg.h
+++ b/block/dmg.h
@@ -26,7 +26,6 @@
 #ifndef BLOCK_DMG_H
 #define BLOCK_DMG_H
 
-#include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "block/block_int.h"
 #include <zlib.h>
-- 
2.14.1
