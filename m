Received: from eggs.gnu.org ([209.51.188.92]:50402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppgU-0001Bd-9X
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppgH-0002yL-Pg
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:25:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:56076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gppg8-0002hI-3p
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:25:33 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Sat,  2 Feb 2019 15:24:42 +0800
Message-Id: <20190202072456.6468-14-yang.zhong@intel.com>
In-Reply-To: <20190202072456.6468-1-yang.zhong@intel.com>
References: <20190202072456.6468-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 13/27] hw/s390/Makefile.objs: Create new
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
