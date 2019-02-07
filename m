Received: from eggs.gnu.org ([209.51.188.92]:57548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnw1-00023Y-Pt
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnw1-0002Li-0E
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:01 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnw0-0002L2-Px
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:00 -0500
Received: by mail-wm1-x343.google.com with SMTP id z5so830505wmf.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:04 +0100
Message-Id: <1549562254-41157-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 21/51] hyperv: express dependencies with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com, Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

remove default-configs/hyperv.mak and make dependencies
with Kconfig.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-41-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/hyperv.mak       | 2 --
 default-configs/i386-softmmu.mak | 1 -
 hw/hyperv/Kconfig                | 3 +++
 hw/i386/Kconfig                  | 1 +
 4 files changed, 4 insertions(+), 3 deletions(-)
 delete mode 100644 default-configs/hyperv.mak

diff --git a/default-configs/hyperv.mak b/default-configs/hyperv.mak
deleted file mode 100644
index 5d0d9fd..0000000
--- a/default-configs/hyperv.mak
+++ /dev/null
@@ -1,2 +0,0 @@
-CONFIG_HYPERV=$(CONFIG_KVM)
-CONFIG_HYPERV_TESTDEV=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 98552e1..c0826f5 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for i386-softmmu
 
-include hyperv.mak
 CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_IPMI=y
diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
index be724b7..a1fa8ff 100644
--- a/hw/hyperv/Kconfig
+++ b/hw/hyperv/Kconfig
@@ -1,5 +1,8 @@
 config HYPERV
     bool
+    depends on KVM
 
 config HYPERV_TESTDEV
     bool
+    default y if TEST_DEVICES
+    depends on HYPERV
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index bd84393..2da10af 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -4,6 +4,7 @@ config SEV
 
 config PC
     bool
+    imply HYPERV
     imply QXL
     imply SEV
     imply TPM_TIS
-- 
1.8.3.1
