Received: from eggs.gnu.org ([2001:4830:134:3::10]:33568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QG-0004FV-IN
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QC-0007DG-ME
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:32 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:53056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QC-0007Co-Hv
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:28 -0400
Received: by mail-qk0-x241.google.com with SMTP id b15so14491807qkg.9
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 20:07:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 00:05:50 -0300
Message-Id: <20171030030553.21259-3-f4bug@amsat.org>
In-Reply-To: <20171030030553.21259-1-f4bug@amsat.org>
References: <20171030030553.21259-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/5] target/i386: tcg stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

missing since 55c3ceef61:

    LINK    x86_64-softmmu/qemu-system-x86_64
  target/i386/cpu.o: In function `x86_cpu_common_class_init':
  target/i386/cpu.c:4215: undefined reference to `tcg_x86_init'

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/i386/tcg-stub.c    | 13 +++++++++++++
 target/i386/Makefile.objs |  1 +
 2 files changed, 14 insertions(+)
 create mode 100644 target/i386/tcg-stub.c

diff --git a/target/i386/tcg-stub.c b/target/i386/tcg-stub.c
new file mode 100644
index 0000000000..e13d993a80
--- /dev/null
+++ b/target/i386/tcg-stub.c
@@ -0,0 +1,13 @@
+/*
+ * QEMU TCG x86 specific function stubs
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+void tcg_x86_init(void)
+{
+}
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 6a26e9d9f0..2b3db1e5c2 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -3,6 +3,7 @@ obj-$(CONFIG_TCG) += translate.o
 obj-$(CONFIG_TCG) += bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
 obj-$(CONFIG_TCG) += seg_helper.o smm_helper.o svm_helper.o
+obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-- 
2.15.0.rc2
