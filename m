Received: from eggs.gnu.org ([2001:4830:134:3::10]:37763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNguv-0006j3-DR
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgur-00050B-7t
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:37 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgur-0004zX-2G
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:33 -0400
Received: by mail-wr0-x230.google.com with SMTP id c11so82678830wrc.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:47:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:47:54 +0100
Message-Id: <20170621144814.15324-2-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/21] docker: update qemu:debian base following
 stretch release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Debian has now released Stretch as its new stable. As we track
debian:stable-slim this has a few consequences. For one thing we can
now drop the emdebian hacks as cross compilers are part of the
official repositories now. However we do loose the ability to build
against powerpc (not ppc64) since that is no longer a release
architecture.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 52bd79938e..4ca6ecaad0 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -9,14 +9,6 @@
 #
 FROM debian:stable-slim
 
-# Setup some basic tools we need
-RUN apt update
-RUN apt install -yy curl aptitude
-
-# Setup Emdebian
-RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
-RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
-
 # Duplicate deb line as deb-src
 RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
 
-- 
2.13.0
