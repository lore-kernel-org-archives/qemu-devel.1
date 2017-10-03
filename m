Received: from eggs.gnu.org ([2001:4830:134:3::10]:40069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWY-0001vV-8t
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWU-0003w7-RQ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:14 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:49906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzNWU-0003ty-ID
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:10 -0400
Received: by mail-wm0-x241.google.com with SMTP id b189so12949420wmd.4
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 15:45:31 +0200
Message-Id: <20171003134540.21625-2-pbonzini@redhat.com>
In-Reply-To: <20171003134540.21625-1-pbonzini@redhat.com>
References: <20171003134540.21625-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/10] i386: hvf: move all hvf files in the
 same directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex@alex.org.uk, agraf@suse.de, sergio.g.delreal@gmail.com

Just call it hvf/, no need for the "utils" suffix.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/Makefile.objs                    |  2 +-
 target/i386/cpu.h                            |  2 +-
 target/i386/{hvf-utils => hvf}/Makefile.objs |  1 +
 target/i386/{hvf-utils => hvf}/README.md     |  0
 target/i386/{ => hvf}/hvf-i386.h             |  2 +-
 target/i386/{hvf-all.c => hvf/hvf.c}         | 20 ++++++++++----------
 target/i386/{hvf-utils => hvf}/vmcs.h        |  0
 target/i386/{hvf-utils => hvf}/vmx.h         |  0
 target/i386/{hvf-utils => hvf}/x86.c         |  0
 target/i386/{hvf-utils => hvf}/x86.h         |  0
 target/i386/{hvf-utils => hvf}/x86_cpuid.c   |  0
 target/i386/{hvf-utils => hvf}/x86_cpuid.h   |  0
 target/i386/{hvf-utils => hvf}/x86_decode.c  |  0
 target/i386/{hvf-utils => hvf}/x86_decode.h  |  0
 target/i386/{hvf-utils => hvf}/x86_descr.c   |  0
 target/i386/{hvf-utils => hvf}/x86_descr.h   |  0
 target/i386/{hvf-utils => hvf}/x86_emu.c     |  0
 target/i386/{hvf-utils => hvf}/x86_emu.h     |  0
 target/i386/{hvf-utils => hvf}/x86_flags.c   |  0
 target/i386/{hvf-utils => hvf}/x86_flags.h   |  0
 target/i386/{hvf-utils => hvf}/x86_gen.h     |  0
 target/i386/{hvf-utils => hvf}/x86_mmu.c     |  0
 target/i386/{hvf-utils => hvf}/x86_mmu.h     |  0
 target/i386/{hvf-utils => hvf}/x86_task.c    | 20 ++++++++++----------
 target/i386/{hvf-utils => hvf}/x86_task.h    |  0
 target/i386/{hvf-utils => hvf}/x86hvf.c      |  0
 target/i386/{hvf-utils => hvf}/x86hvf.h      |  0
 27 files changed, 24 insertions(+), 23 deletions(-)
 rename target/i386/{hvf-utils => hvf}/Makefile.objs (87%)
 rename target/i386/{hvf-utils => hvf}/README.md (100%)
 rename target/i386/{ => hvf}/hvf-i386.h (97%)
 rename target/i386/{hvf-all.c => hvf/hvf.c} (98%)
 rename target/i386/{hvf-utils => hvf}/vmcs.h (100%)
 rename target/i386/{hvf-utils => hvf}/vmx.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_cpuid.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86_cpuid.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_decode.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86_decode.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_descr.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86_descr.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_emu.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86_emu.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_flags.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86_flags.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_gen.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_mmu.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86_mmu.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_task.c (95%)
 rename target/i386/{hvf-utils => hvf}/x86_task.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86hvf.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86hvf.h (100%)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 0bef89c099..44103a693b 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -12,5 +12,5 @@ obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
 endif
 ifdef CONFIG_DARWIN
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
-obj-$(CONFIG_HVF) += hvf-utils/ hvf-all.o
+obj-$(CONFIG_HVF) += hvf/
 endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0ae99ef424..238d3e3535 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,7 +24,7 @@
 #include "cpu-qom.h"
 #include "hyperv-proto.h"
 #if defined(CONFIG_HVF)
-#include "target/i386/hvf-utils/x86.h"
+#include "target/i386/hvf/x86.h"
 #endif
 
 #ifdef TARGET_X86_64
