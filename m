Received: from eggs.gnu.org ([2001:4830:134:3::10]:38247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewoQk-0006h4-Vz
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewoQi-0008LU-Cz
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:25:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewoQi-0008LG-7t
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:25:52 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 Mar 2018 13:25:39 +0100
Message-Id: <20180316122540.28409-2-pbonzini@redhat.com>
In-Reply-To: <20180316122540.28409-1-pbonzini@redhat.com>
References: <20180316122540.28409-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] docker: test-mingw: use SDL2 and GTK+3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, berrange@redhat.com, f4bug@amsat.org

Do not test the deprecated API versions.  debian-win32-cross and debian-win64-cross
are already using SDL2 (they do not cover GTK+ at all).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 8 ++++----
 tests/docker/test-mingw                | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index a00004319e..be3566325c 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -4,12 +4,12 @@ ENV PACKAGES \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
     gcc gcc-c++ llvm clang make perl which bc findutils libaio-devel \
     nettle-devel libasan libubsan \
-    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
-    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
+    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL2 mingw32-pkg-config \
+    mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
     mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
     mingw32-bzip2 \
-    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config \
-    mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
+    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL2 mingw64-pkg-config \
+    mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
     mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
     mingw64-bzip2
 ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index 503a6bc6f7..7cca7e16a6 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -28,8 +28,8 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
         --enable-vnc \
         --enable-bzip2 \
         --enable-guest-agent \
-        --with-sdlabi=1.2 \
-        --with-gtkabi=2.0
+        --with-sdlabi=2.0 \
+        --with-gtkabi=3.0
     install_qemu
     make clean
 
-- 
2.16.2
