Received: from eggs.gnu.org ([209.51.188.92]:57930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOi-0007XP-IW
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOg-0001lc-U2
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:40 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:52261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOe-0001cp-QT
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id m1so6162519wml.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:33 +0100
Message-Id: <1548410831-19553-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/52] hw/sparc/Makefile.objs: CONFIG_* for
 sun4m and leon3 created
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_LEON3 added to default-configs/sparc-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-11-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/sparc-softmmu.mak | 2 ++
 hw/sparc/Makefile.objs            | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
index 12f97ee..59a4a3d 100644
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
index e2d0828..d57e33f 100644
--- a/hw/sparc/Makefile.objs
+++ b/hw/sparc/Makefile.objs
@@ -1 +1,3 @@
-obj-y += sun4m_iommu.o sun4m.o leon3.o
+obj-$(CONFIG_SUN4M) += sun4m_iommu.o
+obj-$(CONFIG_SUN4M) += sun4m.o
+obj-$(CONFIG_LEON3) += leon3.o
-- 
1.8.3.1
