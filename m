Received: from eggs.gnu.org ([2001:4830:134:3::10]:33467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYaz-0005kX-D3
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYax-0006Ax-Qk
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYax-00069w-KH
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:45:37 +0800
Message-Id: <20170909054613.19148-2-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 01/37] docker: ensure NOUSER for travis images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

While adding the current user is a useful default behaviour for
creating new images it is not appropriate for Travis which already has
a default user.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170725133425.436-2-alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index aaab1a4208..d7dafdbd27 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -71,6 +71,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian8-mxe
 docker-image-debian-win64-cross: docker-image-debian8-mxe
+docker-image-travis: NOUSER=3D1
=20
 # Expand all the pre-requistes for each docker image and test combinatio=
n
 $(foreach i,$(DOCKER_IMAGES), \
--=20
2.13.5
