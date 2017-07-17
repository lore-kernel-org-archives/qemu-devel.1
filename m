Received: from eggs.gnu.org ([2001:4830:134:3::10]:36803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KS-0005rY-Ob
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KP-00023E-Nd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:56 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7KP-00022P-H9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:53 -0400
Received: by mail-wr0-x233.google.com with SMTP id 12so8216035wrb.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:48:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:29 +0100
Message-Id: <20170717144848.11793-5-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 04/23] docker: add debug tools to
 travis.docker
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

When a test fails/hangs you don't want the hassle of getting the debug
tools installed. Lets install them on our image by default so we can
debug when we need to.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/travis.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index a315f66ad9..636fa590a5 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -2,5 +2,5 @@ FROM quay.io/travisci/travis-ruby
 RUN apt-get update
 RUN apt-get -y build-dep qemu
 RUN apt-get -y build-dep device-tree-compiler
-RUN apt-get -y install python2.7 python-yaml dh-autoreconf
+RUN apt-get -y install python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
 ENV FEATURES pyyaml
-- 
2.13.0
