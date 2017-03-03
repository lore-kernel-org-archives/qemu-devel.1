Received: from eggs.gnu.org ([2001:4830:134:3::10]:55655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjcMK-0006I8-89
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjcMH-0001Ex-Of
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:50:16 -0500
Message-Id: <cc6a20fc4a2748f24920c03ce64ae34af0f61799.1488504063.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1488504063.git.balaton@eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [Qemu-devel] [PATCH v3 13/13] ppc: Add SM501 device in config for
 ppc and ppcemb targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Fri, 03 Mar 2017 01:50:17 -0000
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

This is not used by default on any emulated machine yet but it is
still useful to have it compiled so it can be added from the command
line for clients that can use it (e.g. MorphOS has no driver for any
other emulated video cards but can output via SM501)

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 default-configs/ppc-softmmu.mak    | 1 +
 default-configs/ppcemb-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 09c1d45..1f1cd85 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -45,6 +45,7 @@ CONFIG_OPENPIC_KVM=$(and $(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
 CONFIG_LIBDECNUMBER=y
+CONFIG_SM501=y
 # For PReP
 CONFIG_SERIAL_ISA=y
 CONFIG_MC146818RTC=y
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index 7f56004..94340de 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -15,3 +15,4 @@ CONFIG_I8259=y
 CONFIG_XILINX=y
 CONFIG_XILINX_ETHLITE=y
 CONFIG_LIBDECNUMBER=y
+CONFIG_SM501=y
-- 
2.7.4
