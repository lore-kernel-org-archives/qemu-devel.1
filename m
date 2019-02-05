Received: from eggs.gnu.org ([209.51.188.92]:36890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H9-0003AC-7G
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H8-0004WP-9A
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:56153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5H8-0004Le-0P
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:50 -0500
Received: by mail-wm1-x334.google.com with SMTP id y139so4641564wmc.5
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:11 +0100
Message-Id: <1549390526-24246-62-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 61/76] hw/nios2/Makefile.objs: Conditionally
 build nios2
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

CONFIG_NIOS2_10M50 added for 10m50 dev board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-18-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/nios2-softmmu.mak | 1 +
 hw/nios2/Makefile.objs            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
index 74dc70c..ab42d0f 100644
--- a/default-configs/nios2-softmmu.mak
+++ b/default-configs/nios2-softmmu.mak
@@ -4,3 +4,4 @@ CONFIG_NIOS2=y
 CONFIG_SERIAL=y
 CONFIG_PTIMER=y
 CONFIG_ALTERA_TIMER=y
+CONFIG_NIOS2_10M50=y
diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
index 6b5c421..89a419a 100644
--- a/hw/nios2/Makefile.objs
+++ b/hw/nios2/Makefile.objs
@@ -1 +1,2 @@
-obj-y = boot.o cpu_pic.o 10m50_devboard.o
+obj-y = boot.o cpu_pic.o
+obj-$(CONFIG_NIOS2_10M50) += 10m50_devboard.o
-- 
1.8.3.1
