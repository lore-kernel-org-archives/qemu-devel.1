Received: from eggs.gnu.org ([2001:4830:134:3::10]:47634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijA-0004RT-GM
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRij5-0002Y3-UB
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRij5-0002XJ-KW
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B682C4E8AB
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:18 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-46.ams2.redhat.com
	[10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 27BB038187
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:49 +0100
Message-Id: <20171220180358.29316-11-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/19] i386: hvf: move all hvf files in the same
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Just call it hvf/, no need for the "utils" suffix.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/Makefile.objs                    |  2 +-
 target/i386/{hvf-utils => hvf}/Makefile.objs |  1 +
 target/i386/{hvf-utils => hvf}/README.md     |  0
 target/i386/{ => hvf}/hvf-i386.h             |  2 +-
 target/i386/{hvf-all.c => hvf/hvf.c}         | 19 +++++++++----------
 target/i386/{hvf-utils => hvf}/vmcs.h        |  0
 target/i386/{hvf-utils => hvf}/vmx.h         |  0
 target/i386/{hvf-utils => hvf}/x86.c         |  0
 target/i386/{hvf-utils => hvf}/x86.h         |  0
 target/i386/{hvf-utils => hvf}/x86_cpuid.c   |  0
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
 25 files changed, 22 insertions(+), 22 deletions(-)
 rename target/i386/{hvf-utils => hvf}/Makefile.objs (87%)
 rename target/i386/{hvf-utils => hvf}/README.md (100%)
 rename target/i386/{ => hvf}/hvf-i386.h (97%)
 rename target/i386/{hvf-all.c => hvf/hvf.c} (98%)
 rename target/i386/{hvf-utils => hvf}/vmcs.h (100%)
 rename target/i386/{hvf-utils => hvf}/vmx.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_cpuid.c (100%)
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
index 5cf1ad0d35..ddd087e537 100644
--- a/target/i386/hvf-all.c
+++ b/target/i386/hvf/hvf.c
@@ -24,15 +24,15 @@
 
 #include "sysemu/hvf.h"
 #include "hvf-i386.h"
-#include "hvf-utils/vmcs.h"
-#include "hvf-utils/vmx.h"
-#include "hvf-utils/x86.h"
-#include "hvf-utils/x86_descr.h"
-#include "hvf-utils/x86_mmu.h"
-#include "hvf-utils/x86_decode.h"
-#include "hvf-utils/x86_emu.h"
-#include "hvf-utils/x86_task.h"
-#include "hvf-utils/x86hvf.h"
+#include "vmcs.h"
+#include "vmx.h"
+#include "x86.h"
+#include "x86_descr.h"
+#include "x86_mmu.h"
+#include "x86_decode.h"
+#include "x86_emu.h"
+#include "x86_task.h"
+#include "x86hvf.h"
 
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
@@ -44,7 +44,6 @@
 #include "hw/boards.h"
 #include "qemu/main-loop.h"
 #include "strings.h"
-#include "trace.h"
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
 #include "target/i386/cpu.h"
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
2.14.3
