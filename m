Received: from eggs.gnu.org ([2001:4830:134:3::10]:42859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5v-0006F6-2l
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5r-0002j4-6C
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:27 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9A5q-0002hD-W2
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:23 -0400
Received: by mail-wr0-x241.google.com with SMTP id d19-v6so14369925wre.1
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:59:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:34 +0100
Message-Id: <20180419135901.30035-17-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 16/43] docker: Add fedora-i386-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Fam Zheng <famz@redhat.com>

It has some basic *-devel.i686 packages to be used with "gcc -m32" as a
32 bit cross build environment.

Signed-off-by: Fam Zheng <famz@redhat.com>
[AJB: add glibc-static]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - include static glibc package as well
---
 tests/docker/dockerfiles/fedora-i386-cross.docker | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker

diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
new file mode 100644
index 0000000000..8fbef2fa53
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -0,0 +1,14 @@
+FROM fedora:latest
+ENV PACKAGES \
+    gcc \
+    glibc-static.i686 \
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
2.17.0
