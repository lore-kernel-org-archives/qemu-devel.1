Received: from eggs.gnu.org ([209.51.188.92]:48714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvyZd-0002iU-9K
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvyZc-0006DG-KE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:08:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:62698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gvyZc-0006Co-CX
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:08:08 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 19 Feb 2019 14:07:18 +0800
Message-Id: <20190219060719.8211-2-richardw.yang@linux.intel.com>
In-Reply-To: <20190219060719.8211-1-richardw.yang@linux.intel.com>
References: <20190219060719.8211-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] pc-dimm: remove check on pc-dimm
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
Cc: mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, Wei Yang <richardw.yang@linux.intel.com>

Function acpi_memory_plug_cb() is only invoked when dev is a PCDIMM,
which is hotpluggable. This means it is not necessary to check this
property again.

This patch removes this check.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/acpi/memory_hotplug.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 8c7c1013f3..b19673d337 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -266,10 +266,6 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
     MemStatus *mdev;
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
 
-    if (!dc->hotpluggable) {
-        return;
-    }
-
     mdev = acpi_memory_slot_status(mem_st, dev, errp);
     if (!mdev) {
         return;
-- 
2.19.1
