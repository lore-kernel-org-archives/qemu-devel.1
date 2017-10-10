Received: from eggs.gnu.org ([2001:4830:134:3::10]:58351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1rkc-0004AU-MM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1rkY-00022x-NC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:27:02 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Oct 2017 12:26:55 +0200
Message-Id: <20171010102655.23322-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] build: remove CONFIG_LIBDECNUMBER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

It is used only by PPC TCG, so just move it in target/ppc/Makefile.objs

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target                           | 6 ------
 default-configs/ppc-linux-user.mak        | 1 -
 default-configs/ppc-softmmu.mak           | 1 -
 default-configs/ppc64-linux-user.mak      | 1 -
 default-configs/ppc64-softmmu.mak         | 1 -
 default-configs/ppc64abi32-linux-user.mak | 1 -
 default-configs/ppc64le-linux-user.mak    | 1 -
 default-configs/ppcemb-softmmu.mak        | 1 -
 target/ppc/Makefile.objs                  | 5 +++++
 9 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index a4b292d2e2..e4244c188a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -102,12 +102,6 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decContext.o
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decNumber.o
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/dpd/decimal32.o
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/dpd/decimal64.o
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/dpd/decimal128.o
-
 #########################################################
 # Linux user emulator target
 
diff --git a/default-configs/ppc-linux-user.mak b/default-configs/ppc-linux-user.mak
index 260ba41836..6273df2930 100644
--- a/default-configs/ppc-linux-user.mak
+++ b/default-configs/ppc-linux-user.mak
@@ -1,2 +1 @@
 # Default configuration for ppc-linux-user
-CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index d7a3755881..bb225c6e46 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -46,7 +46,6 @@ CONFIG_E500=y
 CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
-CONFIG_LIBDECNUMBER=y
 CONFIG_SM501=y
 # For PReP
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/ppc64-linux-user.mak b/default-configs/ppc64-linux-user.mak
index e731ce016e..422d3fbaeb 100644
--- a/default-configs/ppc64-linux-user.mak
+++ b/default-configs/ppc64-linux-user.mak
@@ -1,2 +1 @@
 # Default configuration for ppc64-linux-user
-CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index 9086475bf6..d1b3a6dd50 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -51,7 +51,6 @@ CONFIG_E500=y
 CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
-CONFIG_LIBDECNUMBER=y
 CONFIG_SM501=y
 # For pSeries
 CONFIG_XICS=$(CONFIG_PSERIES)
diff --git a/default-configs/ppc64abi32-linux-user.mak b/default-configs/ppc64abi32-linux-user.mak
index c244d07d56..1c657ec9bb 100644
--- a/default-configs/ppc64abi32-linux-user.mak
+++ b/default-configs/ppc64abi32-linux-user.mak
@@ -1,2 +1 @@
 # Default configuration for ppc64abi32-linux-user
-CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc64le-linux-user.mak b/default-configs/ppc64le-linux-user.mak
index 4ba4eae6ce..63f4269023 100644
--- a/default-configs/ppc64le-linux-user.mak
+++ b/default-configs/ppc64le-linux-user.mak
@@ -1,2 +1 @@
 # Default configuration for ppc64le-linux-user
-CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index 635923a166..13917fb7a3 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -15,5 +15,4 @@ CONFIG_PTIMER=y
 CONFIG_I8259=y
 CONFIG_XILINX=y
 CONFIG_XILINX_ETHLITE=y
-CONFIG_LIBDECNUMBER=y
 CONFIG_SM501=y
diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index f92ba67ebd..ba61012bef 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -15,5 +15,10 @@ obj-y += int_helper.o
 obj-y += timebase_helper.o
 obj-y += misc_helper.o
 obj-y += mem_helper.o
+obj-y += ../../libdecnumber/decContext.o
+obj-y += ../../libdecnumber/decNumber.o
+obj-y += ../../libdecnumber/dpd/decimal32.o
+obj-y += ../../libdecnumber/dpd/decimal64.o
+obj-y += ../../libdecnumber/dpd/decimal128.o
 obj-$(CONFIG_USER_ONLY) += user_only_helper.o
 obj-y += gdbstub.o
-- 
2.14.2
