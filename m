Received: from eggs.gnu.org ([2001:4830:134:3::10]:33835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etFHf-0001M2-KQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etFHc-0001Jh-Sm
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:17:47 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  6 Mar 2018 17:17:28 +0100
Message-Id: <20180306161728.20890-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] build-sys: make help could have 'modules'
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Available when configure --enable-modules.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 9a75c48ae0..5d9ef3b8fd 100644
--- a/Makefile
+++ b/Makefile
@@ -1046,6 +1046,9 @@ include $(SRC_PATH)/tests/vm/Makefile.include
 help:
 	@echo  'Generic targets:'
 	@echo  '  all             - Build all'
+ifdef CONFIG_MODULES
+	@echo  '  modules         - Build all modules'
+endif
 	@echo  '  dir/file.o      - Build specified target only'
 	@echo  '  install         - Install QEMU, documentation and tools'
 	@echo  '  ctags/TAGS      - Generate tags file for editors'
--=20
2.16.2.346.g9779355e34
