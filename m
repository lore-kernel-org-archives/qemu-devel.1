Received: from eggs.gnu.org ([2001:4830:134:3::10]:41211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeT-0005wb-1D
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeP-000730-Rc
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:32 -0500
Received: from [59.151.112.132] (port=30367 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeP-00071q-Fo
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:29 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Sat, 31 Dec 2016 17:13:08 +0800
Message-ID: <1483175588-17006-5-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC v11 4/4] vfio: add 'aer' property to expose
 aercap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, izumi.taku@jp.fujitsu.com, Chen Fan <chen.fan.fnst@cn.fujitsu.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>

Add 'aer' property, let user choose whether expose the aer capability
or not. Should disable aer feature by default, because only non-fatal
error is supported now.

Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/vfio/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9861f72..fc9db66 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3057,6 +3057,8 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
+    DEFINE_PROP_BIT("aer", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_AER_BIT, false),
     /*
      * TODO - support passed fds... is this necessary?
      * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
-- 
1.8.3.1