diff --git a/target/i386/hvf-utils/Makefile.objs b/target/i386/hvf/Makefile.objs
similarity index 87%
rename from target/i386/hvf-utils/Makefile.objs
rename to target/i386/hvf/Makefile.objs
index 79d8969ca8..927b86bc67 100644
--- a/target/i386/hvf-utils/Makefile.objs
+++ b/target/i386/hvf/Makefile.objs
@@ -1 +1,2 @@
+obj-y += hvf.o
 obj-y += x86.o x86_cpuid.o x86_decode.o x86_descr.o x86_emu.o x86_flags.o x86_mmu.o x86hvf.o x86_task.o
diff --git a/target/i386/hvf-utils/README.md b/target/i386/hvf/README.md
similarity index 100%
rename from target/i386/hvf-utils/README.md
rename to target/i386/hvf/README.md
diff --git a/target/i386/hvf-i386.h b/target/i386/hvf/hvf-i386.h
similarity index 97%
rename from target/i386/hvf-i386.h
rename to target/i386/hvf/hvf-i386.h
index 797718ce34..2232501552 100644
--- a/target/i386/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -18,7 +18,7 @@
 
 #include "sysemu/hvf.h"
 #include "cpu.h"
-#include "hvf-utils/x86.h"
+#include "x86.h"
 
 #define HVF_MAX_VCPU 0x10
 #define MAX_VM_ID 0x40
diff --git a/target/i386/hvf-all.c b/target/i386/hvf/hvf.c
similarity index 98%
rename from target/i386/hvf-all.c
rename to target/i386/hvf/hvf.c
index 81d9b64eae..863226cc9a 100644
--- a/target/i386/hvf-all.c
+++ b/target/i386/hvf/hvf.c
@@ -24,16 +24,16 @@
 
 #include "sysemu/hvf.h"
 #include "hvf-i386.h"
