Received: from eggs.gnu.org ([209.51.188.92]:35838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGd-0008It-Oc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGZ-0005hl-Os
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:46974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSGX-0005cV-Rv
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:51 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:31 +0800
Message-Id: <20190118112410.3010-5-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v3 04/43] hw/m68k/Makefile.objs:
 Conditionally build boards
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

CONFIG_AN5206, CONFIG_MCF5206 and CONFIG_MCF5208 make
variables created for m68k boards, and added to
default-configs/m86k-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/m68k-softmmu.mak | 2 ++
 hw/m68k/Makefile.objs            | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index 60f7cdfbf2..27f5274244 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -2,3 +2,5 @@
 
 CONFIG_COLDFIRE=y
 CONFIG_PTIMER=y
+CONFIG_AN5206=y
+CONFIG_MCF5208=y
diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
index d1f089c08a..482f8477b4 100644
--- a/hw/m68k/Makefile.objs
+++ b/hw/m68k/Makefile.objs
@@ -1,2 +1,2 @@
-obj-y += an5206.o mcf5208.o
-obj-y += mcf5206.o mcf_intc.o
+obj-$(CONFIG_AN5206) += an5206.o mcf5206.o
+obj-$(CONFIG_MCF5208) += mcf5208.o mcf_intc.o
-- 
2.17.1
