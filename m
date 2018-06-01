Received: from eggs.gnu.org ([2001:4830:134:3::10]:50229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOneC-0006Ae-Jc
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOne9-0002QF-DF
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOne8-0002OM-RT
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79B584000B6E
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 17:15:24 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-107.ams2.redhat.com
	[10.36.117.107])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 06EEE217B400
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 17:15:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  1 Jun 2018 19:15:20 +0200
Message-Id: <20180601171521.1770-3-pbonzini@redhat.com>
In-Reply-To: <20180601171521.1770-1-pbonzini@redhat.com>
References: <20180601171521.1770-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 55/56] hw: allow compiling out SCSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/mips-softmmu-common.mak | 1 +
 default-configs/pci.mak                 | 1 +
 default-configs/riscv32-softmmu.mak     | 1 +
 default-configs/riscv64-softmmu.mak     | 1 +
 default-configs/s390x-softmmu.mak       | 1 +
 default-configs/sparc-softmmu.mak       | 1 +
 default-configs/usb.mak                 | 1 +
 hw/Makefile.objs                        | 2 +-
 8 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index e31f046b3b..fae2347ee7 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -4,6 +4,7 @@ include pci.mak
 include sound.mak
 include usb.mak
 CONFIG_ESP=y
+CONFIG_SCSI=y
 CONFIG_VGA_ISA=y
 CONFIG_VGA_ISA_MM=y
 CONFIG_VGA_CIRRUS=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 35e7596949..163dd814c7 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -15,6 +15,7 @@ CONFIG_PCNET_COMMON=y
 CONFIG_AC97=y
 CONFIG_HDA=y
 CONFIG_ES1370=y
+CONFIG_SCSI=y
 CONFIG_LSI_SCSI_PCI=y
 CONFIG_VMW_PVSCSI_SCSI_PCI=y
 CONFIG_MEGASAS_SCSI_PCI=y
diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index f9e742120c..9159a4a8af 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -2,3 +2,4 @@
 
 CONFIG_SERIAL=y
 CONFIG_VIRTIO=y
+CONFIG_SCSI=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index f9e742120c..9159a4a8af 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -2,3 +2,4 @@
 
 CONFIG_SERIAL=y
 CONFIG_VIRTIO=y
+CONFIG_SCSI=y
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 2f4bfe73b4..729033b25a 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -2,6 +2,7 @@ CONFIG_PCI=y
 CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
 CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
+CONFIG_SCSI=y
 CONFIG_VIRTIO=y
 CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
index 004b0f4e77..12f97eeb20 100644
--- a/default-configs/sparc-softmmu.mak
+++ b/default-configs/sparc-softmmu.mak
@@ -2,6 +2,7 @@
 
 CONFIG_ISA_BUS=y
 CONFIG_ECC=y
+CONFIG_SCSI=y
 CONFIG_ESP=y
 CONFIG_ESCC=y
 CONFIG_M48T59=y
diff --git a/default-configs/usb.mak b/default-configs/usb.mak
index f4b85684f0..e42cfeabbe 100644
--- a/default-configs/usb.mak
+++ b/default-configs/usb.mak
@@ -3,6 +3,7 @@ CONFIG_USB_TABLET_WACOM=y
 CONFIG_USB_STORAGE_BOT=y
 CONFIG_USB_STORAGE_UAS=y
 CONFIG_USB_STORAGE_MTP=y
+CONFIG_SCSI=y
 CONFIG_USB_SMARTCARD=y
 CONFIG_USB_AUDIO=y
 CONFIG_USB_SERIAL=y
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6a0ffe0afd..a19c1417ed 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -23,7 +23,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += nvram/
 devices-dirs-$(CONFIG_SOFTMMU) += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-$(CONFIG_SOFTMMU) += pcmcia/
-devices-dirs-$(CONFIG_SOFTMMU) += scsi/
+devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-$(CONFIG_SOFTMMU) += sd/
 devices-dirs-$(CONFIG_SOFTMMU) += ssi/
 devices-dirs-$(CONFIG_SOFTMMU) += timer/
-- 
2.17.0
