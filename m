Received: from eggs.gnu.org ([2001:4830:134:3::10]:35711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlF-0006pm-Cp
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlE-0001xm-Ak
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:53 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLlE-0001xJ-3m
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:52 -0400
Received: by mail-wm0-x243.google.com with SMTP id y5so25530346wmh.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:12:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:12:08 +0200
Message-Id: <1499166735-39360-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 15/22] tcg: add the CONFIG_TCG into Makefiles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

From: Yang Zhong <yang.zhong@intel.com>

Add the CONFIG_TCG for frontend and backend's files in the related
Makefiles.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target     | 4 ++--
 accel/Makefile.objs | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 0066579..8e185d4 100644
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
