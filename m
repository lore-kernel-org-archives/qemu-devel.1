Received: from eggs.gnu.org ([208.118.235.92]:40398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf40C-0001rA-H6
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf409-0008MZ-TH
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:29:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf409-0008LH-Jz
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:29:37 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  3 Jan 2019 15:29:19 +0100
Message-Id: <20190103142919.30090-3-philmd@redhat.com>
In-Reply-To: <20190103142919.30090-1-philmd@redhat.com>
References: <20190103142919.30090-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] tests: Disable qht-bench parallel test
 when using gprof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G . Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This test is failing on the Travis CI [*] since some time now,
disable it until it get fixed.

[*] https://travis-ci.org/qemu/qemu/builds/474821674

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3f5a1d0c30..e764d8d2cb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -88,7 +88,8 @@ check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
 check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
 check-unit-y +=3D tests/test-qdist$(EXESUF)
 check-unit-y +=3D tests/test-qht$(EXESUF)
-check-unit-y +=3D tests/test-qht-par$(EXESUF)
+# FIXME: {test-qht-par + gprof} often break on Travis CI
+check-unit-$(call lnot,$(TARGET_GPROF)) +=3D tests/test-qht-par$(EXESUF)
 check-unit-y +=3D tests/test-bitops$(EXESUF)
 check-unit-y +=3D tests/test-bitcnt$(EXESUF)
 check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)
--=20
2.17.2
