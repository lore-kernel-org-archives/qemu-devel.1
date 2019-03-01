Received: from eggs.gnu.org ([209.51.188.92]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gzl88-0001xO-ML
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gzl87-0008W2-Ju
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:35:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gzl87-0008VT-D6
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:35:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  1 Mar 2019 16:35:18 +0000
Message-Id: <20190301163518.20702-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: add missing support status fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, thuth@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This patch adds the "S:" line for areas of the codebase that currently
lack a support status field.

Note that there are a few more areas that are more abstract and do not
correspond to a specific set of files.  They have not been modified.

Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d941cb3862..2464f51879 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -338,6 +338,7 @@ F: include/hw/tricore/
=20
 Multiarch Linux User Tests
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
+S: Maintained
 F: tests/tcg/multiarch/
=20
 Guest CPU Cores (KVM):
@@ -2094,6 +2095,7 @@ F: qemu.sasl
 Coroutines
 M: Stefan Hajnoczi <stefanha@redhat.com>
 M: Kevin Wolf <kwolf@redhat.com>
+S: Maintained
 F: util/*coroutine*
 F: include/qemu/coroutine*
 F: tests/test-coroutine.c
@@ -2528,6 +2530,7 @@ F: .gitlab-ci.yml
 Guest Test Compilation Support
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+S: Maintained
 F: tests/tcg/Makefile
 F: tests/tcg/Makefile.include
 L: qemu-devel@nongnu.org
--=20
2.20.1
