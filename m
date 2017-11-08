Received: from eggs.gnu.org ([2001:4830:134:3::10]:55573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCGOn-0006bM-60
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCGOk-0003rl-3a
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:47:29 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  7 Nov 2017 23:47:19 -0300
Message-Id: <20171108024719.8389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker: correctly escape $BACKEND in the help
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

In Makefiles the $ must be escaped as $$ in shell uses.

Since 8a2390a4f47:

 $ make docker
     [...]
     NETWORK=1            Enable virtual network interface with default backend.
     NETWORK=ACKEND     Enable virtual network interface with ACKEND.

Once escaped:

 $ make docker
     [...]
     NETWORK=1            Enable virtual network interface with default backend.
     NETWORK=$BACKEND     Enable virtual network interface with $BACKEND.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index f1a398e9fa..de87341528 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -109,7 +109,7 @@ docker:
 	@echo '    DEBUG=1              Stop and drop to shell in the created container'
 	@echo '                         before running the command.'
 	@echo '    NETWORK=1            Enable virtual network interface with default backend.'
-	@echo '    NETWORK=$BACKEND     Enable virtual network interface with $BACKEND.'
+	@echo '    NETWORK=$$BACKEND     Enable virtual network interface with $$BACKEND.'
 	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
 	@echo '    NOCACHE=1            Ignore cache when build images.'
 	@echo '    EXECUTABLE=<path>    Include executable in image.'
-- 
2.15.0
