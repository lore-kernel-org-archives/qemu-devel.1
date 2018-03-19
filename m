Received: from eggs.gnu.org ([2001:4830:134:3::10]:43119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19X-00021Z-7R
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19W-0006hn-An
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ey19W-0006hU-5O
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 19 Mar 2018 17:12:49 -0300
Message-Id: <20180319201255.9317-2-ehabkost@redhat.com>
In-Reply-To: <20180319201255.9317-1-ehabkost@redhat.com>
References: <20180319201255.9317-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v3 1/7] nios2: 10m50_devboard: replace cpu_model
 with cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Igor Mammedov <imammedo@redhat.com>

use cpu_create() instead of being removed cpu_generic_init()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1518000027-274608-2-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/nios2/10m50_devboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index e4007f6d7f..42053b2ca9 100644
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
2.14.3
