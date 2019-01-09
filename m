Received: from eggs.gnu.org ([209.51.188.92]:45847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGln-0002IJ-B6
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlm-0001L6-3U
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGll-0001Ka-SS
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:54 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:12 +0000
Message-Id: <20190109163114.17010-12-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/13] travis: stop using container based envs
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

The Travis container based envs are deprecated:

  https://docs.travis-ci.com/user/reference/trusty/

  "Container-based infrastructure is currently being deprecated.
   Please remove any sudo: false keys in your .travis.yml file
   to use the default fully-virtualized Linux infrastructure
   instead."

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index ddfef6d738..dc8b37db80 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,8 +1,4 @@
-# The current Travis default is a container based 14.04 Trust on EC2
-# Additional builds with specific requirements for a full VM need to
-# be added as additional matrix: entries later on
=20
-sudo: false
 dist: trusty
 language: c
 python:
@@ -253,6 +249,5 @@ matrix:
     - env:
         - CONFIG=3D"--disable-system --disable-docs"
         - TEST_CMD=3D"make -j3 check-tcg"
-      sudo: required
       dist: trusty
       compiler: gcc
--=20
2.19.2
