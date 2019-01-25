Received: from eggs.gnu.org ([209.51.188.92]:57857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOb-0007Qe-Tm
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOT-0001Zp-1p
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:29 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOQ-0001Xh-Sy
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:23 -0500
Received: by mail-wr1-x42e.google.com with SMTP id v13so9615057wrw.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:26 +0100
Message-Id: <1548410831-19553-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/52] hw/arm/Makefile.objs: CONFIG_VIRT
 created for virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

From: Yang Zhong <yang.zhong@intel.com>

make virt code configurable and the new CONFIG_VIRT definitions
added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
in arm board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-5-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 +
 hw/arm/Makefile.objs            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 107f801..68deb1c 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -147,6 +147,7 @@ CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
 CONFIG_ACPI=y
+CONFIG_VIRT=y
 CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
 CONFIG_GPIO_KEY=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 50c7b4a..41dab8a 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,4 +1,5 @@
-obj-y += boot.o virt.o sysbus-fdt.o
+obj-y += boot.o sysbus-fdt.o
+obj-$(CONFIG_VIRT) += virt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
-- 
1.8.3.1
