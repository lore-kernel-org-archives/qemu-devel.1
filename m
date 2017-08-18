Received: from eggs.gnu.org ([2001:4830:134:3::10]:35962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimeY-00075w-Lc
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimeT-00058E-OR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:09:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dimeT-00057y-I4
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:09:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BB16883C0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 19:09:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 18 Aug 2017 16:09:43 -0300
Message-Id: <20170818190943.23858-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] numa: Move
 numa_legacy_auto_assign_ram to pc-i440fx-2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The 'm->numa_auto_assign_ram = numa_legacy_auto_assign_ram;' line
was supposed to be in pc_i440fx_2_9_machine_options() (see commit
3bfe5716 "numa: equally distribute memory on nodes"), but the
merge commit adb354dd ("Merge remote-tracking branch
'mst/tags/for_upstream' into staging") moved it to the
pc_i440fx_2_10_machine_options().

Move the line back to pc_i440fx_2_9_machine_options().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 11b4336..46dfd2c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -441,7 +441,6 @@ static void pc_i440fx_2_10_machine_options(MachineClass *m)
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
-    m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
 
 DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
@@ -453,6 +452,7 @@ static void pc_i440fx_2_9_machine_options(MachineClass *m)
     m->is_default = 0;
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
+    m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
 
 DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
-- 
2.9.4
