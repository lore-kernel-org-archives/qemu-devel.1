Received: from eggs.gnu.org ([2001:4830:134:3::10]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mh-0000zk-8c
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mg-0000QG-2h
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6Mf-0000PV-R1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:57 -0500
Received: by mail-wm1-x335.google.com with SMTP id y1so6138256wmi.3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:57 +0100
Message-Id: <1544628195-37728-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 36/54] tcg/tcg.h: Remove GCC check for
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
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Both GCC v4.8 and Clang v3.4 support (our minimum versions) support
__builtin_unreachable(), so we can remove the version check here now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543937577-28256-5-git-send-email-thuth@redhat.com>
---
 tcg/tcg.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index cbe4309..973a757 100644
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
