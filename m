Received: from eggs.gnu.org ([209.51.188.92]:59814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVd-0004OS-UA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVW-0003Lf-NH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCVR-0002Nr-3O
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:25 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:55:54 +0800
Message-Id: <20190123065618.3520-21-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 20/44] hw/openrisc/Makefile.objs: Create
 CONFIG_* for openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

Add the new configs to default-configs/or1k-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/or1k-softmmu.mak | 1 +
 hw/openrisc/Makefile.objs        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/or1k-softmmu.mak b/default-configs/or1k-softmmu.mak
index 6f5824fd48..85a7e696c7 100644
--- a/default-configs/or1k-softmmu.mak
+++ b/default-configs/or1k-softmmu.mak
@@ -3,3 +3,4 @@
 CONFIG_SERIAL=y
 CONFIG_OPENCORES_ETH=y
 CONFIG_OMPIC=y
+CONFIG_OPENRISC=y
diff --git a/hw/openrisc/Makefile.objs b/hw/openrisc/Makefile.objs
index 61246b149b..8dc413c3b2 100644
--- a/hw/openrisc/Makefile.objs
+++ b/hw/openrisc/Makefile.objs
@@ -1,2 +1,2 @@
 obj-y = pic_cpu.o cputimer.o
-obj-y += openrisc_sim.o 
+obj-$(CONFIG_OPENRISC) += openrisc_sim.o
-- 
2.17.1
