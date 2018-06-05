Received: from eggs.gnu.org ([2001:4830:134:3::10]:53154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQEVG-0000vB-Ke
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQESz-0004N3-Eq
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:10 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:52857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQESz-0004MY-3J
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:05:49 -0400
Received: by mail-wm0-x236.google.com with SMTP id p126-v6so6010396wmb.2
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 09:05:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Jun 2018 17:05:40 +0100
Message-Id: <20180605160541.10664-6-alex.bennee@linaro.org>
In-Reply-To: <20180605160541.10664-1-alex.bennee@linaro.org>
References: <20180605160541.10664-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/6] docker: test-mingw: use SDL2 and GTK+3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Do not test the deprecated API versions.  debian-win32-cross and debian-win64-cross
are already using SDL2 (they do not cover GTK+ at all).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[AJB: fix merge conflicts]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 65d7761cf5..7d1d008002 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -11,12 +11,12 @@ ENV PACKAGES \
     numactl-devel SDL2-devel snappy-devel spice-server-devel \
     systemtap-sdt-devel usbredir-devel virglrenderer-devel vte3-devel \
     xen-devel \
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
2.17.0
