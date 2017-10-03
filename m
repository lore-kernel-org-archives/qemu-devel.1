Received: from eggs.gnu.org ([2001:4830:134:3::10]:40098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWc-0001yK-8l
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWW-00040a-Ll
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:18 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:49906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzNWW-0003yq-FG
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:12 -0400
Received: by mail-wm0-x243.google.com with SMTP id b189so12949596wmd.4
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 15:45:32 +0200
Message-Id: <20171003134540.21625-3-pbonzini@redhat.com>
In-Reply-To: <20171003134540.21625-1-pbonzini@redhat.com>
References: <20171003134540.21625-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] i386: hvf: header cleanup
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

Remove inclusions of system headers and avoid "pragma once".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86.h        | 8 +++-----
 target/i386/hvf/x86_decode.h | 9 ++++-----
 target/i386/hvf/x86_descr.h  | 5 ++++-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 7fd8fede80..ae957fc895 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -16,12 +16,9 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#pragma once
+#ifndef HVF_X86_H
+#define HVF_X86_H 1
 
-#include <sys/types.h>
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <stdarg.h>
 #include "qemu-common.h"
 #include "x86_gen.h"
 
@@ -474,3 +471,4 @@ static inline uint64_t rdtscp(void)
     return tsc;
 }
 
+#endif
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index 329131360f..50957819f6 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -15,12 +15,9 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#pragma once
+#ifndef HVF_X86_DECODE_H
+#define HVF_X86_DECODE_H 1
 
-#include <sys/types.h>
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <stdarg.h>
 #include "qemu-common.h"
 #include "x86.h"
 #include "cpu.h"
@@ -323,3 +320,5 @@ void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
                           struct x86_decode_op *op);
 void set_addressing_size(CPUX86State *env, struct x86_decode *decode);
 void set_operand_size(CPUX86State *env, struct x86_decode *decode);
+
+#endif
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
-- 
2.13.6
