Received: from eggs.gnu.org ([209.51.188.92]:55040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goYtc-0005tp-Lt
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goYtb-00083l-Nb
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:18:08 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 29 Jan 2019 19:17:39 +0000
Message-Id: <20190129191746.14868-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
References: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v4 1/8] target/ppc: implement complete set of
 Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

This prepares us for eliminating the use of direct array access within the VMX
instruction implementations.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/internal.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index c7c0f77dd6..f26a71ffcf 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -206,16 +206,23 @@ EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
 
 #if defined(HOST_WORDS_BIGENDIAN)
 #define VsrB(i) u8[i]
+#define VsrSB(i) s8[i]
 #define VsrH(i) u16[i]
+#define VsrSH(i) s16[i]
 #define VsrW(i) u32[i]
+#define VsrSW(i) s32[i]
 #define VsrD(i) u64[i]
+#define VsrSD(i) s64[i]
 #else
 #define VsrB(i) u8[15 - (i)]
+#define VsrSB(i) s8[15 - (i)]
 #define VsrH(i) u16[7 - (i)]
+#define VsrSH(i) s16[7 - (i)]
 #define VsrW(i) u32[3 - (i)]
+#define VsrSW(i) s32[3 - (i)]
 #define VsrD(i) u64[1 - (i)]
+#define VsrSD(i) s64[1 - (i)]
 #endif
-
 static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 {
     vsr->VsrD(0) = env->vsr[n].u64[0];
-- 
2.11.0
