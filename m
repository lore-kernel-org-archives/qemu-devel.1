Received: from eggs.gnu.org ([2001:4830:134:3::10]:36236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMe4-0007GJ-Rn
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMe0-0003eL-Ck
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:02:36 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMe0-0003eB-7x
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:02:32 -0400
Received: by mail-qt0-x242.google.com with SMTP id i18-v6so5951674qtp.12
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:02:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Jun 2018 11:02:23 -0300
Message-Id: <20180622140223.26056-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] docker: Add fedora-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

As of this commit:

  $ xtensa-linux-gnu-as -v
  GNU assembler version 2.29.1 (xtensa-linux-gnu) using BFD version version 2.29.1-1.fc27

  $ xtensa-linux-gnu-gcc -v
  Target: xtensa-linux-gnu
  gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/fedora-xtensa-cross.docker | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-xtensa-cross.docker

diff --git a/tests/docker/dockerfiles/fedora-xtensa-cross.docker b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
new file mode 100644
index 0000000000..6f9521520c
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
@@ -0,0 +1,7 @@
+FROM fedora:latest
+ENV PACKAGES \
+    binutils-xtensa-linux-gnu \
+    gcc-xtensa-linux-gnu
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.18.0.rc2
