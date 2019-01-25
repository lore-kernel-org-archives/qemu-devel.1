Received: from eggs.gnu.org ([209.51.188.92]:57928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOi-0007XO-I6
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOe-0001jt-TU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:39 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOe-0001g4-CE
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:36 -0500
Received: by mail-wr1-x443.google.com with SMTP id p7so9671438wru.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:38 +0100
Message-Id: <1548410831-19553-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 19/52] hw/sparc64/Makefile.objs: Create
 CONFIG_* for sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

From: Yang Zhong <yang.zhong@intel.com>

Add the new configs to default-configs/sparc64-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-16-yang.zhong@intel.com>
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
