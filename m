Received: from eggs.gnu.org ([2001:4830:134:3::10]:57282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fesoK-0002aD-MS
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 22:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fesoH-00009z-5W
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 22:00:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fesoH-00007W-0e
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 22:00:21 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 16 Jul 2018 10:00:08 +0800
Message-Id: <20180716020008.31468-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests: vm: Add vm-clean-all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The images are big. Add a rule to clean up easily.

Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/Makefile.include | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 5daa2a3b73..79e7866c8b 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -1,6 +1,6 @@
 # Makefile for VM tests
=20
-.PHONY: vm-build-all
+.PHONY: vm-build-all vm-clean-all
=20
 IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd
 IMAGE_FILES :=3D $(patsubst %, tests/vm/%.img, $(IMAGES))
@@ -17,6 +17,9 @@ vm-test:
=20
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
=20
+vm-clean-all:
+	rm -f $(IMAGE_FILES)
+
 tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
 		$(SRC_PATH)/tests/vm/basevm.py \
 		$(SRC_PATH)/tests/vm/Makefile.include
--=20
2.17.1
