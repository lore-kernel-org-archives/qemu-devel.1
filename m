Received: from eggs.gnu.org ([209.51.188.92]:36593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gh-0002hH-Tq
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gg-0004EN-VC
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gg-0004Dc-MZ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:22 -0500
Received: by mail-wr1-x42d.google.com with SMTP id v16so2846916wrn.11
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:00 +0100
Message-Id: <1549390526-24246-51-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 50/76] hw/i386/Makefile.objs: Build pc_piix* and
 pc_q35 boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

CONFIG_PIIX and CONFIG_Q35 created for the pc board object files. These
are enabled automatically at default-configs/i386-softmmu.mak and
default-configs/x86_64-softmmu.mak

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-7-yang.zhong@intel.com>
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
