Received: from eggs.gnu.org ([2001:4830:134:3::10]:60465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crAIQ-0003go-7P
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crAIP-0008GV-HO
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1crAIP-0008Fz-Bk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:25 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 23 Mar 2017 18:28:48 -0300
Message-Id: <20170323212848.8492-5-ehabkost@redhat.com>
In-Reply-To: <20170323212848.8492-1-ehabkost@redhat.com>
References: <20170323212848.8492-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 4/4] q35: Remove fw_cfg* from sysbus whitelist
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

fw_cfg devices are supposed to be created by the q35 board code,
and not manually using -device. Remove them from the whitelist.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_q35.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 94a3069e16..91d7f67e48 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -307,8 +307,6 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_add_sysbus_whitelist(m, "amd-iommu");
     machine_class_add_sysbus_whitelist(m, "cfi.pflash01");
     machine_class_add_sysbus_whitelist(m, "esp");
-    machine_class_add_sysbus_whitelist(m, "fw_cfg_io");
-    machine_class_add_sysbus_whitelist(m, "fw_cfg_mem");
     machine_class_add_sysbus_whitelist(m, "generic-sdhci");
     machine_class_add_sysbus_whitelist(m, "hpet");
     machine_class_add_sysbus_whitelist(m, "intel-iommu");
-- 
2.11.0.259.g40922b1
