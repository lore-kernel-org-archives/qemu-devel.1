Received: from eggs.gnu.org ([2001:4830:134:3::10]:34458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMsz9-0008KK-3B
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMsz8-0008Db-DN
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMsz8-0008D3-7g
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:22 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Dec 2016 16:55:55 +0800
Message-Id: <1483088160-6714-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1483088160-6714-1-git-send-email-peterx@redhat.com>
References: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 3/8] lib/asm-generic: add
 atomic.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, agordeev@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com

Provide some gcc-builtin atomic ops.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/asm-generic/atomic.h | 21 +++++++++++++++++++++
 lib/x86/atomic.h         |  2 ++
 2 files changed, 23 insertions(+)
 create mode 100644 lib/asm-generic/atomic.h

diff --git a/lib/asm-generic/atomic.h b/lib/asm-generic/atomic.h
new file mode 100644
index 0000000..26b645a
--- /dev/null
+++ b/lib/asm-generic/atomic.h
@@ -0,0 +1,21 @@
+#ifndef __ASM_GENERIC_ATOMIC_H__
+#define __ASM_GENERIC_ATOMIC_H__
+
+/* From QEMU include/qemu/atomic.h */
+#define atomic_fetch_inc(ptr)  __sync_fetch_and_add(ptr, 1)
+#define atomic_fetch_dec(ptr)  __sync_fetch_and_add(ptr, -1)
+#define atomic_fetch_add(ptr, n) __sync_fetch_and_add(ptr, n)
+#define atomic_fetch_sub(ptr, n) __sync_fetch_and_sub(ptr, n)
+#define atomic_fetch_and(ptr, n) __sync_fetch_and_and(ptr, n)
+#define atomic_fetch_or(ptr, n) __sync_fetch_and_or(ptr, n)
+#define atomic_fetch_xor(ptr, n) __sync_fetch_and_xor(ptr, n)
+
+#define atomic_inc_fetch(ptr)  __sync_add_and_fetch(ptr, 1)
+#define atomic_dec_fetch(ptr)  __sync_add_and_fetch(ptr, -1)
+#define atomic_add_fetch(ptr, n) __sync_add_and_fetch(ptr, n)
+#define atomic_sub_fetch(ptr, n) __sync_sub_and_fetch(ptr, n)
+#define atomic_and_fetch(ptr, n) __sync_and_and_fetch(ptr, n)
+#define atomic_or_fetch(ptr, n) __sync_or_and_fetch(ptr, n)
+#define atomic_xor_fetch(ptr, n) __sync_xor_and_fetch(ptr, n)
+
+#endif
diff --git a/lib/x86/atomic.h b/lib/x86/atomic.h
index de2f033..c9ce489 100644
--- a/lib/x86/atomic.h
+++ b/lib/x86/atomic.h
@@ -1,6 +1,8 @@
 #ifndef __ATOMIC_H
 #define __ATOMIC_H
 
+#include "asm-generic/atomic.h"
+
 typedef struct {
 	volatile int counter;
 } atomic_t;
-- 
2.7.4
