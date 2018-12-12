Received: from eggs.gnu.org ([2001:4830:134:3::10]:58547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0ad-00087E-LI
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0ac-000457-Js
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:13:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gX0ac-00044m-Dz
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:13:58 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Dec 2018 10:13:46 +0100
Message-Id: <1544606032-16924-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1544606032-16924-1-git-send-email-thuth@redhat.com>
References: <1544606032-16924-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] configure: Remove obsolete check for Clang
 < 3.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Since we have got a check for Clang >= 3.4 now, we do not need to
check for older Clang versions in the configure test for 128-bit ints
anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configure b/configure
index 7621c00..ca364f6 100755
--- a/configure
+++ b/configure
@@ -5148,11 +5148,6 @@ fi
 
 int128=no
 cat > $TMPC << EOF
-#if defined(__clang_major__) && defined(__clang_minor__)
-# if ((__clang_major__ < 3) || (__clang_major__ == 3) && (__clang_minor__ < 2))
-#  error __int128_t does not work in CLANG before 3.2
-# endif
-#endif
 __int128_t a;
 __uint128_t b;
 int main (void) {
-- 
1.8.3.1
