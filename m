Received: from eggs.gnu.org ([209.51.188.92]:58009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOl-0007ax-SL
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOk-0001pF-TV
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:43 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOk-0001ep-Jj
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id a62so6153288wmh.4
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:36 +0100
Message-Id: <1548410831-19553-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 17/52] hw/nios2/Makefile.objs: Conditionally
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
Cc: yang.zhong@intel.com, thuth@redhat.com

From: Yang Zhong <yang.zhong@intel.com>

CONFIG_NIOS2_10M50 added for 10m50 dev board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-14-yang.zhong@intel.com>
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
