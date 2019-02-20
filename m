Received: from eggs.gnu.org ([209.51.188.92]:39478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwG9n-0001Mc-Al
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwG9U-0006dg-6z
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:54:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:25996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gwG9R-0005XQ-Ib
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:54:17 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 20 Feb 2019 08:51:22 +0800
Message-Id: <20190220005124.24224-2-richardw.yang@linux.intel.com>
In-Reply-To: <20190220005124.24224-1-richardw.yang@linux.intel.com>
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/3] pc-dimm: remove check on pc-dimm
 hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, philmd@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

Function acpi_memory_plug_cb() is only invoked when dev is a PCDIMM,
which is hotpluggable. This means it is not necessary to check this
property again.

This patch removes this check.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v2:
  * remove unused dc
---
 hw/acpi/memory_hotplug.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 8c7c1013f3..cb5284d36f 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -264,11 +264,6 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp)
 {
     MemStatus *mdev;
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
-
-    if (!dc->hotpluggable) {
-        return;
-    }
 
     mdev = acpi_memory_slot_status(mem_st, dev, errp);
     if (!mdev) {
-- 
2.19.1
