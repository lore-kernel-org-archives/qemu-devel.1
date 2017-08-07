Received: from eggs.gnu.org ([2001:4830:134:3::10]:47804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpN-0005yZ-8y
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpI-0005jk-2T
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpH-0005jE-TF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:29 -0400
Message-Id: <1502149958-23381-14-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 13/22] translate-all: remove hole in PageDesc
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

Groundwork for supporting parallel TCG generation.

Move the hole to the end of the struct, so that a u32
field can be added there without bloating the struct.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 12e1252..64d099b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -108,8 +108,8 @@ typedef struct PageDesc {
 #ifdef CONFIG_SOFTMMU
     /* in order to optimize self modifying code, we count the number
        of lookups we do to a given page to use a bitmap */
-    unsigned int code_write_count;
     unsigned long *code_bitmap;
+    unsigned int code_write_count;
 #else
     unsigned long flags;
 #endif
-- 
2.7.4
