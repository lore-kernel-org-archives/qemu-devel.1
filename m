Received: from eggs.gnu.org ([2001:4830:134:3::10]:33598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QJ-0004I2-O7
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QG-0007Ie-PM
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 00:05:51 -0300
Message-Id: <20171030030553.21259-4-f4bug@amsat.org>
In-Reply-To: <20171030030553.21259-1-f4bug@amsat.org>
References: <20171030030553.21259-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/5] target/s390x: tcg stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

missing since 55c3ceef61:

    LINK    s390x-softmmu/qemu-system-s390x
  target/s390x/cpu.o: In function `s390_cpu_class_init':
  target/s390x/cpu.c:500: undefined reference to `s390x_translate_init'

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/s390x/tcg-stub.c    | 13 +++++++++++++
 target/s390x/Makefile.objs |  1 +
 2 files changed, 14 insertions(+)
 create mode 100644 target/s390x/tcg-stub.c

diff --git a/target/s390x/tcg-stub.c b/target/s390x/tcg-stub.c
new file mode 100644
index 0000000000..1e3ed46e89
--- /dev/null
+++ b/target/s390x/tcg-stub.c
@@ -0,0 +1,13 @@
+/*
+ * QEMU TCG support -- s390x specific function stubs.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "internal.h"
+
+void s390x_translate_init(void)
+{
+}
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 31932de9cf..31dd498d01 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -1,6 +1,7 @@
 obj-y += cpu.o cpu_models.o cpu_features.o gdbstub.o interrupt.o helper.o
 obj-$(CONFIG_TCG) += translate.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o crypto_helper.o
+obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
 obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o diag.o
 obj-$(CONFIG_SOFTMMU) += sigp.o
 obj-$(CONFIG_KVM) += kvm.o
-- 
2.15.0.rc2
