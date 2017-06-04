Received: from eggs.gnu.org ([2001:4830:134:3::10]:39316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHYIa-000210-HR
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHYIW-0004Qj-LW
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:22:40 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:10 +0300
Message-Id: <271f37abb510607ca7650e40951284692a67579a.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/22] configure: Detect native NetBSD curses(3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Kamil Rytarowski <n54@gmx.com>

NetBSD ships with traditional BSD curses with compatibility with ncurses.
qemu works nicely with the basesystem version of curses(3) from NetBSD.

The only mismatch between curses(3) and ncurses is the lack of
curses_version() in the NetBSD version. This function is used solely in
the configure script, therefore eliminate it from the curses(3) detection=
.

With this change applied, configure detects correctly curses frontend.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 configure | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure b/configure
index 21944eaa05..fbb6a93c99 100755
--- a/configure
+++ b/configure
@@ -3042,14 +3042,13 @@ if test "$curses" !=3D "no" ; then
 #include <curses.h>
 #include <wchar.h>
 int main(void) {
-  const char *s =3D curses_version();
   wchar_t wch =3D L'w';
   setlocale(LC_ALL, "");
   resize_term(0, 0);
   addwstr(L"wide chars\n");
   addnwstr(&wch, 1);
   add_wch(WACS_DEGREE);
-  return s !=3D 0;
+  return 0;
 }
 EOF
   IFS=3D:
--=20
2.11.0
