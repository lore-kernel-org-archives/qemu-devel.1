Received: from eggs.gnu.org ([2001:4830:134:3::10]:44693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWL4-00019N-Rl
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWL4-0006yg-2o
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:54 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWL3-0006yN-Uj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:54 -0400
Received: by mail-qt0-x242.google.com with SMTP id u48so3451183qtc.4
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:33:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 11 Sep 2017 18:33:28 -0300
Message-Id: <20170911213328.9701-6-f4bug@amsat.org>
In-Reply-To: <20170911213328.9701-1-f4bug@amsat.org>
References: <20170911213328.9701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/5] tcg: restrict i386 regs definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
cleaning while here :)

 accel/tcg/user-exec.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 2a975eaf69..484a3f5f8f 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -25,15 +25,6 @@
 #include "exec/cpu_ldst.h"
 #include "translate-all.h"
 
-#undef EAX
-#undef ECX
-#undef EDX
-#undef EBX
-#undef ESP
-#undef EBP
-#undef ESI
-#undef EDI
-#undef EIP
 #ifdef __linux__
 #include <sys/ucontext.h>
 #endif
@@ -131,6 +122,15 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
 }
 
 #if defined(__i386__)
+#undef EAX
+#undef ECX
+#undef EDX
+#undef EBX
+#undef ESP
+#undef EBP
+#undef ESI
+#undef EDI
+#undef EIP
 
 #if defined(__NetBSD__)
 #include <ucontext.h>
-- 
2.14.1
