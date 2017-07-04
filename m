Received: from eggs.gnu.org ([2001:4830:134:3::10]:35798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlP-0006ze-0Q
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlM-00022g-Go
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:02 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLlM-00022M-9T
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:00 -0400
Received: by mail-wm0-x244.google.com with SMTP id u23so25605245wma.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:13:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:12:14 +0200
Message-Id: <1499166735-39360-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 21/22] target/i386: add the CONFIG_TCG into
 Makefiles
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
	v2: compile out bpt_helper.c [Richard]

 target/i386/Makefile.objs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 4fcb7f3..fcc18a0 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -1,7 +1,9 @@
-obj-y += translate.o helper.o cpu.o bpt_helper.o
-obj-y += excp_helper.o fpu_helper.o cc_helper.o int_helper.o svm_helper.o
-obj-y += smm_helper.o misc_helper.o mem_helper.o seg_helper.o mpx_helper.o
+obj-y += helper.o cpu.o
 obj-y += gdbstub.o
+obj-$(CONFIG_TCG) += translate.o
+obj-$(CONFIG_TCG) += bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
+obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
+obj-$(CONFIG_TCG) += seg_helper.o smm_helper.o svm_helper.o
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-- 
1.8.3.1
