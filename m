Received: from eggs.gnu.org ([209.51.188.92]:35509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoRy-0006Eh-LH
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoRx-0007oh-U5
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:18:54 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 01:18:29 +0100
Message-Id: <20190205001835.25660-3-philmd@redhat.com>
In-Reply-To: <20190205001835.25660-1-philmd@redhat.com>
References: <20190205001835.25660-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/8] qemu-iotests: Add dependency to
 qemu-nbd tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Since a9660664fde, some iotests use qemu-nbd.
Add a dependency to build it before using it.
This fixes:

  $ make check-block
    GEN     qemu-img-cmds.h
    CC      qemu-img.o
    LINK    qemu-img
    CC      qemu-io.o
    LINK    qemu-io
    CC      tests/qemu-iotests/socket_scm_helper.o
    LINK    tests/qemu-iotests/socket_scm_helper
  tests/qemu-iotests-quick.sh
  check: qemu-nbd not found
  make: *** [tests/Makefile.include:1059: check-tests/qemu-iotests-quick.=
sh] Error 1

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 679656b64a..c31b87a41f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1057,7 +1057,7 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D =
tests/qemu-iotests/socket_scm_helper$(EXESUF)
=20
 .PHONY: check-tests/qemu-iotests-quick.sh
-check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$=
(EXESUF) qemu-io$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
+check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$=
(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
 	$<
=20
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
--=20
2.20.1
