Received: from eggs.gnu.org ([209.51.188.92]:36810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H7-00037K-KP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H5-0004TQ-Nm
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:54475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5H3-0004MZ-GH
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:46 -0500
Received: by mail-wm1-x32d.google.com with SMTP id a62so4681191wmh.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:13 +0100
Message-Id: <1549390526-24246-64-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 63/76] hw/sparc64/Makefile.objs: Create CONFIG_*
 for sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

Add the new configs to default-configs/sparc64-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-20-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/sparc64-softmmu.mak | 2 ++
 hw/sparc64/Makefile.objs            | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index ce63d47..1fae488 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -17,3 +17,5 @@ CONFIG_SUNHME=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_SUN4V_RTC=y
+CONFIG_SUN4U=y
+CONFIG_NIAGARA=y
diff --git a/hw/sparc64/Makefile.objs b/hw/sparc64/Makefile.objs
index 117e0ff..af0525c 100644
--- a/hw/sparc64/Makefile.objs
+++ b/hw/sparc64/Makefile.objs
@@ -1,4 +1,4 @@
 obj-y += sparc64.o
-obj-y += sun4u_iommu.o
-obj-y += sun4u.o
-obj-y += niagara.o
\ No newline at end of file
+obj-$(CONFIG_SUN4U) += sun4u_iommu.o
+obj-$(CONFIG_SUN4U) += sun4u.o
+obj-$(CONFIG_NIAGARA) += niagara.o
-- 
1.8.3.1
