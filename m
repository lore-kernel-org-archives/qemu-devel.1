Received: from eggs.gnu.org ([2001:4830:134:3::10]:52537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPl-00065g-FK
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPg-0000Ww-Qd
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqFPg-0000WD-K7
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:24 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:16:56 +0800
Message-Id: <20170908091700.14867-4-famz@redhat.com>
In-Reply-To: <20170908091700.14867-1-famz@redhat.com>
References: <20170908091700.14867-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/7] docker: Add fedora-i386-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, programmingkidx@gmail.com, crosa@redhat.com, pbonzini@redhat.com, rth@twiddle.net

It has some basic *-devel.i686 packages to be used with "gcc -m32" as a
32 bit cross build environment.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/fedora-i386-cross.docker | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker

diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
new file mode 100644
index 0000000000..239fba5fa6
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -0,0 +1,13 @@
+FROM fedora:latest
+ENV PACKAGES \
+    gcc \
+    glibc-devel.i686 \
+    glib2-devel.i686 \
+    zlib-devel.i686 \
+    glib2-devel.i686 \
+    nettle-devel.i686 \
+    pixman-devel.i686 \
+    gnutls-devel.i686
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.13.5
