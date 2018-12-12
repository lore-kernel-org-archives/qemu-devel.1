Received: from eggs.gnu.org ([2001:4830:134:3::10]:52528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mh-0000zj-7p
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Me-0000Om-Iy
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:59 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:55395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6Md-0000Nn-TP
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id y139so6133868wmc.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:55 +0100
Message-Id: <1544628195-37728-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/54] configure: Remove obsolete check for
 Clang < 3.2
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

Since we have got a check for Clang >= 3.4 now, we do not need to
check for older Clang versions in the configure test for 128-bit ints
anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1543937577-28256-3-git-send-email-thuth@redhat.com>
---
 configure | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configure b/configure
index 51150b1..3e401b7 100755
--- a/configure
+++ b/configure
@@ -5145,11 +5145,6 @@ fi
 
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
