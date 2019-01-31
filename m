Received: from eggs.gnu.org ([209.51.188.92]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qG-00062L-Ft
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qF-0002c4-OC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:60061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6qF-0002Yq-Gp
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:55 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:12 +0800
Message-Id: <20190131073234.18037-6-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 05/27] build: actually use CONFIG_PAM
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

Do not link it unconditionally into all binaries.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/i386-softmmu.mak | 1 +
 hw/pci-host/Makefile.objs        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 2f919df346..48da9968cc 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -67,3 +67,4 @@ CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
 CONFIG_VTD=y
 CONFIG_AMD_IOMMU=y
+CONFIG_PAM=y
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 073d5124d1..a9cd3e022d 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += pam.o
+common-obj-$(CONFIG_PAM) += pam.o
 
 # PPC devices
 common-obj-$(CONFIG_PREP_PCI) += prep.o
-- 
2.17.1
