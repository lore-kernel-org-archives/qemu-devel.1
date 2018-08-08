Received: from eggs.gnu.org ([2001:4830:134:3::10]:48310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxG-0000ZZ-MU
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxD-00084z-Vq
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnMxD-00084Q-P1
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 416D081663CF
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 11:48:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  8 Aug 2018 13:48:10 +0200
Message-Id: <20180808114830.7169-3-quintela@redhat.com>
In-Reply-To: <20180808114830.7169-1-quintela@redhat.com>
References: <20180808114830.7169-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/22] config: CONFIG_SERIAL* is already in
 pci.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 default-configs/alpha-softmmu.mak       | 2 --
 default-configs/arm-softmmu.mak         | 2 --
 default-configs/hppa-softmmu.mak        | 3 ---
 default-configs/i386-softmmu.mak        | 2 --
 default-configs/mips-softmmu-common.mak | 2 --
 default-configs/ppc-softmmu.mak         | 1 -
 default-configs/ppcemb-softmmu.mak      | 2 --
 default-configs/sh4-softmmu.mak         | 2 --
 default-configs/sh4eb-softmmu.mak       | 2 --
 default-configs/sparc64-softmmu.mak     | 2 --
 default-configs/x86_64-softmmu.mak      | 2 --
 11 files changed, 22 deletions(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index bbe361f01a..2d81a98441 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -2,8 +2,6 @@
 
 include pci.mak
 include usb.mak
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_I82374=y
 CONFIG_I8254=y
 CONFIG_I8257=y
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 834d45cfaf..4d33e9983d 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -5,8 +5,6 @@ include usb.mak
 CONFIG_VGA=y
 CONFIG_NAND=y
 CONFIG_ECC=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
 CONFIG_SD=y
 CONFIG_MAX7310=y
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index 4badc0521e..f3712afc27 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -1,8 +1,5 @@
 include pci.mak
 include usb.mak
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
-CONFIG_ISA_BUS=y
 CONFIG_I8259=y
 CONFIG_E1000_PCI=y
 CONFIG_IDE_ISA=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 8c7d4a0fa0..8827166ba1 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -15,8 +15,6 @@ CONFIG_IPMI_LOCAL=y
 CONFIG_IPMI_EXTERN=y
 CONFIG_ISA_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
 CONFIG_I8254=y
 CONFIG_PCSPK=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index fae2347ee7..9bae997ca0 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -9,8 +9,6 @@ CONFIG_VGA_ISA=y
 CONFIG_VGA_ISA_MM=y
 CONFIG_VGA_CIRRUS=y
 CONFIG_VMWARE_VGA=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
 CONFIG_I8254=y
 CONFIG_PCSPK=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 3181bbf163..d8dd969499 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -53,7 +53,6 @@ CONFIG_IDE_MACIO=y
 # For PReP
 CONFIG_PREP=y
 CONFIG_PREP_PCI=y
-CONFIG_SERIAL_ISA=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_RS6000_MC=y
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index ac44f150c6..f7a0d577d8 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -5,8 +5,6 @@ include sound.mak
 include usb.mak
 CONFIG_PPC4XX=y
 CONFIG_M48T59=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_I8257=y
 CONFIG_OPENPIC=y
 CONFIG_PFLASH_CFI01=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index caeccd55be..2b46d57ab4 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -2,8 +2,6 @@
 
 include pci.mak
 include usb.mak
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 53b9cd7b5a..279896a43d 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -2,8 +2,6 @@
 
 include pci.mak
 include usb.mak
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_SH4=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 52edafe547..e039ae3057 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -4,8 +4,6 @@ include pci.mak
 include usb.mak
 CONFIG_M48T59=y
 CONFIG_PTIMER=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
 CONFIG_PCKBD=y
 CONFIG_FDC=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 0390b4303c..85528ac9af 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -15,8 +15,6 @@ CONFIG_IPMI_LOCAL=y
 CONFIG_IPMI_EXTERN=y
 CONFIG_ISA_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
 CONFIG_I8254=y
 CONFIG_PCSPK=y
-- 
2.17.1
