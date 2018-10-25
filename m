Received: from eggs.gnu.org ([2001:4830:134:3::10]:40308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKp-0006hk-AT
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjJl-0008PX-D9
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjJl-0008P2-57
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:16 -0400
Message-Id: <20181025172057.20414-8-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 07/48] tcg: export TCGHelperInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h | 7 +++++++
 tcg/tcg.c | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index f4efbaa680..9f9643b470 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -480,6 +480,13 @@ typedef TCGv_ptr TCGv_env;
 /* Used to align parameters.  See the comment before tcgv_i32_temp.  */
 #define TCG_CALL_DUMMY_ARG      ((TCGArg)0)
 
+typedef struct TCGHelperInfo {
+    void *func;
+    const char *name;
+    unsigned flags;
+    unsigned sizemask;
+} TCGHelperInfo;
+
 /* Conditions.  Note that these are laid out for easy manipulation by
    the functions below:
      bit 0 is used for inverting;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 65da3c5dbf..08b6926894 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -868,13 +868,6 @@ void tcg_pool_reset(TCGContext *s)
     s->pool_current = NULL;
 }
 
-typedef struct TCGHelperInfo {
-    void *func;
-    const char *name;
-    unsigned flags;
-    unsigned sizemask;
-} TCGHelperInfo;
-
 #include "exec/helper-proto.h"
 
 static const TCGHelperInfo all_helpers[] = {
-- 
2.17.1
