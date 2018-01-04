Received: from eggs.gnu.org ([2001:4830:134:3::10]:37493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX83F-0007Wp-8k
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX83E-0003oB-Dh
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX83E-0003nI-7P
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:28 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:10 +0100
Message-Id: <20180104160523.22995-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/18] tests/docker: add some sanitizers to
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
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Build fedora image with ASAN/UBSan support.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
index 4b26c3aded..32de731675 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -3,7 +3,7 @@ ENV PACKAGES \
     ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostna=
me \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
     gcc gcc-c++ clang make perl which bc findutils libaio-devel \
-    nettle-devel \
+    nettle-devel libasan libubsan \
     mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-con=
fig \
     mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libt=
asn1 \
     mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
@@ -15,4 +15,4 @@ ENV PACKAGES \
=20
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-ENV FEATURES mingw clang pyyaml
+ENV FEATURES mingw clang pyyaml asan
--=20
2.15.1.355.g36791d7216
