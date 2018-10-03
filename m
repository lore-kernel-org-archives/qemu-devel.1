Received: from eggs.gnu.org ([2001:4830:134:3::10]:41144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7nOI-0002ca-Or
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7nOF-0006wD-AX
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:05:02 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36181)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7nOE-0006u2-Tf
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:04:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  3 Oct 2018 16:04:52 -0400
Message-Id: <20181003200454.18384-3-cota@braap.org>
In-Reply-To: <20181003200454.18384-1-cota@braap.org>
References: <20181003200454.18384-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 2/4] cputlb: fix assert_cpu_is_self macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cputlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 502eea2850..f6b388c961 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -58,9 +58,9 @@
     } \
 } while (0)
 
-#define assert_cpu_is_self(this_cpu) do {                         \
+#define assert_cpu_is_self(cpu) do {                              \
         if (DEBUG_TLB_GATE) {                                     \
-            g_assert(!cpu->created || qemu_cpu_is_self(cpu));     \
+            g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
         }                                                         \
     } while (0)
 
-- 
2.17.1
