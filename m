Received: from eggs.gnu.org ([209.51.188.92]:36761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gz-00031F-Lf
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gq-0004La-4q
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Go-0004Ja-Tu
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id g67so4752730wmd.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:08 +0100
Message-Id: <1549390526-24246-59-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 58/76] hw/sparc/Makefile.objs: CONFIG_* for
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
Cc: =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_LEON3 added to default-configs/sparc-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-15-yang.zhong@intel.com>
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
