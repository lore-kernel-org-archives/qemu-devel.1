Received: from eggs.gnu.org ([209.51.188.92]:45634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlT-00022Y-Ai
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlQ-00017I-MU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlQ-00013e-F7
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:32 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:03 +0000
Message-Id: <20190109163114.17010-3-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/13] tests: remove obsolete 'debian'
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The 'debian' dockerfile was deprecated in favour of versioned
dockerfiles in July 2017. That is enough time for developers to
be warned about the rename.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/docker/dockerfiles/debian.docker | 13 -------------
 1 file changed, 13 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian.docker

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/docker=
files/debian.docker
deleted file mode 100644
index fd32e71b79..0000000000
--- a/tests/docker/dockerfiles/debian.docker
+++ /dev/null
@@ -1,13 +0,0 @@
-# This template is deprecated and was previously based on Jessie on QEMU=
 2.9.
-# Now than Stretch is out, please use qemu:debian8 as base for Jessie,
-# and qemu:debian9 for Stretch.
-#
-FROM qemu:debian9
-
-MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-
-RUN for n in $(seq 8); do echo; done && \
-    echo "\n\t\tThis image is deprecated." && echo && \
-    echo "\tUse 'FROM qemu:debian9' to use the stable Debian Stretch ima=
ge" && \
-    echo "\tor 'FROM qemu:debian8' to use old Debian Jessie." && \
-    for n in $(seq 8); do echo; done
--=20
2.19.2
