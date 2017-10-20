Received: from eggs.gnu.org ([2001:4830:134:3::10]:51665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Qr9-0001d2-QE
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Qr5-0007NR-WB
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e5Qr5-0007NC-Qc
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Oct 2017 14:32:15 +0800
Message-Id: <20171020063219.2035-2-famz@redhat.com>
In-Reply-To: <20171020063219.2035-1-famz@redhat.com>
References: <20171020063219.2035-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] docker: Don't allocate tty unless DEBUG=1
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

The existence of tty in the container seems to urge gcc into colorizing
the errors, but the escape chars will clutter the report once turned
into email replies on patchew. Move -t to debug mode.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20171013011954.9975-1-famz@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 6f9ea196a7..ab939f2bec 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -134,10 +134,10 @@ docker-run: docker-qemu-src
 			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
 	$(call quiet-command,						\
 		$(SRC_PATH)/tests/docker/docker.py run 			\
-			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
+			$(if $(NOUSER),,-u $(shell id -u)) 		\
 			--security-opt seccomp=3Dunconfined		\
 			$(if $V,,--rm) 					\
-			$(if $(DEBUG),-i,)				\
+			$(if $(DEBUG),-ti,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=3D$(NETWORK)),--net=
=3Dnone) \
 			-e TARGET_LIST=3D$(TARGET_LIST) 			\
 			-e EXTRA_CONFIGURE_OPTS=3D"$(EXTRA_CONFIGURE_OPTS)" \
--=20
2.13.5
