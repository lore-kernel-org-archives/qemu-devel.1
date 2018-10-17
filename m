Received: from eggs.gnu.org ([2001:4830:134:3::10]:53448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiiA-0005yK-Bs
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii7-0002Ey-8w
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCii6-0001Hr-Sm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:51 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:05:07 +0200
Message-Id: <1539770707-7289-16-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/15] configure: remove glib_subprocess check
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This should have been removed as part of commit
692fbdf9f4c6f6bafd0b3a4d4f94973effd3bbae.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/configure b/configure
index 8af2be9..9138af3 100755
--- a/configure
+++ b/configure
@@ -3531,12 +3531,6 @@ if ! compile_prog "$CFLAGS" "$LIBS" ; then
 	       "build target"
 fi
=20
-# g_test_trap_subprocess added in 2.38. Used by some tests.
-glib_subprocess=3Dyes
-if ! $pkg_config --atleast-version=3D2.38 glib-2.0; then
-    glib_subprocess=3Dno
-fi
-
 # Silence clang 3.5.0 warnings about glib attribute __alloc_size__ usage
 cat > $TMPC << EOF
 #include <glib.h>
--=20
1.8.3.1
