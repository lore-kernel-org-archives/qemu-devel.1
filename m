Received: from eggs.gnu.org ([2001:4830:134:3::10]:36804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KS-0005rZ-Or
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KO-00022H-Lp
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:56 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7KO-00021B-Fc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:52 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w126so78414449wme.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:48:52 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:28 +0100
Message-Id: <20170717144848.11793-4-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 03/23] docker: include python-yaml in
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

Although the upstream Travis images don't need this library our
"travis-lite" scripts are written in python. This allows us to do:

  make docker-travis@travis J=10

and approximate a travis run on their default image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/travis.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index e4983ae2d3..a315f66ad9 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -2,5 +2,5 @@ FROM quay.io/travisci/travis-ruby
 RUN apt-get update
 RUN apt-get -y build-dep qemu
 RUN apt-get -y build-dep device-tree-compiler
-RUN apt-get -y install python2.7 dh-autoreconf
+RUN apt-get -y install python2.7 python-yaml dh-autoreconf
 ENV FEATURES pyyaml
-- 
2.13.0
