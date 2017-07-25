Received: from eggs.gnu.org ([2001:4830:134:3::10]:44579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZzyu-00049z-G7
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZzyt-0004TC-Hj
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:34:36 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dZzyt-0004SW-Bu
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:34:35 -0400
Received: by mail-wr0-x22b.google.com with SMTP id k71so65612440wrc.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:34:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 25 Jul 2017 14:34:24 +0100
Message-Id: <20170725133425.436-6-alex.bennee@linaro.org>
In-Reply-To: <20170725133425.436-1-alex.bennee@linaro.org>
References: <20170725133425.436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 5/6] docker: don't install
 device-tree-compiler build-deps in travis.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Installing the device-tree-compiler build-deps is a little extreme. We
only actually need the binary so include it with the other packages.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/travis.docker | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index 636fa590a5..57ac8e1419 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -1,6 +1,5 @@
 FROM quay.io/travisci/travis-ruby
 RUN apt-get update
 RUN apt-get -y build-dep qemu
-RUN apt-get -y build-dep device-tree-compiler
-RUN apt-get -y install python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
+RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
 ENV FEATURES pyyaml
-- 
2.13.0
