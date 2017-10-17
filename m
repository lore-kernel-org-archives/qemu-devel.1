Received: from eggs.gnu.org ([2001:4830:134:3::10]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e4M3o-00063h-M4
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e4M3l-0001g5-Gl
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:13:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e4M3l-0001fd-B9
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:13:05 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 17 Oct 2017 15:12:46 +0800
Message-Id: <20171017071247.32355-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] docker: cleanup temp directory after test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

There are temp directories named "docker-src.*" after doing docker
tests.  I don't see much point in keeping that (it only contains the
qemu.tar which is exactly current tree, and the copied "run" file).
Let's remove it after test finished.

CC: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
CC: Fam Zheng <famz@redhat.com>
CC: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/docker/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 6f9ea196a7..c8fbd37127 100644
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
