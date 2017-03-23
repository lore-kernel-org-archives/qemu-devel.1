Received: from eggs.gnu.org ([2001:4830:134:3::10]:60426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crAIN-0003dz-IR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crAIK-0008DA-8V
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1crAIK-0008Cl-2L
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 23 Mar 2017 18:28:47 -0300
Message-Id: <20170323212848.8492-4-ehabkost@redhat.com>
In-Reply-To: <20170323212848.8492-1-ehabkost@redhat.com>
References: <20170323212848.8492-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 3/4] q35: Remove ioapic devices from sysbus
 whitelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

An ioapic device is always created by the q35 machine, so
"-device ioapic" and "-device kvm-ioapic" never worked before.
Remove it from the sysbus whitelist.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_q35.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index ea039540d8..94a3069e16 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -312,9 +312,7 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_add_sysbus_whitelist(m, "generic-sdhci");
     machine_class_add_sysbus_whitelist(m, "hpet");
     machine_class_add_sysbus_whitelist(m, "intel-iommu");
-    machine_class_add_sysbus_whitelist(m, "ioapic");
     machine_class_add_sysbus_whitelist(m, "isabus-bridge");
-    machine_class_add_sysbus_whitelist(m, "kvm-ioapic");
     machine_class_add_sysbus_whitelist(m, "kvmclock");
     machine_class_add_sysbus_whitelist(m, "kvmvapic");
     machine_class_add_sysbus_whitelist(m, "SUNW,fdtwo");
-- 
2.11.0.259.g40922b1
