Received: from eggs.gnu.org ([2001:4830:134:3::10]:53104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQEVD-0000v2-8P
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQESw-0004L5-LR
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:07 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQESw-0004KQ-Ak
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:05:46 -0400
Received: by mail-wm0-x243.google.com with SMTP id v131-v6so6186056wma.1
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 09:05:46 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Jun 2018 17:05:39 +0100
Message-Id: <20180605160541.10664-5-alex.bennee@linaro.org>
In-Reply-To: <20180605160541.10664-1-alex.bennee@linaro.org>
References: <20180605160541.10664-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/6] docker: Add fedora-i386-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Fam Zheng <famz@redhat.com>

It has some basic *-devel.i686 packages to be used with "gcc -m32" as a
32 bit cross build environment.

Signed-off-by: Fam Zheng <famz@redhat.com>
[AJB: add glibc-static]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
