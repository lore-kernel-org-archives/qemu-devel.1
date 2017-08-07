Received: from eggs.gnu.org ([2001:4830:134:3::10]:50629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dek8F-0004jz-12
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dek88-0006cw-RT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:51 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dek88-0006cI-LB
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:44 -0400
Received: by mail-wm0-x22c.google.com with SMTP id m85so10138225wma.1
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 08:39:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  7 Aug 2017 16:39:34 +0100
Message-Id: <20170807153934.29477-7-alex.bennee@linaro.org>
In-Reply-To: <20170807153934.29477-1-alex.bennee@linaro.org>
References: <20170807153934.29477-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v3 6/6] docker: reduce noise when
 building travis.docker
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

Set the DEBIAN_FRONTEND and locale env vars to stop apt complaining so
much as we build the image. See the Travis build logs where it is done
by their scripts.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v3
  - one line env, drop LANG
  - add r-b and t-b tags
---
 tests/docker/dockerfiles/travis.docker | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index 57ac8e1419..03b7ef34de 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -1,4 +1,5 @@
 FROM quay.io/travisci/travis-ruby
+ENV DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8
 RUN apt-get update
 RUN apt-get -y build-dep qemu
 RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
-- 
2.13.0
