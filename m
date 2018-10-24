Received: from eggs.gnu.org ([2001:4830:134:3::10]:43392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFq0-0004hp-8P
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFpx-00068t-66
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gFFpu-00065h-I7
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:23 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 Oct 2018 10:52:06 +0100
Message-Id: <1540374728-27579-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1540374728-27579-1-git-send-email-thuth@redhat.com>
References: <1540374728-27579-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/6] debian-bootstrap.pre: Modern shell
 scripting (use $() instead of ``)
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

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Various shell files contain a mix between obsolete ``
and modern $(); It would be nice to convert to using $()
everywhere.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/docker/dockerfiles/debian-bootstrap.pre | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker=
/dockerfiles/debian-bootstrap.pre
index 3b0ef95..c164778 100755
--- a/tests/docker/dockerfiles/debian-bootstrap.pre
+++ b/tests/docker/dockerfiles/debian-bootstrap.pre
@@ -2,7 +2,7 @@
 #
 # Simple wrapper for debootstrap, run in the docker build context
 #
-FAKEROOT=3D`which fakeroot 2> /dev/null`
+FAKEROOT=3D$(which fakeroot 2> /dev/null)
 # debootstrap < 1.0.67 generates empty sources.list, see Debian#732255
 MIN_DEBOOTSTRAP_VERSION=3D1.0.67
=20
@@ -52,7 +52,7 @@ fi
=20
 if [ -z $DEBOOTSTRAP_DIR ]; then
     NEED_DEBOOTSTRAP=3Dfalse
-    DEBOOTSTRAP=3D`which debootstrap 2> /dev/null`
+    DEBOOTSTRAP=3D$(which debootstrap 2> /dev/null)
     if [ -z $DEBOOTSTRAP ]; then
         echo "No debootstrap installed, attempting to install from SCM"
         NEED_DEBOOTSTRAP=3Dtrue
--=20
1.8.3.1
