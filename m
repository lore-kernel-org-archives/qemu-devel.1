Received: from eggs.gnu.org ([2001:4830:134:3::10]:43877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV1p-0002up-7f
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV1n-0003XY-LX
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvV1n-0003WS-Fs
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:26:11 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  4 Apr 2017 17:24:28 -0300
Message-Id: <20170404202429.14643-21-ehabkost@redhat.com>
In-Reply-To: <20170404202429.14643-1-ehabkost@redhat.com>
References: <20170404202429.14643-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/21] xen-sysdev: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juergen Gross <jgross@suse.com>, sstabellini@kernel.org

TYPE_XENSYSDEV is only used internally by xen_be_init(), and is
not supposed to be plugged/unplugged dynamically. Remove the
user_creatable flag from the device class.

Cc: Juergen Gross <jgross@suse.com>,
Cc: Peter Maydell <peter.maydell@linaro.org>,
Cc: Thomas Huth <thuth@redhat.com>
Cc: sstabellini@kernel.org
Cc: Markus Armbruster <armbru@redhat.com>,
Cc: Marcel Apfelbaum <marcel@redhat.com>,
Cc: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v1 -> v2:
* (New patch added to series)
---
 hw/xen/xen_backend.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 56df27992f..e48c5f48fc 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -663,11 +663,6 @@ static void xen_sysdev_class_init(ObjectClass *klass, void *data)
     k->init = xen_sysdev_init;
     dc->props = xen_sysdev_properties;
     dc->bus_type = TYPE_XENSYSBUS;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo xensysdev_info = {
-- 
2.11.0.259.g40922b1
