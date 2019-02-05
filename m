Received: from eggs.gnu.org ([209.51.188.92]:36986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5HA-0003Bo-IA
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H8-0004Y9-S0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:52 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5H8-0004OC-Iq
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id d15so4680837wmb.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:17 +0100
Message-Id: <1549390526-24246-68-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 67/76] hw/moxie/Makefile.objs: Conditionally
 build moxie
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

CONFIG_MOXIE added for moxiesim board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-24-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/moxie-softmmu.mak | 1 +
 hw/moxie/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/moxie-softmmu.mak b/default-configs/moxie-softmmu.mak
index e00d099..17ba906 100644
--- a/default-configs/moxie-softmmu.mak
+++ b/default-configs/moxie-softmmu.mak
@@ -5,3 +5,4 @@ CONFIG_MC146818RTC=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_VGA=y
+CONFIG_MOXIESIM=y
diff --git a/hw/moxie/Makefile.objs b/hw/moxie/Makefile.objs
index bfc9001..ddbf300 100644
--- a/hw/moxie/Makefile.objs
+++ b/hw/moxie/Makefile.objs
@@ -1,2 +1,2 @@
 # moxie boards
-obj-y += moxiesim.o
+obj-$(CONFIG_MOXIESIM) += moxiesim.o
-- 
1.8.3.1
