Received: from eggs.gnu.org ([2001:4830:134:3::10]:33873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbb-0006Ic-78
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYba-0006Ze-GJ
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYba-0006ZB-AN
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:45:58 +0800
Message-Id: <20170909054613.19148-23-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 22/37] docker: Use unconfined security profile
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

Some by default blocked syscalls are required to run tests for example
userfaultfd.

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170905025614.579-4-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Based-on: 20170905021201.25684-1-famz@redhat.com
---
 tests/docker/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 4bb02b1bb5..0e4f159619 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -135,6 +135,7 @@ docker-run: docker-qemu-src
 	$(call quiet-command,						\
 		$(SRC_PATH)/tests/docker/docker.py run 			\
 			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
+			--security-opt seccomp=unconfined		\
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-i,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
-- 
2.13.5
