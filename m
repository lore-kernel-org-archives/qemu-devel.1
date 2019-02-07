Received: from eggs.gnu.org ([209.51.188.92]:57341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvt-0001vt-Fx
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvr-0002DE-PC
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvr-00027h-Ex
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:51 -0500
Received: by mail-wr1-x444.google.com with SMTP id q1so809902wrp.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:56:51 +0100
Message-Id: <1549562254-41157-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/51] kconfig: introduce CONFIG_TEST_DEVICES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

Devices that are mostly used for testing purposes (for example in
endianness-test) will be moved under a new symbol CONFIG_TEST_DEVICES
that can be disabled in the default-configs file.  This makes
it easier to drop this code from QEMU if desirable.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak       | 1 +
 default-configs/i386-softmmu.mak        | 1 +
 default-configs/mips-softmmu-common.mak | 1 +
 default-configs/ppc-softmmu.mak         | 1 +
 default-configs/sh4-softmmu.mak         | 1 +
 default-configs/sh4eb-softmmu.mak       | 1 +
 default-configs/sparc64-softmmu.mak     | 1 +
 hw/Kconfig                              | 3 +++
 8 files changed, 10 insertions(+)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 49cb7ce..74501ca 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -18,5 +18,6 @@ CONFIG_IDE_CMD646=y
 CONFIG_I8259=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
+CONFIG_TEST_DEVICES=y
 CONFIG_SMC37C669=y
 CONFIG_DP264=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 412c8c5..1d43fb2 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -4,6 +4,7 @@ include pci.mak
 include sound.mak
 include usb.mak
 include hyperv.mak
+CONFIG_TEST_DEVICES=y
 CONFIG_VGA_ISA=y
 CONFIG_VGA_CIRRUS=y
 CONFIG_VMWARE_VGA=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index ded7498..331bdc5 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -41,3 +41,4 @@ CONFIG_MALTA=y
 CONFIG_MIPSSIM=y
 CONFIG_ACPI_SMBUS=y
 CONFIG_SMBUS_EEPROM=y
+CONFIG_TEST_DEVICES=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 90118cb..a58d81a 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_TEST_DEVICES=y
 
 # For embedded PPCs:
 CONFIG_PPC4XX=y
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 1fdb009..38c7290 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -12,6 +12,7 @@ CONFIG_SM501=y
 CONFIG_I2C=y
 CONFIG_DDC=y
 CONFIG_ISA_TESTDEV=y
+CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
 CONFIG_I8259=y
 CONFIG_I8254=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 3b550a5..c966cca 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -12,6 +12,7 @@ CONFIG_SM501=y
 CONFIG_I2C=y
 CONFIG_DDC=y
 CONFIG_ISA_TESTDEV=y
+CONFIG_TEST_DEVICES=y
 CONFIG_I82378=y
 CONFIG_I8259=y
 CONFIG_I8254=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 1fae488..415d4e0 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -16,6 +16,7 @@ CONFIG_SIMBA=y
 CONFIG_SUNHME=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
+CONFIG_TEST_DEVICES=y
 CONFIG_SUN4V_RTC=y
 CONFIG_SUN4U=y
 CONFIG_NIAGARA=y
diff --git a/hw/Kconfig b/hw/Kconfig
index c4f1547..f902c8f 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -61,6 +61,9 @@ source unicore32/Kconfig
 source xtensa/Kconfig
 
 # Symbols used by multiple targets
+config TEST_DEVICES
+    bool
+
 config XILINX
     bool
 
-- 
1.8.3.1
