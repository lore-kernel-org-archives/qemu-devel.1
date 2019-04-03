Received: from eggs.gnu.org ([209.51.188.92]:43163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hBfL1-0004ZU-7q
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hBfL0-0003Cl-9T
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:49:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:41069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1hBfKz-0003Be-Tk
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:49:54 -0400
Date: Wed, 3 Apr 2019 14:49:48 +0200
From: Helge Deller <deller@gmx.de>
Message-ID: <20190403124948.GA14129@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

On a non-release architecture, the configure program aborts if the
=2D-enable-seccomp flag was given (with no way to work around it on the
command line):

ERROR: User requested feature libseccomp
	configure was not able to find it.
	libseccomp is not supported for host cpu parisc64

Instead of aborting, fall back to require libseccomp version 2.2.0
(or any higher version currently installed) which should be OK for
non-release architectures.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/configure b/configure
index 1c563a7027..8632267049 100755
=2D-- a/configure
+++ b/configure
@@ -2389,7 +2389,6 @@ if test "$seccomp" !=3D "no" ; then
         libseccomp_minver=3D"2.3.0"
         ;;
     *)
-        libseccomp_minver=3D""
         ;;
     esac
