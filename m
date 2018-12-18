Received: from eggs.gnu.org ([2001:4830:134:3::10]:54088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDgq-0007JY-OY
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDgj-0003Ng-KQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:37:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZDgj-0003NI-7r
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:37:25 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 12:37:17 +0100
Message-Id: <20181218113717.29130-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests: Move qdict-test-data.txt to
 tests/data/qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Move qdict-test-data.txt to the tests/data/qobject/ subdirectory,
and remove the unnecessary symlinking.
(See 4b2ff65a1f3 for similar test-data cleanup).

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                                         | 1 +
 configure                                           | 2 +-
 tests/check-qdict.c                                 | 2 +-
 qdict-test-data.txt =3D> tests/data/qobject/qdict.txt | 0
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename qdict-test-data.txt =3D> tests/data/qobject/qdict.txt (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83c127f0d6..269427c3f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1891,6 +1891,7 @@ F: tests/check-qnum.c
 F: tests/check-qjson.c
 F: tests/check-qlist.c
 F: tests/check-qstring.c
+F: tests/data/qobject/qdict.txt
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
=20
 QEMU Guest Agent
diff --git a/configure b/configure
index 224d3071ac..8022f4b999 100755
--- a/configure
+++ b/configure
@@ -7534,7 +7534,7 @@ DIRS=3D"$DIRS tests/fp"
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
index a1e8305066..b5efa859b0 100644
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
2.17.2
