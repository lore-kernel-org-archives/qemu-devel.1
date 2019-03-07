Received: from eggs.gnu.org ([209.51.188.92]:57905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1ug6-0007CO-ES
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1ug5-0002iu-N8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:22 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  7 Mar 2019 16:10:45 +0100
Message-Id: <20190307151046.15086-2-philmd@redhat.com>
In-Reply-To: <20190307151046.15086-1-philmd@redhat.com>
References: <20190307151046.15086-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/2] ahci-test: Add dependency to qemu-img
 tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Since the ahci-test uses qemu-img, add a dependency to build it
before using it.
This fixes:

  $ gmake check-qtest V=3D1
  QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3D=
qemu-img tests/ahci-test
  Failed to execute child process "/tmp/qemu-test.19tMRF/qemu-img" (No su=
ch file or directory)
  ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !err)

Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 97e1cb90a3..b6bd0a5ed8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -758,7 +758,7 @@ tests/prom-env-test$(EXESUF): tests/prom-env-test.o $=
(libqos-obj-y)
 tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
 tests/fdc-test$(EXESUF): tests/fdc-test.o
 tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
-tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y)
+tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-img$=
(EXESUF)
 tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
 tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
 tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
--=20
2.20.1
