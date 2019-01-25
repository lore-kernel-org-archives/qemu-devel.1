Received: from eggs.gnu.org ([209.51.188.92]:58507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP3-0007xN-Se
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP2-0002DP-Rw
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:01 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyP2-0002Co-KF
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:00 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so9615122wrs.8
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:08:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:07:05 +0100
Message-Id: <1548410831-19553-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 46/52] hyperv: express dependencies with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

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
 hw/hyperv/Kconfig                | 4 ++++
 3 files changed, 4 insertions(+), 3 deletions(-)
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
index 4aa04e4..42435d7 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for i386-softmmu
 
-include hyperv.mak
 CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_IPMI=y
diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
index be724b7..a178bac 100644
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
1.8.3.1
