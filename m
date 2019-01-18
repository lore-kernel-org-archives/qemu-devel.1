Received: from eggs.gnu.org ([209.51.188.92]:35912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGm-0008Pg-0f
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGj-0005oe-Rg
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:46976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSGh-0005dV-RR
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:01 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:37 +0800
Message-Id: <20190118112410.3010-11-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v3 10/43] hw/lm32/Makefile.objs:
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
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

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
