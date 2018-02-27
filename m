Received: from eggs.gnu.org ([2001:4830:134:3::10]:50930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eqXzG-0004aT-83
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eqXzC-0000QB-LP
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:38 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eqXzC-0000PX-Hd
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Feb 2018 00:39:16 -0500
Message-Id: <1519709965-29833-8-git-send-email-cota@braap.org>
In-Reply-To: <1519709965-29833-1-git-send-email-cota@braap.org>
References: <1519709965-29833-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 07/16] translate-all: remove hole in PageDesc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Groundwork for supporting parallel TCG generation.

Move the hole to the end of the struct, so that a u32
field can be added there without bloating the struct.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f2bfa71..816419a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -107,8 +107,8 @@ typedef struct PageDesc {
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
