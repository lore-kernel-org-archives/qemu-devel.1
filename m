Received: from eggs.gnu.org ([209.51.188.92]:33854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOf-0004lP-MM
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOd-0008Hk-NU
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:37 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOZ-0007Zr-P0
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:34 -0500
Received: by mail-wr1-x429.google.com with SMTP id l9so12329212wrt.13
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:21 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:00 +0000
Message-Id: <20190110174516.21586-4-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 03/19] tests: remove obsolete 'debian'
 dockerfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The 'debian' dockerfile was deprecated in favour of versioned
dockerfiles in July 2017. That is enough time for developers to
be warned about the rename.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian.docker | 13 -------------
 1 file changed, 13 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian.docker

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
deleted file mode 100644
index fd32e71b79..0000000000
--- a/tests/docker/dockerfiles/debian.docker
+++ /dev/null
@@ -1,13 +0,0 @@
-# This template is deprecated and was previously based on Jessie on QEMU 2.9.
-# Now than Stretch is out, please use qemu:debian8 as base for Jessie,
-# and qemu:debian9 for Stretch.
-#
-FROM qemu:debian9
-
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
-RUN for n in $(seq 8); do echo; done && \
-    echo "\n\t\tThis image is deprecated." && echo && \
-    echo "\tUse 'FROM qemu:debian9' to use the stable Debian Stretch image" && \
-    echo "\tor 'FROM qemu:debian8' to use old Debian Jessie." && \
-    for n in $(seq 8); do echo; done
-- 
2.17.1
