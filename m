Received: from eggs.gnu.org ([209.51.188.92]:43317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEL5-0004H6-Cg
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEL4-0002MP-Cm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEL4-0002MD-6v
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:38 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  2 May 2019 18:13:09 +0200
Message-Id: <20190502161310.15624-8-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
References: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/8] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Helge Deller <deller@gmx.de>, Eduardo Otubo <otubo@redhat.com>

From: Helge Deller <deller@gmx.de>

All major distributions do support libseccomp version >=3D 2.3.0, so ther=
e
is no need to special-case on various architectures any longer.

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20190404183923.GA22347@ls3530.dellerweb.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/configure b/configure
index f14b25c49c..3a9bee2621 100755
--- a/configure
+++ b/configure
@@ -2374,36 +2374,16 @@ fi
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
2.21.0
