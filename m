Received: from eggs.gnu.org ([2001:4830:134:3::10]:33398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRZa-000811-Ac
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRZZ-0001w0-JO
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:29:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:18 -0300
Message-Id: <20180528232719.4721-21-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 20/21] hw/ide: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

There is no need to include pci.h in this file.
(Continue f23c81073a cleanup).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 866c659498..cc9ca28c33 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -25,7 +25,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
-- 
2.17.0
