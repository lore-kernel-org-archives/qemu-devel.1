Received: from eggs.gnu.org ([209.51.188.92]:59660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCUt-0003hN-1y
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCUr-0002WC-Nn
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCUr-0002Nr-EX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:49 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:55:45 +0800
Message-Id: <20190123065618.3520-12-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v4 11/44] hw/lm32/Makefile.objs:
 Conditionally build lm32 and milkmyst
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

CONFIG_LM32 and CONFIG_MILKYMIST added for lm32 and milkmyst build.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/lm32/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/lm32/Makefile.objs b/hw/lm32/Makefile.objs
index ea6418ae59..c3941866c7 100644
--- a/hw/lm32/Makefile.objs
+++ b/hw/lm32/Makefile.objs
@@ -1,3 +1,3 @@
 # LM32 boards
-obj-y += lm32_boards.o
-obj-y += milkymist.o
+obj-$(CONFIG_LM32) += lm32_boards.o
+obj-$(CONFIG_MILKYMIST) += milkymist.o
-- 
2.17.1