-#include "hvf-utils/vmcs.h"
-#include "hvf-utils/vmx.h"
-#include "hvf-utils/x86.h"
-#include "hvf-utils/x86_descr.h"
-#include "hvf-utils/x86_mmu.h"
-#include "hvf-utils/x86_decode.h"
-#include "hvf-utils/x86_emu.h"
-#include "hvf-utils/x86_cpuid.h"
-#include "hvf-utils/x86_task.h"
-#include "hvf-utils/x86hvf.h"
+#include "vmcs.h"
+#include "vmx.h"
+#include "x86.h"
+#include "x86_descr.h"
+#include "x86_mmu.h"
+#include "x86_decode.h"
+#include "x86_emu.h"
+#include "x86_cpuid.h"
+#include "x86_task.h"
+#include "x86hvf.h"
 
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
diff --git a/target/i386/hvf-utils/vmcs.h b/target/i386/hvf/vmcs.h
similarity index 100%
rename from target/i386/hvf-utils/vmcs.h
rename to target/i386/hvf/vmcs.h
diff --git a/target/i386/hvf-utils/vmx.h b/target/i386/hvf/vmx.h
similarity index 100%
rename from target/i386/hvf-utils/vmx.h
rename to target/i386/hvf/vmx.h
diff --git a/target/i386/hvf-utils/x86.c b/target/i386/hvf/x86.c
similarity index 100%
rename from target/i386/hvf-utils/x86.c
rename to target/i386/hvf/x86.c
diff --git a/target/i386/hvf-utils/x86.h b/target/i386/hvf/x86.h
similarity index 100%
rename from target/i386/hvf-utils/x86.h
rename to target/i386/hvf/x86.h
diff --git a/target/i386/hvf-utils/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
similarity index 100%
rename from target/i386/hvf-utils/x86_cpuid.c
rename to target/i386/hvf/x86_cpuid.c
diff --git a/target/i386/hvf-utils/x86_cpuid.h b/target/i386/hvf/x86_cpuid.h
similarity index 100%
rename from target/i386/hvf-utils/x86_cpuid.h
rename to target/i386/hvf/x86_cpuid.h
diff --git a/target/i386/hvf-utils/x86_decode.c b/target/i386/hvf/x86_decode.c
similarity index 100%
rename from target/i386/hvf-utils/x86_decode.c
rename to target/i386/hvf/x86_decode.c
diff --git a/target/i386/hvf-utils/x86_decode.h b/target/i386/hvf/x86_decode.h
similarity index 100%
rename from target/i386/hvf-utils/x86_decode.h
rename to target/i386/hvf/x86_decode.h
diff --git a/target/i386/hvf-utils/x86_descr.c b/target/i386/hvf/x86_descr.c
similarity index 100%
rename from target/i386/hvf-utils/x86_descr.c
rename to target/i386/hvf/x86_descr.c
diff --git a/target/i386/hvf-utils/x86_descr.h b/target/i386/hvf/x86_descr.h
similarity index 100%
rename from target/i386/hvf-utils/x86_descr.h
rename to target/i386/hvf/x86_descr.h
diff --git a/target/i386/hvf-utils/x86_emu.c b/target/i386/hvf/x86_emu.c
similarity index 100%
rename from target/i386/hvf-utils/x86_emu.c
rename to target/i386/hvf/x86_emu.c
diff --git a/target/i386/hvf-utils/x86_emu.h b/target/i386/hvf/x86_emu.h
similarity index 100%
rename from target/i386/hvf-utils/x86_emu.h
rename to target/i386/hvf/x86_emu.h
diff --git a/target/i386/hvf-utils/x86_flags.c b/target/i386/hvf/x86_flags.c
similarity index 100%
rename from target/i386/hvf-utils/x86_flags.c
rename to target/i386/hvf/x86_flags.c
diff --git a/target/i386/hvf-utils/x86_flags.h b/target/i386/hvf/x86_flags.h
similarity index 100%
rename from target/i386/hvf-utils/x86_flags.h
rename to target/i386/hvf/x86_flags.h
diff --git a/target/i386/hvf-utils/x86_gen.h b/target/i386/hvf/x86_gen.h
similarity index 100%
rename from target/i386/hvf-utils/x86_gen.h
rename to target/i386/hvf/x86_gen.h
diff --git a/target/i386/hvf-utils/x86_mmu.c b/target/i386/hvf/x86_mmu.c
similarity index 100%
rename from target/i386/hvf-utils/x86_mmu.c
rename to target/i386/hvf/x86_mmu.c
diff --git a/target/i386/hvf-utils/x86_mmu.h b/target/i386/hvf/x86_mmu.h
similarity index 100%
rename from target/i386/hvf-utils/x86_mmu.h
rename to target/i386/hvf/x86_mmu.h
diff --git a/target/i386/hvf-utils/x86_task.c b/target/i386/hvf/x86_task.c
similarity index 95%
rename from target/i386/hvf-utils/x86_task.c
rename to target/i386/hvf/x86_task.c
index 1a2646437a..22fde7fc39 100644
--- a/target/i386/hvf-utils/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -12,16 +12,16 @@
 
 #include "sysemu/hvf.h"
 #include "hvf-i386.h"
-#include "hvf-utils/vmcs.h"
-#include "hvf-utils/vmx.h"
-#include "hvf-utils/x86.h"
-#include "hvf-utils/x86_descr.h"
-#include "hvf-utils/x86_mmu.h"
-#include "hvf-utils/x86_decode.h"
-#include "hvf-utils/x86_emu.h"
-#include "hvf-utils/x86_cpuid.h"
-#include "hvf-utils/x86_task.h"
-#include "hvf-utils/x86hvf.h"
+#include "vmcs.h"
+#include "vmx.h"
+#include "x86.h"
+#include "x86_descr.h"
+#include "x86_mmu.h"
+#include "x86_decode.h"
+#include "x86_emu.h"
+#include "x86_cpuid.h"
+#include "x86_task.h"
+#include "x86hvf.h"
 
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
diff --git a/target/i386/hvf-utils/x86_task.h b/target/i386/hvf/x86_task.h
similarity index 100%
rename from target/i386/hvf-utils/x86_task.h
rename to target/i386/hvf/x86_task.h
diff --git a/target/i386/hvf-utils/x86hvf.c b/target/i386/hvf/x86hvf.c
similarity index 100%
rename from target/i386/hvf-utils/x86hvf.c
rename to target/i386/hvf/x86hvf.c
diff --git a/target/i386/hvf-utils/x86hvf.h b/target/i386/hvf/x86hvf.h
similarity index 100%
rename from target/i386/hvf-utils/x86hvf.h
rename to target/i386/hvf/x86hvf.h
-- 
2.13.6
