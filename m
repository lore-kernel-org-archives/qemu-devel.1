Received: from eggs.gnu.org ([209.51.188.92]:50003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppfb-0000IQ-5h
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppfa-0002OJ-Cw
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:24:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:56071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gppfa-0002MY-2N
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:24:54 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Sat,  2 Feb 2019 15:24:30 +0800
Message-Id: <20190202072456.6468-2-yang.zhong@intel.com>
In-Reply-To: <20190202072456.6468-1-yang.zhong@intel.com>
References: <20190202072456.6468-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 01/27] arm: disable CONFIG_SERIAL_ISA
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

From: Paolo Bonzini <pbonzini@redhat.com>

ARM should not have an ISA bus, this device should not be enabled.
Kconfig allows to clean up the dependencies and remove CONFIG_ISA_BUS=y
from ARM, and then catches a contradiction between the hardcoded
CONFIG_SERIAL_ISA=y and CONFIG_ISA_BUS=n.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index be88870799..d7b540cb25 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -6,7 +6,6 @@ CONFIG_VGA=y
 CONFIG_NAND=y
 CONFIG_ECC=y
 CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
 CONFIG_SD=y
 CONFIG_MAX7310=y
-- 
2.17.1
