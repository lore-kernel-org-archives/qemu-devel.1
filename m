Received: from eggs.gnu.org ([209.51.188.92]:33856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOf-0004lQ-Mc
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOd-0008J8-Sk
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:37 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOZ-0007e1-Oy
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:34 -0500
Received: by mail-wr1-x442.google.com with SMTP id q18so12341948wrx.9
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:03 +0000
Message-Id: <20190110174516.21586-7-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 06/19] tests: use in-place sed magic for
 enabling deb-src in travis image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This avoids potential problems with duplicates.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/travis.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index 03ebfb0ef2..46cf367488 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -2,7 +2,7 @@ FROM travisci/ci-garnet:packer-1512502276-986baf0
 ENV DEBIAN_FRONTEND noninteractive
 ENV LANG en_US.UTF-8
 ENV LC_ALL en_US.UTF-8
-RUN cat /etc/apt/sources.list | sed "s/# deb-src/deb-src/" >> /etc/apt/sources.list
+RUN sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list
 RUN apt-get update
 RUN apt-get -y build-dep qemu
 RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools gcovr
-- 
2.17.1
