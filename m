Received: from eggs.gnu.org ([2001:4830:134:3::10]:57990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshx-0005e3-3G
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshu-00038p-GH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:49 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshu-00037T-99
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:46 -0400
Received: by mail-wr0-x244.google.com with SMTP id o1so2498868wro.10
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:46 -0700 (PDT)
Received: from donizetti.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	x107sm1557951wrb.97.2018.03.13.15.47.43 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Mar 2018 15:47:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:29 +0100
Message-Id: <20180313224719.4954-20-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/69] hw/i386: make IOMMUs configurable via
 default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Allow distributions to disable the Intel and/or AMD IOMMU devices.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak   | 2 ++
 default-configs/x86_64-softmmu.mak | 2 ++
 hw/i386/Makefile.objs              | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 3326e3e0bb..9e5a29fa4a 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -63,3 +63,5 @@ CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
+CONFIG_VTD=y
+CONFIG_AMD_IOMMU=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 1c6cda1d9a..7baf91b921 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -63,3 +63,5 @@ CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
+CONFIG_VTD=y
+CONFIG_AMD_IOMMU=y
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index fd279e7584..fa87a14152 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -2,8 +2,8 @@ obj-$(CONFIG_KVM) += kvm/
 obj-y += multiboot.o
 obj-y += pc.o pc_piix.o pc_q35.o
 obj-y += pc_sysfw.o
-obj-y += x86-iommu.o intel_iommu.o
-obj-y += amd_iommu.o
+obj-$(CONFIG_VTD) += x86-iommu.o intel_iommu.o
+obj-$(CONFIG_AMD_IOMMU) += x86-iommu.o amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
-- 
2.14.3
