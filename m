Received: from eggs.gnu.org ([209.51.188.92]:36055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6rS-0007Ac-FV
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6rQ-0003JA-Pa
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:60113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6rP-0002jN-BR
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:08 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:30 +0800
Message-Id: <20190131073234.18037-24-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 23/27] hw/moxie/Makefile.objs: Conditionally
 build moxie
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

CONFIG_MOXIE added for moxiesim board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/moxie-softmmu.mak | 1 +
 hw/moxie/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/moxie-softmmu.mak b/default-configs/moxie-softmmu.mak
index e00d099994..17ba906dc2 100644
--- a/default-configs/moxie-softmmu.mak
+++ b/default-configs/moxie-softmmu.mak
@@ -5,3 +5,4 @@ CONFIG_MC146818RTC=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_VGA=y
+CONFIG_MOXIESIM=y
diff --git a/hw/moxie/Makefile.objs b/hw/moxie/Makefile.objs
index bfc90012fd..ddbf300f54 100644
--- a/hw/moxie/Makefile.objs
+++ b/hw/moxie/Makefile.objs
@@ -1,2 +1,2 @@
 # moxie boards
-obj-y += moxiesim.o
+obj-$(CONFIG_MOXIESIM) += moxiesim.o
-- 
2.17.1
