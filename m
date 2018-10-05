Received: from eggs.gnu.org ([2001:4830:134:3::10]:56699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM7-0006XZ-5K
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM5-00068t-0g
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM1-00060k-DK
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id e4-v6so14082237wrs.0
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:53 +0100
Message-Id: <20181005154910.3099-5-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 04/21] trace: enable the exec_tb trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Our performance isn't so critical that we can't spare a simple flag
check when we exec a TB considering everything else we check in the
outer loop.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/trace-events | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index c22ad60af7..618cc07738 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -1,10 +1,11 @@
 # Trace events for debugging and performance instrumentation
 
-# TCG related tracing (mostly disabled by default)
+# TCG related tracing (you still need -d nochain to get a full picture
+# as otherwise you'll only see the first TB executed in a chain)
 # cpu-exec.c
-disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
+exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
-- 
2.17.1
