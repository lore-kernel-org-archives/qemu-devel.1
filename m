Received: from eggs.gnu.org ([209.51.188.92]:57804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOT-0007Kz-6L
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOQ-0001Yn-UZ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOP-0001VH-6H
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id 96so9656144wrb.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:24 +0100
Message-Id: <1548410831-19553-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/52] build: actually use CONFIG_PAM
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

Do not link it unconditionally into all binaries.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-3-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak | 1 +
 hw/pci-host/Makefile.objs        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 2f919df..48da996 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -67,3 +67,4 @@ CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
 CONFIG_VTD=y
 CONFIG_AMD_IOMMU=y
+CONFIG_PAM=y
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 073d512..a9cd3e0 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += pam.o
+common-obj-$(CONFIG_PAM) += pam.o
 
 # PPC devices
 common-obj-$(CONFIG_PREP_PCI) += prep.o
-- 
1.8.3.1
