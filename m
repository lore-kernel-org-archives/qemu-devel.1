Received: from eggs.gnu.org ([209.51.188.92]:37703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYZ-0003Ex-ID
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPRJ-000188-PM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:56305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPRJ-00013X-H6
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:37 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:10:35 +0800
Message-Id: <20190115141108.934-5-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
References: <20190115141108.934-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 04/37] hw/m68k/Makefile.objs:
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
 default-configs/m68k-softmmu.mak | 3 +++
 hw/m68k/Makefile.objs            | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index 60f7cdfbf2..a179da9077 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -2,3 +2,6 @@
 
 CONFIG_COLDFIRE=y
 CONFIG_PTIMER=y
+CONFIG_AN5206=y
+CONFIG_MCF5206=y
+CONFIG_MCF5208=y
diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
index d1f089c08a..fa287edd0b 100644
--- a/hw/m68k/Makefile.objs
+++ b/hw/m68k/Makefile.objs
@@ -1,2 +1,3 @@
-obj-y += an5206.o mcf5208.o
-obj-y += mcf5206.o mcf_intc.o
+obj-$(CONFIG_AN5206) += an5206.o
+obj-$(CONFIG_MCF5206) += mcf5206.o
+obj-$(CONFIG_MCF5208) += mcf5208.o mcf_intc.o
-- 
2.17.1
