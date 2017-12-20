Received: from eggs.gnu.org ([2001:4830:134:3::10]:47635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijA-0004RU-Gc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRij6-0002Z3-Pt
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRij6-0002Y7-Fw
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A794ABDFD
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:19 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-46.ams2.redhat.com
	[10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 17A223818B
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:50 +0100
Message-Id: <20171220180358.29316-12-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/19] i386: hvf: header cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remove inclusions of system headers and avoid "pragma once".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86.h        |  9 +++------
 target/i386/hvf/x86_cpuid.c  |  1 +
 target/i386/hvf/x86_decode.c |  1 +
 target/i386/hvf/x86_decode.h | 12 +++++-------
 target/i386/hvf/x86_descr.c  |  1 +
 target/i386/hvf/x86_descr.h  |  5 ++++-
 target/i386/hvf/x86_flags.c  |  2 +-
 target/i386/hvf/x86_gen.h    |  4 ----
 target/i386/hvf/x86hvf.c     |  2 +-
 9 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 250364b448..2dc55477a5 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -16,13 +16,9 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#pragma once
+#ifndef HVF_X86_H
+#define HVF_X86_H 1
 
-#include <sys/types.h>
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <stdarg.h>
-#include "qemu-common.h"
 #include "x86_gen.h"
 
 /* exceptions */
@@ -467,3 +463,4 @@ static inline uint64_t rdtscp(void)
     return tsc;
 }
 
+#endif
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 103223a85d..bcb9705a71 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "x86.h"
 #include "vmx.h"
 #include "sysemu/hvf.h"
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 623c051339..2a42a67130 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 
+#include "qemu-common.h"
 #include "x86_decode.h"
 #include "string.h"
 #include "vmx.h"
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index 329131360f..3e1eca0cdb 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -15,15 +15,11 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#pragma once
+#ifndef HVF_X86_DECODE_H
+#define HVF_X86_DECODE_H 1
 
-#include <sys/types.h>
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <stdarg.h>
-#include "qemu-common.h"
-#include "x86.h"
 #include "cpu.h"
+#include "x86.h"
 
 typedef enum x86_prefix {
     /* group 1 */
@@ -323,3 +319,5 @@ void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
                           struct x86_decode_op *op);
 void set_addressing_size(CPUX86State *env, struct x86_decode *decode);
 void set_operand_size(CPUX86State *env, struct x86_decode *decode);
+
+#endif
diff --git a/target/i386/hvf/x86_descr.c b/target/i386/hvf/x86_descr.c
index 0b9562818f..b4a7cdd2a7 100644
--- a/target/i386/hvf/x86_descr.c
+++ b/target/i386/hvf/x86_descr.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 
+#include "qemu-common.h"
 #include "vmx.h"
 #include "x86_descr.h"
 
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index 1285dd3897..034d8e95c5 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -16,7 +16,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#pragma once
+#ifndef HVF_X86_DESCR_H
+#define HVF_X86_DESCR_H 1
 
 #include "x86.h"
 
@@ -53,3 +54,5 @@ uint32_t vmx_read_segment_ar(CPUState *cpu, x86_reg_segment seg);
 void vmx_segment_to_x86_descriptor(struct CPUState *cpu,
                                    struct vmx_segment *vmx_desc,
                                    struct x86_segment_descriptor *desc);
+
+#endif
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index c833774485..d2693f21f4 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -22,8 +22,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 
+#include "qemu-common.h"
 #include "cpu.h"
 #include "x86_flags.h"
 #include "x86.h"
diff --git a/target/i386/hvf/x86_gen.h b/target/i386/hvf/x86_gen.h
index 2045b0e69d..69edeffb19 100644
--- a/target/i386/hvf/x86_gen.h
+++ b/target/i386/hvf/x86_gen.h
@@ -18,10 +18,6 @@
 #ifndef __X86_GEN_H__
 #define __X86_GEN_H__
 
-#include <stdlib.h>
-#include <stdio.h>
-#include "qemu-common.h"
-
 typedef uint64_t addr_t;
 
 #define VM_PANIC(x) {\
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index cb1edb6186..aeeb422590 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -18,8 +18,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 
+#include "qemu-common.h"
 #include "x86hvf.h"
 #include "vmx.h"
 #include "vmcs.h"
-- 
2.14.3
