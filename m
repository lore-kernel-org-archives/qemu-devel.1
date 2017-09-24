Received: from eggs.gnu.org ([2001:4830:134:3::10]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEMd-0008PQ-NG
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEMZ-00048J-NA
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:22:59 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:19 +0300
Message-Id: <94219606725f67b0888061c39465abc74a394b00.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/31] configure: Remove unused code (found by
 shellcheck)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Stefan Weil <sw@weilnetz.de>

smartcard_cflags is no longer needed since commit
0b22ef0f57a8910d849602bef0940edcd0553d2c.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index 133a5757ef..12d4e4ebfa 100755
--- a/configure
+++ b/configure
@@ -4229,7 +4229,6 @@ EOF
 fi
=20
 # check for smartcard support
-smartcard_cflags=3D""
 if test "$smartcard" !=3D "no"; then
     if $pkg_config libcacard; then
         libcacard_cflags=3D$($pkg_config --cflags libcacard)
--=20
2.11.0
