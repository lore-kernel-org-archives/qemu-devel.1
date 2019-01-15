Received: from eggs.gnu.org ([209.51.188.92]:37690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYZ-0003EN-3j
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPRK-00018k-92
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:56305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPRK-00013X-0o
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:38 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:10:39 +0800
Message-Id: <20190115141108.934-9-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
References: <20190115141108.934-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 08/37] hw/sh4/Makefile.objs: New
 CONFIG_* varibales created for sh4 boards and device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

Make hw/sh4 configurable and add new CONFIG_* to the default-configs/sh4*-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/sh4-softmmu.mak   | 3 +++
 default-configs/sh4eb-softmmu.mak | 3 +++
 hw/sh4/Makefile.objs              | 6 +++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index caeccd55be..4b65489624 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -19,3 +19,6 @@ CONFIG_PCSPK=y
 CONFIG_I82374=y
 CONFIG_I8257=y
 CONFIG_MC146818RTC=y
+CONFIG_R2D=y
+CONFIG_SHIX=y
+CONFIG_SH7750=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 53b9cd7b5a..af71aa7f42 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -19,3 +19,6 @@ CONFIG_PCSPK=y
 CONFIG_I82374=y
 CONFIG_I8257=y
 CONFIG_MC146818RTC=y
+CONFIG_R2D=y
+CONFIG_SHIX=y
+CONFIG_SH7750=y
diff --git a/hw/sh4/Makefile.objs b/hw/sh4/Makefile.objs
index 2393702c57..70903d79a9 100644
--- a/hw/sh4/Makefile.objs
+++ b/hw/sh4/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += shix.o r2d.o
-
-obj-y += sh7750.o sh7750_regnames.o
+obj-$(CONFIG_R2D) +=  r2d.o
+obj-$(CONFIG_SHIX) += shix.o
+obj-$(CONFIG_SH7750) += sh7750.o sh7750_regnames.o
 obj-y += sh_pci.o
-- 
2.17.1
