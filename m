Received: from eggs.gnu.org ([209.51.188.92]:60025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7v-00064l-KX
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7u-0004Ev-Ff
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:51 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7u-00043N-5V
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:50 -0500
Received: by mail-wm1-x32b.google.com with SMTP id p6so1026696wmc.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:11 +0100
Message-Id: <1549305379-51117-70-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 69/77] hw/openrisc/Makefile.objs: Create
 CONFIG_* for openrisc
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

Add the new configs to default-configs/or1k-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-25-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/or1k-softmmu.mak | 1 +
 hw/openrisc/Makefile.objs        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/or1k-softmmu.mak b/default-configs/or1k-softmmu.mak
index 6f5824f..6a0f2ef 100644
--- a/default-configs/or1k-softmmu.mak
+++ b/default-configs/or1k-softmmu.mak
@@ -3,3 +3,4 @@
 CONFIG_SERIAL=y
 CONFIG_OPENCORES_ETH=y
 CONFIG_OMPIC=y
+CONFIG_OR1K_SIM=y
diff --git a/hw/openrisc/Makefile.objs b/hw/openrisc/Makefile.objs
index 61246b1..aa04de7 100644
--- a/hw/openrisc/Makefile.objs
+++ b/hw/openrisc/Makefile.objs
@@ -1,2 +1,2 @@
 obj-y = pic_cpu.o cputimer.o
-obj-y += openrisc_sim.o 
+obj-$(CONFIG_OR1K_SIM) += openrisc_sim.o
-- 
1.8.3.1
