Received: from eggs.gnu.org ([209.51.188.92]:35790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qd-0006Il-Aj
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qc-0002o1-Ky
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:60109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6qc-0002ib-DQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:18 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:20 +0800
Message-Id: <20190131073234.18037-14-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 13/27] hw/s390/Makefile.objs: Create new
 CONFIG_* variables for s390x boards and devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Make hw/s390x configurable and add new CONFIG_* to the
default-configs/s390x*-softmmu.mak. This will be used to
enable/disable vfio-ccw.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/s390x-softmmu.mak | 1 +
 hw/s390x/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 5eef375924..8bb7e438c8 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
 CONFIG_VFIO_CCW=$(CONFIG_LINUX)
 CONFIG_WDT_DIAG288=y
 CONFIG_VFIO_AP=$(CONFIG_LINUX)
+CONFIG_S390_CCW_VIRTIO=y
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index ca68806e44..a18c471913 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -5,7 +5,7 @@ obj-y += sclpquiesce.o
 obj-y += sclpcpu.o
 obj-y += ipl.o
 obj-y += css.o
-obj-y += s390-virtio-ccw.o
+obj-$(CONFIG_S390_CCW_VIRTIO) += s390-virtio-ccw.o
 obj-y += 3270-ccw.o
 obj-y += virtio-ccw.o
 obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
-- 
2.17.1
