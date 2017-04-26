Received: from eggs.gnu.org ([2001:4830:134:3::10]:60731)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d3KeA-000607-Ft
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d3Ke5-0003mA-MS
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:58:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:59288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d3Ke5-0003lq-DG
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:58:05 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Wed, 26 Apr 2017 12:50:27 +0200
Message-Id: <20170426105027.10666-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] configure: Detect native NetBSD curses(3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Kamil Rytarowski <n54@gmx.com>

NetBSD ships with traditional BSD curses with compatibility with ncurses.
qemu works nicely with the basesystem version of curses(3) from NetBSD.

The only mismatch between curses(3) and ncurses is the lack of
curses_version() in the NetBSD version. This function is used solely in
the configure script, therefore eliminate it from the curses(3) detection.

With this change applied, configure detects correctly curses frontend.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 configure | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure b/configure
index c35acf1192..17dc7224f7 100755
--- a/configure
+++ b/configure
@@ -3034,14 +3034,13 @@ if test "$curses" != "no" ; then
 #include <curses.h>
 #include <wchar.h>
 int main(void) {
-  const char *s = curses_version();
   wchar_t wch = L'w';
   setlocale(LC_ALL, "");
   resize_term(0, 0);
   addwstr(L"wide chars\n");
   addnwstr(&wch, 1);
   add_wch(WACS_DEGREE);
-  return s != 0;
+  return 0;
 }
 EOF
   IFS=:
-- 
2.12.2
