Received: from eggs.gnu.org ([2001:4830:134:3::10]:59675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTO-000466-RE
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTK-0000yU-87
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:46851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTTJ-0000mJ-Ts
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id r64-v6so11807586pfb.13
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:48:59 -0700
Message-Id: <20181016174911.9052-10-richard.henderson@linaro.org>
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/21] cputlb: fix assert_cpu_is_self macro
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
