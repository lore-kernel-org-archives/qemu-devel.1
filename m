Received: from eggs.gnu.org ([2001:4830:134:3::10]:47761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eIcC8-0005VN-RF
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eIcC6-00058y-OS
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eIcC6-00058r-IT
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:38 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sat, 25 Nov 2017 13:16:09 -0200
Message-Id: <20171125151610.20547-6-ehabkost@redhat.com>
In-Reply-To: <20171125151610.20547-1-ehabkost@redhat.com>
References: <20171125151610.20547-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] xen: Add only xen-sysdev to dynamic
 sysbus device list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

There's no need to make the machine allow every possible sysbus
device.  We can now just add xen-sysdev to the allowed list.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v1 -> v2:
* New patch added to series
---
 hw/xen/xen_backend.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 82380ea9ee..7445b506ac 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -564,12 +564,7 @@ static void xen_set_dynamic_sysbus(void)
     ObjectClass *oc = object_get_class(machine);
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    /*
-     * Emulate old mc->has_dynamic_sysbus=true assignment
-     *
-     *TODO: add only Xen devices to the list
-     */
-    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_XENSYSDEV);
 }
 
 int xen_be_register(const char *type, struct XenDevOps *ops)
-- 
2.13.6
