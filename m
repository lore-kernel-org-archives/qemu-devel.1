Received: from eggs.gnu.org ([209.51.188.92]:42721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFa-0000UF-CV
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFZ-0007Oj-Lx
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:50 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFZ-0007O2-GJ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:49 -0500
Received: by mail-wm1-x32c.google.com with SMTP id g20so9427895wmh.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:49 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:30 +0000
Message-Id: <20190228202537.4638-10-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/16] tests/docker: add fedora-cris-cross
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
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
2.20.1
