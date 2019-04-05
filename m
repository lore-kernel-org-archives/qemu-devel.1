Received: from eggs.gnu.org ([209.51.188.92]:40072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQY-00047x-7k
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQR-0001qN-Pf
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hCRPf-0000Ox-EW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id 4so7294842wmf.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:09:54 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
Date: Fri,  5 Apr 2019 17:09:37 +0100
Message-Id: <20190405160938.27494-4-jbi.octave@gmail.com>
In-Reply-To: <20190405160938.27494-1-jbi.octave@gmail.com>
References: <20190405160938.27494-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/4] target/mips: wrap lines to fix
 checkpatch errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: amarkovic@wavecomp.com
Cc: arikalo@wavecomp.com, qemu-devel@nongnu.org

Wrap lines to fix errors issued by checkpatch.pl tool
"ERROR: line over 90 characters"
within "target/mips/cpu.h" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 target/mips/cpu.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 0d2718d7bf..e2f421359a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -72,15 +72,28 @@ struct CPUMIPSFPUContext {
 #define FCR31_FS 24
 #define FCR31_ABS2008 19
 #define FCR31_NAN2008 18
-#define SET_FP_COND(num, env)     do { ((env).fcr31) |= ((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
-#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &= ~((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
-#define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) | (((env).fcr31 >> 23) & 0x1))
+#define SET_FP_COND(num, env)     do { ((env).fcr31) |= \
+                                       ((num) ? (1 << ((num) + 24)) : \
+                                                       (1 << 23)); \
+                                      } while (0)
+#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &= \
+                                         ~((num) ? (1 << ((num) + 24)) :\
+                                                          (1 << 23)); \
+                                      } while (0)
+#define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) | \
+                                  (((env).fcr31 >> 23) & 0x1))
 #define GET_FP_CAUSE(reg)        (((reg) >> 12) & 0x3f)
 #define GET_FP_ENABLE(reg)       (((reg) >>  7) & 0x1f)
 #define GET_FP_FLAGS(reg)        (((reg) >>  2) & 0x1f)
-#define SET_FP_CAUSE(reg, v)      do { (reg) = ((reg) & ~(0x3f << 12)) | ((v & 0x3f) << 12); } while (0)
-#define SET_FP_ENABLE(reg, v)     do { (reg) = ((reg) & ~(0x1f <<  7)) | ((v & 0x1f) << 7); } while (0)
-#define SET_FP_FLAGS(reg, v)      do { (reg) = ((reg) & ~(0x1f <<  2)) | ((v & 0x1f) << 2); } while (0)
+#define SET_FP_CAUSE(reg, v)      do { (reg) = ((reg) & ~(0x3f << 12)) | \
+                                               ((v & 0x3f) << 12); \
+                                     } while (0)
+#define SET_FP_ENABLE(reg, v)     do { (reg) = ((reg) & ~(0x1f <<  7)) |\
+                                               ((v & 0x1f) << 7);\
+                                     } while (0)
+#define SET_FP_FLAGS(reg, v)      do { (reg) = ((reg) & ~(0x1f <<  2)) |\
+                                               ((v & 0x1f) << 2);\
+                                     } while (0)
 #define UPDATE_FP_FLAGS(reg, v)   do { (reg) |= ((v & 0x1f) << 2); } while (0)
 #define FP_INEXACT        1
 #define FP_UNDERFLOW      2
-- 
2.20.1
