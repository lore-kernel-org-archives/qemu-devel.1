Received: from eggs.gnu.org ([2001:4830:134:3::10]:49235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dNKOo-0002Wy-Ij
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dNKOn-0002Fb-Qk
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:44:58 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dNKOn-0002C4-JI
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:44:57 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:44:46 +0100
Message-Id: <1497969886-17773-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497969886-17773-1-git-send-email-peter.maydell@linaro.org>
References: <1497969886-17773-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] risu_reginfo_arm.c: Move orphan comment to
 risu.h.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, patches@linaro.org

Move an orphan comment that describes the reginfo structure
into risu.h, and expand it a little.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 risu.h             | 5 +++++
 risu_reginfo_arm.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/risu.h b/risu.h
index 3fbeda8..70c2184 100644
--- a/risu.h
+++ b/risu.h
@@ -48,6 +48,11 @@ extern int test_fp_exc;
 /* The memory block should be this long */
 #define MEMBLOCKLEN 8192
 
+/* This is the data structure we pass over the socket for OP_COMPARE
+ * and OP_TESTEND. It is a simplified and reduced subset of what can
+ * be obtained with a ucontext_t*, and is architecture specific
+ * (defined in risu_reginfo_*.h).
+ */
 struct reginfo;
 
 /* Functions operating on reginfo */
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index b0d5da7..6b9ee7b 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -19,11 +19,6 @@
 
 extern int insnsize(ucontext_t *uc);
 
-/* This is the data structure we pass over the socket.
- * It is a simplified and reduced subset of what can
- * be obtained with a ucontext_t*
- */
-
 static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
 {
     /* Read VFP registers. These live in uc->uc_regspace, which is
-- 
2.7.4
