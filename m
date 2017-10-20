Received: from eggs.gnu.org ([2001:4830:134:3::10]:51698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5QrE-0001g2-Bv
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5QrC-0007Pq-1v
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e5QrB-0007Pd-Rl
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:33 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Oct 2017 14:32:18 +0800
Message-Id: <20171020063219.2035-5-famz@redhat.com>
In-Reply-To: <20171020063219.2035-1-famz@redhat.com>
References: <20171020063219.2035-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] docker: fix out-of-tree 'make
 docker-test-build@debian-powerpc-cross'
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

From: Greg Kurz <groug@kaod.org>

Without this patch, it fails with:

IOError: [Errno 2] No such file or directory:
 'tests/docker/dockerfiles/debian-apt-fake.sh'

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <150841324224.31292.4012464539983692364.stgit@bahia.lan>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 02cd520590..f1a398e9fa 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -44,7 +44,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),\
 		"BUILD","$*")
=20
-docker-image-debian-powerpc-cross: EXTRA_FILES:=3Dtests/docker/dockerfil=
es/debian-apt-fake.sh
+docker-image-debian-powerpc-cross: EXTRA_FILES:=3D$(SRC_PATH)/tests/dock=
er/dockerfiles/debian-apt-fake.sh
=20
 # Enforce dependancies for composite images
 docker-image-debian: docker-image-debian9
--=20
2.13.5
