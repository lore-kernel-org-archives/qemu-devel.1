Received: from eggs.gnu.org ([209.51.188.92]:57948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOj-0007YX-Jz
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOg-0001lW-U1
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:40 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOe-0001hD-OD
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:38 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so5996952wmf.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:40 +0100
Message-Id: <1548410831-19553-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 21/52] hw/cris/Makefile.objs: Create CONFIG_*
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
Cc: yang.zhong@intel.com, thuth@redhat.com

From: Yang Zhong <yang.zhong@intel.com>

Add the new configs to default-configs/cris-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-18-yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
