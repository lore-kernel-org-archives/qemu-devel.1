Received: from eggs.gnu.org ([209.51.188.92]:46530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6y-0004sD-Vy
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6y-0003pG-4B
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:18:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkE6x-0003nx-QU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:59 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:40 -0200
Message-Id: <20190117201743.20470-7-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
References: <20190117201743.20470-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] check-help: visual and content improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

The "check" target is not a target that will run all other tests
listed, so in order to be accurate it's necessary to list those that
will run.  The same is true for "check-clean".

Then, to give a better visual impression of the differences in the
various targets, let's add empty lines.

Finally, a small (and hopeful) grammar fix from a non-native speaker.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181109150710.31085-5-crosa@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/Makefile.include | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f8d4399293..9348451450 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -3,7 +3,8 @@
 check-help:
 	@echo "Regression testing targets:"
 	@echo
-	@echo " $(MAKE) check                Run all tests"
+	@echo " $(MAKE) check                Run unit, qapi-schema, qtest and d=
ecodetree"
+	@echo
 	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
 	@echo " $(MAKE) check-qtest          Run qtest tests"
 	@echo " $(MAKE) check-unit           Run qobject tests"
@@ -12,12 +13,13 @@ check-help:
 	@echo " $(MAKE) check-block          Run block tests"
 	@echo " $(MAKE) check-tcg            Run TCG tests"
 	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) te=
sts"
+	@echo
 	@echo " $(MAKE) check-report.html    Generates an HTML test report"
 	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
-	@echo " $(MAKE) check-clean          Clean the tests"
+	@echo " $(MAKE) check-clean          Clean the tests and related data"
 	@echo
 	@echo "Please note that HTML reports do not regenerate if the unit test=
s"
-	@echo "has not changed."
+	@echo "have not changed."
 	@echo
 	@echo "The variable SPEED can be set to control the gtester speed setti=
ng."
 	@echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; they c=
an be"
--=20
2.18.0.rc1.1.g3f1ff2140
