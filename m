Received: from eggs.gnu.org ([209.51.188.92]:57683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEuV4-0005GT-8V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEuV3-0003Ln-3a
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1hEuV2-0003LP-Rn
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:37:41 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 12 Apr 2019 13:37:30 +0200
Message-Id: <20190412113730.28828-2-otubo@redhat.com>
In-Reply-To: <20190412113730.28828-1-otubo@redhat.com>
References: <20190412113730.28828-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, deller@gmx.de, berrange@redhat.com, philmd@redhat.com

From: Helge Deller <deller@gmx.de>

All major distributions do support libseccomp version >=3D 2.3.0, so ther=
e
is no need to special-case on various architectures any longer.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
---
 configure | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/configure b/configure
index 1c563a7027..fcc56aa979 100755
--- a/configure
+++ b/configure
@@ -2377,36 +2377,16 @@ fi
 ##########################################
 # libseccomp check
=20
-libseccomp_minver=3D"2.2.0"
 if test "$seccomp" !=3D "no" ; then
-    case "$cpu" in
-    i386|x86_64|mips)
-        ;;
-    arm|aarch64)
-        libseccomp_minver=3D"2.2.3"
-        ;;
-    ppc|ppc64|s390x)
-        libseccomp_minver=3D"2.3.0"
-        ;;
-    *)
-        libseccomp_minver=3D""
-        ;;
-    esac
-
-    if test "$libseccomp_minver" !=3D "" &&
-       $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ; t=
hen
+    libseccomp_minver=3D"2.3.0"
+    if $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ; t=
hen
         seccomp_cflags=3D"$($pkg_config --cflags libseccomp)"
         seccomp_libs=3D"$($pkg_config --libs libseccomp)"
         seccomp=3D"yes"
     else
         if test "$seccomp" =3D "yes" ; then
-            if test "$libseccomp_minver" !=3D "" ; then
-                feature_not_found "libseccomp" \
-                    "Install libseccomp devel >=3D $libseccomp_minver"
-            else
-                feature_not_found "libseccomp" \
-                    "libseccomp is not supported for host cpu $cpu"
-            fi
+            feature_not_found "libseccomp" \
+                 "Install libseccomp devel >=3D $libseccomp_minver"
         fi
         seccomp=3D"no"
     fi
--=20
2.17.2
