Received: from eggs.gnu.org ([209.51.188.92]:59449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glqIe-0007UT-IA
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glqId-0002Zg-0u
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:16:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glqIc-0002Wy-Rd
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:16:42 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 22 Jan 2019 08:08:36 +0100
Message-Id: <1548140916-6923-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1548140916-6923-1-git-send-email-thuth@redhat.com>
References: <1548140916-6923-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 26/26] tests: remove rule for nonexisting
 qdev-monitor-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This test was merged into drive_del-test in 2014.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Fixes: e2f3f221885a90de766ce9a3 ("Merge of qdev-monitor-test, blockdev-te=
st")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e0b9aa2..4eea38a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -748,7 +748,6 @@ tests/qom-test$(EXESUF): tests/qom-test.o
 tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-ob=
j-y)
-tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-=
obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
--=20
1.8.3.1
