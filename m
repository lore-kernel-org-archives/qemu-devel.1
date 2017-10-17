Received: from eggs.gnu.org ([2001:4830:134:3::10]:47075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V0d-0002EN-I5
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V0c-0003XP-PC
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:27 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 17 Oct 2017 13:44:10 -0300
Message-Id: <20171017164426.25277-27-f4bug@amsat.org>
In-Reply-To: <20171017164426.25277-1-f4bug@amsat.org>
References: <20171017164426.25277-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 26/42] hw/ipmi: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Corey Minyard <cminyard@mvista.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Corey Minyard <cminyard@mvista.com>
---
no IPMI entry!

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
2.15.0.rc0
