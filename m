Received: from eggs.gnu.org ([209.51.188.92]:59957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7r-0005z3-T2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7n-00049a-E9
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:46 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7a-000426-J4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:34 -0500
Received: by mail-wr1-x435.google.com with SMTP id z3so981857wrv.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:09 +0100
Message-Id: <1549305379-51117-68-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 67/77] hw/hppa/Makefile.objs: Create CONFIG_*
 for hppa
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

Add the new configs to default-configs/hppa-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190202072456.6468-23-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/hppa-softmmu.mak | 1 +
 hw/hppa/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index 4badc05..b594a6d 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -10,3 +10,4 @@ CONFIG_IDE_CMD646=y
 # CONFIG_IDE_MMIO=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_MC146818RTC=y
+CONFIG_DINO=y
diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
index bef241e..67838f5 100644
--- a/hw/hppa/Makefile.objs
+++ b/hw/hppa/Makefile.objs
@@ -1 +1 @@
-obj-y += machine.o pci.o dino.o
+obj-$(CONFIG_DINO) += pci.o machine.o dino.o
-- 
1.8.3.1
