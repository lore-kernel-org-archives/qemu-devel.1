Received: from eggs.gnu.org ([209.51.188.92]:59588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCUq-0003dd-SS
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCUp-0002U0-Rw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:36921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCUo-0002NF-Sy
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:47 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:55:37 +0800
Message-Id: <20190123065618.3520-4-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v4 03/44] hw/i386/Makefile.objs: Build
 pc_piix* and pc_q35 boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Paolo Bonzini <pbonzini@redhat.com>

CONFIG_PIIX and CONFIG_Q35 created for the pc board object files. These
are enabled automatically at default-configs/i386-softmmu.mak and
default-configs/x86_64-softmmu.mak

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/i386-softmmu.mak | 2 ++
 hw/i386/Makefile.objs            | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 48da9968cc..71c9f6fbcb 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -68,3 +68,5 @@ CONFIG_SEV=$(CONFIG_KVM)
 CONFIG_VTD=y
 CONFIG_AMD_IOMMU=y
 CONFIG_PAM=y
+CONFIG_I440FX=y
+CONFIG_Q35=y
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index fa87a14152..3de7ca2bb9 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -1,6 +1,8 @@
 obj-$(CONFIG_KVM) += kvm/
 obj-y += multiboot.o
-obj-y += pc.o pc_piix.o pc_q35.o
+obj-y += pc.o
+obj-$(CONFIG_I440FX) += pc_piix.o
+obj-$(CONFIG_Q35) += pc_q35.o
 obj-y += pc_sysfw.o
 obj-$(CONFIG_VTD) += x86-iommu.o intel_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += x86-iommu.o amd_iommu.o
-- 
2.17.1
