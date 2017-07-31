Received: from eggs.gnu.org ([2001:4830:134:3::10]:50907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pd-00046u-W5
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pb-00069a-LU
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:26 +0300
Message-Id: <b94b330e233368d906e8b66e827a761e67845c51.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/25] tests: add missing dependency to build
 QTEST_QEMU_BINARY
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

This allow a one liner from fresh repository clone, i.e.:

  ./configure && make -j check-qtest-aarch64

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 98387d3a51..59e536bf0b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -830,7 +830,7 @@ GCOV_OPTIONS =3D -n $(if $(V),-f,)
 # gtester tests, possibly with verbose output
=20
 .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
-$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: $(check-q=
test-y)
+$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-=
softmmu $(check-qtest-y)
 	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
 	$(call quiet-command,QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
 		QTEST_QEMU_IMG=3Dqemu-img$(EXESUF) \
--=20
2.11.0
