Received: from eggs.gnu.org ([2001:4830:134:3::10]:36921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8Ng-0006oQ-Ep
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gL8Na-0006jY-IK
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gL8Na-0006iW-Ao
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:07:26 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 10:07:07 -0500
Message-Id: <20181109150710.31085-2-crosa@redhat.com>
In-Reply-To: <20181109150710.31085-1-crosa@redhat.com>
References: <20181109150710.31085-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] configure: keep track of Python version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>

Some functionality is dependent on the Python version
detected/configured on configure.  While it's possible to run the
Python version later and check for the version, doing it once is
preferable.  Also, it's a relevant information to keep in build logs,
as the overall behavior of the build can be affected by it.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 74e313a810..67fff0290d 100755
--- a/configure
+++ b/configure
@@ -1740,6 +1740,9 @@ if ! $python -c 'import sys; sys.exit(sys.version_i=
nfo < (2,7))'; then
       "Use --python=3D/path/to/python to specify a supported Python."
 fi
=20
+# Preserve python version since some functionality is dependent on it
+python_version=3D$($python -V 2>&1 | sed -e 's/Python\ //')
+
 # Suppress writing compiled files
 python=3D"$python -B"
=20
@@ -5918,7 +5921,7 @@ echo "LDFLAGS           $LDFLAGS"
 echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
-echo "python            $python"
+echo "python            $python ($python_version)"
 if test "$slirp" =3D "yes" ; then
     echo "smbd              $smbd"
 fi
@@ -6823,6 +6826,7 @@ echo "INSTALL_DATA=3D$install -c -m 0644" >> $confi=
g_host_mak
 echo "INSTALL_PROG=3D$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=3D$python" >> $config_host_mak
+echo "PYTHON_VERSION=3D$python_version" >> $config_host_mak
 echo "CC=3D$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=3D$iasl" >> $config_host_mak
--=20
2.19.1
