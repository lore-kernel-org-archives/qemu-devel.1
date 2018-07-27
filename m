Received: from eggs.gnu.org ([2001:4830:134:3::10]:42770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiyDG-0003r3-Is
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiyDD-0000Ve-Fq
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:35:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fiyDD-0000Tz-Bk
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:34:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 27 Jul 2018 16:34:45 +0800
Message-Id: <20180727083445.21436-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests/vm: Add vm-build-all/vm-clean-all in
 help text
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

Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 5daa2a3b73..9e19f8662f 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -14,6 +14,9 @@ vm-test:
 	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
 	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
+	@echo ""
+	@echo "  vm-build-all                    - Build QEMU in all VMs"
+	@echo "  vm-clean-all                    - Clean up VM images"
=20
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
=20
--=20
2.17.1
