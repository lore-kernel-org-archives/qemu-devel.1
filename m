Received: from eggs.gnu.org ([2001:4830:134:3::10]:43683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBSp-0006M6-Kn
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBSn-0003mL-Sx
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:17:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Jun 2018 22:15:01 -0300
Message-Id: <20180611011501.10235-41-f4bug@amsat.org>
In-Reply-To: <20180611011501.10235-1-f4bug@amsat.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 40/40] cutils: Do not include "qemu/units.h"
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

All files using "qemu/units.h" definitions already include it directly,
we can now remove it from "qemu/cutils.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 include/qemu/cutils.h | 1 -
 1 file changed, 1 deletion(-)

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
-- 
2.17.1
