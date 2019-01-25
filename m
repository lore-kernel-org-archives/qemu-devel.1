Received: from eggs.gnu.org ([209.51.188.92]:57810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOT-0007L4-9s
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOR-0001Yv-0q
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:24 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOQ-0001WS-P2
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:22 -0500
Received: by mail-wm1-x342.google.com with SMTP id r24so4413450wmh.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:25 +0100
Message-Id: <1548410831-19553-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/52] hw/i386/Makefile.objs: Build pc_piix*
 and pc_q35 boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

CONFIG_PIIX and CONFIG_Q35 created for the pc board object files. These
are enabled automatically at default-configs/i386-softmmu.mak and
default-configs/x86_64-softmmu.mak

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-4-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak | 2 ++
 hw/i386/Makefile.objs            | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 48da996..71c9f6f 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -68,3 +68,5 @@ CONFIG_SEV=$(CONFIG_KVM)
 CONFIG_VTD=y
 CONFIG_AMD_IOMMU=y
 CONFIG_PAM=y
+CONFIG_I440FX=y
+CONFIG_Q35=y
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index fa87a14..3de7ca2 100644
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
1.8.3.1
