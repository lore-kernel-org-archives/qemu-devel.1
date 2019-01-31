Received: from eggs.gnu.org ([209.51.188.92]:35841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qt-0006Xi-8f
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qn-0002u2-HE
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:60061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6ql-0002Yq-2K
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:28 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:22 +0800
Message-Id: <20190131073234.18037-16-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 15/27] hw/lm32/Makefile.objs: Conditionally
 build lm32 and milkmyst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

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
