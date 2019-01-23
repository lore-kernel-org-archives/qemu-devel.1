Received: from eggs.gnu.org ([209.51.188.92]:59635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCUs-0003gf-C4
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCUr-0002Vp-CP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:36921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCUr-0002NF-43
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:49 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:55:43 +0800
Message-Id: <20190123065618.3520-10-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v4 09/44] hw/sh4/Makefile.objs: New
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
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

Make hw/sh4 configurable and add new CONFIG_* to the default-configs/sh4*-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/sh4-softmmu.mak   | 2 ++
 default-configs/sh4eb-softmmu.mak | 2 ++
 hw/sh4/Makefile.objs              | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index caeccd55be..1fdb009151 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -19,3 +19,5 @@ CONFIG_PCSPK=y
 CONFIG_I82374=y
 CONFIG_I8257=y
 CONFIG_MC146818RTC=y
+CONFIG_R2D=y
+CONFIG_SHIX=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 53b9cd7b5a..3b550a5fe8 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -19,3 +19,5 @@ CONFIG_PCSPK=y
 CONFIG_I82374=y
 CONFIG_I8257=y
 CONFIG_MC146818RTC=y
+CONFIG_R2D=y
+CONFIG_SHIX=y
diff --git a/hw/sh4/Makefile.objs b/hw/sh4/Makefile.objs
index 2393702c57..2a707f9473 100644
--- a/hw/sh4/Makefile.objs
+++ b/hw/sh4/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += shix.o r2d.o
-
 obj-y += sh7750.o sh7750_regnames.o
 obj-y += sh_pci.o
+obj-$(CONFIG_R2D) +=  r2d.o
+obj-$(CONFIG_SHIX) += shix.o
-- 
2.17.1
