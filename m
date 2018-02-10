Received: from eggs.gnu.org ([2001:4830:134:3::10]:60333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQHT-0007JR-LB
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQHQ-0003Gy-93
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:13:07 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:55:04 +0300
Message-Id: <bff8a0bbe95900b49f3c0113c0b9a330869acaca.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/17] build: fix typo in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Fixes: f62bbee55d503f639ee9498878ebf42ff4f4299a
---
 scripts/git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index bc7224a27f..807ca0b4f8 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -28,7 +28,7 @@ error() {
     echo
     echo "and then manually update submodules prior to running make, wit=
h:"
     echo
-    echo " $ scripts/git-sbumodule.sh update $modules"
+    echo " $ scripts/git-submodule.sh update $modules"
     echo
     exit 1
 }
--=20
2.11.0
