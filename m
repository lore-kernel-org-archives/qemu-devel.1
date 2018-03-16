Received: from eggs.gnu.org ([2001:4830:134:3::10]:38246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewoQk-0006h3-VW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewoQi-0008LT-Ci
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:25:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewoQi-0008LF-7E
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:25:52 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 Mar 2018 13:25:40 +0100
Message-Id: <20180316122540.28409-3-pbonzini@redhat.com>
In-Reply-To: <20180316122540.28409-1-pbonzini@redhat.com>
References: <20180316122540.28409-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] docker: fedora: include more build
 dependencies
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

Install optional dependencies of QEMU to get better coverage.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 67 ++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index be3566325c..6d810f6a92 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,18 +1,61 @@
 FROM fedora:27
 ENV PACKAGES \
     ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
-    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
-    gcc gcc-c++ llvm clang make perl which bc findutils libaio-devel \
-    nettle-devel libasan libubsan \
-    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL2 mingw32-pkg-config \
-    mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
-    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
-    mingw32-bzip2 \
-    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL2 mingw64-pkg-config \
-    mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
-    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
-    mingw64-bzip2
-ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
+    gcc gcc-c++ llvm clang make perl which bc findutils libasan libubsan \
+    alsa-lib-devel \
+    bluez-libs-devel \
+    brlapi-devel \
+    bzip2-devel mingw32-bzip2 mingw64-bzip2 \
+    cyrus-sasl-devel \
+    device-mapper-multipath-devel \
+    glib2-devel mingw32-glib2 mingw64-glib2 \
+    glusterfs-api-devel \
+    gnutls-devel mingw32-gnutls mingw64-gnutls \
+    gtk3-devel mingw32-gtk3 mingw64-gtk3 \
+    libaio-devel \
+    libattr-devel \
+    libcacard-devel \
+    libcap-devel \
+    libcap-ng-devel \
+    libcurl-devel mingw32-curl mingw64-curl \
+    libepoxy-devel \
+    libfdt-devel \
+    mingw32-gmp mingw64-gmp \
+    libiscsi-devel \
+    libjpeg-devel mingw32-libjpeg-turbo mingw64-libjpeg-turbo \
+    libnfs-devel \
+    libpng-devel mingw32-libpng mingw64-libpng \
+    librbd-devel \
+    librdmacm-devel \
+    libseccomp-devel \
+    libtasn1-devel mingw32-libtasn1 mingw64-libtasn1 \
+    libssh2-devel mingw32-libssh2 mingw64-libssh2 \
+    libusbx-devel \
+    libuuid-devel \
+    libxml2-devel \
+    lzo-devel \
+    mesa-libgbm-devel \
+    ncurses-devel \
+    nettle-devel mingw32-nettle mingw64-nettle \
+    nss-devel \
+    numactl-devel \
+    perl-podlators \
+    pkg-config mingw32-pkg-config mingw64-pkg-config \
+    pulseaudio-libs-devel \
+    pixman-devel mingw32-pixman mingw64-pixman \
+    SDL2-devel mingw32-SDL2 mingw64-SDL2 \
+    snappy-devel \
+    spice-server-devel \
+    systemd-devel \
+    systemtap-sdt-devel \
+    texinfo \
+    usbredir-devel \
+    virglrenderer-devel \
+    vte291-devel \
+    xen-devel \
+    zlib-devel
+
+ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3 --enable-trace-backends=dtrace,log,simple
 
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.16.2
