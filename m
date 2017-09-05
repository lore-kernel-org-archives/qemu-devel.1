Received: from eggs.gnu.org ([2001:4830:134:3::10]:50144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42Y-0004vZ-3O
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42T-0003P4-Lb
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp42T-0003Of-Fg
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:33 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 10:56:11 +0800
Message-Id: <20170905025614.579-4-famz@redhat.com>
In-Reply-To: <20170905025614.579-1-famz@redhat.com>
References: <20170905025614.579-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/6] docker: Use unconfined security profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, kchamart@redhat.com, eblake@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Some by default blocked syscalls are required to run tests for example
userfaultfd.

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7a027d5bd6..168198e026 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -134,6 +134,7 @@ docker-run: docker-qemu-src
 	$(call quiet-command,						\
 		$(SRC_PATH)/tests/docker/docker.py run 			\
 			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
+			--security-opt seccomp=unconfined		\
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-i,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
-- 
2.13.5
