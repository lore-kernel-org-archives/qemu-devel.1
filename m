Received: from eggs.gnu.org ([2001:4830:134:3::10]:57338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGJ-000301-J0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGE-0002wN-FV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGE-0002vu-AY
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:26 -0400
Date: Thu, 3 May 2018 22:51:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-43-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 42/67] tcg: use include "tcg.h" consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Some places include tcg.h, others tcg/tcg.h.
Let's be consistent.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/translator.h | 2 +-
 trace/mem.h               | 2 +-
 accel/stubs/tcg-stub.c    | 2 +-
 accel/tcg/cputlb.c        | 2 +-
 accel/tcg/translator.c    | 2 +-
 disas/tci.c               | 2 +-
 hw/i386/kvmvapic.c        | 2 +-
 tcg/tcg-common.c          | 2 +-
 tcg/tci.c                 | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index e2dc2a0..a915953 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -20,7 +20,7 @@
 
 
 #include "exec/exec-all.h"
-#include "tcg/tcg.h"
+#include "tcg.h"
 
 
 /**
diff --git a/trace/mem.h b/trace/mem.h
index 9c88bcb..39a1e21 100644
--- a/trace/mem.h
+++ b/trace/mem.h
@@ -10,7 +10,7 @@
 #ifndef TRACE__MEM_H
 #define TRACE__MEM_H
 
-#include "tcg/tcg.h"
+#include "tcg.h"
 
 
 /**
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index ee575a8..ab2a372b 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "tcg/tcg.h"
+#include "tcg.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0543903..d295d14 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -27,7 +27,7 @@
 #include "exec/cputlb.h"
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
-#include "tcg/tcg.h"
+#include "tcg.h"
 #include "qemu/error-report.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 23c6602..01480b9 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,7 +11,7 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
-#include "tcg/tcg.h"
+#include "tcg.h"
 #include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
 #include "exec/gen-icount.h"
diff --git a/disas/tci.c b/disas/tci.c
index 1cdf5ee..7408a56 100644
--- a/disas/tci.c
+++ b/disas/tci.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "disas/bfd.h"
-#include "tcg/tcg.h"
+#include "tcg.h"
 
 /* Disassemble TCI bytecode. */
 int print_insn_tci(bfd_vma addr, disassemble_info *info)
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index fc962c5..23aef34 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -18,7 +18,7 @@
 #include "sysemu/kvm.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
-#include "tcg/tcg.h"
+#include "tcg.h"
 
 #define VAPIC_IO_PORT           0x7e
 
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 2f139de..d80cbec 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "exec/cpu-common.h"
-#include "tcg/tcg.h"
+#include "tcg.h"
 
 #if defined(CONFIG_TCG_INTERPRETER)
 uintptr_t tci_tb_ptr;
diff --git a/tcg/tci.c b/tcg/tci.c
index 33edca1..2d11dc6 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -28,7 +28,7 @@
 #endif
 
 #include "qemu-common.h"
-#include "tcg/tcg.h"           /* MAX_OPC_PARAM_IARGS */
+#include "tcg.h"           /* MAX_OPC_PARAM_IARGS */
 #include "exec/cpu_ldst.h"
 #include "tcg-op.h"
 
-- 
MST
