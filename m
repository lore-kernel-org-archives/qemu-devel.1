Received: from eggs.gnu.org ([209.51.188.92]:58594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grnyQ-0004T2-9C
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grnyG-0003X9-NZ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:00:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1grnyF-0003WQ-52
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:00:20 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  7 Feb 2019 13:00:11 -0500
Message-Id: <20190207180012.27303-3-crosa@redhat.com>
In-Reply-To: <20190207180012.27303-1-crosa@redhat.com>
References: <20190207180012.27303-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/3] Acceptance tests: depend on qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Cleber Rosa <crosa@redhat.com>

Tests using the avocado.utils.vmimage library make use of qemu-img,
and because it makes sense to use the version matching the rest of the
source code, let's make sure it gets built.

Its selection, instead of a possible qemu-img binary installed system
wide, is already dealt with by the change that adds the build dir to
the PATH during the test execution.

This is based on the same work for qemu-iotests, and suggested by its
author:

  - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00951.html

CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b39e989f72..9a2fb94f4a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1111,7 +1111,7 @@ $(TESTS_RESULTS_DIR):
=20
 check-venv: $(TESTS_VENV_DIR)
=20
-check-acceptance: check-venv $(TESTS_RESULTS_DIR)
+check-acceptance: check-venv $(TESTS_RESULTS_DIR) qemu-img$(EXESUF)
 	$(call quiet-command, \
             $(TESTS_VENV_DIR)/bin/python -m avocado \
             --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RES=
ULTS_DIR) \
--=20
2.20.1
