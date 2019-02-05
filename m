Received: from eggs.gnu.org ([209.51.188.92]:36697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gn-0002n8-B0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gl-0004IH-52
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:29 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gk-0004HE-HF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:26 -0500
Received: by mail-wr1-x42f.google.com with SMTP id r2so4686334wrv.10
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:04 +0100
Message-Id: <1549390526-24246-55-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 54/76] hw/mips/Makefile.objs: Create CONFIG_*
 for r4k, malta, mipssim boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>, Yang Zhong <yang.zhong@intel.com>

From: Ákos Kovács <akoskovacs@gmx.com>

Add the new configs to default-configs/mips*-sofmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-11-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/mips-softmmu-common.mak | 3 +++
 hw/mips/Makefile.objs                   | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index fae2347..479fb4d 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -36,3 +36,6 @@ CONFIG_EMPTY_SLOT=y
 CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
 CONFIG_I2C=y
+CONFIG_R4K=y
+CONFIG_MALTA=y
+CONFIG_MIPSSIM=y
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 17a311a..525809a 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,7 +1,8 @@
-obj-y += mips_r4k.o mips_malta.o mips_mipssim.o
 obj-y += addr.o mips_int.o
+obj-$(CONFIG_R4K) += mips_r4k.o
+obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
+obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
 obj-$(CONFIG_JAZZ) += mips_jazz.o
 obj-$(CONFIG_FULONG) += mips_fulong2e.o
-obj-y += gt64xxx_pci.o
 obj-$(CONFIG_MIPS_CPS) += cps.o
 obj-$(CONFIG_MIPS_BOSTON) += boston.o
-- 
1.8.3.1
