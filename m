Received: from eggs.gnu.org ([2001:4830:134:3::10]:46427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zL-0004RG-5h
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zE-00030n-PF
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-0002z5-5C
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:01 -0400
Message-Id: <1499586614-20507-10-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 09/22] exec-all: shrink tb->invalid to uint8_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

To avoid wasting a byte. I don't have any use in mind for this byte,
but I think it's good to leave this byte explicitly free for future use.
See this discussion for how the u16 came to be:
  https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04564.html
We could use a bool but in some systems that would take > 1 byte.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8326e7d..a388756 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -327,7 +327,7 @@ struct TranslationBlock {
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
 
-    uint16_t invalid;
+    uint8_t invalid;
 
     void *tc_ptr;    /* pointer to the translated code */
     uint8_t *tc_search;  /* pointer to search data */
-- 
2.7.4
