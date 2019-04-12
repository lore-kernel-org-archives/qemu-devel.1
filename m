Received: from eggs.gnu.org ([209.51.188.92]:51421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3Nc-0000UU-Qv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3Na-000596-Fs
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:36 -0400
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 12 Apr 2019 23:06:18 +0200
Message-Id: <1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base year
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, hpoussin@reactos.org
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>

AIX 5.1 expects the base year to be 1900. Adjust accordingly.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/isa/i82378.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index a5d67bc..546c928 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     isa = isa_create_simple(isabus, "i82374");
 
     /* timer */
-    isa_create_simple(isabus, TYPE_MC146818_RTC);
+    isa = isa_create(isabus, TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
+    qdev_init_nofail(DEVICE(isa));
 }
 
 static void i82378_init(Object *obj)
-- 
2.7.2
