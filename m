Received: from eggs.gnu.org ([2001:4830:134:3::10]:45914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUChM-00061w-5F
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUChH-0000Rk-A5
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUChH-0000RK-4q
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:15 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  4 Dec 2018 16:32:54 +0100
Message-Id: <1543937577-28256-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1543937577-28256-1-git-send-email-thuth@redhat.com>
References: <1543937577-28256-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 v2 4/7] tcg/tcg.h: Remove GCC check for
 tcg_debug_assert() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org

Both GCC v4.8 and Clang v3.4 support (our minimum versions) support
__builtin_unreachable(), so we can remove the version check here now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tcg/tcg.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index f4efbaa..f9a56a9 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -230,11 +230,9 @@ typedef uint64_t tcg_insn_unit;
 
 #if defined CONFIG_DEBUG_TCG || defined QEMU_STATIC_ANALYSIS
 # define tcg_debug_assert(X) do { assert(X); } while (0)
-#elif QEMU_GNUC_PREREQ(4, 5)
+#else
 # define tcg_debug_assert(X) \
     do { if (!(X)) { __builtin_unreachable(); } } while (0)
-#else
-# define tcg_debug_assert(X) do { (void)(X); } while (0)
 #endif
 
 typedef struct TCGRelocation {
-- 
1.8.3.1
