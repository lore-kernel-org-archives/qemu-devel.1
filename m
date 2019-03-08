Received: from eggs.gnu.org ([209.51.188.92]:36828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Beq-0005ar-NY
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bep-0008Uq-1W
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2Bel-0008Px-8a
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:08 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  8 Mar 2019 10:18:37 +0100
Message-Id: <1552036723-1949-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1552036723-1949-1-git-send-email-thuth@redhat.com>
References: <1552036723-1949-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/7] tests: Move qdict-test-data.txt to
 tests/data/qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Move qdict-test-data.txt to the tests/data/qobject/ subdirectory,
and remove the unnecessary symlinking.
(See 4b2ff65a1f3 for similar test-data cleanup).

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[thuth: Fix conflict in MAINTAINERS]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                         | 2 +-
 configure                                           | 2 +-
 tests/check-qdict.c                                 | 2 +-
 qdict-test-data.txt =3D> tests/data/qobject/qdict.txt | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename qdict-test-data.txt =3D> tests/data/qobject/qdict.txt (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 074ad46..2344215 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1965,7 +1965,7 @@ F: tests/check-qnull.c
 F: tests/check-qnum.c
 F: tests/check-qobject.c
 F: tests/check-qstring.c
-F: qdict-test-data.txt
+F: tests/data/qobject/qdict.txt
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
=20
 QEMU Guest Agent
diff --git a/configure b/configure
index 5921d08..b970bc4 100755
--- a/configure
+++ b/configure
@@ -7662,7 +7662,7 @@ DIRS=3D"$DIRS tests/fp"
 DIRS=3D"$DIRS docs docs/interop fsdev scsi"
 DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS=3D"$DIRS roms/seabios roms/vgabios"
-LINKS=3D"Makefile tests/tcg/Makefile qdict-test-data.txt"
+LINKS=3D"Makefile tests/tcg/Makefile"
 LINKS=3D"$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
 LINKS=3D"$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Mak=
efile"
 LINKS=3D"$LINKS tests/fp/Makefile"
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index a1e8305..b5efa85 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -291,7 +291,7 @@ static void qdict_stress_test(void)
     FILE *test_file;
     QDict *qdict;
     QString *value;
-    const char *test_file_path =3D "qdict-test-data.txt";
+    const char *test_file_path =3D "tests/data/qobject/qdict.txt";
=20
     test_file =3D fopen(test_file_path, "r");
     g_assert(test_file !=3D NULL);
diff --git a/qdict-test-data.txt b/tests/data/qobject/qdict.txt
similarity index 100%
rename from qdict-test-data.txt
rename to tests/data/qobject/qdict.txt
--=20
1.8.3.1
