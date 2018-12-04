Received: from eggs.gnu.org ([2001:4830:134:3::10]:45832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUChC-0005i3-Li
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUChB-0000OS-Vk
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUChB-0000O0-QJ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:33:09 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  4 Dec 2018 16:32:52 +0100
Message-Id: <1543937577-28256-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1543937577-28256-1-git-send-email-thuth@redhat.com>
References: <1543937577-28256-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 v2 2/7] configure: Remove obsolete
 check for Clang < 3.2
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

Since we have got a check for Clang >= 3.4 now, we do not need to
check for older Clang versions in the configure test for 128-bit ints
anymore.

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
