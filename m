Received: from eggs.gnu.org ([2001:4830:134:3::10]:57368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQhg8-0006GJ-No
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQhg4-0004vy-Bu
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:45:04 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:19 +0300
Message-Id: <28a029d32c87b2661f822127906956c1cbe7a86d.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/61] Makefile: add more targets to the
 UNCHECKED_GOALS rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

These targets don't need a full build of git submodules.
(See b8e535ae8af and eaa2ddbb767).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1f93515677..d86ecd2dd4 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,10 @@ BUILD_DIR=3D$(CURDIR)
 # Before including a proper config-host.mak, assume we are in the source=
 tree
 SRC_PATH=3D.
=20
-UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% help
+UNCHECKED_GOALS :=3D %clean TAGS cscope ctags dist \
+    html info pdf txt \
+    help check-help \
+    docker docker-% vm-test vm-build-%
=20
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
--=20
2.11.0
