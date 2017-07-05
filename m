Received: from eggs.gnu.org ([2001:4830:134:3::10]:46882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeX7-00051d-S3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeX7-0007t9-0k
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:33 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeX6-0007sm-Qq
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:32 -0400
Received: by mail-wr0-x241.google.com with SMTP id x23so49173773wrb.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:39 +0200
Message-Id: <1499238885-26161-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 36/42] tcg: add the CONFIG_TCG into Makefiles
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

Add the CONFIG_TCG for frontend and backend's files in the related
Makefiles.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target     | 4 ++--
 accel/Makefile.objs | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index ffa7a8f..2baec92 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -90,8 +90,8 @@ all: $(PROGS) stap
 # cpu emulator library
 obj-y += exec.o
 obj-y += accel/
-obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
-obj-y += tcg/tcg-common.o tcg/tcg-runtime.o
+obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
+obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/tcg-runtime.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index cd5702f..10666ed 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SOFTMMU) += accel.o
 obj-y += kvm/
-obj-y += tcg/
+obj-$(CONFIG_TCG) += tcg/
 obj-y += stubs/
-- 
1.8.3.1
