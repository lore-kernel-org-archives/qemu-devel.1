Received: from eggs.gnu.org ([209.51.188.92]:60350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWk-0005N9-Rd
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWk-00043o-3U
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCWj-0002Nr-Rv
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:46 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:14 +0800
Message-Id: <20190123065618.3520-41-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 40/44] hyperv: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

remove default-configs/hyperv.mak and make dependencies
with Kconfig.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/hyperv.mak       | 2 --
 default-configs/i386-softmmu.mak | 1 -
 hw/hyperv/Kconfig                | 4 ++++
 3 files changed, 4 insertions(+), 3 deletions(-)
 delete mode 100644 default-configs/hyperv.mak

diff --git a/default-configs/hyperv.mak b/default-configs/hyperv.mak
deleted file mode 100644
index 5d0d9fd830..0000000000
--- a/default-configs/hyperv.mak
+++ /dev/null
@@ -1,2 +0,0 @@
-CONFIG_HYPERV=$(CONFIG_KVM)
-CONFIG_HYPERV_TESTDEV=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 38622f7132..ab57978b9a 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for i386-softmmu
 
-include hyperv.mak
 CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_IPMI=y
diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
index be724b7f8b..a178bac3da 100644
--- a/hw/hyperv/Kconfig
+++ b/hw/hyperv/Kconfig
@@ -1,5 +1,9 @@
 config HYPERV
     bool
+    default y if PC
+    depends on KVM
 
 config HYPERV_TESTDEV
     bool
+    default y if PC
+    depends on HYPERV
-- 
2.17.1
