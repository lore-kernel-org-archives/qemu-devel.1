Received: from eggs.gnu.org ([2001:4830:134:3::10]:46502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0I-0007QA-PJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0H-00037K-VS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:22 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0H-00035d-Ou
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:21 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 12so23211121wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:44 +0100
Message-Id: <20170718104513.23947-4-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/32] docker: include python-yaml in
 travis.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:-----------------..." <qemu-devel@nongnu.org>

Although the upstream Travis images don't need this library our
"travis-lite" scripts are written in python. This allows us to do:

  make docker-travis@travis J=10

and approximate a travis run on their default image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
