Received: from eggs.gnu.org ([2001:4830:134:3::10]:51655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Qr8-0001cv-VM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Qr7-0007ON-Vq
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e5Qr7-0007Np-Ps
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:29 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Oct 2017 14:32:16 +0800
Message-Id: <20171020063219.2035-3-famz@redhat.com>
In-Reply-To: <20171020063219.2035-1-famz@redhat.com>
References: <20171020063219.2035-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] docker: cleanup temp directory after test
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

From: Peter Xu <peterx@redhat.com>

There are temp directories named "docker-src.*" after doing docker
tests.  I don't see much point in keeping that (it only contains the
qemu.tar which is exactly current tree, and the copied "run" file).
Let's remove it after test finished.

CC: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
CC: Fam Zheng <famz@redhat.com>
CC: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171017071247.32355-1-peterx@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index ab939f2bec..38874ec03d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -151,6 +151,8 @@ docker-run: docker-qemu-src
 			$(IMAGE) 					\
 			/var/tmp/qemu/run 				\
 			$(TEST), "  RUN $(TEST) in ${IMAGE}")
+	$(call quiet-command, rm -r $(DOCKER_SRC_COPY), \
+		"  CLEANUP $(DOCKER_SRC_COPY)")
=20
 # Run targets:
 #
--=20
2.13.5
