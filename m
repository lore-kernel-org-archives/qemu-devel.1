Received: from eggs.gnu.org ([209.51.188.92]:60093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7w-000666-N8
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7u-0004FO-MM
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7u-00041W-CB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:50 -0500
Received: by mail-wm1-x334.google.com with SMTP id m1so973086wml.2
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:07 +0100
Message-Id: <1549305379-51117-66-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 65/77] hw/alpha/Makefile.objs: Create CONFIG_*
 for alpha
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

Add the new configs to default-configs/alpha-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190202072456.6468-21-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak | 1 +
 hw/alpha/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 4d654ea..49cb7ce 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -19,3 +19,4 @@ CONFIG_I8259=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_SMC37C669=y
+CONFIG_DP264=y
diff --git a/hw/alpha/Makefile.objs b/hw/alpha/Makefile.objs
index 5c74275..62fdf3e 100644
--- a/hw/alpha/Makefile.objs
+++ b/hw/alpha/Makefile.objs
@@ -1 +1 @@
-obj-y += dp264.o pci.o typhoon.o
+obj-$(CONFIG_DP264) += dp264.o pci.o typhoon.o
-- 
1.8.3.1
