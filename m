Received: from eggs.gnu.org ([2001:4830:134:3::10]:54611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnNYE-0004kV-US
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnNYC-0006OT-Ec
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnNYC-0006ON-8P
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 31 Aug 2017 19:22:08 +0800
Message-Id: <20170831112210.19921-2-famz@redhat.com>
In-Reply-To: <20170831112210.19921-1-famz@redhat.com>
References: <20170831112210.19921-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] docker: Use unconfined security profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Some by default blocked syscalls are required to run tests for example
userfaultfd.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index aaab1a4208..8ded838b20 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -145,6 +145,7 @@ docker-run: docker-qemu-src
 	$(call quiet-command,						\
 		$(SRC_PATH)/tests/docker/docker.py run 			\
 			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
+			--security-opt seccomp=unconfined		\
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-i,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
-- 
2.13.5
