Received: from eggs.gnu.org ([2001:4830:134:3::10]:39262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDNwj-0004Tr-A2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDNwg-0002nt-9z
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:07:41 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:38372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDNwf-00027G-QK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:07:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id q19-v6so12325465pll.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 23:07:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Oct 2018 23:06:44 -0700
Message-Id: <20181019060656.7968-10-richard.henderson@linaro.org>
In-Reply-To: <20181019060656.7968-1-richard.henderson@linaro.org>
References: <20181019060656.7968-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 09/21] cputlb: fix assert_cpu_is_self macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20181009174557.16125-5-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.2
