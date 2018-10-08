Received: from eggs.gnu.org ([2001:4830:134:3::10]:56227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9Zzm-00032E-OT
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9ZhB-0003UW-Q0
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:52:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9ZhB-0003SK-Cr
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:51:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  8 Oct 2018 13:51:46 -0400
Message-Id: <20181008175148.15018-3-cota@braap.org>
In-Reply-To: <20181008175148.15018-1-cota@braap.org>
References: <20181008175148.15018-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 2/4] cputlb: fix assert_cpu_is_self macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
