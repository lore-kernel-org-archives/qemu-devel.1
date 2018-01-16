Received: from eggs.gnu.org ([2001:4830:134:3::10]:40514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRXg-0000D0-A0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebRXd-0001UN-6b
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebRXd-0001Tx-0E
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:44:41 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 16 Jan 2018 13:42:17 +0000
Message-Id: <20180116134217.8725-15-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-1-berrange@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 14/14] docker: change Fedora images to run
 with python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Fedora has switched to Python 3 by default, so it makes sense to use that
for testing QEMU builds, so we get testing of Python 3 compatibility.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 4b26c3aded..a22fe16157 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,6 +1,6 @@
 FROM fedora:latest
 ENV PACKAGES \
-    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
+    ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
     gcc gcc-c++ clang make perl which bc findutils libaio-devel \
     nettle-devel \
@@ -12,6 +12,7 @@ ENV PACKAGES \
     mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
     mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
     mingw64-bzip2
+ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.14.3
