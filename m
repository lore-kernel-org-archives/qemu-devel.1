Received: from eggs.gnu.org ([2001:4830:134:3::10]:33673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGRC-0000YX-Pk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGRB-0004pq-PG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:30 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGRB-0004pd-Kx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:29 -0400
Received: by mail-qt0-x243.google.com with SMTP id l55so708808qtl.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:32:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:31 -0300
Message-Id: <20170718003159.10200-4-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 03/31] docker: include python-yaml in
 travis.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

Although the upstream Travis images don't need this library our
"travis-lite" scripts are written in python. This allows us to do:

  make docker-travis@travis J=10

and approximate a travis run on their default image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
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
2.13.2
