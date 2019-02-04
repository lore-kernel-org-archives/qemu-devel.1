Received: from eggs.gnu.org ([209.51.188.92]:60105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7w-00066J-V9
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7v-0004H2-Gg
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:52 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7u-00041n-TP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:51 -0500
Received: by mail-wm1-x32d.google.com with SMTP id z5so981318wmf.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:08 +0100
Message-Id: <1549305379-51117-67-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 66/77] hw/cris/Makefile.objs: Create CONFIG_*
 for cris
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

Add the new configs to default-configs/cris-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-22-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/cris-softmmu.mak | 1 +
 hw/cris/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/cris-softmmu.mak b/default-configs/cris-softmmu.mak
index d970d50..a637c4b 100644
--- a/default-configs/cris-softmmu.mak
+++ b/default-configs/cris-softmmu.mak
@@ -4,3 +4,4 @@ CONFIG_ETRAXFS=y
 CONFIG_NAND=y
 CONFIG_PTIMER=y
 CONFIG_PFLASH_CFI02=y
+CONFIG_AXIS=y
diff --git a/hw/cris/Makefile.objs b/hw/cris/Makefile.objs
index 7624173..a4a27b3 100644
--- a/hw/cris/Makefile.objs
+++ b/hw/cris/Makefile.objs
@@ -1,2 +1,2 @@
 obj-y += boot.o
-obj-y += axis_dev88.o
+obj-$(CONFIG_AXIS) += axis_dev88.o
-- 
1.8.3.1
