Received: from eggs.gnu.org ([209.51.188.92]:45977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCg-00022L-Ar
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCe-0004HU-6G
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCd-0004F1-TP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:40 -0500
Received: by mail-wr1-x441.google.com with SMTP id n2so6633538wrw.8
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:43 +0100
Message-Id: <1551723614-1823-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/54] hyperv: express dependencies with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

remove default-configs/hyperv.mak and make dependencies
with Kconfig.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-41-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/hyperv.mak       | 1 -
 default-configs/i386-softmmu.mak | 1 -
 hw/hyperv/Kconfig                | 2 ++
 3 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 default-configs/hyperv.mak

diff --git a/default-configs/hyperv.mak b/default-configs/hyperv.mak
deleted file mode 100644
index bc38061..0000000
--- a/default-configs/hyperv.mak
+++ /dev/null
@@ -1 +0,0 @@
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
index 632c3a6..a1fa8ff 100644
--- a/hw/hyperv/Kconfig
+++ b/hw/hyperv/Kconfig
@@ -4,3 +4,5 @@ config HYPERV
 
 config HYPERV_TESTDEV
     bool
+    default y if TEST_DEVICES
+    depends on HYPERV
-- 
1.8.3.1
