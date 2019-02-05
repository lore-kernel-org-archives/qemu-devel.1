Received: from eggs.gnu.org ([209.51.188.92]:36638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gj-0002ia-AL
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gh-0004F6-Oz
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:25 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gh-0004EI-Fv
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:23 -0500
Received: by mail-wr1-x434.google.com with SMTP id q15so4662073wro.12
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:01 +0100
Message-Id: <1549390526-24246-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 51/76] hw/arm/Makefile.objs: CONFIG_ARM_VIRT
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
Cc: Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

Make ARM virt code configurable and the new CONFIG_ARM_VIRT
definitions added to the default-configs/arm-softmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-8-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 +
 hw/arm/Makefile.objs            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 32f4a4a..1db3639 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -148,6 +148,7 @@ CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
 CONFIG_ACPI=y
+CONFIG_ARM_VIRT=y
 CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
 CONFIG_GPIO_KEY=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 22b7f0e..fa40e8d 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,4 +1,5 @@
-obj-y += boot.o virt.o sysbus-fdt.o
+obj-y += boot.o sysbus-fdt.o
+obj-$(CONFIG_ARM_VIRT) += virt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
-- 
1.8.3.1
