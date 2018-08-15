Received: from eggs.gnu.org ([2001:4830:134:3::10]:57044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFZ-0007Jj-Bc
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFY-0001mC-Kc
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFY-0001k8-AI
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:47 +0800
Message-Id: <20180815031248.14908-17-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/17] tests/vm: Add vm-build-all/vm-clean-all
 in help text
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

Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180727083445.21436-1-famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 76f416286e..a98fb3027f 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -15,6 +15,9 @@ vm-test:
 	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
 	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, wit=
h Docker"
+	@echo ""
+	@echo "  vm-build-all                    - Build QEMU in all VMs"
+	@echo "  vm-clean-all                    - Clean up VM images"
=20
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
=20
--=20
2.17.1
