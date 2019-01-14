Received: from eggs.gnu.org ([209.51.188.92]:35385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kA-0006Ef-DP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3k9-0005Jb-Hb
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3k9-0005Gm-8t
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id y139so9171885wmc.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:36 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:14 +0000
Message-Id: <20190114150129.1013-7-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/21] tests: use in-place sed magic for
 enabling deb-src in travis image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This avoids potential problems with duplicates.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
