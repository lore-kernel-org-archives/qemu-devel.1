Received: from eggs.gnu.org ([209.51.188.92]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGj-0008NH-PC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGh-0005nG-RZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:47015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSGf-0005lq-T6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:59 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:36 +0800
Message-Id: <20190118112410.3010-10-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v3 09/43] hw/sparc/Makefile.objs: CONFIG_*
 for sun4m and leon3 created
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

CONFIG_LEON3 added to default-configs/sparc-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/sparc-softmmu.mak | 2 ++
 hw/sparc/Makefile.objs            | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
index 12f97eeb20..59a4a3d693 100644
--- a/default-configs/sparc-softmmu.mak
+++ b/default-configs/sparc-softmmu.mak
@@ -18,4 +18,6 @@ CONFIG_CS4231=y
 CONFIG_GRLIB=y
 CONFIG_STP2000=y
 CONFIG_ECCMEMCTL=y
+
 CONFIG_SUN4M=y
+CONFIG_LEON3=y
diff --git a/hw/sparc/Makefile.objs b/hw/sparc/Makefile.objs
index e2d0828c39..d57e33f83e 100644
--- a/hw/sparc/Makefile.objs
+++ b/hw/sparc/Makefile.objs
@@ -1 +1,3 @@
-obj-y += sun4m_iommu.o sun4m.o leon3.o
+obj-$(CONFIG_SUN4M) += sun4m_iommu.o
+obj-$(CONFIG_SUN4M) += sun4m.o
+obj-$(CONFIG_LEON3) += leon3.o
-- 
2.17.1
