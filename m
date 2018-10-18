Received: from eggs.gnu.org ([2001:4830:134:3::10]:48436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyc-0007i5-ES
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyY-0006aK-Mh
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:02 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:35102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyY-0006Yp-Bn
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id o17-v6so901132wmh.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:02 +0200
Message-Id: <1539894735-14232-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 35/48] default-configs: collect CONFIG_HYPERV*
 in hyperv.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Accumulate HYPERV config options in a dedicated file.  There are only
two so far; more will be added later.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082041.29380-5-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/hyperv.mak       | 2 ++
 default-configs/i386-softmmu.mak | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/hyperv.mak

diff --git a/default-configs/hyperv.mak b/default-configs/hyperv.mak
new file mode 100644
index 0000000..5d0d9fd
--- /dev/null
+++ b/default-configs/hyperv.mak
@@ -0,0 +1,2 @@
+CONFIG_HYPERV=$(CONFIG_KVM)
+CONFIG_HYPERV_TESTDEV=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 8c7d4a0..210cff2 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include sound.mak
 include usb.mak
+include hyperv.mak
 CONFIG_QXL=$(CONFIG_SPICE)
 CONFIG_VGA_ISA=y
 CONFIG_VGA_CIRRUS=y
@@ -58,7 +59,6 @@ CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
-CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
-- 
1.8.3.1
