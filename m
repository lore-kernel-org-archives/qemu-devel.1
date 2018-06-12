Received: from eggs.gnu.org ([2001:4830:134:3::10]:51375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSefG-0007WZ-GC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSefB-0003Y9-Lo
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:28:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fSefB-0003Xs-Hm
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:28:25 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 12 Jun 2018 09:28:23 +0100
Message-Id: <20180612082823.25507-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] travis: display config.log when configure fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When configure fails in CI systems we must be able to see the contents
of the config.log file to diagnose the root cause.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 814be151f4..fc9a1fe8a8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -69,7 +69,7 @@ before_install:
   - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-s=
eed.tar.xz | tar -xvJ
   - git submodule update --init --recursive
 before_script:
-  - ./configure ${CONFIG}
+  - ./configure ${CONFIG} || (cat config.log && exit 1)
 script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
@@ -151,4 +151,4 @@ matrix:
         - CONFIG=3D"--cc=3Dgcc-7 --cxx=3Dg++-7 --disable-pie --disable-l=
inux-user"
         - TEST_CMD=3D""
       before_script:
-        - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3Dt=
hread -fuse-ld=3Dgold" || cat config.log
+        - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3Dt=
hread -fuse-ld=3Dgold" || (cat config.log && exit 1)
--=20
2.17.0
