Received: from eggs.gnu.org ([2001:4830:134:3::10]:33234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRZM-0007o8-OK
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRZL-0001gn-RI
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:28:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:14 -0300
Message-Id: <20180528232719.4721-17-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 16/21] hw/misc/mips_itu: Cleanup includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/mips_itu.h | 2 ++
 hw/misc/mips_itu.c         | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index b3a4532036..030eb4ac62 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -20,6 +20,8 @@
 #ifndef MIPS_ITU_H
 #define MIPS_ITU_H
 
+#include "hw/sysbus.h"
+
 #define TYPE_MIPS_ITU "mips-itu"
 #define MIPS_ITU(obj) OBJECT_CHECK(MIPSITUState, (obj), TYPE_MIPS_ITU)
 
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index c84a48bbb7..ccc4c7d98a 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -18,13 +18,10 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu/log.h"
 #include "exec/exec-all.h"
-#include "hw/hw.h"
-#include "hw/sysbus.h"
-#include "sysemu/sysemu.h"
 #include "hw/misc/mips_itu.h"
 
 #define ITC_TAG_ADDRSPACE_SZ (ITC_ADDRESSMAP_NUM * 8)
-- 
2.17.0
