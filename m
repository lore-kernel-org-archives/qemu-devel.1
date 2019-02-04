Received: from eggs.gnu.org ([209.51.188.92]:60165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7y-00067p-AB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7w-0004J5-7r
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:54 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7v-0003v4-4e
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:51 -0500
Received: by mail-wr1-x42f.google.com with SMTP id l9so901060wrt.13
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:01 +0100
Message-Id: <1549305379-51117-60-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 59/77] hw/sparc/Makefile.objs: CONFIG_* for
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
