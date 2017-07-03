Received: from eggs.gnu.org ([2001:4830:134:3::10]:51694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KN-0000py-18
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KM-000866-7m
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:59 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4KM-00085X-0B
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:58 -0400
Received: by mail-wm0-x243.google.com with SMTP id y5so21474206wmh.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:35:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:42 +0200
Message-Id: <1499099693-22903-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/22] tcg: add the tcg-stub.c file into
 accel/stubs/
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

If tcg is disabled, the functions in tcg-stub.c file will be called.
This file is target-independent file, do not include any platform
related stub functions into this file.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/stubs/Makefile.objs |  1 +
 accel/stubs/tcg-stub.c    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 accel/stubs/tcg-stub.c

diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index bd5794f..fdfbf73 100644
--- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1 +1,2 @@
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
new file mode 100644
index 0000000..5dd480b
--- /dev/null
+++ b/accel/stubs/tcg-stub.c
@@ -0,0 +1,22 @@
+/*
+ * QEMU TCG accelerator stub
+ *
+ * Copyright Red Hat, Inc. 2013
+ *
+ * Author: Paolo Bonzini     <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "tcg/tcg.h"
+#include "exec/cpu-common.h"
+#include "exec/exec-all.h"
+
+void tb_flush(CPUState *cpu)
+{
+}
-- 
1.8.3.1
