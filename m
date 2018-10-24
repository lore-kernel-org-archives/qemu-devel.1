Received: from eggs.gnu.org ([2001:4830:134:3::10]:43353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFpu-0004eU-Ie
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFps-000661-8v
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gFFps-00064a-2O
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:20 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 Oct 2018 10:52:05 +0100
Message-Id: <1540374728-27579-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1540374728-27579-1-git-send-email-thuth@redhat.com>
References: <1540374728-27579-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] configs: Add a CONFIG_SMC37C669 switch for
 the "smc37c669-superio" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

This device is not user-creatable and currently only used for the
"alpha" target. So if the user does not want to compile alpha-softmmu,
we should also not compile this device. Add a proper config switch to
be able to compile this more flexibly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/alpha-softmmu.mak | 1 +
 hw/isa/Makefile.objs              | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index bbe361f..eb58b40 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -19,3 +19,4 @@ CONFIG_IDE_CMD646=y
 CONFIG_I8259=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
+CONFIG_SMC37C669=y
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index 83e06f6..9e106df 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -1,9 +1,10 @@
 common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
-common-obj-$(CONFIG_ISA_BUS) += isa-superio.o smc37c669-superio.o
+common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
 common-obj-$(CONFIG_APM) += apm.o
 common-obj-$(CONFIG_I82378) += i82378.o
 common-obj-$(CONFIG_PC87312) += pc87312.o
 common-obj-$(CONFIG_PIIX4) += piix4.o
 common-obj-$(CONFIG_VT82C686) += vt82c686.o
+common-obj-$(CONFIG_SMC37C669) += smc37c669-superio.o
 
 obj-$(CONFIG_LPC_ICH9) += lpc_ich9.o
-- 
1.8.3.1
