Received: from eggs.gnu.org ([209.51.188.92]:50899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gpphH-0001uh-1l
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gpphB-0003gz-DI
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:26:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:56083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gpph4-0002jk-J1
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:26:28 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Sat,  2 Feb 2019 15:24:53 +0800
Message-Id: <20190202072456.6468-25-yang.zhong@intel.com>
In-Reply-To: <20190202072456.6468-1-yang.zhong@intel.com>
References: <20190202072456.6468-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 24/27] hw/openrisc/Makefile.objs: Create
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
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com

Add the new configs to default-configs/or1k-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/or1k-softmmu.mak | 1 +
 hw/openrisc/Makefile.objs        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/or1k-softmmu.mak b/default-configs/or1k-softmmu.mak
index 6f5824fd48..6a0f2ef6cf 100644
--- a/default-configs/or1k-softmmu.mak
+++ b/default-configs/or1k-softmmu.mak
@@ -3,3 +3,4 @@
 CONFIG_SERIAL=y
 CONFIG_OPENCORES_ETH=y
 CONFIG_OMPIC=y
+CONFIG_OR1K_SIM=y
diff --git a/hw/openrisc/Makefile.objs b/hw/openrisc/Makefile.objs
index 61246b149b..aa04de7f5a 100644
--- a/hw/openrisc/Makefile.objs
+++ b/hw/openrisc/Makefile.objs
@@ -1,2 +1,2 @@
 obj-y = pic_cpu.o cputimer.o
-obj-y += openrisc_sim.o 
+obj-$(CONFIG_OR1K_SIM) += openrisc_sim.o
-- 
2.17.1
