Received: from eggs.gnu.org ([2001:4830:134:3::10]:43317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU7-00087L-Jy
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU6-0000Wu-Ok
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU6-0000WM-Hj
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:38 -0500
Received: by mail-wm1-x343.google.com with SMTP id y1so11318571wmi.3
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:38 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:24 +0000
Message-Id: <20181210152829.29271-9-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 08/13] tests/docker: add fedora-cris-cross
 compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora-cris-cross.docker | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-cris-cross.docker

diff --git a/tests/docker/dockerfiles/fedora-cris-cross.docker b/tests/docker/dockerfiles/fedora-cris-cross.docker
new file mode 100644
index 0000000000..b168ada615
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-cris-cross.docker
@@ -0,0 +1,8 @@
+#
+# Cross compiler for cris system tests
+#
+
+FROM fedora:latest
+ENV PACKAGES gcc-cris-linux-gnu
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.17.1
