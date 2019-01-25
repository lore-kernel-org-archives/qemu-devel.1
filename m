Received: from eggs.gnu.org ([209.51.188.92]:58090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOn-0007cy-Ip
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOl-0001ry-TK
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:50411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOl-0001iV-D6
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:43 -0500
Received: by mail-wm1-x32a.google.com with SMTP id n190so6176256wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:42 +0100
Message-Id: <1548410831-19553-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 23/52] hw/moxie/Makefile.objs: Conditionally
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
Cc: yang.zhong@intel.com, thuth@redhat.com

From: Yang Zhong <yang.zhong@intel.com>

CONFIG_MOXIE added for moxiesim board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-20-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/moxie-softmmu.mak | 1 +
 hw/moxie/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/moxie-softmmu.mak b/default-configs/moxie-softmmu.mak
index e00d099..b176563 100644
--- a/default-configs/moxie-softmmu.mak
+++ b/default-configs/moxie-softmmu.mak
@@ -5,3 +5,4 @@ CONFIG_MC146818RTC=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_VGA=y
+CONFIG_MOXIE=y
diff --git a/hw/moxie/Makefile.objs b/hw/moxie/Makefile.objs
index bfc9001..cb575ef 100644
--- a/hw/moxie/Makefile.objs
+++ b/hw/moxie/Makefile.objs
@@ -1,2 +1,2 @@
 # moxie boards
-obj-y += moxiesim.o
+obj-$(CONFIG_MOXIE) += moxiesim.o
-- 
1.8.3.1
