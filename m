Received: from eggs.gnu.org ([2001:4830:134:3::10]:44741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5rE-00040D-Ci
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5rD-00015h-ES
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:35:28 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5rC-00015U-W9
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:35:27 -0500
Received: by mail-qk0-x242.google.com with SMTP id i141so17036554qke.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 06:35:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 11:34:57 -0300
Message-Id: <20180115143500.22631-7-f4bug@amsat.org>
In-Reply-To: <20180115143500.22631-1-f4bug@amsat.org>
References: <20180115143500.22631-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 6/8] docker: add the Fedora 27 base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

straight copy on Fedora 25 base.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/fedora27.docker | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora27.docker

diff --git a/tests/docker/dockerfiles/fedora27.docker b/tests/docker/dockerfiles/fedora27.docker
new file mode 100644
index 0000000000..7cba4dcc2c
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora27.docker
@@ -0,0 +1,18 @@
+FROM fedora:27
+ENV PACKAGES \
+    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
+    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
+    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
+    nettle-devel \
+    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
+    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
+    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
+    mingw32-bzip2 \
+    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config \
+    mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
+    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
+    mingw64-bzip2
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV FEATURES mingw clang pyyaml
-- 
2.15.1
