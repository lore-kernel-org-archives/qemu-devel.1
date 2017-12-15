Received: from eggs.gnu.org ([2001:4830:134:3::10]:34906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgjD-0002rb-Rv
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgjD-0005XW-2x
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:32:03 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:29:58 -0300
Message-Id: <20171215033015.738-27-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 26/43] hw/ipmi: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/isa_ipmi_bt.c  | 1 -
 hw/ipmi/isa_ipmi_kcs.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 2fcc3d2e7c..e098fd5206 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -26,7 +26,6 @@
 #include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/isa/isa.h"
-#include "hw/i386/pc.h"
 
 /* Control register */
 #define IPMI_BT_CLR_WR_BIT         0
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 80444977a0..689587b65d 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -26,7 +26,6 @@
 #include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/isa/isa.h"
-#include "hw/i386/pc.h"
 
 #define IPMI_KCS_OBF_BIT        0
 #define IPMI_KCS_IBF_BIT        1
-- 
2.15.1
