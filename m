Received: from eggs.gnu.org ([2001:4830:134:3::10]:52757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rL4-0006aV-02
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rL3-0001vl-5K
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:43:07 -0300
Message-Id: <20180415234307.28132-42-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 41/41] cutils: Do not include "qemu/units.h"
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

All files using "qemu/units.h" definitions already include it directly,
we can now remove it from "qemu/cutils.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/cutils.h | 1 -
 hw/core/machine.c     | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 056e6629bb..cdb0f0db75 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -2,7 +2,6 @@
 #define QEMU_CUTILS_H
 
 #include "qemu/fprintf-fn.h"
-#include "qemu/units.h"
 
 /**
  * pstrcpy:
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2040177664..8f70c5ad94 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -19,7 +19,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "qemu/error-report.h"
-#include "qemu/cutils.h"
+#include "qemu/units.h"
 #include "sysemu/qtest.h"
 
 static char *machine_get_accel(Object *obj, Error **errp)
-- 
2.17.0
