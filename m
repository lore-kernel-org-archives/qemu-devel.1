Received: from eggs.gnu.org ([2001:4830:134:3::10]:50240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS3v-0002uC-8z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS3p-0004YO-B1
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:03 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:41873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS3p-0004Y1-58
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:57 -0500
Received: by mail-wm0-x243.google.com with SMTP id f71so8700778wmf.0
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:17:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:16:55 +0100
Message-Id: <1516112253-14480-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/51] tests/docker: add some sanitizers to
 fedora dockerfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Build fedora image with ASAN/UBSan support.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180104160523.22995-6-marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 4b26c3a..32de731 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -3,7 +3,7 @@ ENV PACKAGES \
     ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
     gcc gcc-c++ clang make perl which bc findutils libaio-devel \
-    nettle-devel \
+    nettle-devel libasan libubsan \
     mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
     mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
     mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
@@ -15,4 +15,4 @@ ENV PACKAGES \
 
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-ENV FEATURES mingw clang pyyaml
+ENV FEATURES mingw clang pyyaml asan
-- 
1.8.3.1
