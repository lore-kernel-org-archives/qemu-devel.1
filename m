Received: from eggs.gnu.org ([2001:4830:134:3::10]:59293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHqN-0008UV-E9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHqJ-0005KU-E9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:38:19 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 12 Jul 2017 16:38:02 +0300
Message-Id: <e189091fba4481fa4c9d760f0bf9037620a51989.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/13] configure: Handle having no c++ compiler
 in FORTIFY_SOURCE check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

Our FORTIFY_SOURCE check assumes that $cxx refers to a working C++
compiler, with the result that if you don't happen to have one
then configure will spuriously print
  configure: line 4685: c++: command not found

Fix this by adding a 'has $cxx' check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index ce7e8aa842..08ef54103e 100755
--- a/configure
+++ b/configure
@@ -4771,7 +4771,7 @@ fi
 if test "$fortify_source" !=3D "no"; then
   if echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then
     fortify_source=3D"no";
-  elif test -n "$cxx" &&
+  elif test -n "$cxx" && has $cxx &&
        echo | $cxx -dM -E - | grep __clang__ >/dev/null 2>&1 ; then
     fortify_source=3D"no";
   else
--=20
2.11.0
