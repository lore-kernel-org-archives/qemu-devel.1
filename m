Received: from eggs.gnu.org ([2001:4830:134:3::10]:58527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejNB4-00032x-6X
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejNB1-0004ZH-0i
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ejNB0-0004Yp-SJ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:42:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 798C7400187D
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 10:42:03 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  7 Feb 2018 11:40:23 +0100
Message-Id: <1518000027-274608-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1518000027-274608-1-git-send-email-imammedo@redhat.com>
References: <1518000027-274608-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/5] nios2: 10m50_devboard: replace
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
Cc: Eduardo Habkost <ehabkost@redhat.com>

use cpu_create() instead of being removed cpu_generic_init()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
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
