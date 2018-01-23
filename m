Received: from eggs.gnu.org ([2001:4830:134:3::10]:54817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtey-0007Oq-CD
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtet-0001vu-PV
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:24 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:00 +0100
Message-Id: <1516694904-64879-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/25] nios2: 10m50_devboard: replace
 cpu_model with cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

use cpu_create() instead of being removed cpu_generic_init()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Chris Wulff <crwulff@gmail.com>
CC: Marek Vasut <marex@denx.de>
---
 hw/nios2/10m50_devboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index e4007f6..42053b2 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -75,7 +75,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
                                 phys_ram_alias);
 
     /* Create CPU -- FIXME */
-    cpu = NIOS2_CPU(cpu_generic_init(TYPE_NIOS2_CPU, "nios2"));
+    cpu = NIOS2_CPU(cpu_create(TYPE_NIOS2_CPU));
 
     /* Register: CPU interrupt controller (PIC) */
     cpu_irq = nios2_cpu_pic_init(cpu);
-- 
2.7.4
