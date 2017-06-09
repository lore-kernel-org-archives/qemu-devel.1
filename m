Received: from eggs.gnu.org ([2001:4830:134:3::10]:33025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJLUf-00026A-Ht
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJLUc-0000nu-SI
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:06:33 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Jun 2017 12:05:59 -0300
Message-Id: <20170609150600.4654-2-f4bug@amsat.org>
In-Reply-To: <20170609150600.4654-1-f4bug@amsat.org>
References: <20170609150600.4654-1-f4bug@amsat.org>
In-Reply-To: <80969f61-38d4-20ac-d850-5e90c8852b40@redhat.com>
References: <80969f61-38d4-20ac-d850-5e90c8852b40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/2] arm/highbank: use defined type name
 instead of hard-coded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-block@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/highbank.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index d209b97dee..dd809b404b 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -31,6 +31,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
+#include "hw/ide/ahci.h"
 
 #define SMP_BOOT_ADDR           0x100
 #define SMP_BOOT_REG            0x40
@@ -341,7 +342,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     sysbus_create_simple("pl031", 0xfff35000, pic[19]);
     sysbus_create_simple("pl022", 0xfff39000, pic[23]);
 
-    sysbus_create_simple("sysbus-ahci", 0xffe08000, pic[83]);
+    sysbus_create_simple(TYPE_SYSBUS_AHCI, 0xffe08000, pic[83]);
 
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], "xgmac");
-- 
2.11.0
